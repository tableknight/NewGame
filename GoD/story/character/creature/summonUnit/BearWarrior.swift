//
//  BearWarrior.swift
//  GoD
//
//  Created by kai chen on 2019/2/21.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class BearWarrior: SummonUnit {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _stars.strength = 1.1
        _stars.stamina = 2.6
        _stars.agility = 0.8
        _stars.intellect = 0.6
        _name = "熊战士"
        _race = EvilType.NATURE
        _img = SKTexture(imageNamed: "bear_warrior")
        _spellsInuse = [Taunt()]
    }
}
