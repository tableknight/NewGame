//
//  George.swift
//  GoD
//
//  Created by kai chen on 2019/2/10.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class George:Boss {
    static let LEVEL:CGFloat = 39
    override init() {
        super.init()
        _name = "乔治·安顿比尔"
        _quality = Quality.SACRED
        _growth.stamina = 2.1
        _growth.strength = 3
        _growth.agility = 2.6
        _growth.intellect = 2.8
        _race = EvilType.DEMON
        _level = George.LEVEL
        _img = SKTexture(imageNamed: "George")
        _imgUrl = "George"
        _spellsInuse = [Spell.Infection, Spell.DrawBlood, Spell.Screaming, Spell.VampireBlood]
        _sensitive = 25
    }
    override func create(level: CGFloat) {
        
        levelTo(level: level)
        _extensions.health *= 3
        _extensions.hp = _extensions.health
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class GeorgeServant1:BossMinion {
    override init() {
        super.init()
        _name = "眷族"
        _img = SKTexture(imageNamed: "george_servant1")
    }
    override func create(level: CGFloat) {
        _quality = Quality.NORMAL
        _growth.stamina = 2.2
        _growth.strength = 2.8
        _growth.agility = 2.2
        _growth.intellect = 1.5
        levelTo(level: level)
        _extensions.health *= 2.5
        _extensions.hp = _extensions.health
        _spellsInuse = [Spell.Reborn, Spell.VampireBlood, Spell.Infection]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class GeorgeServant2:BossMinion {
    override init() {
        super.init()
        _name = "眷族"
        _img = SKTexture(imageNamed: "george_servant2")
    }
    override func create(level: CGFloat) {
        _quality = Quality.NORMAL
        _growth.stamina = 2.2
        _growth.strength = 1.6
        _growth.agility = 2.2
        _growth.intellect = 2.9
        levelTo(level: level)
        _extensions.health *= 2.5
        _extensions.hp = _extensions.health
        _sensitive = 60
        _spellsInuse = [Spell.Screaming, Spell.VampireBlood, Spell.LifeDraw]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
