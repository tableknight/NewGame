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
        _attackSpeed = seed(min: 80, max: 110).toFloat() * 0.01
        _selfAttrs = [ATTACK_BASE, CRITICAL]
        removeAttrId(id: CRITICAL)
    }
    override func createSelfAttrs() {
        super.createSelfAttrs()
        _attrs[0]._value *= 1.2
    }
}
