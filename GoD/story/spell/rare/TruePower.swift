//
//  TruePower.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/21.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class TruePower: Passive {
    
    override init() {
        super.init()
        _name = "全力以赴"
        _description = "提升10%基础力量"
        _quality = Quality.RARE
        
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
