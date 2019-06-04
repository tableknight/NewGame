//
//  DragonBlood.swift
//  GoD
//
//  Created by kai chen on 2019/2/21.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class DragonBlood:Passive {
    override init() {
        super.init()
        _name = "龙族血统"
        _description = "有一定几率免疫火焰伤害"
        _quality = Quality.GOOD
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
