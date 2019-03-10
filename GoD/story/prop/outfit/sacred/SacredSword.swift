//
//  DragonSlayer.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/3.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class NewSwordPlus: Sword {
    override init() {
        super.init()
        _attackSpeed = 1.1
        _name = "冒险者之剑(改)"
        _description = "冒险者最梦寐以求的武器。"
        price = 10
        _chance = 100
    }
    override func create() {
        initialized = true
        _quality = Quality.SACRED
        let atk = AttackAttribute()
        atk._value = 10
        _attrs.append(atk)
        
        let str = Strength()
        str._value = 10
        _attrs.append(str)
        
        let sta = Stamina()
        sta._value = 10
        _attrs.append(sta)
        
        let agl = Agility()
        agl._value = 10
        _attrs.append(agl)
        
        let int = Intellect()
        int._value = 10
        _attrs.append(int)
        createPrice()
    }
}
class NewSword: Sword {
    override init() {
        super.init()
        _attackSpeed = 1.1
        _name = "冒险者之剑"
        _description = "冒险者最梦寐以求的武器。"
        price = 1
        _chance = 100
    }
    override func create() {
        initialized = true
        _quality = Quality.NORMAL
        let atk = AttackAttribute()
        atk._value = 2
        _attrs.append(atk)
        
        let str = Strength()
        str._value = 2
        _attrs.append(str)
        
        let sta = Stamina()
        sta._value = 2
        _attrs.append(sta)
        
        let agl = Agility()
        agl._value = 2
        _attrs.append(agl)
        
        let int = Intellect()
        int._value = 2
        _attrs.append(int)
        createPrice()
    }
}
class DragonSlayer: Sword {
    override init() {
        super.init()
        _name = "屠龙者"
        _description = "对龙类造成的全伤害提升100%。"
        _level = 65
        _chance = 15
        _quality = Quality.SACRED
        price = 851
    }
    
    override func create() {
        createSelfAttrs()
        createAttr(attrId: STAMINA, value: 50)
        removeAttrId(id: STAMINA)
        createAttr(attrId: CRITICAL, value: 25)
        removeAttrId(id: CRITICAL)
        createAttr(attrId: REVENGE,value: 15)
        removeAttrId(id: REVENGE)
        _attrCount = 3
        createAttrs()
    }
}
class DragonSaliva: Sword {
    override init() {
        super.init()
        _name = "龙涎剑"
        _description = "普通攻击附带30%的火焰伤害。"
        _level = 81
        _chance = 10
        _quality = Quality.SACRED
        price = 1882
    }
    override func create() {
        createAttr(attrId: ATTACK_BASE)
        createAttr(attrId: STRENGTH, value: 50)
        removeAttrId(id: STRENGTH)
        createAttr(attrId: STAMINA, value: 50)
        removeAttrId(id: STAMINA)
        createAttr(attrId: AGILITY, value: 50)
        removeAttrId(id: AGILITY)
        createAttr(attrId: INTELLECT, value: 50)
        createAttr(attrId: FIREPOWER, value: 50)
        removeAttrId(id: FIREPOWER)
        _attrCount = 2
        createAttrs()
    }
}
class TheExorcist:Sword {
    static let CHANCE:Int = 35
    override init() {
        super.init()
        _name = "驱魔剑"
        _description = "攻击亡灵时有一定几率直接杀死"
        _level = 35
        _chance = 35
        price = 124
        _quality = Quality.SACRED
    }
    override func create() {
        createSelfAttrs()
        createAttr(attrId: MIND, value: seedFloat(min: 15, max: 26), remove: true)
        createAttr(attrId: LUCKY, value: seedFloat(min: 15, max: 26), remove: true)
        createAttr(attrId: ACCURACY, value: seedFloat(min: 15, max: 26), remove: true)
        createAttr(attrId: SPIRIT, value: seedFloat(min: 15, max: 26), remove: true)
        _attrCount = 1
        createAttrs()
    }
}
class BloodBlade:Sword {
    override init() {
        super.init()
        _name = "血刃"
        _description = "生命值越低，攻击力越高"
        _level = 25
        _chance = 25
        price = 55
        _quality = Quality.SACRED
    }
    override func create() {
        createSelfAttrs()
        createAttr(attrId: AGILITY, value: 15, remove: true)
        createAttr(attrId: CRITICAL, value: 15, remove: true)
        createAttr(attrId: ACCURACY, value: seedFloat(min: 15, max: 26), remove: true)
        _attrCount = 2
        createAttrs()
    }
}
class ElementalSword:Sword {
    override init() {
        super.init()
        _name = "元素剑"
        _description = "获得元素大师效果"
        _level = 38
        _chance = 15
        price = 542
        _quality = Quality.SACRED
    }
    override func create() {
        createSelfAttrs()
        createAttr(attrId: INTELLECT, value: 30, remove: true)
        createAttr(attrId: LUCKY, value: seedFloat(min: 20, max: 31), remove: true)
        _attrCount = 3
        createAttrs()
    }
    private var _spell:Spell!
    override func on() {
        let c = Game.instance.char!
        if !c.hasSpell(spell: ElementMaster()) {
            _spell = ElementMaster()
            c._spellsHidden.append(_spell)
        }
    }
    override func off() {
        if nil != _spell {
            let c = Game.instance.char!
            let i = c._spellsHidden.index(of: _spell)
            c._spellsHidden.remove(at: i!)
        }
    }
}
class IberisHand:Sword {
    override init() {
        super.init()
        _name = "伊比利斯之舞"
        _description = "提升乱舞次数"
        _level = 42
        _chance = 15
        _quality = Quality.SACRED
        price = 448
    }
    override func create() {
        createAttr(attrId: ATTACK_BASE)
        createAttr(attrId: AVOID, value: 30, remove: true)
        createAttr(attrId: ACCURACY, value: 30, remove: true)
        createAttr(attrId: SPEED, value: 30, remove: true)
        createAttr(attrId: CRITICAL, value: 30, remove: true)
        createAttr(attrId: REVENGE, value: seedFloat(min: 10, max: 16), remove: true)
        createAttr(attrId: RHYTHM, value: seedFloat(min: 10, max: 16), remove: true)
    }
}

