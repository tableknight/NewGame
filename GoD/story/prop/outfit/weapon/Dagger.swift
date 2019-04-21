//
//  Dagger.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/27.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Dagger: Weapon {
    override init() {
        super.init()
        _name = "匕首"
        _outfitName = "匕首"
        _attackSpeed = seed(min: 120, max: 150).toFloat() * 0.01
        _selfAttrs = [ATTACK, AVOID]
        removeAttrId(id: AVOID)
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
