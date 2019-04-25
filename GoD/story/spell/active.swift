//
//  Active.swift
//  GoD
//
//  Created by kai chen on 2019/2/4.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class Active: Spell {
    override init() {
        super.init()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
