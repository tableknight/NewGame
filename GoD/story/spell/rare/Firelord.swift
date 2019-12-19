//
//  Firelord.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Firelord: Auro {
    
    override init() {
        super.init()
        _id = Spell.Firelord
        _name = "火焰领主"
        _description = "提升全队20点火焰抗性和20点火焰伤害"
        _quality = Quality.RARE
        
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    
}
