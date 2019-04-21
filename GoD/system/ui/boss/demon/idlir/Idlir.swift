//
//  Idlir.swift
//  GoD
//
//  Created by kai chen on 2019/2/7.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class Idlir:Boss {
    override init() {
        super.init()
        _name = "伊德利尔"
        _img = SKTexture(imageNamed: "Idlir")
    }
    override func create(level: CGFloat) {
        _quality = Quality.SACRED
        _growth.stamina = 1.5
        _growth.strength = 3
        _growth.agility = 3
        _growth.intellect = 1.5
        levelTo(level: level)
        _extensions.health *= 4
        _extensions.hp = _extensions.health
        _extensions.attack *= 2
        _extensions.accuracy = 200
        _extensions.avoid = 200
        _revenge = 200
        
        _spellsInuse = [MagicReflect(), MagicConvert(), BossAttack(), BossAttack(), BossAttack()]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
