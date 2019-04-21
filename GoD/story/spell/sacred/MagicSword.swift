//
//  MagicSword.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class MagicSword: Passive {
    
    override init() {
        super.init()
        _name = "魔剑术"
        _description = "用精神替代攻击力"
        _quality = Quality.SACRED
        
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
