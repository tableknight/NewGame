//
//  BlackCat.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/20.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class BlackCat: Creature {
    override init() {
        super.init()
        _stars.strength = 1.1
        _stars.stamina = 1.5
        _stars.agility = 2.1
        _stars.intellect = 1.1
        _name = "奇奇"
        _imgUrl = "kiki"
        _race = EvilType.NATURE
        _img = SKTexture(imageNamed: _imgUrl)
    }
    override func create(level: CGFloat) {
        _level = level
        _quality = Quality.NORMAL
        _growth.stamina = _stars.stamina
        _growth.strength = _stars.strength
        _growth.agility = _stars.agility
        _growth.intellect = _stars.intellect
        _birth.stamina = 20
        _birth.strength = 20
        _birth.agility = 20
        _birth.intellect = 20
        levelTo(level: level)
        _extensions.hp = _extensions.health
        createSensitive()
        
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
