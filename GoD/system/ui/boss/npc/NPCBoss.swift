//
//  NPCBoss.swift
//  GoD
//
//  Created by kai chen on 2019/8/26.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class NPCBoss: Boss {
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
