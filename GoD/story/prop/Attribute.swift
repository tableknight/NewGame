//
//  Attribute.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/25.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Attribute: Core {
    override init() {
        super.init()
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _name = try values.decode(String.self, forKey: ._name)
        _value = try values.decode(CGFloat.self, forKey: ._value)
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_name, forKey: ._name)
        try container.encode(_value, forKey: ._value)
        try super.encode(to: encoder)
    }
    private enum CodingKeys: String, CodingKey {
        case _name
        case _value
    }
    var _name = ""
    var _value:CGFloat = 0
    func on(unit:Creature) -> Void {
        
    }
    func off(unit:Creature) -> Void {
        
    }
    func create(level:CGFloat) {
        
    }
    func getText() -> String {
        if _value < 0 {
            return "\(_name) \(_value.toInt())"
        } else {
            return "\(_name) +\(_value.toInt())"
        }
    }
     func midAttrValue(level:CGFloat) {
        var min = (level * 0.4).toInt()
        if min < 1 {
            min = 1
        }
        var max = (level * 0.8).toInt()
        if max < 1 {
            max = 1
        }
        _value = seed(min: min, max: max).toFloat()
    }
     func upperAttrValue(level:CGFloat) {
        var min = (level * 0.8).toInt()
        if min < 1 {
            min = 1
        }
        var max = (level * 1.2).toInt()
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
}
