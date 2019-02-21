//
//  ElementalResistance.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/27.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class ElementalResistance: Attribute {
    override init() {
        super.init()
        _name = "元素抗性"
    }
    override func on(unit: Creature) {
        unit._elementalResistance.fire += _value
        unit._elementalResistance.water += _value
        unit._elementalResistance.thunder += _value
    }
    
    override func off(unit: Creature) {
        unit._elementalResistance.fire -= _value
        unit._elementalResistance.water -= _value
        unit._elementalResistance.thunder -= _value
    }
    override func create(level: CGFloat) {
        elementalAttrValue(level: level)
    }
}
