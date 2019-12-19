//
//  Battle.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/12.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Battle: SKSpriteNode {
    internal func touchAction(s:CGPoint) {
        
        if cancelTouch {
            return
        }
        if _orderCancel.contains(s) && _orderCancel.visible {
            cancelButtonClicked()
            return
        }
        
        if waitingForSelectItemTarget {
            let this = self
            let parts = _playerPart + _enemyPart
            for u in parts {
                if u.contains(s) && u.selectable {
                    waitingForSelectItemTarget = false
                    this.hideCancel()
                    this.hideOrder()
                    this.setUnitDefault(all: true)
                    let item = _selectedItem!
                    item._battle = self
                    item.use(unit: u) {
                        this.moveEnd()
                    }
                    break
                }
            }
            return
        }
        
        if waitingForSelectRecallTarget {
            for u in _playerPart {
                if u.contains(s) && u.selectable {
                    _playerUnit.showText(text: "召回")
                    u._unit._seat = BUnit.STAND_BY
                    
                    waitingForSelectRecallTarget = false
                    setUnitDefault(all: true)
                    hideCancel()
                    
                    let this = self
                    u.actionRecall {
                        u.removeFromParent()
                        u.removeFromBattle()
                        this.moveEnd()
                    }
                }
            }
            return
        }
        
        if waitingForSelectSummonSeat {
            for u in _summonUnits.values {
                if u.contains(s) {
                    let seat = u._unit._seat
                    if _selectedAction is Interchange {
                        waitingForSelectSummonSeat = false
                        _selectedTarget = u
                        let this = self
                        speakSpellName()
                        _selectedAction.cast {
                            this.moveEnd()
                            this.cdSpell(spell: self._selectedAction as! Spell)
                        }
                        cleanSummonSeats()
                        setUnitDefault(all: true)
                        hideCancel()
                        return
                    }
                    
                    if u.isEmpty {
                        if _playerPart.count >= 6 || _char.getReadyMinions().count >= _char._minionsCount {
                            showMsg(text: "随从已达上限！")
//                            showCancel()
                            return
                        }
                        
                        _playerUnit.showText(text: "召唤")
                        u.removeFromParent()
                        waitingForSelectSummonSeat = false
                        var seatedMinions = Array<Creature>()
                        for m in _char._minions {
                            if m._seat == seat {
                                m._seat = BUnit.STAND_BY
                                break
                            }
                            if m._seat != BUnit.STAND_BY {
                                seatedMinions.append(m)
                            }
                        }
                        if seatedMinions.count > _char._minionsCount {
                            for m in _char._minions {
                                if m._seat != BUnit.STAND_BY && m._extensions.hp < 1 {
                                    m._seat = BUnit.STAND_BY
                                }
                            }
                        }
                        _selectedMinion._seat = seat
                        let unit = createPlayerPartUnit(c: _selectedMinion)
                        cleanSummonSeats()
                        setUnitDefault(all: true)
                        hideCancel()
                        
                        let this = self
                        unit.actionSummon {
                            this.moveEnd()
                        }
                        
                    } else {
                        _playerUnit.showText(text: "召唤")
//                        let unit = findUnitBySeat(part: _playerPart, seat: u._unit._seat)
//                        u.removeFromBattle()
//                        u.removeFromParent()
                        u._unit._seat = BUnit.STAND_BY
                        
                        waitingForSelectSummonSeat = false
                        _selectedMinion._seat = seat
                        cleanSummonSeats()
                        setUnitDefault(all: true)
                        hideCancel()
                        
                        let this = self
                        u.actionRecall {
                            let bUnit = this.createPlayerPartUnit(c: this._selectedMinion)
                            u.removeFromParent()
                            u.removeFromBattle()
                            bUnit.actionSummon {
                                this.moveEnd()
                            }
                        }
                    }
                    
                    return
                }
            }
            return
        }
        
        for button in _spellsButton {
            if button.selectable && button.contains(s) {
//                spellSelect(spell: button.spell)
                return
            }
        }
        
        
        if _orderItem.contains(s) && !_orderItem.isHidden {
            showItemPanel()
            hideOrder()
            showCancel()
            waitingForSelectTarget = false
            return
        }
        
        if _orderSummon.contains(s) && !_orderSummon.isHidden {
            hideOrder()
            showCancel()
            showMinionsList()
            //            showSummonableSeats()
            return
        }
        
        if _orderRecall.contains(s) && !_orderRecall.isHidden {
            hideOrder()
            showCancel()
            setUnitDefault(all: true)
            showRecallMinions()
            waitingForSelectRecallTarget = true
            return
        }
        
        //点击攻击选项
        if _orderAttack.contains(s) && !_orderAttack.isHidden {
            hideOrder()
            showCancel()
            //            _orderCancel.isHidden = false
            waitingForSelectTarget = true
            _selectedAction = Attack()
            _selectedAction._battle = self
            showAvailableUnits(selectObject: _selectedAction)
            return
        } else if _orderDefend.contains(s) && !_orderDefend.isHidden {
            _selectedAction = Defend()
            _selectedAction._battle = self
            _curRole.isDefend = true
            setUnitDefault(all: true)
            hideOrder()
            hideCancel()
            moveEnd()
            return
//        } else if _orderSpell.contains(s) && !_orderSpell.isHidden {
//            showSpellCards()
//            hideOrder()
//            showCancel()
//            _waitingForSelectTarget = false
//            return
        }
        
        if waitingForSelectTarget {
            _selectedTarget = nil
            for unit in _playerPart {
                if unit.contains(s) && unit.selectable {
                    _selectedTarget = unit
                }
                
            }
            for unit in _enemyPart {
                if unit.contains(s) && unit.selectable {
                    _selectedTarget = unit
                }
            }
            if _selectedTarget != nil {
                waitingForSelectTarget = false
                setUnitDefault(all: true)
                _selectedTarget!.setSelectedMode()
                hideCancel()
                hideOrder()
                execOrder()
            } else {
                debug("has no selected target!")
            }
            return
        }
        
//        for card in _spellCards {
//            if card.contains(s) {
//                if card.coolDown > 0 {
//                    return
//                }
//                _selectedSpell = card.spell
//                hideOrder()
//                showCancel()
//                removeSpellCards()
//                if _selectedSpell.isAutoSelectTarget {
//                    _waitingForSelectTarget = false
//                    _selectedSpell.findTarget()
//                    setUnitDefault(all: true)
//                    execOrder()
//                    hideCancel()
//                } else {
//                    if _selectedSpell is SummonFlower {
//                        waitingForSelectSummonSeat = true
//                        setUnitDefault()
//                        showSummonableSeats(selectAll: false)
//                        return
//                    }
//
//                    if _selectedSpell is Interchange {
//                        waitingForSelectSummonSeat = true
//                        setUnitDefault()
//                        showSummonableSeats()
//                        return
//                    }
//
//                    _waitingForSelectTarget = true
//                    showAvailableUnits()
//                }
//            }
//        }
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.name = "battle"
        let c = cellSize
        let x1 = -c * 2
        let x2:CGFloat = 0
        let x3 = c * 2
        let y1 = c * 5
        let y2 = c * 3
        let y3 = -c * 1
        let y4 = -c * 3
        
        let s:CGFloat = 12
        
        ttl.x = x1 + s
        ttl.y = y1
        
        ttm.x = x2
        ttm.y = y1
        
        ttr.x = x3 - s
        ttr.y = y1
        
        tbl.x = x1
        tbl.y = y2
        
        tbm.x = x2
        tbm.y = y2
        
        tbr.x = x3
        tbr.y = y2
        
        btl.x = x1
        btl.y = y3
        
        btm.x = x2
        btm.y = y3
        
        btr.x = x3
        btr.y = y3
        
        bbl.x = x1 - s
        bbl.y = y4
        
        bbm.x = x2
        bbm.y = y4
        
        bbr.x = x3 + s
        bbr.y = y4
        
        _enemySeats[BUnit.TTL] = ttl
        _enemySeats[BUnit.TTM] = ttm
        _enemySeats[BUnit.TTR] = ttr
        _enemySeats[BUnit.TBL] = tbl
        _enemySeats[BUnit.TBM] = tbm
        _enemySeats[BUnit.TBR] = tbr
        
        _playerSeats[BUnit.BTL] = btl
        _playerSeats[BUnit.BTM] = btm
        _playerSeats[BUnit.BTR] = btr
        _playerSeats[BUnit.BBL] = bbl
        _playerSeats[BUnit.BBM] = bbm
        _playerSeats[BUnit.BBR] = bbr
        
        _char = Game.instance.char!
        createBG()
        createOrder()
        _animationLayer.zPosition = 110
        _animationLayer.size = CGSize(width: cellSize * 5, height: cellSize * 5)
        addChild(_animationLayer)
        isUserInteractionEnabled = true
    }
    internal var _isCharDead = false
    internal var _isAllEvilDead = false
    func battleStart() {
        for s in _char._spellsInuse {
//            s._timeleft = 0
        }
        
        for m in _char._minions {
            for s in m._spellsInuse {
//                s._timeleft = 0
            }
        }
//        if _char._weapon is CreationMatrix {
//            var ss:Array<Spell> = []
//            for s in _char._spellsInuse {
//                if s is Active {
//                    ss.append(s)
//                }
//            }
//            if ss.count > 0 {
//                _creationMatrixSpell = ss.one()
//            }
//        }
        
//        _roundLabel.fontSize = 18
//        _roundLabel.align = "left"
//        _roundLabel.position.x = -cellSize * 7.5
//        _roundLabel.position.y = cellSize * 4 - 10
//        addChild(_roundLabel)
        setTimeout(delay: 1, completion: roundStart)
//        roundStart()
    }
    internal var _roundLabel = Label()
    internal func defaultOrderAttack() {
        if !(_curRole.ifWeaponIs(Outfit.Instrument)) {
            waitingForSelectTarget = true
            _selectedAction = Attack()
            _selectedAction._battle = self
            showAvailableUnits(selectObject: _selectedAction)
        }
    }
    func reduceCooldown() {
        let u = _curRole
        for s in u._unit._spellsInuse + u._unit._spellsHidden {
//            if s._timeleft > 0 {
//                s._timeleft -= 1
//            }
        }
        for status in u._status.values {
            if status._timeleft > 0 && !status.hasBeforeMoveAction {
                status._timeleft -= 1
                if status._timeleft == 0 {
                    status.timeupAction()
                }
            }
        }
        _curRole.showStatusText()
//        for u in _playerPart {
//            u.showStatusText()
//        }
//        for u in _enemyPart {
//            u.showStatusText()
//        }
//        for u in _enemyPart {
//            for s in u._unit._spellsInuse {
//                if s._timeleft > 0 {
//                    s._timeleft -= 1
//                }
//            }
//            for status in u._status.values {
//                if status._timeleft > 0 && !status.hasBeforeMoveAction {
//                    status._timeleft -= 1
//                    if status._timeleft == 0 {
//                        status.timeupAction()
//                    }
//                }
//            }
//        }
//        for u in _playerPart {
//            for s in u._unit._spellsInuse {
//                if s._timeleft > 0 {
//                    s._timeleft -= 1
//                }
//            }
//            for status in u._status.values {
//                if status._timeleft > 0 && !status.hasBeforeMoveAction {
//                    status._timeleft -= 1
//                    if status._timeleft == 0 {
//                        status.timeupAction()
//                    }
//                }
//            }
//        }
        
//        for p in _char._props {
//            if p is Item {
//                let item = p as! Item
//                if item._timeleft > 0 {
//                    item._timeleft -= 1
//                }
//            }
//        }
        
    }
    internal func findUnitBySeat(part:Array<BUnit>, seat:String) -> BUnit? {
        var i = 0
        for u in part {
            if u._unit._seat == seat {
                return u
            }
            i += 1
        }
        return nil
    }
    internal func stillInBattle(unit:BUnit) -> Bool {
        if _enemyPart.contains(unit) {
            return true
        }
        if _playerPart.contains(unit) {
            return true
        }
        
        return false
    }
    func roundEnd() {
        for u in _playerPart {
            for s in u._status.values {
                s.inEndOfRound()
            }
        }
        for u in _enemyPart {
            for s in u._status.values {
                s.inEndOfRound()
            }
        }
    }
    func moveStart() {
        if hasFinished() {
            return
        }
        //行动开始 重制技能判定
        for i in 0...spellDecision.count - 1 {
            spellDecision[i] = false
        }
        if _roleAll.count <= 0 {
//            debug("roleAll empty")
            roundEnd()
            roundStart()
            return
        }
        let this = self
        findNextRole() {
            if this._curRole.isDead() {
                debug("dead in move start")
                this._curRole.removeFromBattle()
                this._curRole.removeFromParent()
                this.moveStart()
                return
            }
            
            if !this.stillInBattle(unit: this._curRole) {
                debug("单位已不在战斗中")
                return
            }
            let delay:CGFloat = self._curRole.playerPart ? 0.5 : 0
            setTimeout(delay: delay, completion: self.createAction)
        }
    }
    
    func getSpell(u:BUnit) -> Spell {
        var sps = Array<Spell>()
        for s in u.getActiveSpell() {
            s._battle = self
            if s._timeleft == 0 && s.selectable() {
                sps.append(s)
            }
        }
        if sps.count < 1 {
            return Attack()
        } else {
            return sps.one()
        }
    }
    internal func createAction() {
        _curRole.isDefend = false
        
//        var delay:CGFloat = 0
        var castSpells = Array<Status>()
        for s in _curRole._status.values {
            if s.hasBeforeMoveAction && s._timeleft > 0 {
                castSpells.append(s)
            }
        }
        if castSpells.count > 0 {
            var i = 0
            func castFunc() {
                if i < castSpells.count {
                    let s = castSpells[i]
                    s._castSpell._battle = self
//                    s._castSpell.findTarget()
                    s._castSpell.cast {
                        s._timeleft -= 1
                        if s._timeleft < 1 {
                            s.timeupAction()
                        }
                        castFunc()
                    }
                    i += 1
                } else {
                    self._curRole.showStatusText()
                    self.controlAction()
                }
            }
            castFunc()
        } else {
            controlAction()
        }
//        setTimeout(delay: delay, completion: controlAction)
//        controlAction()
        
//        if _curRole.hasStatus(type: Status.BURNING) {
//            let s = _curRole.getStatus(type: Status.BURNING) as! BurningStatus
//            let damage = s.getBurningDamage(unit: _curRole)
//            _curRole.showValue(value: damage)
//            if _curRole.isDead() {
//                moveEnd()
//                return
//            }
//        }
    }
    internal func controlAction() {
        if hasFinished() {
            return
        }
        if _curRole.isDead() {
            moveEnd()
            return
        }
        let this = self
        if this._curRole.hasStatus(type: Status.FREEZING) {
            this._curRole.actionUnfreeze {
                debug("unfreezing")
                this._curRole.removeStatus(type: Status.FREEZING)
                this.moveEnd()
            }
            return
        }
        
        if this._curRole.hasStatus(type: Status.PETRIFY) {
            this.moveEnd()
            return
        }
        
        if this._curRole.hasStatus(type: Status.NERVOUS_POISON) {
            if seed() < 33 {
                self._curRole.showText(text: "POISON") {
                    this.moveEnd()
                }
                return
            }
        }
        
        if _curRole.hasStatus(type: Status.TAUNTED) {
            this._selectedAction = Attack()
            this._selectedAction._battle = self
            let s = _curRole.getStatus(type: Status.TAUNTED)
            let source = s!._source
            if nil == s {
                debug("taunt error")
            }
            if !source.isDead() {
                _selectedTarget = source
                execOrder()
                return
            }
        }
        
        
        
        if _curRole._unit is SummonUnit {
            //            _selectedSpell = _curRole._unit._spellsInuse[0]
            _selectedAction = getSpell(u: _curRole)
            _selectedAction._battle = self
            _selectedAction.findTarget()
            execOrder()
            return
        }
        
//        if this._curRole.hasSpell(spell: Crazy()) {
//            this._selectedSpell = Attack()
//            this._selectedSpell._rate = 2
//            this._selectedSpell._battle = self
//            this._selectedSpell.findTarget()
//            this.execOrder()
//            return
//        }
        
        if _curRole.hasStatus(type: Status.CONFUSED) {
            var all = _playerPart + _enemyPart
            let index = all.firstIndex(of: _curRole)
            all.remove(at: index!)
            _selectedAction = Attack()
            _selectedAction._battle = self
            _selectedTarget = all.one()
            _curRole.showText(text: "CONFUSED") {
                self.execOrder()
            }
            return
        }
        
        if !(_curRole._unit is Character) {
            this.createAI()
        } else {
            cancelTouch = false
            _curRole.setOrderMode()
            defaultOrderAttack()
            showOrder()
            hideCancel()
        }
    }
    internal func cleanUnitStatus() {
        for unit in _enemyPart {
            unit._speed = 0
        }
        for unit in _playerPart {
            unit._speed = 0
        }
    }
    internal func getSpellAttack() -> Spell {
        return Attack()
    }
    internal func createAI() {
        if seed() < 15 && !Mode.nodefence {
            _curRole.isDefend = true
            _selectedAction = Defend()
            _selectedAction._battle = self
            _curRole.showText(text: "防守") {
                self.execOrder()
            }
            return
        }
//        debug("sensitive \(_curRole.getSensitive())")
        if seed() < _curRole.getSensitive() {
            _selectedAction = getSpell(u: _curRole)
            _selectedAction._battle = self
            _selectedAction.findTarget()
            execOrder()
        } else {
            _selectedAction = getSpellAttack()
            _selectedAction._battle = self
            _selectedAction.findTarget()
            execOrder()
        }
    }
    var victory = false
    var lootPanelConfirmAction = {}
    internal var expRate:CGFloat = 1
    internal func defeat() {
        if victory {
            return
        }
        let l = Loot()
        for u in _evilsOrg {
            for r in _playerPart {
                let exp = l.getExp(selfUnit: r, enemyLevel: u._unit._level) * expRate
                r._unit.expUp(up: exp)
            }
            if _char._level - u._unit._level <= 5 {
//                l.loot(level: u._unit._level)
                if Game.instance.curStage._curScene is BossRoad {
                    l.lootInBossRoad(level: u._unit._level)
                }
                
            }
        }
        victory = true
        let list = l.getList() + specialLoot()
        
        fadeOutBattle()
        
        if list.count > 0 {
            let p = LootPanel()
            p.create(props: list)
            setTimeout(delay: 0.5, completion: {
                for u in self._playerPart {
                    u.removeFromParent()
                }
                Game.instance.curStage.showPanel(p)
            })
            p.confirmAction = {
                self.lootPanelConfirmAction()
            }
        } else {
            self.lootPanelConfirmAction()
        }
    }
    internal func specialLoot() -> Array<Item> {
        let p = Array<Item>()
        return p
    }
    internal func defeated() {
        victory = false
        showMsg(text: "战斗失败！")
        fadeOutBattle()
    }
    func fadeOutBattle() {
        
        setTimeout(delay: 0.75, completion: {
            if self.victory {
                self.defeatAction()
            } else {
                self.defeatedAction()
            }
            Game.instance.curStage.removeBattle(self)
        })
    }
