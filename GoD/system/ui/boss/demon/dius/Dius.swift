//
//  Dius.swift
//  GoD
//
//  Created by kai chen on 2019/2/7.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class Dius:Boss {
    static let LEVEL:CGFloat = 19
    static let DEFENCE = 0
    static let SPIRIT = 1
    static let FIRE = 2
    static let WATER = 3
    static let THUNDER = 4
    override init() {
        super.init()
        _name = "迪乌斯"
        _quality = Quality.SACRED
        _growth.stamina = 3
        _growth.strength = 3
        _growth.agility = 3
        _growth.intellect = 3
        _race = EvilType.DEMON
        _level = Dius.LEVEL
        _img = SKTexture(imageNamed: "Dius")
        _imgUrl = "Dius"
        _spellsInuse = [Spell.ExposeWeakness, Spell.LineAttack, Spell.BallLighting, Spell.SuperWater, Spell.FireExplode]
    }
    override func create(level: CGFloat) {
        levelTo(level: level)
        _extensions.health *= 4
        _extensions.hp = _extensions.health
        _extensions.defence = 0
        _elementalResistance.fire = 0
        _elementalResistance.water = 0
        _elementalResistance.thunder = 0
        
        
    }
    var _wwakness = 0
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
