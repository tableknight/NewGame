//
//  Bellicose.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Bellicose: Passive {
    
    override init() {
        super.init()
        _name = "好战"
        _description = "提升30%基础攻击力"
        _quality = Quality.NORMAL
        
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
