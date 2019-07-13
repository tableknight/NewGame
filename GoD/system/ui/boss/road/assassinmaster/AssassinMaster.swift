//
//  AssassinMaster.swift
//  GoD
//
//  Created by kai chen on 2019/7/8.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class AssassinMaster:Boss {
    override init() {
        super.init()
        _name = "刺客大师"
        _img = SKTexture(imageNamed: "AssassinMaster")
    }
    override func create(level: CGFloat) {
        _quality = Quality.SACRED
        _growth.stamina = 1.2
        _growth.strength = 3
        _growth.agility = 3
        _growth.intellect = 1.1
        levelTo(level: level)
        _extensions.health *= 5
        _extensions.hp = _extensions.health
        _spellsInuse = [Disappear(), ThrowWeapon(), ShadowCopy(), Observant(), FlashPowder()]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

