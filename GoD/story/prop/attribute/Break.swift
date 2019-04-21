//
//  Break.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/28.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Break: Attribute {
    override init() {
        super.init()
        _name = "破甲"
    }
    override func on(unit: Creature) {
        unit._break += _value
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    
    override func off(unit: Creature) {
        unit._break -= _value
    }
    override func create(level: CGFloat) {
        if level < 15 {
            _value = seed(min: 1, max: 6).toFloat()
        } else {
            _value = seed(min: 1, max: 11).toFloat()
        }
    }
}
