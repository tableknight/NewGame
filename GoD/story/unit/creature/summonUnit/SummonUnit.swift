//
//  SummonUnit.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/15.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class SummonUnit: Creature {
    static let POWERUP_RATE:CGFloat = 1.5
    override init() {
        super.init()
//        _spellsInuse = [BossAttack()]
    }
    var _last = 0
    var canBeControl = false
    internal func createPropValue() -> CGFloat {
        return seed(min: 10, max: 21).toFloat() * 0.1
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