//    var afterBatteAction = func(victory:Bool){}
//    var afterBatteAction = {}
    var defeatAction = {}
    var defeatedAction = {}
    func hasFinished() -> Bool {
        if _enemyPart.count < 1 {
            defeat()
            return true
        }
        if _char._extensions.hp < 1 {
            defeated()
            return true
        }
        
        return false
    }
    internal func calcSpeedLine() {
        _speedLine = 0
        for unit in _enemyPart {
            _speedLine += unit.getSpeed()
        }
//        for unit in _playerPart {
//            if nil != unit._unit._weapon {
//                _speedLine += unit.getSpeed() * unit._unit._weapon!._attackSpeed
//            } else {
//                _speedLine += unit.getSpeed()
//            }
//        }
    }
    internal func roundStart(){
        _round += 1
        _roundLabel.text = "第\(_round)回合"
        cleanUnitStatus()
//        reduceCooldown()
        calcSpeedLine()
        orderUnits()
        let this = self
        setTimeout(delay: 0.5, completion: {
            this.moveStart()
        })
    }
    internal func orderUnits() {
        var all = _enemyPart + _playerPart
        _roleAll = []
        for i in 0...all.count - 1 {
            if all[i].hasSpell(spell: Vanguard()) {
                _roleAll.append(all[i])
                all.remove(at: i)
                break
            }
        }
        while all.count > 0 {
            for unit in all {
//                if nil != unit._unit._weapon {
//                    unit._speed += unit.getSpeed() * unit._unit._weapon!._attackSpeed
//                } else {
//                    unit._speed += unit.getSpeed()
//                }
//                if unit._speed >= _speedLine {
//                    _roleAll.append(unit)
//                    all.remove(at: all.firstIndex(of: unit)!)
//                }
            }
        }
    }
    internal var _speedLine:CGFloat = 0
    var _roleAll = Array<BUnit>()
    var _round = 0
    internal var hasRhythm = false
    internal func findNextRole(completion:@escaping () -> Void) {
        if hasRhythm {
            hasRhythm = false
            let this = self
            _curRole.showText(text: "律动") {
                this.createCurRole {
                    completion()
                }
            }
            return
        }
        let sd = seed()
        if sd < 25 - _playerUnit.getChaos().toInt() {
            let index = seed(max: _roleAll.count)
            let unit = _roleAll[index]
            _curRole = unit
            _roleAll.remove(at: index)
//            debug("行为混乱")
            completion()
        } else {
            createCurRole {
                completion()
            }
        }
    }
    
    internal func createCurRole(completion:@escaping () -> Void) {
        _curRole = _roleAll[0]
        if seed().toFloat() < _curRole.getRhythm() {
            completion()
            hasRhythm = true
        } else {
            _roleAll.remove(at: 0)
            completion()
        }
    }
    
    func placeEvils() {}
    func placeRoles() {}
    func silenceUnit(unit:BUnit) {
        if unit.hasSpell(spell: RaceSuperiority()) || unit.hasStatus(type: Status.IMMUNE) {
            unit.showText(text: "IMMUNE")
            return
        }
        if unit._unit is Boss {
            unit.showText(text: "IMMUNE")
        } else {
            unit.showText(text: "SILENCED")
            let index = _roleAll.firstIndex(of: unit)
            if nil != index {
                _roleAll.remove(at: index!)
            } else {
                debug("silenceUnit not exist")
            }
        }
    }
    //unused
    internal func createBG() {
//        let di = Game.instance
//        let bg = SKShapeNode(rect: CGRect(x: -di.screenWidth * 0.6, y: -di.screenHeight * 0.6, width: di.screenWidth * 1.2, height: di.screenHeight * 1.2))
////        bg.fillColor = UIColor.black
////        bg.alpha = 0.10
//        addChild(bg)
    }

    internal var _orderAttack = RoundButton()
    internal var _orderCancel = RoundButton()
    internal var _orderDefend = RoundButton()
    internal var _orderSpell = RoundButton()
    internal var _orderItem = RoundButton()
    internal var _orderSummon = RoundButton()
    internal var _orderRecall = RoundButton()
    internal func createOrder() {
        let y = -cellSize * 5.25
        let size:CGFloat = cellSize * 0.45
        let x = -cellSize * 3.3
        let gap = size + cellSize * 0.5
//        let t:CGFloat = 10
        _orderAttack = createMenuButtons(x: x, y: y, size: size, text: "攻击")
        _orderDefend = createMenuButtons(x: x + gap, y: y, size: size, text: "防守")
        _orderItem = createMenuButtons(x: x + gap * 2, y: y, size: size, text: "物品")
        _orderSummon = createMenuButtons(x: x + gap * 3, y: y, size: size, text: "召唤")
        _orderRecall = createMenuButtons(x: x + gap * 4, y: y, size: size, text: "召回")
        _orderCancel = createMenuButtons(x: -x, y: y, size: size, text: "取消")
        
        _orders.append(_orderAttack)
        _orders.append(_orderDefend)
        _orders.append(_orderSpell)
        _orders.append(_orderItem)
        _orders.append(_orderSummon)
        _orders.append(_orderRecall)
    }
    internal var _spellsButton = Array<SpellRoundButton>()
    internal func createRoleSpellsButton() {
        _spellsButton = []
        var y = -cellSize * 5.25
        let size:CGFloat = cellSize * 0.45
        let x = -cellSize * 3.3
        let gap = size + cellSize * 0.5
        var i:CGFloat = 5
        let spells = _curRole._unit._spellsInuse + _curRole._unit._spellsHidden
        for s in spells {
//            s._battle = self
//            if s is Auro || s is Passive {
//                continue
//            }
//            let srb = SpellRoundButton()
//            srb.create(text: s._name, size: size)
//            srb.spell = s
//            _spellsButton.append(srb)
////            debug("\(_curRole._unit._name) \(s._name) is  \(s._timeleft)")
//            
//            if s._timeleft > 0 {
//                srb.timeleft = s._timeleft
//                srb.selectable = false
//            } else {
//                srb.selectable = s.selectable()
//            }
            if i >= 8 {
                i = 5 + (8 - i)
                y = -cellSize * 6.2
            }
//            srb.xAxis = x + gap * i
//            srb.yAxis = y
//            i += 1
//            addChild(srb)
        }
    }
    internal func removeRoleSpellsButton() {
        for s in _spellsButton {
            s.removeFromParent()
        }
    }
    private func createMenuButtons(x:CGFloat, y:CGFloat, size:CGFloat, text:String) -> RoundButton {
        let s = RoundButton()
        s.create(text: text, size: size)
        s.position.x = x
        s.position.y = y
        s.zPosition = self.zPosition + 1
        s.hide()
        addChild(s)
        _orders.append(s)
        return s
    }
    var _selectedAction:Castable!
    internal var waitingForSelectTarget = false
    internal var waitingForSelectItemTarget = false
    internal var waitingForSelectSummonSeat = false
    internal var waitingForSelectRecallTarget = false
    internal var _itemTargets = Array<BUnit>()
    var _selectedTarget:BUnit?
    var _selectedTargets = Array<BUnit>()
    internal var _char:Character!
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //let view = touches.first?.view
        let first = touches.first
        let s = first?.location(in: self)
        touchAction(s: s!)
    }
    
    func moveBack(unit:BUnit, completion:@escaping () -> Void) {
        if unit.isDead() {
            completion()
            return
        }
//        let oPos = getPosByStr(unit._seat)
//        var dy = unit.position.y - oPos[1]
//        if abs(dy) < 1 {
//            dy = 0
//        }
//        let dx = round(unit.position.x - oPos[0])
//        let v = CGVector(dx: -dx, dy: -dy)
////        debug("move back \(dx)")
//        var time:CGFloat = Game.instance.frameSize * 4
//        if abs(v.dx) > 360 {
//            time = Game.instance.frameSize * 5
//        }
//        let move = SKAction.move(by: v, duration: TimeInterval(time))
        let wait = SKAction.wait(forDuration: TimeInterval(0.5))
////        let move = SKAction.sequence([go, wait])
//        if oPos[0] < unit.position.x {
//            unit.faceWest()
//            unit.moveWest4frame()
//        } else {
//            unit.faceEast()
//            unit.moveEast4frame()
//        }
////        let this = self
//        unit.run(move, completion: {
//            if unit.inleft {
//                unit.faceEast()
//            } else {
////                unit.faceEast()
//                unit.faceWest()
//            }
//            unit.run(wait) {
//                completion()
//            }
//        })
        unit.run(wait) {
            completion()
        }
    }
    //unused
    internal func checkRoleDead() {
        for u in _playerPart {
            if u.isDead() {
                u.actionDead {
                    u.removeFromBattle()
                    u.removeFromParent()
                }
            }
        }
        for u in _enemyPart {
            if u.isDead() {
                u.actionDead {
                    u.removeFromBattle()
                    u.removeFromParent()
                }
            }
        }
    }
    internal func moveEnd() {
        if hasFinished() {
            return
        }
        if _curRole.isDead() {
            moveStart()
            return
        }
        let spells = _curRole._unit._spellsInuse + _curRole._unit._spellsHidden
        var castSpells = Array<Spell>()
        for spell in spells {
//            if spell.hasAfterMoveAction {
//                castSpells.append(spell)
//            }
        }
        if castSpells.count > 1 {
            debug("castSpells count is : \(castSpells.count)")
        }
        reduceCooldown()
        if castSpells.count > 0 {
            func castAction(index:Int) {
                if self.hasFinished() {
                    return
                }
                setTimeout(delay: 0.5, completion: {
                    if index < castSpells.count {
                        let spell = castSpells[index]
                        spell._battle = self
                        spell.findTarget()
                        spell.cast {
                            let next = index + 1
                            castAction(index: next)
                        }
                    } else {
                        self.moveStart()
                    }
                })
            }
            castAction(index: 0)
        } else {
            moveStart()
        }
        
//        moveStart()
//        if nil != selectedSpell {
//            let this = self
//            _curRole.showText(text: selectedSpell!._name) {
//                selectedSpell!._battle = this
//                selectedSpell!.findTarget()
//                selectedSpell!.cast {
//                    this.moveStart()
//                }
//            }
//        } else {
//        }
    }
    internal func cdSpell(spell:Spell) {
        if Mode.nocd && _curRole._unit is Character {
            return
        }
        if spell == _creationMatrixSpell {
            return
        }
//        if spell is SummonSkill && _curRole.weaponIs(TheFear.EFFECTION) {
//            return
//        }
        if spell._cooldown > 0 {
            if _curRole._unit is Character && Game.instance.curStage.hasTowerStatus(status: TimeReduce()) {
                spell._timeleft = spell._cooldown
            } else {
                spell._timeleft = spell._cooldown + 1
            }
//            debug("\(_curRole._unit._name) \(spell._name) is  \(spell._timeleft)")
        }
    }
    internal func speak(text:String = "") {
//        var speaking = _selectedSpell._name
//        if text.count > 0 {
//            speaking = text
//        }
//        if speaking.count > 0 {
//            _curRole.speakInBattle(text: speaking)
//        }
    }
    internal func speakSpellName() {
//        _curRole.showText(text:_selectedSpell._name)
    }
    internal func execOrder() {
        cancelTouch = true
//        let delay:CGFloat = 0
//        setTimeout(delay: delay, completion: {
//
//        })
        if self._selectedAction is Attack {
            let t = self._selectedTarget
            if nil != t && t!.isDead() {
                self.moveEnd()
                debug("\(t!._unit._name) is dead! in attack cast in battle! 1142")
            } else {
                self._selectedAction.cast {
                    self.cdSpell(spell: self._selectedAction as! Spell)
                    self.moveEnd()
                }
            }
        } else {
            self._curRole.showText(text: self._selectedAction._name) {
                self._selectedAction.cast {
                    self.cdSpell(spell: self._selectedAction as! Spell)
                    self.moveEnd()
                }
            }
        }
    }
    func roleMove(from:BUnit, to:BUnit, completion:@escaping () -> Void) {
//        let fromPos = getPosByStr(from._seat)
//        let toPos = getPosByStr(to._seat)
//        if fromPos == toPos {
//            debug("moving bug!")
//        }
//        var dPos = from._charSize
//        if from.position.x < to.position.x {
//            from.moveEast4frame()
//        } else {
//            from.moveWest4frame()
//            dPos = -from._charSize
//        }
//        let v = CGVector(dx: -(fromPos[0] - toPos[0] + dPos), dy: -(fromPos[1] - toPos[1]))
////        debug("\(from.inleft ? "left" : "right") role move 移动距离 ： \(v.dx)")
////        print(v)
//        var time:CGFloat = Game.instance.frameSize * 4
//        if abs(v.dx) > 360 {
//            time = Game.instance.frameSize * 5
//        }
//        let move = SKAction.move(by: v, duration: TimeInterval(time))
////        print(move)
//        let wait = SKAction.wait(forDuration: TimeInterval(0.5))
//        let go = SKAction.sequence([move, wait])
        let go = SKAction.wait(forDuration: TimeInterval(0.5))
        from.run(go) {
            completion()
        }
    }
    internal func hideCancel() {
        _orderCancel.isHidden = true
    }
    internal func cancelButtonClicked() {
        hideCancel()
        showOrder()
        _orderCancel.isHidden = true
        waitingForSelectTarget = false
        waitingForSelectSummonSeat = false
        waitingForSelectItemTarget = false
        waitingForSelectRecallTarget = false
//        removeSpellCards()
        cleanSummonSeats()
        setUnitDefault()
    }
    internal func showCancel() {
        _orderCancel.isHidden = false
    }
    internal func setUnitDefault(all:Bool = false) {
        for unit in _playerPart {
            if all {
                unit.setDefaultMode()
            } else {
                if _curRole != unit {
                    unit.setDefaultMode()
                }
                _curRole.setOrderMode()
            }
            
        }
        for unit in _enemyPart {
            unit.setDefaultMode()
        }
    }
    internal func showUnitInfo(hidden:Bool = false) {
        for u in _playerPart {
            u._levelLabel.isHidden = hidden
        }
        for u in _enemyPart {
            u._levelLabel.isHidden = hidden
        }
    }
    internal var _availableEvils = Array<BUnit>()
    internal func showAvailableUnits(selectObject:Castable) {
        setUnitDefault()
        _availableEvils = Array<BUnit>()
        if selectObject.targetAll {
            _availableEvils = _enemyPart + _playerPart
            if !selectObject.canBeTargetSelf {
                let index = _availableEvils.firstIndex(of: _curRole)
                _availableEvils.remove(at: index!)
            }
            for unit in _availableEvils {
                unit.setSelectableMode()
            }
            return
        }
        if selectObject.targetEnemy{
            if selectObject.isClose && _curRole.isClose() {
                if isPlayerPartUnitBlocked(unit: _curRole) {
                    for unit in _enemyPart {
                        if !isEnemyPartUnitBlocked(unit: unit) {
                            _availableEvils.append(unit)
                        }
                    }
                } else {
                    for unit in _enemyPart {
                        _availableEvils.append(unit)
                    }
                }
            } else {
                for unit in _enemyPart {
                    _availableEvils.append(unit)
                }
            }
            
        } else {
            _availableEvils = _playerPart
        }
        for unit in _availableEvils {
            if selectObject.canBeTargetSummonUnit {
                unit.setSelectableMode()
            } else {
                if unit._unit is SummonUnit {
                    
                } else {
                    unit.setSelectableMode()
                }
            }
            
        }
    }
    
    func isEnemyPartUnitBlocked(unit:BUnit) -> Bool{
        let s = unit.seat
        var target = ""
//        if s == BUnit.TTL {
//            target = BUnit.TBL
//        } else if s == BUnit.TTM {
//            target = BUnit.TBM
//        } else if s == BUnit.TTR {
//            target = BUnit.TBR
//        } else {
//            return false
//        }
//        if !target.isEmpty {
//            for u in _enemyPart {
//                if u._unit._seat == target {
//                    return true
//                }
//            }
//        }
        return false
    }
    
    func isPlayerPartUnitBlocked(unit:BUnit) -> Bool {
        let s = unit._unit._seat
        var target = ""
        if s == BUnit.BBL {
            target = BUnit.BTL
        } else
        if s == BUnit.BBM {
            target = BUnit.BTM
        } else
        if s == BUnit.BBR {
            target = BUnit.BTR
        } else {
            return false
        }
        if !target.isEmpty {
            for u in _playerPart {
                if u._unit._seat == target {
                    return true
                }
            }
        }
        return false
    }
    internal func selectItem(_ i:Item) {
        debug("asdasdasd \(i._name)")
    }
    internal func showItemPanel() {
        let bip = BattleItemPanel()
        bip._battle = self
        bip.create()
        bip.closeAction = {
            self.cancelButtonClicked()
        }
        bip.selectAction = {
            let item = bip.selectedItem!
            item._battle = self
//            if item is TownScroll {
//                Game.instance.curStage.removeBattle(self)
//                item.use()
//            } else if item.autoCast {
//                item.use(unit: self._curRole, completion: self.moveEnd)
//                self.hideOrder()
//                self.hideCancel()
//                self._curRole.setDefaultMode()
//            } else {
//                self.waitingForSelectItemTarget = true
//                self.showAvailableUnits(selectObject: item)
//                self.hideOrder()
//                self.showCancel()
//            }
            self._selectedItem = item
//            item?.useInBattle()
        }
        addChild(bip)
    }
    internal func wandWitch(spell:Spell) -> Bool {
        if spell.isCurse {
            if _curRole._unit is Character {
                let char = _curRole._unit as! Character
//                if char._weapon is WitchWand {
//                    return true
//                }
            }
        }
        return false
    }
    internal func wandFireMaster(spell:Spell) -> Bool {
        if spell.isMagical && spell.isFire {
            if _curRole._unit is Character {
                let char = _curRole._unit as! Character
//                if char._weapon is FireMaster {
//                    return true
//                }
            }
        }
        
        return false
    }
    internal var cancelTouch = true
    internal var _orders = Array<RoundButton>()
    internal func showOrder() {
        for o in _orders {
            o.isHidden = false
//            addChild(o)
        }
//        hideOrder()
        if _curRole.ifWeaponIs(Outfit.Instrument) {
            _orderAttack.isHidden = true
        }
        if !(_curRole._unit is Character) {
            _orderItem.isHidden = true
            _orderRecall.isHidden = true
            _orderSummon.isHidden = true
        }
        showUnitInfo(hidden: false)
        createRoleSpellsButton()
    }
    internal func hideOrder() {
        for o in _orders {
            o.isHidden = true
//            o.removeFromParent()
        }
        showUnitInfo(hidden: true)
        removeRoleSpellsButton()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.zPosition = MyScene.MASK_LAYER_Z + 1
    }
