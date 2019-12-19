//
//  RaceSuperiority.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/22.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Dominate: Passive {
    override init() {
        super.init()
        _id = Spell.Dominate
        _name = "战场主宰"
        _description = "使自己的种族属性始终处于优势"
        _quality = Quality.RARE
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

