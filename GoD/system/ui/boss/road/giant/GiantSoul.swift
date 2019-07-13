//
//  GiantSoul.swift
//  GoD
//
//  Created by kai chen on 2019/7/6.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class GiantSoul:SoulStone {
    override init() {
        super.init()
        _name = "巨人之魂"
        _description = "种族变为巨人"
        _level = 33
        _race = EvilType.GIANT
        _chance = 40
        _quality = Quality.SACRED
        price = 290
    }
    override func create() {
        
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
