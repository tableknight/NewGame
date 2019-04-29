//
//  BlackCat.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/20.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class BlackCat: Natrue {
    override init() {
        super.init()
        _stars.strength = 1.4
        _stars.stamina = 1.1
        _stars.agility = 2.1
        _stars.intellect = 1.1
        _name = "奇奇"
        _imgUrl = "kiki"
        _img = SKTexture(imageNamed: _imgUrl)
    }
    override func createQuality() {
        _quality = Quality.NORMAL
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
