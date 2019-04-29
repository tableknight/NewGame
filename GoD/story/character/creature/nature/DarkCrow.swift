//
//  DarkCrow.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/20.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class DarkCrow: Natrue {
    override init() {
        super.init()
        _stars.strength = 1.8
        _stars.stamina = 1.9
        _stars.agility = 1.0
        _stars.intellect = 0.6
        _name = "阿福"
        _imgUrl = "afu"
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
