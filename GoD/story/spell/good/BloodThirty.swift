//
//  BloodThirty.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class BloodThirsty: Passive {
    
    override init() {
        super.init()
        _id = Spell.BloodThirsty
        _name = "嗜血"
        _description = "附加当前等级数值的必杀"
        _quality = Quality.GOOD
        
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
