//
//  Francis.swift
//  GoD
//
//  Created by kai chen on 2019/2/6.
//  Copyright © 2019年 Chen. All rights reserved.
//


import SpriteKit
class Francis:Boss {
    static let LEVEL:CGFloat = 24
    override init() {
        
        super.init()
        _name = "弗朗西斯"
        _quality = Quality.SACRED
        _growth.stamina = 3
        _growth.strength = 2.5
        _growth.agility = 1.8
        _growth.intellect = 3
        _race = EvilType.DEMON
        _level = Francis.LEVEL
        _img = SKTexture(imageNamed: "Francis")
        _spellsInuse = [Spell.SummonServant, Spell.Nova]
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

class UndeadMinion1: BossMinion {
    override init() {
        super.init()
        _stars.strength = 2.1
        _stars.stamina = 2.8
        _stars.agility = 1.1
        _stars.intellect = 1.1
        _name = "亡灵仆从"
        _race = EvilType.RISEN
        _img = SKTexture(imageNamed: "undead_minion_1")
        _spellsInuse = [Spell.DeathAttack]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class UndeadMinion2: BossMinion {
    override init() {
        super.init()
        _stars.strength = 2.8
        _stars.stamina = 2.1
        _stars.agility = 1.5
        _stars.intellect = 1.1
        _name = "亡灵仆从"
        _race = EvilType.RISEN
        _img = SKTexture(imageNamed: "undead_minion_2")
        _spellsInuse = [Spell.LineAttack]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class UndeadMinion3: BossMinion {
    override init() {
        super.init()
        _stars.strength = 3.1
        _stars.stamina = 1.7
        _stars.agility = 1.1
        _stars.intellect = 1
        _name = "亡灵仆从"
        _race = EvilType.RISEN
        _img = SKTexture(imageNamed: "undead_minion_3")
        _spellsInuse = [Spell.AttackPowerUp]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class UndeadMinion4: BossMinion {
    override init() {
        super.init()
        _stars.strength = 1.1
        _stars.stamina = 1.8
        _stars.agility = 2.1
        _stars.intellect = 3.1
        _name = "亡灵仆从"
        _race = EvilType.RISEN
        _img = SKTexture(imageNamed: "undead_minion_4")
        _spellsInuse = [Spell.SoulExtract]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class UndeadMinion5: BossMinion {
    override init() {
        super.init()
        _stars.strength = 1.5
        _stars.stamina = 1.8
        _stars.agility = 1.8
        _stars.intellect = 2.1
        _name = "亡灵仆从"
        _race = EvilType.RISEN
        _img = SKTexture(imageNamed: "undead_minion_5")
        _spellsInuse = [Spell.Reinforce]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

