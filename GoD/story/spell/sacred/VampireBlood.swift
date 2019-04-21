//
//  VampireBlood.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/23.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class VampireBlood: Passive {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "吸血鬼血统"
        _description = "普通攻击回复造成伤害的20%"
        _quality = Quality.SACRED
        
    }
}
