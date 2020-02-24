//
//  Sumahl.swift
//  GoD
//
//  Created by kai chen on 2019/1/23.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class Sumahl:Boss {
    static let LEVEL:CGFloat = 40
    override init() {
        super.init()
        _name = "苏玛尔"
        _quality = Quality.SACRED
        _growth.stamina = 3.5
        _growth.strength = 1.5
        _growth.agility = 2.8
        _growth.intellect = 3.5
        _race = EvilType.ANGEL
        _level = Sumahl.LEVEL
        _img = SKTexture(imageNamed: "Sumahl")
        _imgUrl = "Sumahl"
//        _spellsInuse = [MindIntervene(), HealAll(), SilenceAll()]
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
class SumahlServant1:BossMinion {
    override init() {
        super.init()
        _name = "溶露"
        _img = SKTexture(imageNamed: "anki")
    }
    override func create(level: CGFloat) {
        _quality = Quality.NORMAL
        _growth.stamina = 2.5
        _growth.strength = 2.5
        _growth.agility = 2.8
        _growth.intellect = 1.6
        levelTo(level: level)
        if _createForBattle {
            _extensions.health *= 1.5
            _extensions.hp = _extensions.health
        }
        _spellsInuse = [Spell.HolySacrifice]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class SumahlServant2:BossMinion {
    override init() {
        super.init()
        _name = "蜜琪"
        _img = SKTexture(imageNamed: "miki")
    }
    override func create(level: CGFloat) {
        _quality = Quality.NORMAL
        _growth.stamina = 2.1
        _growth.strength = 1.5
        _growth.agility = 2.8
        _growth.intellect = 2.6
        levelTo(level: level)
        if _createForBattle {
            _extensions.health *= 1.5
            _extensions.hp = _extensions.health
        }
        _spellsInuse = [Spell.LifeFlow]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
