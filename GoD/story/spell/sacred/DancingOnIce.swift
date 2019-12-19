//
//  DancingOnIce.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/7.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class DancingOnIce: Passive {
    
    override init() {
        super.init()
        _id = Spell.DancingOnIce
        _name = "冰舞"
        _description = "降低100%护甲，提升100点闪避"
        _quality = Quality.SACRED
        
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
