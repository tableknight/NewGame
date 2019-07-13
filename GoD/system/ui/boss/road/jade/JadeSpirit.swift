//
//  JadeSpirit.swift
//  GoD
//
//  Created by kai chen on 2019/7/5.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class JadeSpirit:Boss {
    override init() {
        super.init()
        _name = "翠玉之灵"
        _img = SKTexture(imageNamed: "FireSpirit")
    }
    override func create(level: CGFloat) {
        _quality = Quality.SACRED
        _growth.stamina = 1.6
        _growth.strength = 1.6
        _growth.agility = 1.6
        _growth.intellect = 3.2
        levelTo(level: level)
        _extensions.health *= 4
        _extensions.hp = _extensions.health
        _elementalResistance.fire = 80
        _elementalResistance.water = -40
        _spellsInuse = [FireBreath(), FireAngel(), LavaExplode(), FireRain(), BurnHeart(), FireFist()]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

