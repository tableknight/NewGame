//
//  Rhythm.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/6/9.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Rhythm: Attribute {
    override init() {
        super.init()
        _name = "律动"
    }
    override func on(unit: Creature) {
        unit._rhythm += _value
    }
    
    override func off(unit: Creature) {
        unit._rhythm -= _value
    }
    override func create(level: CGFloat) {
        if level < 20 {
            _value = seed(min: 1, max: 4).toFloat()
        } else if level < 50 {
            _value = seed(min: 1, max: 6).toFloat()
        } else {
            _value = seed(min: 1, max: 9).toFloat()
        }
    }
}

