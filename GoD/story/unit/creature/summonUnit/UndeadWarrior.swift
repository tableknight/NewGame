//
//  UndeadWarrior.swift
//  GoD
//
//  Created by kai chen on 2019/2/16.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class UndeadWarrior: SummonUnit {
    override init() {
        super.init()
        _stars.strength = createPropValue()
        _stars.stamina = createPropValue()
        _stars.agility = createPropValue()
        _stars.intellect = createPropValue()
        _name = "亡灵战士"
        _race = EvilType.RISEN
        _img = SKTexture(imageNamed: "undead_warrior")
        
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class MummyMinion: SummonUnit {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _stars.strength = 1.1
        _stars.stamina = 1.1
        _stars.agility = 1.2
        _stars.intellect = 1.9
        _name = "木乃伊"
        _race = EvilType.RISEN
        _img = SKTexture(imageNamed: "mummy")
//        _spellsInuse = [ReduceLife(), HorribleImage()]
    }
}

class UndeadWitch: SummonUnit {
    override init() {
        super.init()
        _stars.strength = 1.2
        _stars.stamina = 1.2
        _stars.agility = 1.6
        _stars.intellect = 2.1
        _name = "亡灵巫师"
        _race = EvilType.RISEN
        _img = SKTexture(imageNamed: "undead_minion_5")
//        _spellsInuse = [IceSpear(), FireBreath()]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class UndeadMinion: SummonUnit {
    override init() {
        super.init()
        _stars.strength = 2.2
        _stars.stamina = 1.6
        _stars.agility = 1.1
        _stars.intellect = 0.8
        _name = "亡灵仆从"
        _race = EvilType.RISEN
        _img = SKTexture(imageNamed: "undead_minion_2")
//        _spellsInuse = [LineAttack()]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
