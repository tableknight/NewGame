//
//  ElementWizard.swift
//  GoD
//
//  Created by kai chen on 2019/2/10.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class ElementWizard:Boss {
    override init() {
        super.init()
        _name = "元素法师"
        _quality = Quality.SACRED
        _growth.stamina = 1.5
        _growth.strength = 1
        _growth.agility = 1.9
        _growth.intellect = 3.5
        _race = EvilType.MAN
        _img = SKTexture(imageNamed: "element_wizard")
//        _spellsInuse = [FireRain(), FireMatrix(), IceBomb(), FrozenShoot()]
        _sensitive = 75
    }
    override func create(level: CGFloat) {
        
        levelTo(level: level)
        _extensions.health *= 4
        _extensions.hp = _extensions.health
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class MagicStudent:BossMinion {
    override init() {
        super.init()
        _name = "魔法学徒"
        _img = SKTexture(imageNamed: "magic_student")
    }
    override func create(level: CGFloat) {
        _quality = Quality.NORMAL
        _growth.stamina = 1.2
        _growth.strength = 0.8
        _growth.agility = 2.5
        _growth.intellect = 2.8
        levelTo(level: level)
        _extensions.health *= 1.5
        _extensions.hp = _extensions.health
//        _spellsInuse = [FireOrFired(), LowlevelFlame()]
        _sensitive = 65
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
