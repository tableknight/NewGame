//
//  Passive.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/23.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Passive: Spell {
    
    override init() {
        super.init()
        isPassive = true
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
//    func on(){}
//    func off(){}
}
