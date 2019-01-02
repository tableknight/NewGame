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
        
        //        if _roundLabel.contains(s) {
        //            Game.instance.stage.removeBattle(b: self)
        //            let tp = TownScroll()
        //            tp.use(target: Creature())
        //            return
        //        }
        
        if _orderCancel.contains(s) && _orderCancel.visible {
            cancelButtonClicked()
            return
        }
        
        if waitingForSelectItemTarget {
            let this = self
            for u in _itemTargets {
                if u.contains(s) {
                    waitingForSelectItemTarget = false
                    this.hideCancel()
                    this.setUnitDefault(all: true)
                    let item = _selectedItem.prop as! Item
                    item._battle = self
                    item.use(unit: u) {
                        this.moveEnd()
                    }
                    _char.removeProp(p: item)
                    break
                }
            }
            return
        }
        
        if waitingForSelectRecallTarget {
            for u in _playerPart {
                if u.contains(s) {
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
                    if _selectedSpell is Interchange {
                        waitingForSelectSummonSeat = false
                        _selectedTarget = u
                        let this = self
                        speakSpellName()
                        _selectedSpell.cast {
                            this.moveEnd()
                            this.cdSpell(spell: this._selectedSpell)
                        }
                        cleanSummonSeats()
                        setUnitDefault(all: true)
                        hideCancel()
                        return
                    }
                    if _selectedSpell is SummonFlower {
                        let flower = FlowerOfHeal()
                        if _curRole._unit is Character {
                            flower._growth.strength = 1
                            flower._growth.stamina = 1
                            flower._growth.agility = 1
                            flower._growth.intellect = 1
                        } else {
                            flower._growth.strength = _curRole._unit._growth.strength * 0.5
                            flower._growth.stamina = _curRole._unit._growth.stamina * 0.5
                            flower._growth.agility = _curRole._unit._growth.agility * 0.5
                            flower._growth.intellect = _curRole._unit._growth.intellect * 0.5
                        }
                        flower.create(level: _curRole._unit._level)
                        
                        //                        _mainChar.showText(text: _selectedSpell._name)
                        //                        _curRole.speak(text: "")
                        speakSpellName()
                        let this = self
                        _curRole.actionCast {
                            u.removeFromParent()
                            this.waitingForSelectSummonSeat = false
                            flower._seat = seat
                            let flowerBUnit = this.createPlayerPartUnit(c: flower)
                            this.cdSpell(spell: this._selectedSpell)
                            flowerBUnit.actionSummon {
                                this.moveEnd()
                            }
                        }
                        setUnitDefault(all: true)
                        cleanSummonSeats()
                        hideCancel()
                        return
                    }
                    if u.isEmpty {
                        if _char._minionsCount <= (_playerPart.count - 1) {
                            showMsg(text: "战场随从已达上限！")
                            return
                        }
                        
                        _playerUnit.showText(text: "召唤")
                        u.removeFromParent()
                        waitingForSelectSummonSeat = false
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
        
        
        
        if _orderItem.contains(s) && !_orderItem.isHidden {
            showItemPanel()
            hideOrder()
            showCancel()
            _waitingForSelectTarget = false
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
            _waitingForSelectTarget = true
            _selectedSpell = Attack()
            _selectedSpell._battle = self
            showAvailableUnits()
            return
        } else if _orderDefend.contains(s) && !_orderDefend.isHidden {
            _selectedSpell = Defend()
            _selectedSpell._battle = self
            _curRole.isDefend = true
            setUnitDefault(all: true)
            hideOrder()
            hideCancel()
            moveEnd()
            return
        } else if _orderSpell.contains(s) && !_orderSpell.isHidden {
            showSpellCards()
            hideOrder()
            showCancel()
            _waitingForSelectTarget = false
            return
        }
        
        if _waitingForSelectTarget {
            _selectedTarget = nil
            for unit in _playerPart {
                if unit.contains(s) && unit.selectable {
                    _selectedTarget = unit
                }
                
            }
            for unit in _enimyPart {
                if unit.contains(s) && unit.selectable {
                    _selectedTarget = unit
                }
            }
            if _selectedTarget != nil {
                _waitingForSelectTarget = false
                setUnitDefault(all: true)
                _selectedTarget!.setSelectedMode()
                hideCancel()
                hideOrder()
                execOrder()
            } else {
                print("has no selected target!")
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
        let y1 = c * 3.5
        let y2 = c * 2
        let y3 = -c * 2
        let y4 = -c * 4
        
        let s:CGFloat = cellSize * 0.5
        
        ttl.x = x1 + s
        ttl.y = y1
        
        ttm.x = x2
        ttm.y = y1
        
        ttr.x = x3 - s
        ttr.y = y1
        
        tbl.x = x1 + s
        tbl.y = y2
        
        tbm.x = x2
        tbm.y = y2
        
        tbr.x = x3 - s
        tbr.y = y2
        
        btl.x = x1
        btl.y = y3
        
        btm.x = x2
        btm.y = y3
        
        btr.x = x3
        btr.y = y3
        
        bbl.x = x1
        bbl.y = y4
        
        bbm.x = x2
        bbm.y = y4
        
        bbr.x = x3
        bbr.y = y4
        
        _enimySeats[BUnit.TTL] = ttl
        _enimySeats[BUnit.TTM] = ttm
        _enimySeats[BUnit.TTR] = ttr
        _enimySeats[BUnit.TBL] = tbl
        _enimySeats[BUnit.TBM] = tbm
        _enimySeats[BUnit.TBR] = tbr
        
        _playerSeats[BUnit.BTL] = btl
        _playerSeats[BUnit.BTM] = btm
        _playerSeats[BUnit.BTR] = btr
        _playerSeats[BUnit.BBL] = bbl
        _playerSeats[BUnit.BBM] = bbm
        _playerSeats[BUnit.BBR] = bbr
        
        _char = Game.instance.char!
        createBG()
        createOrder()
        isUserInteractionEnabled = true;
    }
    internal var _isCharDead = false;
    internal var _isAllEvilDead = false;
    func battleStart() {
        for p in _char._props {
            if p is Item {
                let item = p as! Item
                item._timeleft = 0
            }
        }
        
        for s in _char._spellsInuse {
            s._timeleft = 0
        }
        
        for m in _char._minions {
            for s in m._spellsInuse {
                s._timeleft = 0
            }
        }
        
//        _roundLabel.fontSize = 18
//        _roundLabel.align = "left"
//        _roundLabel.position.x = -cellSize * 7.5
//        _roundLabel.position.y = cellSize * 4 - 10
//        addChild(_roundLabel)
        roundStart()
    }
    internal var _roundLabel = Label()
    internal func defaultOrderAttack() {
        if !(_curRole._unit._weapon is Instrument) {
            _waitingForSelectTarget = true
            _selectedSpell = Attack()
            _selectedSpell._battle = self
            showAvailableUnits()
        }
    }
    func reduceCooldown() {
        for u in _enimyPart {
            for s in u._unit._spellsInuse {
                if s._timeleft > 0 {
                    s._timeleft -= 1
                }
            }
        }
        for u in _playerPart {
            for s in u._unit._spellsInuse {
                if s._timeleft > 0 {
                    s._timeleft -= 1
                }
            }
        }
        
        for p in _char._props {
            if p is Item {
                let item = p as! Item
                if item._timeleft > 0 {
                    item._timeleft -= 1
                }
            }
        }
        
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
        if _enimyPart.contains(unit) {
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
        for u in _enimyPart {
            for s in u._status.values {
                s.inEndOfRound()
            }
        }
    }
    func moveStart() {
//        if _isCharDead {
//            defeated()
//            return
//        }
//        if _isAllEvilDead {
//            defeat()
//            return
//        }
        if _roleAll.count <= 0 {
            debug("roleAll empty")
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
            
            this.createAction()
        }
    }
    internal func createAction() {
        let this = self
        _curRole.isDefend = false
        if this._curRole.hasStatus(type: Status.FREEZING) {
            this._curRole.actionUnfreeze {
                print("unfreezing")
                this._curRole.removeStatus(type: Status.FREEZING)
                this.moveEnd()
            }
            return
        }
        
        if !_curRole._unit.hasAction {
            moveEnd()
            return
        }
        
        if _curRole.hasStatus(type: Status.TAUNTED) {
            this._selectedSpell = Attack()
            this._selectedSpell._battle = self
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
        
        if !_curRole.playerPart {
            this.createAI()
        } else {
            if this._curRole.hasSpell(spell: Crazy()) {
                this._selectedSpell = Attack()
                this._selectedSpell._battle = self
                this._selectedSpell.findTarget()
                this.execOrder()
            } else {
                this._curRole.setOrderMode()
                this.defaultOrderAttack()
                this.showOrder()
                this.hideCancel()
            }
        }
    }
    internal func cleanUnitStatus() {
        for unit in _enimyPart {
            unit._speed = 0
        }
        for unit in _playerPart {
            unit._speed = 0
        }
    }
    
    internal func createAI() {
        let _seed = seed(max:101)
        let sensitive = _curRole._unit._sensitive
        if _seed < sensitive {
            let sps = _curRole.getActiveSpell()
//            debug("ai cast spell")
            if sps.count < 1 {
                _selectedSpell = Attack()
            } else {
                _selectedSpell = sps[seed(max: sps.count)]
            }
            _selectedSpell._battle = self
            _selectedSpell.findTarget()
            execOrder()
        } else if _seed < (sensitive + 25) {
//            debug("ai cast defend")
            _curRole.isDefend = true
            _selectedSpell = Defend()
            _selectedSpell._battle = self
            let this = self
            _curRole.showText(text: "防御") {
                this.execOrder()
            }
        } else {
//            debug("ai cast attack")
            _selectedSpell = Attack()
            _selectedSpell._battle = self
            _selectedSpell.findTarget()
            execOrder()
        }
    }
    var victory = false
    internal func defeat() {
        if victory {
            return
        }
        print("defeat")
        let l = Loot()
        let ms = _char.getReadyMinions()
        for u in _evilsOrg {
            l.loot(role: u._unit)
            let exp = l.getExp(level: u._unit._level)
            _char.expUp(up: exp)
            debug("\(_char._name)获得了\(exp.toInt())点经验。")
            for m in ms {
                if m._extensions.hp > 0 {
                    let ep = l.getExp(level: u._unit._level)
                    m.expUp(up: ep)
                    debug("\(m._name)获得了\(ep.toInt())点经验。")
                }
            }
        }
        victory = true
        let list = l.getList()
        fadeOutBattle()
        
        if list.count > 0 {
            let p = LootPanel()
            p.create(props: list)
            Game.instance.curStage.showPanel(p)
        }
    }
    internal func defeated() {
//        print("defeated")
        victory = false
        showMsg(text: "战斗失败！")
        fadeOutBattle()
    }
    func fadeOutBattle() {
//        let this = self
//        run(SKAction.fadeOut(withDuration: TimeInterval(1))) {}
        if victory {
            defeatAction()
        } else {
            defeatedAction()
        }
        Game.instance.curStage.removeBattle(self)
    }
//    var afterBatteAction = func(victory:Bool){}
//    var afterBatteAction = {}
    var defeatAction = {}
    var defeatedAction = {}
    func hasFinished() -> Bool {
        if _enimyPart.count < 1 {
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
        for unit in _enimyPart {
            if nil != unit._unit._weapon {
                _speedLine += unit.getSpeed() * unit._unit._weapon!._attackSpeed
            } else {
                _speedLine += unit.getSpeed()
            }
        }
        for unit in _playerPart {
            if nil != unit._unit._weapon {
                _speedLine += unit.getSpeed() * unit._unit._weapon!._attackSpeed
            } else {
                _speedLine += unit.getSpeed()
            }
        }
    }
    internal func roundStart(){
        _round += 1
        _roundLabel.text = "第\(_round)回合"
        cleanUnitStatus()
        reduceCooldown()
        calcSpeedLine()
        orderUnits()
        let this = self
        setTimeout(delay: 0.5, completion: {
            this.moveStart()
        })
    }
    internal func orderUnits() {
        var all = _enimyPart + _playerPart
        _roleAll = []
        while all.count > 0 {
            for unit in all {
                if nil != unit._unit._weapon {
                    unit._speed += unit.getSpeed() * unit._unit._weapon!._attackSpeed
                } else {
                    unit._speed += unit.getSpeed()
                }
                if unit._speed >= _speedLine {
                    _roleAll.append(unit)
                    all.remove(at: all.index(of: unit)!)
                }
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
            debug("行为混乱")
            completion()
        } else {
            createCurRole {
                completion()
            }
        }
        //print(_curRole._unit._name)
    }
    
    internal func createCurRole(completion:@escaping () -> Void) {
        _curRole = _roleAll[0]
        //            let this = self
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
        let index = _roleAll.index(of: unit)
        if nil != index {
            _roleAll.remove(at: index!)
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
//        let hw = -Game.instance.screenWidth * 0.5
//        let hh = -Game.instance.screenHeight * 0.5
//        _orderAttack = createMenuButton(x: hw + 30, y: hh + 30, size: 30, text: "攻击")
//        _orderDefend = createMenuButton(x: hw + 20, y: hh + 90, size: 20, text: "防御")
//        _orderSpell = createMenuButton(x: hw + 90, y: hh + 20, size: 20, text: "法术")
//        _orderItem = createMenuButton(x: hw + 75, y: hh + 75, size: 20, text: "物品")
//        _orderSummon = createMenuButton(x: hw + 140, y: hh + 20, size: 20, text: "召唤")
//        _orderRecall = createMenuButton(x: hw + 190, y: hh + 20, size: 20, text: "召回")
//        _orderCancel = createMenuButton(x: -hw - 30, y: hh + 30, size: 30, text: "取消")
        
        let y = -cellSize * 6.5
        let size:CGFloat = cellSize * 0.45
        let x = -cellSize * 3.5
        let gap = size + cellSize * 0.5
        _orderAttack = createMenuButtons(x: x, y: y, size: size, text: "攻击")
        _orderDefend = createMenuButtons(x: x + gap, y: y, size: size, text: "防御")
        _orderSpell = createMenuButtons(x: x + gap * 2 , y: y, size: size, text: "法术")
        _orderItem = createMenuButtons(x: x + gap * 3, y: y, size: size, text: "物品")
        _orderSummon = createMenuButtons(x: x + gap * 4, y: y, size: size, text: "召唤")
        _orderRecall = createMenuButtons(x: x + gap * 5, y: y, size: size, text: "召回")
        _orderCancel = createMenuButtons(x: -x, y: y, size: size, text: "取消")
        
        _orders.append(_orderAttack)
        _orders.append(_orderDefend)
        _orders.append(_orderSpell)
        _orders.append(_orderItem)
        _orders.append(_orderSummon)
        _orders.append(_orderRecall)
    }
    private func createMenuButtons(x:CGFloat, y:CGFloat, size:CGFloat, text:String) -> RoundButton {
        let s = RoundButton()
        s.create(text: text, size: size)
        s.position.x = x
        s.position.y = y
        s.zPosition = MyStage.UI_LAYER_Z
        s.hide()
        addChild(s)
        _orders.append(s)
        return s
    }
    var _selectedSpell = Spell()
    internal var _waitingForSelectTarget = false
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
        for u in _enimyPart {
            if u.isDead() {
                u.actionDead {
                    u.removeFromBattle()
                    u.removeFromParent()
                }
            }
        }
    }
    //行动结束后释放的法术或者道具只能存在一个
    internal func moveEnd() {
//        checkRoleDead()
        
//        if _rightRoles.count < 1 {
//            defeat()
//            return
//        }
//        if Data.instance._char._extensions.hp < 1 {
//            defeated()
//            return
//        }
        for s in _curRole._status.values {
            if s._timeleft > 0 {
                s._timeleft -= 1
                if s._timeleft == 0 {
                    s.afterTimesUp()
                }
            }
        }
        var hasAfterMoveAction = false
        let this = self
        for s in _curRole._unit._spellsInuse {
            if s.hasAfterMoveAction {
                s._battle = self
                _curRole.showText(text: s._name)
                s.afterMove {
                    this._selectedTarget = nil
                    this._waitingForSelectTarget = false
                    this.moveStart()
                }
                hasAfterMoveAction = true
                break
            }
        }
        if !hasAfterMoveAction {
            if _curRole._unit is Character && Game.instance.char._shield is Faceless && _round % 3 == 1 {
//                let c = _curRole
                _curRole.showText(text: "无面者") {
                    this._curRole.actionBuff {
                        let spell = MagicReflect()
                        spell.removeSpecialStatus(t:this._curRole)
                        let status = Status()
                        status._type = Status.EYE_TO_EYE
                        status._timeleft = 2
                        this._curRole.addStatus(status: status)
                        
                        this._selectedTarget = nil
                        this._waitingForSelectTarget = false
                        this.moveStart()
                    }
                }
            } else {
                _selectedTarget = nil
                _waitingForSelectTarget = false
                moveStart()
            }
        }
    }
//    internal func targetAttacked() {
//        let this = self
//        debug("targetAttacked")
//        _selectedSpell.cast() {
//            //近战攻击并且时物理技能才需要跑回去
//            if this._curRole._unit._weapon.isClose && this._selectedSpell.isPhysical {
//                this.moveBack(unit: this._curRole) {
//
//                }
//            } else {
//                this.moveEnd()
//            }
//            this.unitDead()
//        }
//    }
//    internal func unitDead() {
////        let this = self
////        if this._selectedTarget.isDead() {
////            this._selectedTarget.actionDead {
////                if this._left.index(forKey: this._selectedTarget._seat) != nil {
////                    this._left.removeValue(forKey: this._selectedTarget._seat)
////                }
////                if this._right.index(forKey: this._selectedTarget._seat) != nil {
////                    this._right.removeValue(forKey: this._selectedTarget._seat)
////                }
////                this._selectedTarget.removeFromParent()
////            }
////            if _selectedTarget._unit._name == Data.instance._char._name {
////                _isCharDead = true
////            }
////            if _right.values.count <= 0 {
////                _isAllEvilDead = true
////            }
////        }
//        let this = self
//        for unit in _left.values {
//            if unit.isDead() {
//                this._left.removeValue(forKey: unit._seat)
//                if unit._unit._name == Data.instance._char._name {
//                    this._isCharDead = true
//                }
//                unit.actionDead {
//                    unit.removeFromParent()
//                }
//
//            }
//        }
//        for unit in _right.values {
//            if unit.isDead() {
//                this._right.removeValue(forKey: unit._seat)
//                unit.actionDead {
//                    unit.removeFromParent()
//                }
//            }
//        }
//        if this._right.values.count <= 0 {
//            this._isAllEvilDead = true
//        }
//
//    }
    internal func cdSpell(spell:Spell) {
        if Mode.nocd {
            return
        }
        if spell._cooldown > 0 {
            if Game.instance.curStage.hasTowerStatus(status: TimeReduce()) {
                spell._timeleft = spell._cooldown
            } else {
                spell._timeleft = spell._cooldown + 1
            }
        }
    }
    internal func speak(text:String = "") {
        var speaking = _selectedSpell._name
        if text.count > 0 {
            speaking = text
        }
        if speaking.count > 0 {
            _curRole.speakInBattle(text: speaking)
        }
    }
    internal func speakSpellName() {
        _curRole.showText(text:_selectedSpell._name)
    }
    internal func execOrder() {
        let this = self
//        speak()
        speakSpellName()
        var delay:CGFloat = 0
        if _selectedSpell.isPhysical && !(_selectedSpell is Attack) {
            delay = 1
        }
//        debug("delay is \(delay)")
        setTimeout(delay: delay, completion: {
            this._selectedSpell.cast {
                this.cdSpell(spell: this._selectedSpell)
                this.moveEnd()
            }
        })
    
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
        _waitingForSelectTarget = false
        waitingForSelectSummonSeat = false
        waitingForSelectItemTarget = false
        waitingForSelectRecallTarget = false
        removeSpellCards()
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
        for unit in _enimyPart {
            unit.setDefaultMode()
        }
    }
    internal func showUnitInfo(hidden:Bool = false) {
        for u in _playerPart {
            u._levelLabel.isHidden = hidden
        }
        for u in _enimyPart {
            u._levelLabel.isHidden = hidden
        }
    }
    internal var _availableEvils = Array<BUnit>()
    internal func showAvailableUnits() {
        setUnitDefault()
        _availableEvils = Array<BUnit>()
        if _selectedSpell.isTargetAll {
            _availableEvils = _enimyPart + _playerPart
            if !_selectedSpell.canBeTargetSelf {
                let index = _availableEvils.index(of: _playerUnit)
                if nil != index {
                } else {
                    debug("showAvailableUnits 找不到主角")
                }
                _availableEvils.remove(at: index!)
            }
            for unit in _availableEvils {
                unit.setSelectableMode()
            }
            return
        }
        if _selectedSpell.isTargetEmemy{
            if _selectedSpell.isClose && _curRole._unit.isClose() {
                if isPlayerPartUnitBlocked(unit: _curRole) {
                    for unit in _enimyPart {
                        if !isEnimyPartUnitBlocked(unit: unit) {
                            _availableEvils.append(unit)
                        }
                    }
                } else {
                    for unit in _enimyPart {
                        _availableEvils.append(unit)
                    }
                }
            } else {
                for unit in _enimyPart {
                    _availableEvils.append(unit)
                }
            }
            
        } else {
            _availableEvils = _playerPart
        }
        for unit in _availableEvils {
            unit.setSelectableMode()
        }
    }
    
    func isEnimyPartUnitBlocked(unit:BUnit) -> Bool{
        let s = unit._unit._seat
        var target = ""
        if s == BUnit.TTL {
            target = BUnit.TBL
        } else
            if s == BUnit.TTM {
                target = BUnit.TBM
            } else
                if s == BUnit.TTR {
                    target = BUnit.TBR
        }
        if !target.isEmpty {
            for u in _enimyPart {
                if u._unit._seat == target {
                    return true
                }
            }
        }
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
        bip.create()
        let this = self
        bip.closeAction = {
            this.cancelButtonClicked()
        }
        bip.selectAction = {
            let item = bip.selectedItem
            item?._battle = self
//            item?.useInBattle()
        }
        addChild(bip)
    }
    internal var _spellCards = Array<BattleSpellIcon>()
    internal func showSpellCards() {
        var spells = Array<Spell>()
        for s in _curRole._unit._spellsInuse {
            if !s.isAuro && !s.isPassive {
                spells.append(s)
            }
        }
        if spells.count > 0 {
            let cardPanel = BattleSpellCard()
            cardPanel.create(spells: spells)
            let this = self
            cardPanel.closeAction = {
                this.showOrder()
                this.hideCancel()
                this.setUnitDefault()
            }
            cardPanel.selectAction = {
                this._selectedSpell = cardPanel.selectedSpell!
                this._selectedSpell._battle = this
                this.hideOrder()
                this.showCancel()
                if this._selectedSpell.isAutoSelectTarget {
                    this._waitingForSelectTarget = false
                    this._selectedSpell.findTarget()
                    this.setUnitDefault(all: true)
                    this.execOrder()
                    this.hideCancel()
                } else {
                    if this._selectedSpell is SummonFlower {
                        this.waitingForSelectSummonSeat = true
                        this.setUnitDefault()
                        this.showSummonableSeats(selectAll: false)
                    } else
                    if this._selectedSpell is Interchange {
                        this.waitingForSelectSummonSeat = true
                        this.setUnitDefault()
                        this.showSummonableSeats()
                    }
                    
                    this._waitingForSelectTarget = true
                    this.showAvailableUnits()
                }
            }
            addChild(cardPanel)
        }
        showCancel()
//        let ta = FrozenShoot()
//        ta._battle = self
//        card.create(spell: ta)
//        card.zPosition = 70
//        addChild(card)
    }
    internal func wandWitch(spell:Spell) -> Bool {
        if spell.isCurse {
            if _curRole._unit is Character {
                let char = _curRole._unit as! Character
                if char._weapon is WitchWand {
                    return true
                }
            }
        }
        return false
    }
    internal func wandFireMaster(spell:Spell) -> Bool {
        if spell.isMagical && spell.isFire {
            if _curRole._unit is Character {
                let char = _curRole._unit as! Character
                if char._weapon is FireMaster {
                    return true
                }
            }
        }
        
        return false
    }
    internal func removeSpellCards() {
        for card in _spellCards {
            card.removeFromParent()
        }
        _spellCards = Array<BattleSpellIcon>()
    }
    
    internal var _orders = Array<RoundButton>()
    internal func showOrder() {
        for o in _orders {
            o.isHidden = false
//            addChild(o)
        }
//        hideOrder()
        if _curRole._unit._weapon is Instrument {
            _orderAttack.isHidden = true
        }
        if !(_curRole._unit is Character) {
            _orderItem.isHidden = true
            _orderRecall.isHidden = true
            _orderSummon.isHidden = true
        }
        showUnitInfo(hidden: false)
    }
    internal func hideOrder() {
        for o in _orders {
            o.isHidden = true
//            o.removeFromParent()
        }
        showUnitInfo(hidden: true)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
    internal var _enimySeatsArray = [BUnit.TTL, BUnit.TTM, BUnit.TTR, BUnit.TBL, BUnit.TBM, BUnit.TBR]
    internal var _enimySeats = Dictionary<String, CGPoint>()
    internal var _playerSeats = Dictionary<String, CGPoint>()
    func setEnimyPart(minions:Array<Creature>) {
        for m in minions {
            let bUnit = BUnit()
            bUnit.setUnit(unit: m)
            bUnit._battle = self
            bUnit.playerPart = false
            bUnit.create()
            bUnit.faceSouth()
            let index = seed(max: _enimySeatsArray.count)
            bUnit.position = _enimySeats[_enimySeatsArray[index]]!
            m._seat = _enimySeatsArray[index]
            _enimySeatsArray.remove(at: index)
            _enimyPart.append(bUnit)
            _evilsOrg.append(bUnit)
            addChild(bUnit)
        }
    }
    func setPlayerPart(roles:Array<Creature>) {
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
    
    internal func createPlayerPartUnit(c:Creature) -> BUnit {
        let role = BUnit()
        role.specialUnit = c.specialUnit
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
    //need replace
//    func setRoles(roles:Array<Creature>) {
//        var ps = [BUnit.LLT,BUnit.LLM,BUnit.LLB,BUnit.LRT,BUnit.LRM,BUnit.LRB]
//        for i in 0...roles.count - 1 {
//            ps.remove(at: ps.index(of: roles[i]._seat)!)
//            let role = BUnit()
//            if roles[i].isMainChar {
//                _mainChar = role
//            }
//            role.specialUnit = roles[i].specialUnit
//            role.setUnit(unit: roles[i])
//            role.create()
////            role.faceEast()
////            role.unitPos = "left"
//            role.inleft = true
//            role._battle = self
//            _leftRoles.append(role)
////            let e = roles[i]
////            print("\(e._name): 攻击：\(e._extensions.attack)，防御：\(e._extensions.defence)， 速度\(e._extensions.speed)")
//            role.faceEast()
//            setRolePos(unit: role)
//            addChild(role)
//        }
//        
////        for s in ps {
////            let emptyBUnit = BUnit()
////            emptyBUnit.createEmpty()
////            let c = Creature()
////            c._seat = s
////            emptyBUnit._unit = c
////            setRolePos(unit: emptyBUnit)
////            addChild(emptyBUnit)
////        }
//    }
//    internal var _rolePos = [0,1,2,3,4,5]
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
    
    func removeFromPart(unit:BUnit) {
        if unit.playerPart {
            let index = _playerPart.index(of: unit)
            if nil != index {
                _playerPart.remove(at: index!)
            } else {
                debug("removeFromPart index nil")
            }
        } else {
            let index = _enimyPart.index(of: unit)
            if nil != index {
                _enimyPart.remove(at: index!)
                debug("removeFromPart index nil")
            }
        }
        let index = _roleAll.index(of: unit)
        if nil != index {
            _roleAll.remove(at: index!)
            debug("removeFromPart index nil")
        }
    }
    
    func showItemTargets() {
        let item = _selectedItem.prop as! Item
        if item is TownScroll {
//            Game.instance.stage.removeBattle(b: self)
//            item.use(target: Creature())
//            return
        }
        _waitingForSelectTarget = false
        
        if item.targetSelf {
            for u in _playerPart {
                u.setSelectableMode()
            }
            for u in _enimyPart {
                u.setDefaultMode()
            }
            _itemTargets = _playerPart
        } else {
            for u in _enimyPart {
                u.setSelectableMode()
            }
            _itemTargets = _enimyPart
        }
        waitingForSelectItemTarget = true
        showCancel()
    }
    
    func removeItemPanel(bip:BItemPanel) {
        bip.removeFromParent()
        waitingForSelectItemTarget = false
        showOrder()
        hideCancel()
    }
    
    internal func showSummonableSeats(selectAll:Bool = true) {
        cleanSummonSeats()
        var ps = [BUnit.BTL,BUnit.BTM,BUnit.BTR,BUnit.BBL,BUnit.BBM,BUnit.BBR]
        let index = ps.index(of: _char._seat)
        if nil == index {
            debug("error showSummonableSeats")
        }
        ps.remove(at: index!)
        
        var existUnitSeats = Array<String>()
        for u in _playerPart {
            existUnitSeats.append(u._unit._seat)
        }
        
        for s in ps {
            if existUnitSeats.index(of: s) != nil {
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
                let c = Creature()
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
            
        }
//        clp.create(list: summonableMinions)
        
        addChild(clp)
    }
    
    internal func showRecallMinions() {
        for u in _playerPart {
            if !(u._unit is Character) {
                u.setSelectableMode()
            }
        }
    }
    
    internal var _summonUnits = Dictionary<String, BUnit>()
    internal var _selectedMinion = Creature()
    
    
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
    var _enimyPart = Array<BUnit>()
    
    var _leftRoles = Array<BUnit>()
    var _rightRoles = Array<BUnit>()
    
    var _curRole:BUnit = BUnit()
    var _playerUnit:BUnit = BUnit()
    var _selectedItem = BItemComponent()
    var _specialEvents = Array<String>()
    var isFinalChallenge = false
}

class BattleSpellIcon1:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let rect = CGRect(x: -cellSize * 0.75, y: -cellSize * 0.75, width: cellSize * 1.5, height: cellSize * 1.5)
        bg = SKShapeNode(rect: rect, cornerRadius: 4)
        bg.fillColor = UIColor.black
        bg.zPosition = 40
        addChild(bg)
        
        let cooldownBG = SKShapeNode(rect: rect, cornerRadius: 4)
        cooldownBG.fillColor = UIColor.black
        cooldownBG.alpha = 0.55
        cooldownBG.isHidden = true
        cooldownBG.zPosition = 41
        addChild(cooldownBG)
        
        let cdNum = Label()
        cdNum.fontSize = 24
        cdNum.isHidden = true
        cdNum.zPosition = 42
        cdNum.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        addChild(cdNum)
        
        _cdNum = cdNum
        _cdBg = cooldownBG
    }
    internal var bg:SKShapeNode!
    internal var _spell:Spell!
    var spell:Spell {
        set {
            _spell = newValue
            let l = Label()
            l.text = _spell._name
            l.fontSize = 14
            l.position.y = -cellSize * 0.5 - 6
            l.zPosition = 40
            addChild(l)
            bg.strokeColor = QualityColor.getColor(_spell._quality)
        }
        get {
            return _spell
        }
    }
    
    internal var _cooldown = 0
    internal var _cdNum = Label()
    internal var _cdBg = SKShapeNode()
    var coolDown:Int {
        set {
            _cooldown = newValue
            if newValue > 0 {
                _cdBg.isHidden = false
                _cdNum.isHidden = false
                _cdNum.text = "\(newValue)"
                bg.strokeColor = UIColor.gray
            } else {
                _cdBg.isHidden = true
                _cdNum.isHidden = true
                bg.strokeColor = UIColor.white
            }
        }
        get {
            return _cooldown
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
