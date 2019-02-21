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
        _spellsInuse = [IceSpear(), FireBreath()]
    }
}