//    func setEvilsBySeat(evils:Array<Creature>) {
//        //        var ps = [BUnit.RLT,BUnit.RLM,BUnit.RLB,BUnit.RRT,BUnit.RRM,BUnit.RRB]
//        var es = evils
////        let c = 6 - evils.count
////        for _ in 0...c - 1 {
////            let c = Creature()
////            c._seat = "empty"
////            es.append(c)
////        }
//        for i in 0...es.count - 1 {
//            let evil = BUnit()
//            evil.specialUnit = es[i].specialUnit
//            if es[i]._seat == "empty" {
//                evil.createEmpty()
//            } else {
//                evil.setUnit(unit: es[i])
//                evil.create()
//                evil.faceWest()
//                _rightRoles.append(evil)
//                _evilsOrg.append(evil)
//            }
////            evil.unitPos = "right"
//            evil.inleft = false
//            evil._battle = self
//            setEvilPosBySeat(unit: evil)
//            addChild(evil)
//        }
//    }
//    internal func setEvilPosBySeat(unit:BUnit) {
//        let pos = unit._unit._seat
//        switch pos {
//        case "rlt":
//            unit.position.x = rlt[0]
//            unit.position.y = rlt[1]
////            unit._seat = "rlt"
//            if !unit.isEmpty {
//                _right["rlt"] = unit
//            }
//            break;
//        case "rlm":
//            unit.position.x = rlm[0]
//            unit.position.y = rlm[1]
//            unit._seat = "rlm"
//            if !unit.isEmpty {
//                _right["rlm"] = unit
//            }
//            break;
//        case "rlb":
//            unit.position.x = rlb[0]
//            unit.position.y = rlb[1]
//            unit._seat = "rlb"
//            if !unit.isEmpty {
//                _right["rlb"] = unit
//            }
//            break;
//        case "rrt":
//            unit.position.x = rrt[0]
//            unit.position.y = rrt[1]
//            unit._seat = "rrt"
//            if !unit.isEmpty {
//                _right["rrt"] = unit
//            }
//            break;
//        case "rrm":
//            unit.position.x = rrm[0]
//            unit.position.y = rrm[1]
//            unit._seat = "rrm"
//            if !unit.isEmpty {
//                _right["rrm"] = unit
//            }
//            break;
//        case "rrb":
//            unit.position.x = rrb[0]
//            unit.position.y = rrb[1]
//            unit._seat = "rrb"
//            if !unit.isEmpty {
//                _right["rrb"] = unit
//            }
//            break;
//        default:
//            debug("set evil pos error")
//            break
//        }
//    }
    internal var _evilsOrg = Array<BUnit>()
