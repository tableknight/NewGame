//
//  Revenge.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/30.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Revenge: Attribute {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "复仇"
    }
    override func on(unit: Creature) {
        unit._revenge += _value
    }
    
    override func off(unit: Creature) {
        unit._revenge -= _value
    }
    override func create(level: CGFloat) {
        _value = seed(min: 1, max: 11).toFloat()
    }
}
