//
//  Pitheron.swift
//  GoD
//
//  Created by kai chen on 2019/2/8.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class Pitheron:Boss {
    override init() {
        super.init()
        _name = "皮瑟隆"
        _quality = Quality.SACRED
        _growth.stamina = 1.5
        _growth.strength = 3
        _growth.agility = 3
        _growth.intellect = 1.5
        _race = EvilType.DEMON
        _img = SKTexture(imageNamed: "Pitheron")
//        _spellsInuse = [MagicReflect(), MagicConvert(), BossAttack(), BossAttack(), BossAttack()]
    }
    override func create(level: CGFloat) {
        levelTo(level: level)
        _extensions.health *= 4
        _extensions.hp = _extensions.health
        _extensions.attack *= 2
        _extensions.accuracy = 200
        _extensions.avoid = 200
        _revenge = 200
        
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

