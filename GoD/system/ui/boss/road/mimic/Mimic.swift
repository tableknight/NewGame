//
//  Mimic.swift
//  GoD
//
//  Created by kai chen on 2019/3/30.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class Mimic:Boss {
    override init() {
        super.init()
        _name = "宝箱怪"
        _img = SKTexture(imageNamed: "Mimic")
    }
    override func create(level: CGFloat) {
        _quality = Quality.SACRED
        _growth.stamina = seedFloat(min: 10, max: 31) * 0.1
        _growth.strength = seedFloat(min: 10, max: 31) * 0.1
        _growth.agility = seedFloat(min: 10, max: 31) * 0.1
        _growth.intellect = seedFloat(min: 10, max: 31) * 0.1
        levelTo(level: level)
        _extensions.health *= 2
        _extensions.hp = _extensions.health
        _rhythm = 25
        _spellsInuse = [BossAttack(),BossAttack(),BossAttack(),LineAttack(), FireBreath(), ThunderArray(), LifeDraw()]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

