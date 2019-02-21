//
//  BearWarrior.swift
//  GoD
//
//  Created by kai chen on 2019/2/21.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class BearWarrior: SummonUnit {
    override init() {
        super.init()
        _stars.strength = 1.5
        _stars.stamina = 2.2
        _stars.agility = 0.8
        _stars.intellect = 0.6
        _name = "熊战士"
        _race = EvilType.NATURE
        _img = SKTexture(imageNamed: "bear_warrior")
        _spellsInuse = [Taunt()]
    }
}
