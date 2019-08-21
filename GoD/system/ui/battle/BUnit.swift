//
//  Bunit.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/12.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class BUnit: SKSpriteNode {
    static var LLT = "llt"
    static var LLM = "llm"
    static var LLB = "llb"
    static var LRT = "lrt"
    static var LRM = "lrm"
    static var LRB = "lrb"
    
    static var RLT = "rlt"
    static var RLM = "rlm"
    static var RLB = "rlb"
    static var RRT = "rrt"
    static var RRM = "rrm"
    static var RRB = "rrb"
    
    static var TTL = "ttl"
    static var TTM = "ttm"
    static var TTR = "ttr"
    static var TBL = "tbl"
    static var TBM = "tbm"
    static var TBR = "tbr"
    
    static var BTL = "btl"
    static var BTM = "btm"
    static var BTR = "btr"
    static var BBL = "bbl"
    static var BBM = "bbm"
    static var BBR = "bbr"
    
    var playerPart = false
    var inleft = true
    var _battle:Battle!
    var _stage:MyStage!
    var specialUnit = false
    static var STAND_BY = "standby"
    var _select = SKSpriteNode()
    var _selectTexture = SKTexture(imageNamed: "select.png")
    var hasInitialized = false
    var isDefend = false
    var _speed: CGFloat = 0
    var _acting = false
    var _avoidActing = false
    var _attackActing = false
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _stage = Game.instance.curStage
    }
    var isEmpty = false
    func createEmpty() {
        _charSize = cellSize
        if playerPart {
            _charSize = cellSize * 1.25
        }
        self.size = CGSize(width: _charSize, height: _charSize)
        circleY = -_charSize * 0.25
        _select.size = CGSize(width: _charSize, height: _charSize)
        _select.texture = _selectTexture.getCell(3, 0)
        _select.position.y = circleY
        _select.zPosition = 40
        _charNode.zPosition = 50
        _select.alpha = 0.5
        //        faceEast()
        addChild(_select)
        isEmpty = true
    }
    func create() {
        if 0 == _charSize {
            _charSize = cellSize
        }
        if playerPart {
            _charSize = cellSize * 1.25
        }
        if _unit is Boss {
            _charSize = cellSize * 2
        }
//        self.size = CGSize(width: _charSize, height: _charSize)
        if _unit is Lewis {
            _charNode.size = CGSize(width: _charSize * 1.5, height: _charSize)
        } else {
            _charNode.size = CGSize(width: _charSize, height: _charSize)
        }
        circleY = -_charSize * 0.25
        _select.size = CGSize(width: _charSize, height: _charSize)
        _select.texture = _selectTexture.getCell(3, 0)
        _select.position.y = circleY
        _select.zPosition = 40
        _charNode.zPosition = 50
        _levelLabel.position.y = -_charSize + 10
        if _unit is Boss {
            _levelLabel.position.y = -_charSize * 0.75 - 10
        }
        _levelLabel.position.x = 0
//        faceEast()
        addChild(_select)
        addChild(_charNode)
        addChild(_statusLayer)
        
        createLabel()
        createHPBar()
//        showStatus()
    }
    private var _statusLayer = SKSpriteNode()
    func showStatusText() {
        _statusLayer.removeAllChildren()
        let startY = -_charSize * 0.5
        let gap:CGFloat = 17
        var i:CGFloat = 0
        for s in _status.values {
            if s._timeleft > 0 && !s._labelText.isEmpty {
                createLabelText(text: s._labelText, time: s._timeleft).position.y = startY + gap * i
                i += 1
            }
        }
    }
    private func createLabelText(text:String, time:Int) -> Label {
        let l = Label()
        l.text = "\(text)\(time)"
        l.fontSize = 16
        l.position.x = _charSize * 0.5 + 2
        
        _statusLayer.addChild(l)
        return l
    }
    func createForStage() {
        hasInitialized = true
        if 0 == _charSize {
            _charSize = cellSize
        }
        _charNode.size = CGSize(width: _charSize, height: _charSize)
        circleY = -0.26 * _charSize
        _select.size = CGSize(width: _charSize, height: _charSize)
        _select.texture = _selectTexture.getCell(3, 0)
        _select.position.y = circleY
        _select.zPosition = 40
        _charNode.zPosition = 50
        //        faceEast()
        addChild(_select)
        addChild(_charNode)
    }
    func removeFromBattle() {
        _battle.removeFromPart(unit: self)
    }
    private func createLabel() {
        let label = Label()
        label.fontColor = UIColor.red
        label.text = "23"
        label.fontSize = 18
        label.zPosition = 100
//        label.position.y = _charSize
        addChild(label)
        label.isHidden = true
        _valueText = label
    }
    private func addLabel(fontSize: CGFloat = 24) -> Label {
        let label = Label()
        label.fontColor = UIColor.red
        label.fontSize = fontSize
        label.zPosition = MyScene.MASK_LAYER_Z
        label.align = "center"
        addChild(label)
        return label
    }
    private func createHPBar(value:CGFloat = 1) {
        var hpbarHeight = _charSize * 0.06
        var width = _charSize * 0.8 * value
        var x = -_charSize * 0.4
//        if _unit._quality == Quality.SACRED || _unit is Character {
        if _unit is Character {
            width = _charSize * value
            hpbarHeight = _charSize * 0.08
            x = -_charSize * 0.5
        }
        _hpbar.create(width: width, height: hpbarHeight, value: _unit._extensions.hp / _unit._extensions.health, color: UIColor.red)
        _hpbar.position.y = -_charSize * 0.75
        _hpbar.position.x = x
        _hpbar.zPosition = _charNode.zPosition
        addChild(_hpbar)
        
//        _hpbar = SKShapeNode(rect: CGRect(x: x, y: 0, width: width, height: hpbarHeight))
//        _hpbar.fillColor = UIColor.red
//        _hpbar.zPosition = 50
//        _hpbar.position.y = -_charSize * 0.75
//        addChild(_hpbar)
    }
    private var _valueText = Label()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var _unit:Creature = Creature()
    var _levelLabel = Label()
    func setUnit(unit:Creature) -> Void {
        _unit = unit
//        _speed = unit._extensions.speed
        _levelLabel = Label("lv.\(unit._level.toInt())\(unit._name)", 0, -_charSize, QualityColor.getColor(unit._quality))
        _levelLabel.zPosition = 71
        _levelLabel.fontSize = 14
        _levelLabel.isHidden = true
        _levelLabel.align = "center"
        addChild(_levelLabel)
        _charTexture = unit._img
        
        if hasSpell(spell: TruePower()) {
            strengthChange(value: Game.instance.char._mains.strength * 0.1)
        }
        if hasSpell(spell: Powerful()) {
            strengthChange(value: Powerful.VALUE)
        }
        if hasSpell(spell: SkyAndLand()) {
            intellectChange(value: SkyAndLand.VALUE)
        }
        if hasSpell(spell: SharpStone()) {
            agilityChange(value: SharpStone.VALUE)
        }
        
    }
    func setImg(img:SKTexture) {
        _charNode.texture = img
    }
    var _charTexture = SKTexture()
    var _charNode = SKSpriteNode()
    func faceSouth() {
        if _unit is Boss || _unit is IFace {
            _charNode.texture = _charTexture
        } else {
            _charNode.texture = _charTexture.getCell(1, 0)
        }
    }
    func faceNorth() {
        var y:CGFloat = 3
        if specialUnit {
            y = 2
        }
        _charNode.texture = _charTexture.getCell(1, y)
    }
    func faceWest() {
        _charNode.texture = _charTexture.getCell(1, 1)
    }
    func faceEast() {
        var y:CGFloat = 2
        if specialUnit {
            y = 3
        }
        _charNode.texture = _charTexture.getCell(1, y)
    }
    internal var _wait = SKAction.wait(forDuration: TimeInterval(Game.instance.frameSize))
    func moveNorth() {
        //        faceBack()
        var y:CGFloat = 3
        if specialUnit {
            y = 2
        }
        let move1 = SKAction.setTexture(_charTexture.getCell(0, y))
        let move2 = SKAction.setTexture(_charTexture.getCell(2, y))
        //        let stop = SKAction.setTexture(_charTexture.getTextureCell(1, 3))
        let go = SKAction.sequence([move1, _wait, move2, _wait, move1])
        //        let re = SKAction.repeat(go, count: 5)
        _charNode.run(go)
        //        faceNorth()
    }
    
    func moveSouth() {
        //        faceFront()
        let move1 = SKAction.setTexture(_charTexture.getCell(0, 0))
        let move2 = SKAction.setTexture(_charTexture.getCell(2, 0))
        let go = SKAction.sequence([move1, _wait, move2, _wait, move1])
        _charNode.run(go)
        //        let stop = SKAction.setTexture(_charTexture.getTextureCell(1, 3))
        //        let re = SKAction.repeat(go, count: 5)
        //        let _self = self
    }
    func moveWest() {
        let move1 = SKAction.setTexture(_charTexture.getCell(0, 1))
        let move2 = SKAction.setTexture(_charTexture.getCell(2, 1))
        let go = SKAction.sequence([move1, _wait, move2, _wait, move1])
        _charNode.run(go)
    }
    func moveWest4frame() {
        let move1 = SKAction.setTexture(_charTexture.getCell(0, 1))
        let move2 = SKAction.setTexture(_charTexture.getCell(2, 1))
        let go = SKAction.sequence([move1, _wait, move2, _wait, move1, _wait, move2, _wait])
        _charNode.run(go)
    }
    func moveEast() {
        var y:CGFloat = 2
        if specialUnit {
            y = 3
        }
        let move1 = SKAction.setTexture(_charTexture.getCell(0, y))
        let move2 = SKAction.setTexture(_charTexture.getCell(2, y))
        let go = SKAction.sequence([move1, _wait, move2, _wait, move1])
        _charNode.run(go)
    }
    func moveEast4frame() {
        var y:CGFloat = 2
        if specialUnit {
            y = 3
        }
        let move1 = SKAction.setTexture(_charTexture.getCell(0, y))
        let move2 = SKAction.setTexture(_charTexture.getCell(2, y))
        let go = SKAction.sequence([move1, _wait, move2, _wait, move1, _wait, move2, _wait])
        _charNode.run(go)
    }
    
    func poisoning() {
        let status = Status()
        status._type = Status.NERVOUS_POISON
        status._labelText = "P"
        status._timeleft = 3
        addStatus(status: status)
    }
    
    func burning() {
        if hasSpell(spell: ProtectFromGod()) {
            setTimeout(delay: 0.5, completion: {
                self.showText(text: "IMMUNE")
            })
            return
        }
        let t = self
        let spell = Burning()
        spell._battle = self._battle
        spell._target = self
        if t.hasStatus(type: Status.BURNING) {
            let s = t.getStatus(type: Status.BURNING) as! BurningStatus
            s._level += 1
            s._castSpell = spell
            s._timeleft = 3
            t.addStatus(status: s)
        } else {
            let bs = BurningStatus()
            bs._castSpell = spell
            t.addStatus(status: bs)
        }
        showStatusText()
    }
    func freezing() {
        if hasSpell(spell: RaceSuperiority()) || hasStatus(type: Status.IMMUNE) || _unit is Boss {
            setTimeout(delay: 0.5, completion: {
                self.showText(text: "IMMUNE")
            })
            return
        }
        let target = self
        let status = Status()
        status._type = Status.FREEZING
        status._timeleft = 1
        status._labelText = "F"
        target.addStatus(status: status)
        target.isDefend = false
        target.actionFrozen(){}
    }
    
    func petrify() {
        if hasSpell(spell: ProtectFromGod()) || _unit is Boss || hasStatus(type: Status.IMMUNE) {
            showText(text: "IMMUNE")
            return
        }
        let target = self
        let status = Status()
        status._type = Status.PETRIFY
        status._timeleft = 3
        status._labelText = "P"
        target.addStatus(status: status)
        target.isDefend = false
    }
    
    
    //被选择的单位效果
    func setSelectedMode() {
        _select.texture = _selectTexture.getCell(0, 0)
        let move = SKAction.setTexture(_selectTexture.getCell(3, 0))
        let wait = SKAction.wait(forDuration: TimeInterval(0.5))
        let go = SKAction.sequence([wait, move])
        _select.run(go)
    }
    var _charSize:CGFloat = 0
    private var _hpbar = HBar()
    private var circleY:CGFloat = 0
