//
//  TestSix.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/1/24.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class TestSeven:Scenery {
    override init() {
        super.init()
        xSize = 7
        ySize = 7
        setMatrix([
            [0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0],
            [0,0,1,0,0,0,0],
            [0,0,0,0,1,0,0],
            [0,0,1,0,0,0,0],
            [0,0,0,0,0,1,0],
            [0,0,0,0,0,0,0],
            ])
        _evilList = [EvilId.Mummy, EvilId.Slime]
        _evilCount = 2
        setGround("7x7.png")
        createMovingEvils()
        setUnitMove()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
