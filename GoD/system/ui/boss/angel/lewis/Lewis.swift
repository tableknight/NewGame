//
//  Lewis.swift
//  GoD
//
//  Created by kai chen on 2019/1/24.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class Lewis:Boss {
    static let LEVEL:CGFloat = 31
    override init() {
        super.init()
        _name = "路易斯"
        _quality = Quality.SACRED
        _growth.stamina = 3
        _growth.strength = 2.5
        _growth.agility = 2.2
        _growth.intellect = 3
        _race = EvilType.ANGEL
        _level = Lewis.LEVEL
//        _spellsInuse = [Spell.HandOfGod, Spell.PowerUp, OathBreaker(), SoulWatch()]
        _img = SKTexture(imageNamed: "Lewis")
        _imgUrl = "Lewis"
    }
    override func create(level: CGFloat) {
        levelTo(level: level)
        _extensions.health *= 5
        _extensions.hp = _extensions.health
        _extensions.mpMax *= 4
        _extensions.mp = _extensions.mpMax
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class LewisMinion:BossMinion {
    override init() {
        super.init()
        _name = "诗芬戈"
        _quality = Quality.SACRED
        _growth.stamina = 1.8
        _growth.strength = 2.8
        _growth.agility = 1.9
        _growth.intellect = 2.8
        _race = EvilType.ANGEL
        _level = Lewis.LEVEL
        _img = SKTexture(imageNamed: "Sphingo")
        _imgUrl = "Sphingo"
    }
    override func create(level: CGFloat) {
        _quality = Quality.NORMAL
        levelTo(level: level)
        
        _spellsInuse = [Spell.HandOfGod]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
