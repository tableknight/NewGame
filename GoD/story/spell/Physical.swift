//
//  Physical.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/18.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Physical: Active {
    
    override init() {
        super.init()
        isPhysical = true
        isClose = true
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
