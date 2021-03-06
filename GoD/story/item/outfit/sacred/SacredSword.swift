////
////  DragonSlayer.swift
////  TheWitchNight
////
////  Created by kai chen on 2018/5/3.
////  Copyright © 2018年 Chen. All rights reserved.
////
//
//import SpriteKit
//class NewSwordPlus: Sword {
//    override init() {
//        super.init()
//        _attackSpeed = 1.1
//        _name = "冒险者之剑(改)"
//        _description = "冒险者最梦寐以求的武器。"
//        price = 10
//        _chance = 100
//    }
//    override func create() {
//        initialized = true
//        _quality = Quality.SACRED
//        let atk = AttackAttribute()
//        atk._value = 10
//        _attrs.append(atk)
//        
//        let str = Strength()
//        str._value = 10
//        _attrs.append(str)
//        
//        let sta = Stamina()
//        sta._value = 10
//        _attrs.append(sta)
//        
//        let agl = Agility()
//        agl._value = 10
//        _attrs.append(agl)
//        
//        let int = Intellect()
//        int._value = 10
//        _attrs.append(int)
//        createPrice()
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}
//class NewSword: Sword {
//    override init() {
//        super.init()
//        _attackSpeed = 1.1
//        _name = "冒险者之剑"
//        _description = "冒险者最梦寐以求的武器。"
//        price = 1
//        _chance = 100
//    }
//    override func create() {
//        initialized = true
//        _quality = Quality.SACRED
//        let atk = AttackAttribute()
//        atk._value = 2
//        _attrs.append(atk)
//        
//        let str = Strength()
//        str._value = 2
//        _attrs.append(str)
//        
//        let sta = Stamina()
//        sta._value = 2
//        _attrs.append(sta)
//        
//        let agl = Agility()
//        agl._value = 2
//        _attrs.append(agl)
//        
//        let int = Intellect()
//        int._value = 2
//        _attrs.append(int)
//        createPrice()
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}
//class DragonSlayer: Sword {
//    static let EFFECTION = "dragon_slayer"
//    override init() {
//        super.init()
//        _name = "屠龙者"
//        _description = "对龙类造成的全伤害提升100%。"
//        _level = 40
//        _chance = 15
//        _quality = Quality.SACRED
//        _effection = DragonSlayer.EFFECTION
//        price = 851
//    }
//    
//    override func create() {
//        createSelfAttrs()
//        createAttr(attrId: STAMINA)
//        createAttr(attrId: CRITICAL)
//        createAttr(attrId: REVENGE)
//        _attrCount = 3
//        createAttrs()
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}
//class DragonSaliva: Sword {
//    static let EFFECTION = "dragon_saliva"
//    override init() {
//        super.init()
//        _name = "龙涎剑"
//        _description = "攻击附带30%的火焰伤害。"
//        _level = 40
//        _chance = 5
//        _quality = Quality.SACRED
//        _effection = DragonSaliva.EFFECTION
//        price = 1882
//    }
//    override func create() {
//        createAttr(attrId: ATTACK_BASE)
//        createAttr(attrId: STRENGTH, value: 30)
//        createAttr(attrId: STAMINA, value: 30)
//        createAttr(attrId: AGILITY, value: 30)
//        createAttr(attrId: INTELLECT, value: 30)
//        createAttr(attrId: FIREPOWER, value: 50)
//        createAttrs()
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}
//class TheExorcist:Sword {
//    static let EFFECTION = "the_exoricist"
//    static let CHANCE:Int = 35
//    override init() {
//        super.init()
//        _name = "驱魔剑"
//        _description = "攻击亡灵时有一定几率直接杀死"
//        _level = 18
//        _chance = 35
//        price = 124
//        _effection = TheExorcist.EFFECTION
//        _quality = Quality.SACRED
//    }
//    override func create() {
//        createSelfAttrs()
//        createAttr(attrId: MIND, value: seedFloat(min: 15, max: 26), remove: true)
//        createAttr(attrId: LUCKY, value: seedFloat(min: 15, max: 26), remove: true)
//        createAttr(attrId: ACCURACY, value: seedFloat(min: 15, max: 26), remove: true)
//        createAttr(attrId: SPIRIT, value: seedFloat(min: 15, max: 26), remove: true)
//        _attrCount = 1
//        createAttrs()
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}
//class BloodBlade:Sword {
//    static let EFFECTION = "blood_blade"
//    override init() {
//        super.init()
//        _name = "血刃"
//        _description = "生命值越低，攻击力越高"
//        _level = 25
//        _chance = 25
//        price = 86
//        _effection = BloodBlade.EFFECTION
//        _quality = Quality.SACRED
//    }
//    override func create() {
//        createSelfAttrs()
//        createAttr(attrId: AGILITY, value: 15, remove: true)
//        createAttr(attrId: CRITICAL, value: 15, remove: true)
//        createAttr(attrId: ACCURACY, value: seedFloat(min: 15, max: 26), remove: true)
//        _attrCount = 2
//        createAttrs()
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}
//class ElementalSword:Sword {
//    static let EFFECTION = "elemental_sword"
//    override init() {
//        super.init()
//        _name = "元素剑"
//        _description = "获得元素大师效果"
//        _level = 38
//        _chance = 15
//        price = 542
//        _effection = ElementalSword.EFFECTION
//        _quality = Quality.SACRED
//    }
//    override func create() {
//        createSelfAttrs()
//        createAttr(attrId: INTELLECT, value: 30, remove: true)
//        createAttr(attrId: LUCKY, value: seedFloat(min: 20, max: 31), remove: true)
//        _attrCount = 3
//        createAttrs()
//    }
//    
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}
//class IberisHand:Sword {
//    static let EFFECTION = "iberis_hand"
//    override init() {
//        super.init()
//        _name = "伊比利斯之舞"
//        _description = "提升乱舞次数"
//        _level = 23
//        _chance = 15
//        _quality = Quality.SACRED
//        _effection = IberisHand.EFFECTION
//        price = 448
//    }
//    override func create() {
//        createAttr(attrId: ATTACK_BASE)
//        createAttr(attrId: AVOID, value: 15, remove: true)
//        createAttr(attrId: ACCURACY, value: 15, remove: true)
//        createAttr(attrId: SPEED, value: 15, remove: true)
//        createAttr(attrId: CRITICAL, value: 15, remove: true)
//        createAttr(attrId: REVENGE, value: seedFloat(min: 10, max: 16), remove: true)
//        createAttr(attrId: RHYTHM, value: seedFloat(min: 10, max: 16), remove: true)
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}
//
//class AssassinsSword:Sword {
//    override init() {
//        super.init()
//        _name = "刺客之刃"
//        _description = "提升50点必杀和50点毁灭"
//        _level = 31
//        _chance = 15
//        _quality = Quality.SACRED
//        price = 420
//    }
//    override func create() {
//        createAttr(attrId: ATTACK_BASE)
//        createAttr(attrId: CRITICAL, value: 50, remove: true, hidden: true)
//        createAttr(attrId: DESTROY, value: 50, remove: true, hidden: true)
//        createAttr(attrId: AGILITY)
//        createAttr(attrId: ACCURACY)
//        createAttr(attrId: AVOID)
//        createAttr(attrId: LUCKY, value: seedFloat(min: 25, max: 31), remove: true)
//    }
//    override func on() {
//        super.on()
////        Game.instance.char._extensions.critical += 50
////        Game.instance.char._extensions.destroy += 50
//    }
//    override func off() {
//        super.off()
////        Game.instance.char._extensions.critical -= 50
////        Game.instance.char._extensions.destroy -= 50
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}
