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
    override init() {
        super.init()
        _name = "艾斯斯"
        _quality = Quality.SACRED
        _growth.stamina = 2.5
        _growth.strength = 2.1
        _growth.agility = 1.8
        _growth.intellect = 2.6
        _level = IssThePuppet.LEVEL
        _race = EvilType.RISEN
        _img = SKTexture(imageNamed: "Iss")
        _imgUrl = "Iss"
        _spellsInuse = [Spell.ControlUndead, Spell.LowerSummon, Spell.SummonFlower, Spell.WaterCopy, Spell.HighLevelSummon]
    }
    override func create(level: CGFloat) {
        
        levelTo(level: level)
        _extensions.health *= 4
        _extensions.hp = _extensions.health
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

