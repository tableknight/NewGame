//
//  Attribute.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/25.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Attribute: Core {
    static let STAMINA_TEXT = "防御"
    init(type:Int, level:Int) {
        super.init()
        _type = type
        let l = level.toFloat()
        let t = type
        if t == Attribute.ACCURACY {
            _name = "命中"
            lowerAttrValue(level: l)
        } else if t == Attribute.AGILITY {
            _name = "敏捷"
            midAttrValue(level: l)
        } else if t == Attribute.ATTACK_BASE {
            _name = "攻击"
            let min = (l * 1.6).toInt()
            let max = (l * 2.4).toInt()
            _value = seed(min: min, max: max).toFloat()
        } else if t == Attribute.ATTACK {
            _name = "攻击"
            midAttrValue(level: l)
        } else if t == Attribute.AVOID {
            _name = "躲闪"
            lowerAttrValue(level: l)
        } else if t == Attribute.BREAK {
            _name = "破甲"
            lowLevelValue(level: 1)
        } else if t == Attribute.CRITICAL {
            _name = "必杀"
            lowerAttrValue(level: l)
        } else if t == Attribute.DEFENCE {
            _name = "护甲"
            upperAttrValue(level: l)
        } else if t == Attribute.DESTROY {
            _name = "毁灭"
            _value = seedFloat(min: 1, max: 6)
        } else if t == Attribute.ELEMENTALPOWER {
            _name = "元素伤害"
            elementalAttrValue(level: l)
            _percentValue = true
        } else if t == Attribute.ELEMENTALRESISTANCE {
            _name = "元素抵抗"
            elementalAttrValue(level: l)
            _percentValue = true
        } else if t == Attribute.FIREPOWER {
            _name = "火焰伤害"
            elementalAttrValue(level: l)
            _percentValue = true
        } else if t == Attribute.FIRERESISTANCE {
            _name = "火焰抵抗"
            elementalAttrValue(level: l)
            _percentValue = true
        } else if t == Attribute.WATERPOWER {
            _name = "寒冰伤害"
            elementalAttrValue(level: l)
            _percentValue = true
        } else if t == Attribute.WATERRESISTANCE {
            _name = "寒冷抵抗"
            elementalAttrValue(level: l)
            _percentValue = true
        } else if t == Attribute.THUNDERPOWER {
            _name = "雷电伤害"
            elementalAttrValue(level: l)
            _percentValue = true
        } else if t == Attribute.THUNDERRESISTANCE {
            _name = "雷电抵抗"
            elementalAttrValue(level: l)
            _percentValue = true
        } else if t == Attribute.HEALTH {
            _name = "最大生命"
            _value = seed(min: level, max: level * 2).toFloat()
        } else if t == Attribute.HEALTH_BY_RATE {
            _name = "生命上限"
            _value = seed(min: 6, max: 13).toFloat()
            _percentValue = true
        } else if t == Attribute.INTELLECT {
            _name = "智力"
            midAttrValue(level: l)
        } else if t == Attribute.LUCKY {
            _name = "幸运"
            lowLevelValue(level: l)
        } else if t == Attribute.MAGICAL_POWER {
            _name = "法术穿透"
            _value = seedFloat(min: 1, max: 6)
            _percentValue = true
        } else if t == Attribute.MIND {
            _name = "念力"
            lowerAttrValue(level: l)
        } else if t == Attribute.REVENGE {
            _name = "复仇"
            lowLevelValue(level: l)
        } else if t == Attribute.RHYTHM {
            _name = "律动"
            lowLevelValue(level: l)
        } else if t == Attribute.SPEED {
            _name = "速度"
            upperAttrValue(level: l)
        } else if t == Attribute.STAMINA {
            _name = "防御"
            midAttrValue(level: l)
        } else if t == Attribute.SPIRIT {
            _name = "精神"
            midAttrValue(level: l)
        } else if t == Attribute.SPIRIT_BASE {
            _name = "精神"
            upperAttrValue(level: l)
        } else if t == Attribute.STRENGTH {
            _name = "力量"
            midAttrValue(level: l)
        } else if t == Attribute.PHYSICAL_REDUCE_POINT {
            _name = "物理免伤"
            midAttrValue(level: l)
        } else if t == Attribute.PHYSICAL_REDUCE_PERCENT {
            _name = "物理免伤"
            percentAttrValue(level: l)
            _percentValue = true
        }else {
            debug("attr init error!")
        }
    }
    
    
    
    
    func on(unit:Unit) -> Void {
        let t = _type
        let value = _value
        let r = _reserve1
        if t == Attribute.ACCURACY {
            unit._extensions.accuracy += value
        } else if t == Attribute.AGILITY {
            unit.agilityChange(value: value)
        } else if t == Attribute.ATTACK_BASE {
            unit._extensions.attack += value
        } else if t == Attribute.ATTACK {
            unit._extensions.attack += value
        } else if t == Attribute.AVOID {
            unit._extensions.avoid += value
        } else if t == Attribute.BREAK {
            unit._break -= value
        } else if t == Attribute.CRITICAL {
            unit._extensions.critical += value
        } else if t == Attribute.DEFENCE {
            unit._extensions.defence += value
        } else if t == Attribute.DESTROY {
            unit._extensions.destroy += value
        } else if t == Attribute.ELEMENTALPOWER {
            unit._elementalPower.fire += value
            unit._elementalPower.water += value
            unit._elementalPower.thunder += value
        } else if t == Attribute.ELEMENTALRESISTANCE {
            unit._elementalResistance.fire += value
            unit._elementalResistance.water += value
            unit._elementalResistance.thunder += value
        } else if t == Attribute.FIREPOWER {
            unit._elementalPower.fire += value
        } else if t == Attribute.FIRERESISTANCE {
            unit._elementalResistance.fire += value
        } else if t == Attribute.WATERPOWER {
            unit._elementalPower.water += value
        } else if t == Attribute.WATERRESISTANCE {
            unit._elementalResistance.water += value
        } else if t == Attribute.THUNDERPOWER {
            unit._elementalPower.thunder += value
        } else if t == Attribute.THUNDERRESISTANCE {
            unit._elementalResistance.thunder += value
        } else if t == Attribute.HEALTH {
            unit._extensions.health += value
        } else if t == Attribute.HEALTH_BY_RATE {
            _reserve1 = unit._extensions.health * value / 100
            unit._extensions.health += r
        } else if t == Attribute.INTELLECT {
            unit.intellectChange(value: value)
        } else if t == Attribute.LUCKY {
            unit._lucky += value
        } else if t == Attribute.MAGICAL_POWER {
            unit._power += value
        } else if t == Attribute.MIND {
            unit._extensions.mind += value
        } else if t == Attribute.REVENGE {
            unit._revenge += value
        } else if t == Attribute.RHYTHM {
            unit._rhythm += value
        } else if t == Attribute.SPEED {
            unit._extensions.speed += value
        } else if t == Attribute.STAMINA {
            unit.staminaChange(value: value)
        } else if t == Attribute.SPIRIT {
            unit._extensions.spirit += value
        } else if t == Attribute.SPIRIT_BASE {
            unit._extensions.spirit += value
        } else if t == Attribute.STRENGTH {
            unit.strengthChange(value: value)
        } else if t == Attribute.PHYSICAL_REDUCE_PERCENT {
            unit._physical.resistance += value
        } else if t == Attribute.PHYSICAL_REDUCE_POINT {
            unit._physical.damage += value
        } else {
            debug("attr on error!")
        }
    }
    func off(unit: Unit) -> Void {
        _value *= -1
        _reserve1 *= -1
        on(unit: unit)
        _value *= -1
        _reserve1 *= -1
    }
   
    func getText() -> String {
        var text = ""
        if _value < 0 {
            text = "\(_name) \(_value.toInt())"
        } else {
            text = "\(_name) +\(_value.toInt())"
        }
        if _percentValue {
            text += "%"
        }
        return text
    }
     func midAttrValue(level:CGFloat) {
        var min = (level * 0.35).toInt()
        if min < 1 {
            min = 1
        }
        var max = (level * 0.6).toInt()
        if max < 1 {
            max = 1
        }
        _value = seed(min: min, max: max).toFloat()
    }
     func upperAttrValue(level:CGFloat) {
        var min = (level * 0.6).toInt()
        if min < 1 {
            min = 1
        }
        var max = (level * 0.9).toInt()
        if max < 1 {
            max = 1
        }
        _value = seed(min: min, max: max).toFloat()
    }
    
    func elementalAttrValue(level:CGFloat) {
        if level < 20 {
            _value = seed(min: 5, max: 11).toFloat()
        } else {
            _value = seed(min: 10, max: 21).toFloat()
        }
        
    }
    func percentAttrValue(level:CGFloat) {
        if level < 13 {
            _value = seedFloat(min: 1, max: 6)
        } else if level < 30 {
            _value = seedFloat(min: 3, max: 11)
        } else {
            _value = seedFloat(min: 8, max: 16)
        }
        
    }
     func lowerAttrValue(level:CGFloat) {
        var min = (level * 0.2).toInt()
        if min < 1 {
            min = 1
        }
        var max = (level * 0.4).toInt()
        if max < 1 {
            max = 1
        }
        _value = seed(min: min, max: max).toFloat()
    }
    func lowLevelValue(level:CGFloat) {
        if level < 20 {
            _value = seed(min: 1, max: 6).toFloat()
        } else if level < 30 {
            _value = seed(min: 3, max: 9).toFloat()
        } else {
            _value = seed(min: 5, max: 11).toFloat()
        }
    }
    static let STAMINA = 0
    static let STRENGTH = 1
    static let AGILITY = 2
    static let INTELLECT = 3
    static let ATTACK = 4
    static let DEFENCE = 5
    static let SPEED = 6
    static let SPIRIT = 7
    static let ACCURACY = 8
    static let AVOID = 9
    static let CRITICAL = 10
    static let MIND = 11
    static let HEALTH = 12
    static let FIREPOWER = 13
    static let WATERPOWER = 14
    static let THUNDERPOWER = 15
    static let FIRERESISTANCE = 16
    static let WATERRESISTANCE = 17
    static let THUNDERRESISTANCE = 18
    static let ELEMENTALPOWER = 19
    static let ELEMENTALRESISTANCE = 20
    static let LUCKY = 21
    static let BREAK = 22
    static let REVENGE = 23
    static let RHYTHM = 24
    static let CHAOS = 25
    static let ATTACK_BASE = 26
    static let SPIRIT_BASE = 27
    static let MAGICAL_POWER = 28
    static let DESTROY = 29
    static let HEALTH_BY_RATE = 30
    static let PHYSICAL_REDUCE_PERCENT = 31
    static let PHYSICAL_REDUCE_POINT = 32
        
    private enum CodingKeys: String, CodingKey {
        case _type
        case _name
        case _value
        case _reserve1
        case _percentValue
        case _hidden
    }
    var _type:Int = 0
    var _name = ""
    var _value:CGFloat = 0
    var _reserve1:CGFloat = 0
    var _percentValue = false
    var _hidden = false
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _type = try values.decode(Int.self, forKey: ._type)
        _name = try values.decode(String.self, forKey: ._name)
        _value = try values.decode(CGFloat.self, forKey: ._value)
        _reserve1 = try values.decode(CGFloat.self, forKey: ._reserve1)
        _percentValue = try values.decode(Bool.self, forKey: ._percentValue)
        _hidden = try values.decode(Bool.self, forKey: ._hidden)
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_type, forKey: ._type)
        try container.encode(_name, forKey: ._name)
        try container.encode(_value, forKey: ._value)
        try container.encode(_reserve1, forKey: ._reserve1)
        try container.encode(_hidden, forKey: ._hidden)
        try container.encode(_percentValue, forKey: ._percentValue)
        try super.encode(to: encoder)
    }
    
}
