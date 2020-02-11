//
//  Mimic.swift
//  GoD
//
//  Created by kai chen on 2019/3/30.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class Mimic:Boss {
    override init() {
        super.init()
        _name = "宝箱怪"
        _quality = Quality.SACRED
        _race = EvilType.DEMON
        _growth.stamina = seedFloat(min: 12, max: 24) * 0.1
        _growth.strength = seedFloat(min: 12, max: 24) * 0.1
        _growth.agility = seedFloat(min: 12, max: 24) * 0.1
        _growth.intellect = seedFloat(min: 12, max: 24) * 0.1
        _img = SKTexture(imageNamed: "Mimic")
        _spellsInuse = [Spell.LineAttack, Spell.FireBreath, Spell.ThunderArray, Spell.LifeDraw, Spell.LeeAttack]
    }
    override func create(level: CGFloat) {
        
        levelTo(level: level)
        _extensions.health *= 4
        _extensions.hp = _extensions.health
        _rhythm = 25
        
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

