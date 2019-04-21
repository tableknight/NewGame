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
        _name = "项链"
        _outfitName = "项链"
        _selfAttrs = [HEALTH]
        removeAttrId(id: HEALTH)
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