//    func setEvils(evils:Array<Creature>) {
////        var ps = [BUnit.RLT,BUnit.RLM,BUnit.RLB,BUnit.RRT,BUnit.RRM,BUnit.RRB]
//        var es = evils
////        let c = 6 - evils.count
////        for _ in 0...c - 1 {
////            let c = Creature()
////            c._seat = "empty"
////            es.append(c)
////        }
//        for i in 0...es.count - 1 {
//            let evil = BUnit()
//            evil.specialUnit = es[i].specialUnit
//            if es[i]._seat == "empty" {
//                evil.createEmpty()
//            } else {
//                evil.setUnit(unit: es[i])
//                evil.create()
//                evil.faceWest()
//                _rightRoles.append(evil)
//                _evilsOrg.append(evil)
//            }
////            evil.unitPos = "right"
//            evil.inleft = false
//            evil._battle = self
//            setEvilPos(unit: evil)
//            addChild(evil)
//        }
//    }
    internal var _enemySeatsArray = [BUnit.TTL, BUnit.TTM, BUnit.TTR, BUnit.TBL, BUnit.TBM, BUnit.TBR]
    internal var _enemySeats = Dictionary<String, CGPoint>()
    internal var _playerSeats = Dictionary<String, CGPoint>()
    func setEnemyPart(minions:Array<Creature>) {
        for m in minions {
//            debug(m._name)
//            for s in m._spellsInuse {
//                debug(s._name)
//            }
            let bUnit = BUnit()
            bUnit.setUnit(unit: m)
            bUnit._battle = self
            bUnit.playerPart = false
            bUnit.create()
            bUnit.faceSouth()
            if m._seat == BUnit.STAND_BY {
                let index = seed(max: _enemySeatsArray.count)
                m._seat = _enemySeatsArray[index]
                _enemySeatsArray.remove(at: index)
            }
            bUnit.position = _enemySeats[m._seat]!
            if m is Boss {
                bUnit.yAxis = cellSize * 4.75
            }
//            bUnit.burning()
            _enemyPart.append(bUnit)
            _evilsOrg.append(bUnit)
            addChild(bUnit)
            
//            m._rhythm = 200
//            bUnit.burning()
        }
    }
    internal func getBossYAxis() -> CGFloat {
        return cellSize * 4.25
    }
    func addEnemy(unit:Creature) -> BUnit {
        let bUnit = BUnit()
        bUnit.setUnit(unit: unit)
        bUnit.create()
        addEnemy(bUnit: bUnit)
        
        return bUnit
    }
    func addEnemy(bUnit:BUnit) {
        bUnit._battle = self
        bUnit.playerPart = false
        bUnit.faceSouth()
        bUnit.position = _enemySeats[bUnit._unit._seat]!
        _enemyPart.append(bUnit)
        addChild(bUnit)
    }
    
    func addPlayerMinion(unit:Unit) -> BUnit {
        let bUnit = BUnit()
        bUnit.playerPart = true
        bUnit.setUnit(unit: unit)
        bUnit.create()
        addPlayerMinion(bUnit: bUnit)
        
        return bUnit
    }
    func addPlayerMinion(bUnit:BUnit) {
        bUnit._battle = self
        bUnit.playerPart = true
        bUnit.faceNorth()
        bUnit.position = _playerSeats[bUnit._unit._seat]!
        _playerPart.append(bUnit)
        addChild(bUnit)
    }
    
    func setPlayerPart(roles:Array<Unit>) {
        for r in roles {
            let bUnit = BUnit()
            bUnit.setUnit(unit: r)
            bUnit._battle = self
            bUnit.playerPart = true
            bUnit.create()
            bUnit.faceNorth()
            bUnit.position = _playerSeats[r._seat]!
            _playerPart.append(bUnit)
            addChild(bUnit)
            if r is Character {
                _playerUnit = bUnit
            }
        }
    }
    func getUnitBySeat(seat:String) -> BUnit? {
        for u in _playerPart + _enemyPart {
            if seat == u._unit._seat {
                return u
            }
        }
        return nil
    }
    internal var _emptyPos = [0,1,2,3,4,5]
