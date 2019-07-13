//
//  IssThePuppet.swift
//  GoD
//
//  Created by kai chen on 2019/6/4.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class IssThePuppet:Boss {
    override init() {
        super.init()
        _name = "艾斯斯"
        _img = SKTexture(imageNamed: "Iss")
    }
    override func create(level: CGFloat) {
        _quality = Quality.SACRED
        _growth.stamina = 1.8
        _growth.strength = 2.1
        _growth.agility = 1.8
        _growth.intellect = 2.6
        levelTo(level: level)
        _extensions.health *= 4
        _extensions.hp = _extensions.health
        _spellsInuse = []
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

