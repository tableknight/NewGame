//
//  Fist.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/28.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Fist: Weapon {
    override init() {
        super.init()
        _name = "拳套"
        _outfitName = "拳套"
        _attackSpeed = seed(min: 100, max: 130).toFloat() * 0.01
        _selfAttrs = [ATTACK, BREAK]
        removeAttrId(id: BREAK)
    }
}