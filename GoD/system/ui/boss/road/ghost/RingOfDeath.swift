//
//  RingOfDeath.swift
//  GoD
//
//  Created by kai chen on 2019/7/15.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class RingOfDeath:Ring {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "逝者之戒"
        _description = "提升自身50%的治疗效果"
        _level = 55
        _chance = 30
        _quality = Quality.SACRED
        price = 542
    }
    override func create() {
        createAttr(attrId: SPIRIT, value: 0, remove: true)
        _attrCount = seed(min: 3, max: 5)
        createAttrs()
    }
}
