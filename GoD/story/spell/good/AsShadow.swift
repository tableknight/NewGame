//
//  AsShadow.swift
//  GoD
//
//  Created by kai chen on 2019/8/25.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class AsShadow: Passive {
    
    override init() {
        super.init()
        _name = "如影随从"
        _description = "提升10点律动"
        _quality = Quality.GOOD
        
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

