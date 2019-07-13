//
//  Thorny.swift
//  GoD
//
//  Created by kai chen on 2019/7/5.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class Thorny: Passive {
    
    override init() {
        super.init()
        _name = "荆棘"
        _description = "反弹20%近战物理伤害"
        _quality = Quality.RARE
        
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
