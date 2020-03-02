//
//  GiantSpirit.swift
//  GoD
//
//  Created by kai chen on 2019/7/5.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class GiantSpirit:Boss {
    static let LEVEL:CGFloat = 25
    static let IMG = "GiantSpirit"
    override init() {
        super.init()
        _name = "巨人之魂"
        _quality = Quality.SACRED
        _growth.stamina = 3.2
        _growth.strength = 2.6
        _growth.agility = 1.6
        _growth.intellect = 1.2
        _race = EvilType.GIANT
        _level = GiantSpirit.LEVEL
        _img = SKTexture(imageNamed: "GiantSpirit")
        _imgUrl = "GiantSpirit"
        _spellsInuse = [Spell.Thorny, Spell.TreadEarth, Spell.TakeRest, Spell.ThrowRock, Spell.BeingTired]
    }
    override func create(level: CGFloat) {
        levelTo(level: level)
        _extensions.health *= 6.5
        _extensions.hp = _extensions.health
        _extensions.mpMax *= 4
        _extensions.mp = _extensions.mpMax
        _sensitive = 55
        
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

