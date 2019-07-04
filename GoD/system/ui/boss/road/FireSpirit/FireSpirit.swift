//
//  FireSpirit.swift
//  GoD
//
//  Created by kai chen on 2019/7/4.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class FireSpirit:Boss {
    override init() {
        super.init()
        _name = "火源精华"
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

class FireServant:BossMinion {
    override init() {
        super.init()
        _name = "烈焰仆从"
        _img = SKTexture(imageNamed: "fire_servant")
    }
    override func create(level: CGFloat) {
        _quality = Quality.NORMAL
        _growth.stamina = 2.2
        _growth.strength = 2.2
        _growth.agility = 2.2
        _growth.intellect = 1.1
        _sensitive = 33
        levelTo(level: level)
        
        _elementalResistance.fire = 40
        _elementalResistance.water = -20
        _extensions.health *= 2
        _extensions.hp = _extensions.health
        
        _spellsInuse = [Burn(), Combustion(), BurningOut()]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