//    func setEvilPos(unit:BUnit) {
//        let index = seed(max: _emptyPos.count)
//        let pos = _emptyPos[index]
//        _emptyPos.remove(at: index)
//        switch pos {
//        case 0:
//            unit.position.x = rlt[0]
//            unit.position.y = rlt[1]
//            unit._seat = "rlt"
//            if !unit.isEmpty {
//                _right["rlt"] = unit
//            }
//            break;
//        case 1:
//            unit.position.x = rlm[0]
//            unit.position.y = rlm[1]
//            unit._seat = "rlm"
//            if !unit.isEmpty {
//                
//                _right["rlm"] = unit
//            }
//            break;
//        case 2:
//            unit.position.x = rlb[0]
//            unit.position.y = rlb[1]
//            unit._seat = "rlb"
//            if !unit.isEmpty {
//                
//                _right["rlb"] = unit
//            }
//            break;
//        case 3:
//            unit.position.x = rrt[0]
//            unit.position.y = rrt[1]
//            unit._seat = "rrt"
//            if !unit.isEmpty {
//                
//                _right["rrt"] = unit
//            }
//            break;
//        case 4:
//            unit.position.x = rrm[0]
//            unit.position.y = rrm[1]
//            unit._seat = "rrm"
//            if !unit.isEmpty {
//                
//                _right["rrm"] = unit
//            }
//            break;
//        case 5:
//            unit.position.x = rrb[0]
//            unit.position.y = rrb[1]
//            unit._seat = "rrb"
//            if !unit.isEmpty {
//                
//                _right["rrb"] = unit
//            }
//            break;
//        default:
//            debug("set evil pos error")
//            break
//        }
//    }
    
    internal func createPlayerPartUnit(c:Unit) -> BUnit {
        let role = BUnit()
        role.playerPart = true
        role.setUnit(unit: c)
        role.create()
        role._battle = self
        _playerPart.append(role)
        role.faceNorth()
        setRolePos(unit: role)
        addChild(role)
        return role
    }
    
    internal var _roles = Array<BUnit>()
    func setRolePos(unit:BUnit) {
//        let index = seed(max: _rolePos.count)
        let pos = unit._unit._seat
//        _rolePos.remove(at: index)
        switch pos {
        case BUnit.BBL:
            unit.position = bbl
            break
        case BUnit.BBM:
            unit.position = bbm
            break
        case BUnit.BBR:
            unit.position = bbr
            break
        case BUnit.BTL:
            unit.position = btl
            break
        case BUnit.BTM:
            unit.position = btm
            break
        case BUnit.BTR:
            unit.position = btr
            break
        default:
            debug("set evil pos error")
            break
        }
    }
    //unused
    func getPosByStr(_ str:String) -> Array<CGFloat> {
        switch str {
        case "llt":
            return llt;
        case "llm":
            return llm;
        case "llb":
            return llb;
        case "lrt":
            return lrt;
        case "lrm":
            return lrm;
        case "lrb":
            return lrb;
        case "rlt":
            return rlt;
        case "rlm":
            return rlm;
        case "rlb":
            return rlb;
        case "rrt":
            return rrt;
        case "rrm":
            return rrm;
        case "rrb":
            return rrb;
        default:
            return llt
        }
    }
    
    func getEmptySeats(top:Bool = false) -> Array<String> {
        var seats = Array<String>()
        if top {
            var ps = [BUnit.TTL, BUnit.TTM, BUnit.TTR, BUnit.TBL, BUnit.TBM, BUnit.TBR]
            for i in 0...ps.count - 1 {
                for u in _enemyPart {
                    if u._unit._seat == ps[i] {
                        ps[i] = "e"
                        //                    ps.remove(at: i)
                    }
                }
                if ps[i] != "e" {
                    seats.append(ps[i])
                }
            }
        } else {
            var ps = [BUnit.BTL,BUnit.BTM,BUnit.BTR,BUnit.BBL,BUnit.BBM,BUnit.BBR]
            for i in 0...ps.count - 1 {
                for u in _playerPart {
                    if u._unit._seat == ps[i] {
                        ps[i] = "e"
                        //                    ps.remove(at: i)
                    }
                }
                if ps[i] != "e" {
                    seats.append(ps[i])
                }
            }
        }
        
        return seats
    }
    
    func removeFromPart(unit:BUnit) {
        if unit.playerPart {
            let index = _playerPart.firstIndex(of: unit)
            if nil != index {
                _playerPart.remove(at: index!)
            } else {
                debug("removeFromPart index nil1")
            }
        } else {
            let index = _enemyPart.firstIndex(of: unit)
            if nil != index {
                _enemyPart.remove(at: index!)
//                debug("removeFromPart index nil2")
            }
        }
        let index = _roleAll.firstIndex(of: unit)
        if nil != index {
            _roleAll.remove(at: index!)
//            debug("removeFromPart index nil3")
        }
    }
    
