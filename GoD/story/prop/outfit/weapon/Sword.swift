//
//  Sword.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/27.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Sword: Weapon {
    override init() {
        super.init()
        _name = "剑"
        _outfitName = "剑"
        _attackSpeed = seed(min: 100, max: 130).toFloat() * 0.01
        _selfAttrs = [ATTACK_BASE, STRENGTH]
        removeAttrId(id: STRENGTH)
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
