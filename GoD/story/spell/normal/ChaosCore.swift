//
//  ChaosCore.swift
//  GoD
//
//  Created by kai chen on 2019/7/30.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class ChaosCore: Passive {
    static let VALUE:CGFloat = 25
    override init() {
        super.init()
        _id = Spell.ChaosCore
        _name = "浩劫之心"
        _description = "提升25点复仇"
        _quality = Quality.NORMAL
        
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
