//
//  SoulPeace.swift
//  GoD
//
//  Created by kai chen on 2019/7/18.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class SoulPeace:SoulStone {
    override init() {
        super.init()
        _name = "灵魂碎片"
        _description = ""
        _level = 42
        _race = EvilType.RISEN
        _chance = 40
        _quality = Quality.SACRED
        price = 340
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

