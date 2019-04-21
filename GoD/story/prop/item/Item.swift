//
//  Item.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/6.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Item:Prop, ISelectTarget {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    var targetAll: Bool {
        get {
            return _isTargetAll
        }
    }
    
    var targetEnemy: Bool {
        set {
            _isTargetEnemy = newValue
        }
        get {
            return _isTargetEnemy
        }
    }
    
    var canBeTargetPlayer: Bool {
        get {
            return _canBeTargetPlayer
        }
    }
    var canBeTargetSelf: Bool {
        set {
            _canBeTargetSelf = newValue
        }
        get {
            return _canBeTargetSelf
        }
    }
    
    var isClose: Bool {
        set {
            _isClose = newValue
        }
        get {
            return _isClose
        }
    }
    
    var _isTargetAll = false
    var _isTargetEnemy = false
    var _canBeTargetPlayer = true
    var _canBeTargetSelf = true
    var _isClose = false
    
    func use() {}
    func use(target:Creature) {}
    func use(unit: BUnit, completion:@escaping () -> Void) {}
    
    override init() {
        super.init()
    }
    
//    required init(from decoder: Decoder) throws {
//        fatalError("init(from:) has not been implemented")
//    }
    
    var usable = false
    var usableInBattle = false
    var _timeleft = 0
    var _battle:Battle!
    var _cooldown = 0
    
    func timeleft() -> Int {
        return _timeleft
    }
    
    func removeFromChar() {
        Game.instance.char.removeProp(p: self)
    }
    
    override func getInfosDisplay() -> IPanelSize {
        return ItemInfo()
    }
    func reduce() {
        _count -= 1
    }
    
}

