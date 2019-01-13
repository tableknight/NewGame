//
//  Amulet.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/28.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Amulet: Armor {
    override init() {
        super.init()
        _name = "饰品"
        _outfitName = "饰品"
        _selfAttrs = [HEALTH]
        removeAttrId(id: HEALTH)
    }
}
