//
//  Outfit.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/25.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Outfit:Prop {
    private enum CodingKeys: String, CodingKey {
        case _attrs
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _attrs = try values.decode(Array.self, forKey: ._attrs)
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_attrs, forKey: ._attrs)
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        
        _all = [STAMINA,
                STRENGTH,
                AGILITY,
                INTELLECT,
                DEFENCE,
                SPEED,
                SPIRIT,
                ACCURACY,
                AVOID,
                CRITICAL,
                HEALTH,
                MIND,
                FIREPOWER,
                FIRERESISTANCE,
                WATERPOWER,
                WATERRESISTANCE,
                THUNDERPOWER,
                THUNDERRESISTANCE,
//                ELEMENTALPOWER,
//                ELEMENTALRESISTANCE,
                LUCKY,
                BREAK,
                REVENGE,
                RHYTHM
        ]
    }
    
//    required init(from decoder: Decoder) throws {
//        fatalError("init(from:) has not been implemented")
//    }
    

    internal var _attrCount:Int = 0
    override func create(level:CGFloat) {
        _level = level
        initialized = true
        createQuality()
        createSelfAttrs()
        createAttrs()
        createPrice()
    }
    
    override func create() {
        initialized = true
        createQuality()
        createSelfAttrs()
        createAttrs()
        createPrice()
    }
    
    func sacredAttrCount() {
        _quality = Quality.SACRED
        _attrCount = seed(min: 3, max: 6)
    }
    
    func createPrice() {
        _price = seed(min: 1, max: _level.toInt() + 1) * _quality
        _sellingPrice = _price * 4
    }
    
    func createQuality() {
        let _seed = seed()
        if _seed < 70 {
            _quality = Quality.NORMAL
            _attrCount = seed(min: 1, max: 3)
        } else if _seed < 90 {
            _quality = Quality.GOOD
            _attrCount = seed(min: 2, max: 4)
        } else {
            _quality = Quality.RARE
            _attrCount = seed(min: 3, max: 6)
        }
    }
    internal var _selfAttrs:Array<Int> = []
    func createSelfAttrs() {
        for id in _selfAttrs {
            let a = getAttrById(id: id)
            let index = _all.index(of: id)
            if nil != index {
                _all.remove(at: index!)
            }
            a.create(level: self._level)
            _attrs.append(a)
        }
    }
    func createAttr(attrId:Int, value:CGFloat = 0, remove:Bool = false) {
        let attr = getAttrById(id: attrId)
        if value != 0 {
            attr._value = value
        } else {
            attr.create(level: _level)
        }
        _attrs.append(attr)
        if remove {
            removeAttrId(id: attrId)
        }
    }
    func createAttrs() {
        if _attrCount < 1 {
            return
        }
        for _ in 0..._attrCount - 1 {
            let index = seed(max: _all.count)
            let attr = getAttrById(id: _all[index])
            attr.create(level: _level)
            _attrs.append(attr)
            _all.remove(at: index)
        }
    }
    var _attrs = Array<Attribute>()
    internal var _all = Array<Int>()
    var STAMINA = 0
    var STRENGTH = 1
    var AGILITY = 2
    var INTELLECT = 3
    var ATTACK = 4
    var DEFENCE = 5
    var SPEED = 6
    var SPIRIT = 7
    var ACCURACY = 8
    var AVOID = 9
    var CRITICAL = 10
    var MIND = 11
    var HEALTH = 12
    var FIREPOWER = 13
    var WATERPOWER = 14
    var THUNDERPOWER = 15
    var FIRERESISTANCE = 16
    var WATERRESISTANCE = 17
    var THUNDERRESISTANCE = 18
    var ELEMENTALPOWER = 19
    var ELEMENTALRESISTANCE = 20
    var LUCKY = 21
    var BREAK = 22
    var REVENGE = 23
    var RHYTHM = 24
    var CHAOS = 25
    var ATTACK_BASE = 26
    var SPIRIT_BASE = 27
    var MAGICAL_POWER = 28
    internal func getAttrById(id:Int) -> Attribute {
        switch id {
        case STAMINA:
            return Stamina()
        case STRENGTH:
            return Strength()
        case AGILITY:
            return Agility()
        case INTELLECT:
            return Intellect()
        case ATTACK:
            return AttackAttribute()
        case DEFENCE:
            return Defence()
        case SPEED:
            return Speed()
        case SPIRIT:
            return Spirit()
        case ACCURACY:
            return Accuracy()
        case AVOID:
            return Avoid()
        case MIND:
            return Mind()
        case CRITICAL:
            return Critical()
        case HEALTH:
            return Health()
        case LUCKY:
            return Lucky()
        case FIREPOWER:
            return FirePower()
        case WATERPOWER:
            return WaterPower()
        case THUNDERPOWER:
            return ThunderPower()
        case FIRERESISTANCE:
            return FireResistance()
        case WATERRESISTANCE:
            return WaterResistance()
        case THUNDERRESISTANCE:
            return ThunderResistance()
        case ELEMENTALPOWER:
            return ElementalPower()
        case ELEMENTALRESISTANCE:
            return ElementalResistance()
        case BREAK:
            return Break()
        case REVENGE:
            return Revenge()
        case RHYTHM:
            return Rhythm()
        case CHAOS:
            return Chaos()
        case ATTACK_BASE:
            return AttackAttributeBase()
        case SPIRIT_BASE:
            return SpiritBase()
        case MAGICAL_POWER:
            return MagicalDamage()
        default:
            return Attribute()
        }
    }
    internal func removeAttrId(id:Int) {
        let index = _all.index(of: id)
        if nil != index {
            _all.remove(at: index!)
        }
    }
    func on() {
        for a in _attrs {
            a.on(unit: Game.instance.char)
        }
    }
    func off() {
        for a in _attrs {
            a.off(unit: Game.instance.char)
        }
    }
    
    override func getInfosDisplay() -> IPanelSize {
        return ArmorInfo()
    }
    
    var isRandom = false
    var _chance:Int = 0
    var _outfitName = ""
}