class TheWitchsTear:Item {
    static let NAME = "天使之泪"
    override init() {
        super.init()
        price = 6
        _name = TheWitchsTear.NAME
        _level = 1
        _quality = Quality.NORMAL
        _description = "一滴来自天使的眼泪，经过时间的沉淀，变成了一颗晶莹剔透的水晶，似乎拥有某种魔力"
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class Potion:Item {
    override init() {
        super.init()
        usable = true
        usableInBattle = true
        price = 5
        _cooldown = 4
        _name = "治疗药水"
        _description = "恢复50%最大生命值"
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    internal var _rate:CGFloat = 0.5
    
    override func use(target: Creature) {
        removeFromChar()
        target._extensions.hp += target._extensions.health * _rate
        if target._extensions.hp >= target._extensions.health {
            target._extensions.hp = target._extensions.health
        }
//        Game.instance._char.removeProp(p: self)
    }
    
    override func use(unit: BUnit, completion: @escaping () -> Void) {
        if (unit.getHp() >= unit.getHealth()) || _count <= 0 {
            return
        }
        _timeleft = _cooldown
        let this = self
        _battle._curRole.showText(text: _name) {
            unit.actionHealed {
                let change = unit.getHealth() * this._rate
//                unit.hpChange(value: change)
                unit.showValue(value: change) {
                    completion()
                }
            }
        }
        removeFromChar()
//        completion()
    }
}

class LittlePotion:Potion {
    override init() {
        super.init()
        price = 3
        _cooldown = 2
        _name = "治疗药水(小)"
        _description = "恢复25%最大生命值"
        _rate = 0.25
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class SealScroll:Item {
    override init() {
        super.init()
        usable = false
        usableInBattle = true
        targetEnemy = true
        price = 6
        _cooldown = 0
        _name = "封印卷轴"
        _description = "对目标释放封印术"
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override func use(unit: BUnit, completion:@escaping () -> Void) {
        let this = self
        let char = Game.instance.char!
        let c = _battle._curRole
        removeFromChar()
        c.showText(text: "封印") {
            unit.actionSealed {
                let chance = this.seed(max: unit.getHealth().toInt())
                if Mode.debug || chance > unit.getHp().toInt() {
                    if char._minions.count >= 6 {
                        showMsg(text: "随从位已满！")
                        completion()
                    } else {
                        unit.actionDead {
                            unit.removeFromBattle()
                            unit.removeFromParent()
                            unit._unit._seat = BUnit.STAND_BY
                            char._minions.append(unit._unit)
                            setTimeout(delay: 0.5) {
                                if !this._battle.hasFinished() {
                                    completion()
                                }
                            }
                        }
                    }
                } else {
                    showMsg(text: "封印失败！")
                    completion()
                }
            }
        }
    }
}

class TownScroll:Item {
    override init() {
        super.init()
        usable = true
        usableInBattle = true
        price = 6
        _name = "传送之卷·贝"
        _description = "传送到贝拉姆村"
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override func use() {
        removeFromChar()
        showMsg(text: _description)
        let c = CenterCamping()
        let char = Game.instance.curStage._curScene._role!
//        let stage = Game.instance.
        Game.instance.curStage.switchScene(next: c, afterCreation: {
            c.setRole(x: 5, y: 7, char: char)
        })
    }
}
class GodTownScroll:TownScroll {
    override init() {
        super.init()
        usable = true
        usableInBattle = true
        price = 50
        _name = "传送之卷·雪"
        _description = "传送到神域·雪之国"
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override func use() {
        removeFromChar()
        showMsg(text: _description)
        let c = SnowLanding1()
        let char = Game.instance.curStage._curScene._role!
        //        let stage = Game.instance.
        Game.instance.curStage.switchScene(next: c, afterCreation: {
            c.setRole(x: 7, y: 7, char: char)
        })
    }
}
class DeathTownScroll:TownScroll {
    override init() {
        super.init()
        usable = true
        usableInBattle = true
        price = 50
        _name = "传送之卷·冥"
        _description = "传送到恶魔之城"
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override func use() {
        removeFromChar()
        showMsg(text: _description)
        let c = CenterCamping()
        let char = Game.instance.curStage._curScene._role!
        //        let stage = Game.instance.
        Game.instance.curStage.switchScene(next: c, afterCreation: {
            c.setRole(x: 5, y: 7, char: char)
        })
    }
}

class BlastScroll:Item {
    override init() {
        super.init()
        usable = true
        usableInBattle = false
        price = 3
        _name = "爆破卷轴"
        _description = "移除面前的一个障碍物(只能在远古秘径中使用)"
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override func use() {
        let stage = Game.instance.curStage!
        let scene = Game.instance.curStage._curScene!
        let bChar = scene._role!
        let this = self
        if stage._curPanel != nil {
            stage.removePanel(stage._curPanel!)
        }
        bChar.actionSpark {
            if (scene as! AcientRoad).blastItem() {
                this.removeFromChar()
            }
        }
        
    }
}

class RandomWeapon:Item {
    override init() {
        super.init()
        usable = true
        usableInBattle = false
        price = 25
        _name = "武器"
        _description = "获得一个随机属性的\(_name)"
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override func use() {
        removeFromChar()
        let l = Loot()
        let char = Game.instance.char!
        let weapon = l.getWeaponById(id: weaponId)
        weapon.create(level: char._level)
        char.addProp(p: weapon)
        let stage = Game.instance.curStage!
        stage.removePanel(stage._curPanel!)
        let op = OutfitPanel()
        op.create()
        stage.showPanel(op)
    }
    var weaponId:Int = 0
}

class RandomArmor:Item {
    override init() {
        super.init()
        usable = true
        usableInBattle = false
        price = 25
        _name = "防具"
        _description = "获得一个随机属性的\(_name)"
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override func use() {
        removeFromChar()
        let l = Loot()
        let char = Game.instance.char!
        let armor = l.getArmorById(id: armorId)
        armor.create(level: char._level)
        char.addProp(p: armor)
        let stage = Game.instance.curStage!
        stage.removePanel(stage._curPanel!)
        let op = OutfitPanel()
        op.create()
        stage.showPanel(op)
    }
    var armorId:Int = 0
}

class RandomSacredSpell:Item {
    override init() {
        super.init()
        usable = true
        usableInBattle = false
        price = 180
        _name = "法术?"
        _description = "获得一个随机的神之技"
        _quality = Quality.SACRED
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override func use() {
        removeFromChar()
        let l = Loot()
        let char = Game.instance.char!
        let book = SpellBook()
        book.spell = l.getSacredSpell(id: l._sacredSpellArray.one())
        char.addProp(p: book)
    }
    var armorId:Int = 0
}