//    func showItemTargets() {
//        let item = _selectedItem.prop as! Item
//        if item is TownScroll {
////            Game.instance.stage.removeBattle(b: self)
////            item.use(target: Creature())
////            return
//        }
//        _waitingForSelectTarget = false
//
//        if item.targetSelf {
//            for u in _playerPart {
//                u.setSelectableMode()
//            }
//            for u in _enemyPart {
//                u.setDefaultMode()
//            }
//            _itemTargets = _playerPart
//        } else {
//            for u in _enemyPart {
//                u.setSelectableMode()
//            }
//            _itemTargets = _enemyPart
//        }
//        waitingForSelectItemTarget = true
//        showCancel()
//    }
    
//    func removeItemPanel(bip:BItemPanel) {
//        bip.removeFromParent()
//        waitingForSelectItemTarget = false
//        showOrder()
//        hideCancel()
//    }
    
    internal func showSummonableSeats(selectAll:Bool = true) {
        cleanSummonSeats()
        var ps = [BUnit.BTL,BUnit.BTM,BUnit.BTR,BUnit.BBL,BUnit.BBM,BUnit.BBR]
        let index = ps.firstIndex(of: _char._seat)
        if nil == index {
            debug("error showSummonableSeats")
        }
        ps.remove(at: index!)
        
        var existUnitSeats = Array<String>()
        for u in _playerPart {
            existUnitSeats.append(u._unit._seat)
        }
        
        for s in ps {
            if existUnitSeats.firstIndex(of: s) != nil {
                if selectAll {
                    let unit = findUnitBySeat(part: _playerPart, seat: s)
                    unit?.setSelectableMode()
                    _summonUnits[s] = unit!
                }
            } else {
                let emptyBUnit = BUnit()
                emptyBUnit.playerPart = true
                emptyBUnit.createEmpty()
                emptyBUnit.setSelectableMode()
                emptyBUnit._battle = self
                let c = Creature("")
                c._seat = s
                emptyBUnit._unit = c
                setRolePos(unit: emptyBUnit)
                addChild(emptyBUnit)
                _summonUnits[s] = emptyBUnit
            }
        }
    }
    
    internal func cleanSummonSeats() {
        for u in _summonUnits.values {
            if u.isEmpty {
//                _summonUnits.removeValue(forKey: u._seat)
                u.removeFromParent()
            } else {
                u.setDefaultMode()
            }
        }
        _summonUnits = Dictionary<String, BUnit>()
    }
    
    internal func showMinionsList() {
        let clp = RoleList()
        var summonableMinions = Array<Creature>()
        for m in _char._minions {
            if m._seat == BUnit.STAND_BY {
                summonableMinions.append(m)
            }
        }
        clp.create(list: summonableMinions)
        let this = self
        clp.selectAction = {
            this.waitingForSelectSummonSeat = true
            this.showSummonableSeats(selectAll: true)
            clp.removeFromParent()
            this._selectedMinion = clp._lastSelected!._unit
        }
        clp.closeAction = {
            self.showOrder()
            self.hideCancel()
        }
//        clp.create(list: summonableMinions)
        
        addChild(clp)
    }
    
    internal func showRecallMinions() {
        for u in _playerPart {
//            if _char._minions.firstIndex(of: u._unit) != nil {
//                u.setSelectableMode()
//            }
        }
    }
    
    internal var _summonUnits = Dictionary<String, BUnit>()
    internal var _selectedMinion:Unit!
    
    
    internal var s:CGFloat = 0
    internal var xd:CGFloat = 0
    internal var yd:CGFloat = 0
    
    internal var ttl = CGPoint()
    internal var ttm = CGPoint()
    internal var ttr = CGPoint()
    internal var tbl = CGPoint()
    internal var tbm = CGPoint()
    internal var tbr = CGPoint()
    internal var btl = CGPoint()
    internal var btm = CGPoint()
    internal var btr = CGPoint()
    internal var bbl = CGPoint()
    internal var bbm = CGPoint()
    internal var bbr = CGPoint()
    
    internal var llt = Array<CGFloat>()
    internal var llm = Array<CGFloat>()
    internal var llb = Array<CGFloat>()
    internal var lrt = Array<CGFloat>()
    internal var lrm = Array<CGFloat>()
    internal var lrb = Array<CGFloat>()
    internal var rlt = Array<CGFloat>()
    internal var rlm = Array<CGFloat>()
    internal var rlb = Array<CGFloat>()
    internal var rrt = Array<CGFloat>()
    internal var rrm = Array<CGFloat>()
    internal var rrb = Array<CGFloat>()
    
//    internal var ttl = Array<CGFloat>()
    
    var _left = Dictionary<String, BUnit>()
    var _right = Dictionary<String, BUnit>()
    
    var _playerPart = Array<BUnit>()
    var _enemyPart = Array<BUnit>()
    
    var _leftRoles = Array<BUnit>()
    var _rightRoles = Array<BUnit>()
    
    var _curRole:BUnit = BUnit()
    var _playerUnit:BUnit = BUnit()
    var _selectedItem:Item?
//    var _specialEvents:Array<String> = [false]
//    var isFinalChallenge = false
    //0 判定是否是荆棘反伤
    var spellDecision:Array<Bool> = [false]
    //创世之矩技能
    var _creationMatrixSpell:Spell?
    var _animationLayer = SKSpriteNode()
    //追击锁定的目标
    var _lockedTarget:BUnit!
}
