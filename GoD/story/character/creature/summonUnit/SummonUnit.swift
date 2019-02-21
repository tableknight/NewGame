//
//  SummonUnit.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/15.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class SummonUnit: Creature {
    override init() {
        super.init()
        _spellsInuse = [BossAttack()]
    }
    var _last = 0
    var canBeControl = false
    internal func createPropValue() -> CGFloat {
        return seed(min: 10, max: 20).toFloat() * 0.1
    }
}