//    var _seat:String = ""
//    var unitPos = "left"
    var selectable = false
    func setOrderMode() {
        _select.texture = _selectTexture.getCell(0, 0)
        selectable = false
    }
    func setDefaultMode() {
        _select.texture = _selectTexture.getCell(3, 0)
        selectable = false
    }
    func setSelectableMode() {
        _select.texture = _selectTexture.getCell(2, 0)
        selectable = true
    }
    func markDeathGod() -> Bool {
        if _unit is Character {
            let char = _unit as! Character
            if char._magicMark is MarkOfDeathGod {
                return true
            }
        }
        return false
    }
    func markOfHeaven(value:CGFloat) -> Bool {
        if value < 0 && _battle._curRole._unit._race == EvilType.DEMON {
            if _unit is Character {
                let char = _unit as! Character
                if char._magicMark is MarkOfHeaven {
                    return true
                }
            }
        }
        return false
    }
    func silenced(completion:@escaping () -> Void) {
        if markDeathGod() {
            showText(text: "IMMUNE") {
                completion()
            }
            return
        }
        let index = _battle._roleAll.firstIndex(of: self)
        if nil != index {
            _battle._roleAll.remove(at: index!)
        }
        showText(text: "SILENCE", completion: completion)
    }
    func shieldFrancisFace() -> Bool {
        if _unit is Character {
            let char = _unit as! Character
            if char._shield is FrancisFace {
                return true
            }
        }
        return false
    }
    func markMightOfOaks() -> Bool {
        if !(_battle._selectedSpell is Physical) {
            return false
        }
        if _unit is Character {
            let char = _unit as! Character
            if char._magicMark is MarkOfOaks {
                return true
            }
            
        }
        return false
    }
    func sheildEvilExpel(value:CGFloat) -> Bool {
        if value < 0 {
            if _battle._curRole._unit._race == EvilType.DEMON {
                if _unit is Character {
                    let char = _unit as! Character
                    if char._shield is EvilExpel {
                        return true
                    }
                }
            }
        }
        return false
    }
    func showMiss(completion:@escaping () -> Void = {}) {
        showText(text: "MISS") {
            completion()
        }
    }
    //1 physical
    //2 magical
    //3 fire
    //4 water
    //5 thunder
    func showValue(value:CGFloat, source:BUnit? = nil, criticalFromSpell:Bool = true, critical:Bool = false, damageType:Int = 1, textColor:UIColor = DamageColor.DAMAGE, completion:@escaping () -> Void = {}) {
        var value = value
        let s = (source == nil ? _battle._curRole : source)!
        if value < 0 && self._unit._race == EvilType.RISEN {
            if s.ifWeaponIs(TheExorcist()) && seed() < 15 {
                self.showText(text: "EXORCISED") {
                    self.actionDead {
                        self.die()
                        completion()
                    }
                }
                return
            }
        }
        if value < 0 && ifShieldIs(EvilExpel()) && seed() < 15 {
            showText(text: "BLOCK") {
                completion()
                return
            }
        }
        if value > 0 && hasStatus(type: Status.SOUL_SLAY) {
            showText(text: "SLAY") {
                completion()
            }
            return
        }
        if value < 0 && ifShieldIs(Accident()) && damageType == 2 {
            var us = Array<BUnit>()
            for u in _battle._playerPart {
                if !(u._unit is Character) {
                    us.append(u)
                }
            }
            if us.count > 0 {
                self.showText(text: "SHIFT") {
                    let one = us.one()
                    one.showValue(value: value) {
                        completion()
                    }
                }
                return
            }
        }
        
        if value < 0 && _unit._race == EvilType.RISEN && s.ifWeaponIs(HolyPower()) {
            value *= 2
        }
        if value > 0 {
            if ifRingIs(RingOfDeath()) {
                value *= 1.5
            }
            if ifSoulIs(HeartOfTarrasque()) {
                value *= 2
            }
        }
        if hasStatus(type: Status.PETRIFY) && value < 0 {
            value = seed(min: 0, max: 6).toFloat() * 0.01 * value
        }

        var beCritical = _battle._selectedSpell.beCritical
        if value > 0 || !criticalFromSpell || _battle._selectedSpell is Magical {
            beCritical = critical
        }
        
        if hasStatus(type: Status.PROTECTION_FROM_ICE) {
            if value < 0 {
                if -value > getHp() {
                    showText(text: "FATAL") {
                        completion()
                    }
                    removeStatus(type: Status.PROTECTION_FROM_ICE)
                    return
                }
            }
        }
        
        if _battle.spellDecision[0] {
            _battle._curRole.showValuePure(value: value * 0.2)
            value = value * 0.8
            _battle.spellDecision[0] = false
        }
        
        
        let valueText = addLabel()
//        valueText.isHidden = false
        valueText.position.y = _charSize * (playerPart ? 0.35 : 0.55)
        var color = textColor
        var text = "\(value.toInt())"
        if value > 0 {
            color = DamageColor.HEAL
            text = "+\(value.toInt())"
        }
        if beCritical {
//            text = "Ouch!"
            text = "\(value.toInt())!"
//            valueText.fontSize *= 2
        }
        valueText.text = text
        valueText.fontColor = color
        let v = CGVector(dx: 0, dy: _charSize * 0.5)
        let move = SKAction.move(by: v, duration: TimeInterval(0.25))
        let wait = SKAction.wait(forDuration: TimeInterval(1))
        let go = SKAction.sequence([move, wait])
        let this = self
        valueText.run(go) {
            valueText.removeFromParent()
        }
        if hasStatus(type: "_mess_ghost") {
            let s = _battle._selectedSpell
            if s is Magical && !s.isFire && !s.isWater && !s.isThunder {
                setTimeout(delay: 0.5, completion: {
                    if !self.isDead() {
                        self.showValuePure(value: value)
                        self.hpChange(value: value)
                    }
                })
            }
        }
        setTimeout(delay: 0.5) {
            if self.isDead() {
                self.actionDead {
                    self.die()
                    completion()
                }
            } else {
                
                if self.ifShieldIs(FrancisFace()) && self.seed() < 10 {
                    this.showText(text: "CRITICAL +5") {
                        completion()
                    }
                    this._extensions.critical += 5
                    return
                }
                if this.markMightOfOaks() {
                    if this.seed() < 10 {
                        this.showText(text: "MIGHT OF OAKS")
                        let s = Status()
                        s._type = Status.MIGHT_OF_OAKS
                        s._timeleft = 5
                        this.addStatus(status: s)
                    }
                }
                completion()
            }
        }
        
        hpChange(value: value)
    }
    func showValuePure(value: CGFloat) {
        let valueText = addLabel()
        valueText.position.y = _charSize * (playerPart ? 0.35 : 0.55)
        var color = DamageColor.DAMAGE
        var text = "\(value.toInt())";
        if value > 0 {
            color = DamageColor.HEAL
            text = "+\(value.toInt())"
        }
        valueText.text = text
        valueText.fontColor = color
        let v = CGVector(dx: 0, dy: _charSize * 0.5)
        let move = SKAction.move(by: v, duration: TimeInterval(0.25))
        let wait = SKAction.wait(forDuration: TimeInterval(1))
        let go = SKAction.sequence([move, wait])
        let this = self
        valueText.run(go) {
            valueText.removeFromParent()
        }
        setTimeout(delay: 0.5) {
            if this.isDead() {
                this.removeFromBattle()
                this.actionDead {
                    this.removeFromParent()
                }
            }
        }
        
        hpChange(value: value)
    }
    func showText(text:String = "", color:UIColor = UIColor.white, completion:@escaping () -> Void = {}) {
        if "" == text {
            completion()
            return
        }
        let valueText = addLabel(fontSize: 20)
//        _valueText.isHidden = false
        valueText.position.y = _charSize * (playerPart ? 0.35 : 0.55)
        valueText.text = text
        valueText.fontColor = color
        let v = CGVector(dx: 0, dy: _charSize * 0.5)
        let move = SKAction.move(by: v, duration: TimeInterval(0.25))
        let wait = SKAction.wait(forDuration: TimeInterval(0.5))
        let go = SKAction.sequence([move, wait])
//        let this = self
        valueText.run(go) {
            completion()
//            this._valueText.isHidden = true
            valueText.removeFromParent()
        }
    }
    func die() {
        removeFromBattle()
        removeFromParent()
    }
    func shieldAccident(value:CGFloat, completion:@escaping () -> Void) -> Bool {
        if _unit is Character {
            let char = _unit as! Character
            if char._shield is Accident {
                if value < 0 {
                    if _battle._leftRoles.count > 2 {
                       return true
                    }
                    
                }
            }
        }
        return false
    }
    internal var isSwordExorcist = false
    func swordExorcist(value:CGFloat) -> Bool {
        isSwordExorcist = false
        if seed() > TheExorcist.CHANCE {
            return false
        }
        if _unit._race == EvilType.RISEN {
            if _battle._curRole._unit is Character {
                if _battle._curRole._unit._weapon is TheExorcist {
                    if _battle._selectedSpell.isPhysical {
                        isSwordExorcist = true
                        return true
                    }
                }
            }
        }
        return false
    }
    func amuletMadelOfHero(value:CGFloat) -> Bool {
        if _unit is Character {
            let char = _unit as! Character
            if char._amulet is MedalOfHero {
                if value < 0 && abs(value) > getHp() {
                    return true
                }
            }
        }
        return false
    }
    func amuletJadeHeart() -> Bool {
        if _battle._curRole._unit is PowerLord {
            if _unit is Character {
                let char = _unit as! Character
                if char._amulet is JadeHeart {
                    return true
                }
            }
        }
        return false
    }
    func hpChange(value:CGFloat) {
        let hp = value
        _unit._extensions.hp += hp
        if _unit._extensions.hp > _unit._extensions.health {
            _unit._extensions.hp = _unit._extensions.health
        }
        if _unit._extensions.hp < 0 {
            _unit._extensions.hp = 0
        }
        let per = _unit._extensions.hp / _unit._extensions.health
        _hpbar.setBar(value: per)
//        _hpbar.removeFromParent()
//        createHPBar(value: per)
//        let this = self
//        if isDead() {
//            actionDead {
//                this.removeFromParent()
//            }
//            this._battle.removeFromPart(unit: this)
//        }
    }
    
    func isDead() -> Bool {
        if _unit._extensions.hp <= 0 {
            return true
        }
        return false
    }
    func isBlocked() -> Bool {
        if playerPart {
            return _battle.isPlayerPartUnitBlocked(unit: self)
        } else {
            return _battle.isEnemyPartUnitBlocked(unit: self)
        }
    }
    func getActiveSpell() -> Array<Spell> {
        var spells = Array<Spell>()
        for s in _unit._spellsInuse + _unit._spellsHidden {
            if s is Active {
                spells.append(s)
            }
        }
        return spells
    }
    var _status = Dictionary<String, Status>()
    func hasStatus(type:String) -> Bool {
        if _status.index(forKey: type) != nil {
            let s = _status[type]!
            if s._timeleft > 0 {
                return true
            }
        }
        return false
    }
    
    func hasTeamStatus(type:String) -> Bool {
        if playerPart {
            for u in _battle._playerPart {
                if u.hasStatus(type: type) {
                    return true
                }
            }
        } else {
            for u in _battle._enemyPart {
                if u.hasStatus(type: type) {
                    return true
                }
            }
        }
        
        return false
    }
    
    func getStatus(type:String) -> Status? {
        if _status.index(forKey: type) != nil {
            let s = _status[type]!
            if s._timeleft > 0 {
                return s
            }
        }
        return nil
    }
    
    func hasSpell(spell:Spell) -> Bool {
        for s in _unit._spellsInuse {
            if type(of: spell) == type(of: s) {
                return true
            }
        }
        
        return false
    }
    func hasAuro(auro:Spell) -> Bool {
        if nil == _battle {
            return false
        }
        var spells = Array<Spell>()
        if playerPart {
            for u in _battle._playerPart {
                spells += u._unit._spellsInuse
            }
        } else {
            for u in _battle._enemyPart {
                spells += u._unit._spellsInuse
            }
        }
        for s in spells {
            if type(of: s) == type(of: auro) {
                return true
            }
        }
        return false
    }
    
    func removeStatus(type:String) {
        _status.removeValue(forKey: type)
        showStatusText()
    }
    func addStatus(status:Status) {
        if hasStatus(type: status._type) {
            let s = getStatus(type: status._type)!
            s.timeupAction()
            removeStatus(type: status._type)
        }
        _status[status._type] = status
        showStatusText()
    }
    
    
    func ifRingIs(_ ring:Ring) -> Bool {
        if !(_unit is Character) {
            return false
        } else {
            let c = _unit as! Character
            if c._leftRing != nil {
                if type(of: c._leftRing) == type(of: ring) {
                    return true
                }
            }
            if c._rightRing != nil {
                if type(of: c._rightRing) == type(of: ring) {
                    return true
                }
            }
        }
        return false
    }
    
    func ifSoulIs(_ soul: SoulStone) -> Bool {
        if !(_unit is Character) {
            return false
        } else {
            let c = _unit as! Character
            if c._soulStone != nil {
                if type(of: c._soulStone) == type(of: soul) {
                    return true
                }
            }
        }
        return false
    }
    
    func ifAmuletIs(_ amulet: Amulet) -> Bool {
        if !(_unit is Character) {
            return false
        } else {
            let c = _unit as! Character
            if c._amulet != nil {
                if type(of: c._amulet) == type(of: amulet) {
                    return true
                }
            }
        }
        return false
    }
    
    func ifWeaponIs(_ weapon: Weapon) -> Bool {
        if !(_unit is Character) {
            return false
        } else {
            let c = _unit as! Character
            if c._weapon != nil {
                if type(of: c._weapon) == type(of: weapon) {
                    return true
                }
            }
        }
        return false
    }
    func ifShieldIs(_ shield: Shield) -> Bool {
        if !(_unit is Character) {
            return false
        } else {
            let c = _unit as! Character
            if c._shield != nil {
                if type(of: c._shield) == type(of: shield) {
                    return true
                }
            }
        }
        return false
    }
    
    private var _speakNode = SKSpriteNode()
    func speak(text:String, autoRemove:Bool = true, duration:CGFloat = 3) {
        let node = SKSpriteNode()
        _speakNode.removeFromParent()
        var width = cellSize * 2.25
        if text.count >= 6 {
            width = width + ((text.count - 6) * 12).toFloat()
        }
        let rect = CGRect(x: -width * 0.5, y: -cellSize * 0.375, width: width, height: cellSize * 0.75)
        let bg = SKShapeNode(rect: rect, cornerRadius: 4)
        bg.fillColor = UIColor.black
        bg.alpha = 0.65
        node.addChild(bg)
        
        let border = SKShapeNode(rect: rect, cornerRadius: 4)
        border.lineWidth = 2
        node.addChild(border)
        
        let l = Label()
        l.fontSize = 14
        l.fontColor = UIColor.white
        l.position.y = -7
        l.text = text
        node.addChild(l)
        
        node.zPosition = UIStage.LAYER2 + 3
        node.position.y = cellSize
        addChild(node)
        if autoRemove {
            setTimeout(delay: duration, completion: {
                node.removeFromParent()
            })
        }
        _speakNode = node
    }
    
    func removeSpeak() {
        _speakNode.removeFromParent()
    }
    
    func speakInBattle(text:String, autoRemove:Bool = true, duration:CGFloat = 3) {
        let node = SKSpriteNode()
        _speakNode.removeFromParent()
        var width = cellSize * 1.5
        if text.count >= 4 {
            width = width + ((text.count - 4) * 10).toFloat()
        }
        let rect = CGRect(x: -width * 0.5, y: -cellSize * 0.3, width: width, height: cellSize * 0.6)
        let bg = SKShapeNode(rect: rect, cornerRadius: 2)
        bg.fillColor = UIColor.black
        bg.alpha = 0.65
        node.addChild(bg)
        
        let border = SKShapeNode(rect: rect, cornerRadius: 2)
        border.lineWidth = 1
        border.strokeColor = Game.UNSELECTED_STROKE_COLOR
        node.addChild(border)
        
        let l = Label()
        l.fontSize = 13
        l.fontColor = UIColor.white
        l.position.y = -6
        l.text = text
        node.addChild(l)
        
        node.zPosition = 101
        node.position.y = cellSize * 0.8
        addChild(node)
        if autoRemove {
            setTimeout(delay: duration, completion: {
                node.removeFromParent()
            })
        }
        _speakNode = node
    }
    var _mains:Mains = Mains(stamina:0, strength: 0, agility: 0, intellect: 0)
    var _extensions:Extensions = Extensions(
        attack: 0,
        defence: 0,
        speed: 0,
        accuracy: 0,
        critical: 0,
        destroy: 0,
        avoid: 0,
        spirit: 0,
        hp: 0,
        mp: 0,
        health: 0,
        mind: 0
    )
    var _break:CGFloat = 0
    var _revenge:CGFloat = 0
    var _rhythm:CGFloat = 0
    var _chaos:CGFloat = 0
    var _race:Int = -1
    
    var _elementalPower = Elemental(
        fire : 0,
        water : 0,
        thunder : 0
    )
    
    var _elementalResistance = Elemental(
        fire : 0,
        water : 0,
        thunder : 0
    )
    var _magical = Magic(damage: 0, resistance: 0)
    var _elemental = Magic(damage: 0, resistance: 0)
    var _physical = Magic(damage: 0, resistance: 0)
    var _sensitive:Int = 0
    
    func strengthChange(value: CGFloat) {
        _mains.strength += value
        _extensions.attack += value * 2
        _extensions.defence += value * 0
        _extensions.speed += value * 0.5
        _extensions.accuracy += value * 0.2
        _extensions.avoid += value * 0
        _extensions.critical += value * 0.2
        _extensions.spirit += value * -0.2
        _extensions.health += value * 1
        _extensions.hp += value * 1
        _extensions.mp += value * 0
        if _extensions.hp < 1 {
            _extensions.hp = 1
        }
    }
    func staminaChange(value: CGFloat) {
        _mains.stamina += value
        _extensions.attack += value * 0.1
        _extensions.defence += value * 1.1
        _extensions.speed += value * 0
        _extensions.accuracy += value * 0
        _extensions.avoid += value * -0.2
        _extensions.critical += value * 0
        _extensions.spirit += value * -0.4
        _extensions.health += value * 4
        _extensions.hp += value * 4
        _extensions.mp += value * 0
        if _extensions.hp < 1 {
            _extensions.hp = 1
        }
    }
    func agilityChange(value: CGFloat) {
        _mains.agility += value
        _extensions.attack += value * 1
        _extensions.defence += value * 0.2
        _extensions.speed += value * 2
        _extensions.accuracy += value * 0.5
        _extensions.avoid += value * 0.8
        _extensions.critical += value * 0.3
        _extensions.spirit += value * 0
        _extensions.health += value * 2
        _extensions.hp += value * 2
        _extensions.mp += value * 1
        if _extensions.hp < 1 {
            _extensions.hp = 1
        }
    }
    func intellectChange(value: CGFloat) {
        _mains.intellect += value
        _extensions.attack += value * -0.5
        _extensions.defence += value * 0.3
        _extensions.speed += value * 0.2
        _extensions.accuracy += value * 0
        _extensions.avoid += value * 0.2
        _extensions.critical += value * 0
        _extensions.spirit += value * 2
        _extensions.health += value * 1
        _extensions.hp += value * 1
        _extensions.mp += value * 3
        if _extensions.hp < 1 {
            _extensions.hp = 1
        }
    }
}
