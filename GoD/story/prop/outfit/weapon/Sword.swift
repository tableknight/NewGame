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
        _selfAttrs = [ATTACK, ACCURACY]
        removeAttrId(id: ACCURACY)
    }
}
