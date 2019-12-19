////
////  SacredEarring.swift
////  TheWitchNight
////
////  Created by kai chen on 2018/8/13.
////  Copyright © 2018年 Chen. All rights reserved.
////
//
//import SpriteKit
//class VerdasTear: EarRing {
//    static let EFFECTION = "verdas_tear"
//    override init() {
//        super.init()
//        _name = "维尔达之泪"
//        _description = "略微降低所有法术伤害"
//        _level = 20
//        _chance = 80
//        _quality = Quality.SACRED
//        _effection = VerdasTear.EFFECTION
//        price = 289
//    }
//    override func create() {
//        createAttr(attrId: FIREPOWER, value: 15)
//        createAttr(attrId: WATERPOWER, value: 15)
//        createAttr(attrId: THUNDERPOWER, value: 15)
//        createAttr(attrId: FIRERESISTANCE, value: 15)
//        createAttr(attrId: WATERRESISTANCE, value: 15)
//        createAttr(attrId: THUNDERRESISTANCE, value: 15)
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}
//
//class DeepSeaPearl: EarRing {
//    override init() {
//        super.init()
//        _name = "深海珍珠"
//        _level = 11
//        _chance = 100
//        _quality = Quality.SACRED
//        price = 55
//    }
//    override func create() {
//        createSelfAttrs()
//        createAttr(attrId: WATERPOWER, value: 15, remove: true)
//        createAttr(attrId: SPEED, value: 10, remove: true)
//        createAttr(attrId: REVENGE, value: 5, remove: true)
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
//
//class EyeOfDius: EarRing {
//    override init() {
//        super.init()
////        _value = seed(min: 8, max: 12)
//        _name = "迪乌斯之眼"
////        _description = "提升\(_value)%最大生命"
//        _level = 18
//        _chance = 30
//        price = 168
//        _quality = Quality.SACRED
//    }
//    override func create() {
//        createSelfAttrs()
//        createAttr(attrId: STRENGTH, value: 10, remove: true)
//        createAttr(attrId: AGILITY, value: 10, remove: true)
//        _attrCount = 3
//        createAttrs()
//        let v = seedFloat(min: 8, max: 16)
//        createAttr(attrId: HEALTH_BY_RATE, value: v)
//        _description = "提升生命上限\(v.toInt())%"
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
////    private var _value:Int = 0
////    private var _plus:CGFloat = 0
////    override func on() {
////        super.on()
////        let char = Game.instance.char!
////        _plus = char._extensions.health * _value.toFloat() * 0.01
////        char._extensions.health += _plus
////    }
////    override func off() {
////        super.off()
////        let char = Game.instance.char!
////        char._extensions.health -= _plus
////        if char._extensions.hp > char._extensions.health {
////            char._extensions.hp = char._extensions.health
////        }
////    }
////    private enum CodingKeys: String, CodingKey {
////        case _value
////        case _plus
////    }
////    required init(from decoder: Decoder) throws {
////        let values = try decoder.container(keyedBy: CodingKeys.self)
////        _value = try values.decode(Int.self, forKey: ._value)
////        _plus = try values.decode(CGFloat.self, forKey: ._plus)
////        try super.init(from: decoder)
////    }
////    override func encode(to encoder: Encoder) throws {
////        var container = encoder.container(keyedBy: CodingKeys.self)
////        try container.encode(_value, forKey: ._value)
////        try container.encode(_plus, forKey: ._plus)
////        try super.encode(to: encoder)
////    }
//}
//
//class LavaCrystal: EarRing {
//    static let EFFECTION = "lava_crystal"
//    override init() {
//        super.init()
//        _name = "熔岩结晶"
//        _description = "提升50%单体火焰法术伤害"
//        _level = 25
//        _chance = 15
//        _quality = Quality.SACRED
//        _effection = LavaCrystal.EFFECTION
//        price = 993
//    }
//    override func create() {
//        createSelfAttrs()
//        createAttr(attrId: INTELLECT, value: 20, remove: true)
//        createAttr(attrId: SPIRIT, value: seedFloat(min: 20, max: 31), remove: true)
//        createAttr(attrId: STAMINA, value: -seedFloat(min: 10, max: 16), remove: true)
//        _attrCount = seed(min: 2, max: 4)
//        createAttrs()
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}
