//
//  WoodenDummy.swift
//  GoD
//
//  Created by kai chen on 2019/5/26.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class WoodenDummy: SummonUnit {
    override init() {
        super.init()
        _stars.strength = 2.3
        _stars.stamina = 2.2
        _stars.agility = 1.0
        _stars.intellect = 1.0
        _sensitive = 100
        _name = "木质假人"
        _img = SKTexture(imageNamed: "mummy.png")
//        _spellsInuse = [NoAction()]
        _race = EvilType.NATURE
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
