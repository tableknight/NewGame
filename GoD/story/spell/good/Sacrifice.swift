//
//  Sacrifice.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/18.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Sacrifice: Passive {
    
    override init() {
        super.init()
        _id = Spell.Sacrifice
        _name = "牺牲"
        _description = "降低50%护甲，提升50点命中"
        _quality = Quality.GOOD
        
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
