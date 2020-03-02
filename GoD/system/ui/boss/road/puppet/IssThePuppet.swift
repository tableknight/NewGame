//
//  IssThePuppet.swift
//  GoD
//
//  Created by kai chen on 2019/6/4.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class IssThePuppet:Boss {
    static let LEVEL:CGFloat = 10
    static let IMG = "Plant"
    override init() {
        super.init()
        _name = "魔界灵媒"
        _quality = Quality.SACRED
        _growth.stamina = 2.3
        _growth.strength = 2.1
        _growth.agility = 1.8
        _growth.intellect = 2.6
        _level = IssThePuppet.LEVEL
        _race = EvilType.RISEN
        _imgUrl = IssThePuppet.IMG
        _img = SKTexture(imageNamed: _imgUrl)
        _spellsInuse = [Spell.LowerSummon, Spell.SummonFlower, Spell.WaterCopy, Spell.HighLevelSummon]
    }
    override func create(level: CGFloat) {
        
        levelTo(level: level)
        _extensions.health *= 4
        _extensions.hp = _extensions.health
        _extensions.mpMax *= 3
        _extensions.mp = _extensions.mpMax
        _sensitive = 40
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

