
//
//  Slime.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/1/28.
//  Copyright © 2018年 Chen. All rights reserved.
//
import SpriteKit
class Slime: Creature {
    override init() {
        super.init()
        _race = EvilType.NATURE
        _stars.stamina = 2.8
        _stars.strength = 1.5
        _stars.agility = 0.8
        _stars.intellect = 0.8
        _name = "史莱姆"
        _imgUrl = "slime"
        _img = SKTexture(imageNamed: "slime")
        
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
