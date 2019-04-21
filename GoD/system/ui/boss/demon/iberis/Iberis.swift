//
//  Iberis.swift
//  GoD
//
//  Created by kai chen on 2019/2/8.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class Iberis:Boss {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "伊比利斯"
        _img = SKTexture(imageNamed: "Iberis")
    }
    override func create(level: CGFloat) {
        _quality = Quality.SACRED
        _growth.stamina = 2.5
        _growth.strength = 3
        _growth.agility = 2.5
        _growth.intellect = 2
        levelTo(level: level)
        _extensions.health *= 4
        _extensions.hp = _extensions.health
        
        _spellsInuse = [ChopChop(), FlameAttack(), ElementPowerUp()]
        for _ in 0...3 {
            _spellsInuse.append(BossAttack())
        }
    }
}

