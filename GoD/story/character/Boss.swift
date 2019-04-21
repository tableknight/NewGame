//
//  Boss.swift
//  GoD
//
//  Created by kai chen on 2019/1/17.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class Boss: Creature {
    override init() {
        super.init()
    }
    override func levelTo(level:CGFloat) {
        staminaChange(value: (level + 10) * _growth.stamina)
        strengthChange(value: (level + 10) * _growth.strength)
        agilityChange(value: (level + 10) * _growth.agility)
        intellectChange(value: (level + 10) * _growth.intellect)
        _level = level
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
