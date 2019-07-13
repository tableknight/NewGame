//
//  GiantSpirit.swift
//  GoD
//
//  Created by kai chen on 2019/7/5.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class GiantSpirit:Boss {
    override init() {
        super.init()
        _name = "巨人之魂"
        _img = SKTexture(imageNamed: "GiantSpirit")
    }
    override func create(level: CGFloat) {
        _quality = Quality.SACRED
        _growth.stamina = 3.2
        _growth.strength = 2.6
        _growth.agility = 1.6
        _growth.intellect = 1.2
        levelTo(level: level)
        _extensions.health *= 5
        _extensions.hp = _extensions.health
        _spellsInuse = [Thorny(), TreadEarth(), TakeRest(), ThrowRock(), BeingTired()]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

