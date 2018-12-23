//
//  Bow.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/25.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Bow: Weapon {
    override init() {
        super.init()
        isClose = false
        _name = "弓"
        _outfitName = "弓"
        _attackSpeed = seed(min: 100, max: 130).toFloat() * 0.01
        _selfAttrs = [ATTACK, AGILITY]
        removeAttrId(id: AGILITY)
    }
}