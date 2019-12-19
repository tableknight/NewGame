//
//  OnePunch.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class OnePunch: Passive {
    
    override init() {
        super.init()
        _id = Spell.OnePunch
        _name = "玻璃大炮"
        _description = "将护甲算作物理攻击力"
        _quality = Quality.SACRED
        
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
