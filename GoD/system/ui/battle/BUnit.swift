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
    var _attackedActing = false
    private var _reserveBool = false
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _stage = Game.instance.curStage
        _valueUnit._mains = Mains(stamina: 0, strength: 0, agility: 0, intellect: 0)
        _valueUnit._extensions = Extensions(attack: 0, defence: 0, speed: 0, accuracy: 0, critical: 0, destroy: 0, avoid: 0, spirit: 0, hp: 0, health: 0, mp: 0, mpMax: 0, mind: 0)
        _valueUnit._revenge = 0
        _valueUnit._lucky = 0
        _valueUnit._rhythm = 0
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
        } else if _unit is NPCBoss {
            _charSize = cellSize * 1.25
        } else if _unit is Boss && !(_unit is NPCBoss) {
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
//        _animationLayer.color = UIColor.white
//        _animationLayer.position.y = cellSize * 0.25
        _animationLayer.zPosition = 110
        _animationLayer.size = CGSize(width: _charSize * 2, height: _charSize * 2)
        addChild(_animationLayer)
        
        createLabel()
        createHPBar()
//        showStatus()
    }
    private var _statusLayer = SKSpriteNode()
    internal var _animationLayer = SKSpriteNode()
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
        
//        _animationLayer.position.y = cellSize * 0.25
        _animationLayer.zPosition = 51
        _animationLayer.size = CGSize(width: _charSize * 2, height: _charSize * 2)
        addChild(_animationLayer)
    }
    func removeFromBattle() {
        _battle.removeFromPart(unit: self)
    }
    private func createLabel() {
        let label = Label()
        label.fontColor = UIColor.red
        label.text = "23"
        label.fontSize = 18
        _hpbar.zPosition = _charNode.zPosition
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
        
        if playerPart {
            _mpbar.create(width: width, height: hpbarHeight * 0.6, value: _unit._extensions.mp / _unit._extensions.mpMax, color: Game.MPBAR_COLOR)
            _mpbar.position.y = -_charSize * 0.75 - hpbarHeight * 1.2
            _mpbar.position.x = x
            _mpbar.zPosition = _charNode.zPosition
            addChild(_mpbar)
        }
        
        
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
    var _unit:Unit!
    var _levelLabel = Label()
    func setUnit(unit:Unit) -> Void {
        _unit = unit
//        _speed = unit._extensions.speed
        _levelLabel = Label("Lv\(unit._level.toInt())\(unit._name)", 0, -_charSize * 1.1, QualityColor.getColor(quality))
        _levelLabel.zPosition = 71
        _levelLabel.fontSize = 13
        _levelLabel.isHidden = true
        _levelLabel.align = "center"
        addChild(_levelLabel)
        _charTexture = unit._img
        
        for s in unit._spellsInuse + unit._spellsHidden {
            let spell = Loot.getSpellById(s)
            if spell._id != -1 {
                spells.append(spell)
            }
        }
        
//        if _unit._weapon?._effection == ElementalSword.EFFECTION && !hasSpell(spell: ElementMaster()) {
//            _spellsInBattle.append(ElementMaster())
//        }
//        if _unit is Character {
//            let c = _unit as! Character
//            if c._shield?._effection == Faceless.EFFECTION {
//                _spellsInBattle.append(FacelessSpell())
//            }
//        }
        
//        if hasSpell(spell: TruePower()) {
//            strengthChange(value: Game.instance.char._mains.strength * 0.1)
//        }
//        if hasSpell(spell: Powerful()) {
//            strengthChange(value: Powerful.VALUE)
//        }
//        if hasSpell(spell: SkyAndLand()) {
//            intellectChange(value: SkyAndLand.VALUE)
//        }
//        if hasSpell(spell: SharpStone()) {
//            agilityChange(value: SharpStone.VALUE)
//        }
        
    }
    var quality:Int
    {
        get {
            if _unit is Creature {
                return (_unit as! Creature)._quality
            }
            return Quality.NORMAL
        }
    }
    var seat:String
    {
        get {
            return _unit._seat
        }
        set {
            _unit._seat = newValue
        }
    }
    func isClose() -> Bool {
        if weaponIs(Outfit.Bow) || weaponIs(Outfit.Wand) {
            return false
        }
        return true
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
            self.showText(text: "Immune")
            return
        }
        if _unit is Boss && seed() < 65 {
            self.showMiss()
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
            var last = 3
            if markIs(Sacred.FireMark) {
                last = 4
            }
            if s._timeleft < last {
                s._timeleft = last
            }
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
                self.showText(text: "Immune")
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
            showText(text: "Immune")
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
    private var _mpbar = HBar()
    private var circleY:CGFloat = 0
//    var _seat:String = ""
//    var unitPos = "left"
    var selectable = false
    //等待操作的光环颜色
    func setOrderMode() {
        _select.texture = _selectTexture.getCell(0, 0)
        selectable = false
    }
    //默认光环颜色
    func setDefaultMode() {
        _select.texture = _selectTexture.getCell(3, 0)
        selectable = false
    }
    //可以被选择的光环颜色
    func setSelectableMode() {
        _select.texture = _selectTexture.getCell(2, 0)
        selectable = true
    }
    func silenced(completion:@escaping () -> Void) {
//        if markDeathGod() {
//            showText(text: "IMMUNE") {
//                completion()
//            }
//            return
//        }
        let index = _battle._roleAll.firstIndex(of: self)
        if nil != index {
            _battle._roleAll.remove(at: index!)
        }
        showText(text: "Slience", completion: completion)
    }
    func showMiss(completion:@escaping () -> Void = {}) {
        showText(text: "Miss") {
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
        if value < 0 && damageType == DamageType.FIRE && hasSpell(id: Spell.DragonBlood) && seed() < 33 {
            value = 0
        }
        if value < 0 && self._unit._race == EvilType.RISEN {
            if s.weaponIs(Sacred.TheExorcist) && seed() < 15 {
                self.showText(text: "Exorcised") {
                    self.actionDead {
                        self.die()
                        completion()
                    }
                }
                return
            } else if s.weaponIs(Sacred.NightBlade) {
                value *= 1.25
            }
        }
        if value < 0 && shieldIs(Sacred.EvilExpel) && seed() < 15 {
            showText(text: "Block") {
                completion()
                return
            }
        }
        if value > 0 && hasStatus(type: Status.SOUL_SLAY) {
            showText(text: "Slay") {
                completion()
            }
            return
        }
        if value < 0 && shieldIs(Sacred.Accident) && damageType == DamageType.MAGICAL {
            var us = Array<BUnit>()
            for u in _battle._playerPart {
                if !(u._unit is Character) {
                    us.append(u)
                }
            }
            if us.count > 0 {
                self.showText(text: "Shift") {
                    let one = us.one()
                    one.showValue(value: value) {
                        completion()
                    }
                }
                return
            }
        }
        
        if value < 0 && _unit._race == EvilType.RISEN && s.weaponIs(Sacred.HolyPower) {
            value *= 2
        }
        if value < 0 && hasStatus(type: "_mess_ghost") {
            value *= 2
        }
        if value > 0 {
            if ringIs(Sacred.RingOfDeath) {
                value *= 1.5
            }
            if soulstoneIs(Sacred.HeartOfTarrasque) {
                value *= 2
            }
            if hasStatus(type: Sacred.BansMechanArm) {
                value *= 0.75
            }
            if hasStatus(type: Status.PETRIFY) {
                value = seed(min: 0, max: 6).toFloat() * 0.01 * value
            }
            if hasSpell(id: Spell.DragonBlood) && seed() < 33 {
                value = 0
            }
        }

        var beCritical = (_battle._selectedAction as! Spell).beCritical
        if value > 0 || !criticalFromSpell || _battle._selectedAction is Magical {
            beCritical = critical
        }
        
        if hasStatus(type: Status.PROTECTION_FROM_ICE) {
            if value < 0 {
                if -value > getHp() {
                    showText(text: "Fatal") {
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
        valueText.position.y = _charSize * (playerPart ? 0.65 : 0.75)
        var color = textColor
        var text = "\(value.toInt())"
        if value > 0 {
            color = DamageColor.HEAL
            text = "+\(value.toInt())"
        }
        valueText.text = text
        valueText.fontColor = color
        var v = CGVector(dx: 0, dy: _charSize * 0.25)
        var move = SKAction.move(by: v, duration: TimeInterval(0.15))
        let wait = SKAction.wait(forDuration: TimeInterval(1))
        var go = SKAction.sequence([move, wait])
        if beCritical {
            v = CGVector(dx: 0, dy: _charSize * 0.4)
            move = SKAction.move(by: v, duration: TimeInterval(0.05))
            let s = SKAction.scale(by: 1.3, duration: TimeInterval(0.05))
            let group = SKAction.group([s, move])
            go = SKAction.sequence([group,  wait])
            beCritical = false
        }
        valueText.run(go) {
            valueText.removeFromParent()
        }
        
        setTimeout(delay: 0.5) {
            
            if self.isDead() {
                self.actionDead {
                    self.die()
                    completion()
                }
            } else {
                
                if self.shieldIs(Sacred.FrancisFace) && self.seed() < 10 {
                    self.showText(text: " +5") {
                        completion()
                    }
                    self._valueUnit._extensions.critical += 5
                    return
                }
//                if self.markMightOfOaks() {
//                    if self.seed() < 10 {
//                        self.showText(text: "MIGHT OF OAKS")
//                        let s = Status()
//                        s._type = Status.MIGHT_OF_OAKS
//                        s._timeleft = 5
//                        self.addStatus(status: s)
//                    }
//                }
                completion()
            }
        }
        
        if markIs(Sacred.MarkOfOaks) && damageType == DamageType.PHYSICAL && seed() < 15 {
            cure1f() {
                let s = Status()
                s._type = Status.MIGHT_OF_OAKS
                s._timeleft = 3
                s._labelText = "O"
                self.addStatus(status: s)
            }
            self.play("Raise3")
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
        valueText.position.y = _charSize * (playerPart ? 0.75 : 0.75)
        valueText.text = text
        valueText.fontColor = color
        let v = CGVector(dx: 0, dy: _charSize * 0.25)
        let move = SKAction.move(by: v, duration: TimeInterval(0.15))
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
        return false
    }
    func swordExorcist(value:CGFloat) -> Bool {
        return false
    }
    func amuletMadelOfHero(value:CGFloat) -> Bool {
        return false
    }
    func amuletJadeHeart() -> Bool {
        return false
    }
    func mpLost(value:CGFloat) {
        _unit._extensions.mp -= value
        if _unit._extensions.mp < 0 {
            _unit._extensions.mp = 0
        }
        if playerPart {
            let per = _unit._extensions.mp / _unit._extensions.mpMax
            _mpbar.setBar(value: per)
        }
    }
    func hpChange(value:CGFloat) {
        let hp = value
        if _unit._extensions.hp + hp < 0 && amuletIs(Sacred.MedalOfHero) && !_reserveBool {
            showText(text: "Block")
            _reserveBool = true
            return
        }
        _unit._extensions.hp += hp
        if _unit._extensions.hp > _unit._extensions.health {
            _unit._extensions.hp = _unit._extensions.health
        }
        if _unit._extensions.hp < 0 {
            _unit._extensions.hp = 0
        }
        let per = _unit._extensions.hp / _unit._extensions.health
        _hpbar.setBar(value: per)
        if isDead() {
            removeFromBattle()
        }
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
        var ss = Array<Spell>()
        for s in spells {
            if s is Active {
                ss.append(s)
            }
        }
        return ss
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
            if spell._id == s {
                return true
            }
        }
        
        return false
    }
    func hasSpell(id:Int) -> Bool {
        for s in _unit._spellsInuse {
            if id == s {
                return true
            }
        }
        
        return false
    }
    func hasAuro(id:Int) -> Bool {
        if nil == _battle {
            var spells = Array<Int>()
            let char = Game.instance.char!
            let units = [char] + char._minions
            for u in units {
                spells += u._spellsInuse
            }
            for s in spells {
                if id == s {
                    return true
                }
            }
            return false
        }
        var spells = Array<Spell>()
        if playerPart {
            for u in _battle._playerPart {
                spells += u.spells
            }
        } else {
            for u in _battle._enemyPart {
                spells += u.spells
            }
        }
        for s in spells {
            if s._id == id {
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
    
    
    func ringIs(_ effection: String) -> Bool {
        if !(_unit is Character) {
            return false
        } else {
            let c = _unit as! Character
            if c._leftRing?._effection == effection || c._rightRing?._effection == effection {
                return true
            }
        }
        return false
    }
    
    func markIs(_ effection: String) -> Bool {
        if !(_unit is Character) {
            return false
        } else {
            let c = _unit as! Character
            if c._magicMark?._effection == effection {
                return true
            }
        }
        return false
    }
    
    func soulstoneIs(_ effection: String) -> Bool {
        if !(_unit is Character) {
            return false
        } else {
            let c = _unit as! Character
            if c._soulStone != nil {
                if c._soulStone?._effection == effection {
                    return true
                }
            }
        }
        return false
    }
    
    func amuletIs(_ effection: String) -> Bool {
        if !(_unit is Character) {
            return false
        } else {
            let c = _unit as! Character
            if c._amulet != nil {
                if c._amulet?._effection == effection {
                    return true
                }
            }
        }
        return false
    }
    func weaponIs(_ effection:String) -> Bool {
        if !(_unit is Character) {
            return false
        } else {
            let c = _unit as! Character
            if c._weapon != nil {
                if c._weapon?._effection == effection {
                    return true
                }
                if c._weapon?._type == effection {
                    return true
                }
            }
        }
        return false
    }
    
    func shieldIs(_ effection: String) -> Bool {
        if !(_unit is Character) {
            return false
        } else {
            let c = _unit as! Character
            if c._shield != nil {
                if c._shield?._effection == effection {
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
        var width = cellSize * 1.5
        if text.count >= 6 {
            width = width + ((text.count - 6) * 18).toFloat()
        }
        let rect = CGRect(x: -width * 0.5, y: -cellSize * 0.25, width: width, height: cellSize * 0.5)
        let bg = SKShapeNode(rect: rect, cornerRadius: 4)
        bg.fillColor = UIColor.black
        bg.alpha = 0.65
        node.addChild(bg)
        
        let border = SKShapeNode(rect: rect, cornerRadius: 4)
        border.lineWidth = 1
        node.addChild(border)
        
        let l = Label()
        l.fontSize = 18
        l.fontColor = UIColor.white
        l.align = "center"
        l.position.y = 9
        l.text = text
        node.addChild(l)
        
        node.zPosition = MyScene.UI_LAYER_Z + 100
        node.position.y = _charSize
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
    
    var _valueUnit = Unit()
    internal var spells = Array<Spell>()
}
