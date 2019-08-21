//
//  Blunt.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/27.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Blunt: Weapon {
    override init() {
        super.init()
        _name = "钝器"
        _outfitName = "钝器"
        _attackSpeed = seed(min: 70, max: 100).toFloat() * 0.01
        _selfAttrs = [ATTACK_BASE, STAMINA]
        removeAttrId(id: STAMINA)
    }
    override func createSelfAttrs() {
        super.createSelfAttrs()
        _attrs[0]._value *= 1.2
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
