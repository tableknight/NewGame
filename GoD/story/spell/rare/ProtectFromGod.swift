//
//  ProtectFromGod.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class ProtectFromGod: Passive {
    
    override init() {
        super.init()
        _id = Spell.ProtectFromGod
        _quality = Quality.RARE
        _name = "神之庇护"
        _description = "免疫燃烧"
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
