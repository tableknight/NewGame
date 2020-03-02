//
//  Umisa.swift
//  GoD
//
//  Created by kai chen on 2019/2/9.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class Umisa:Boss {
    static let LEVEL:CGFloat = 34
    override init() {
        super.init()
        _name = "尤弥萨"
        _quality = Quality.SACRED
        _growth.stamina = 2.5
        _growth.strength = 3
        _growth.agility = 2.5
        _growth.intellect = 2
        _race = EvilType.DEMON
        _level = Umisa.LEVEL
        _img = SKTexture(imageNamed: "Umisa")
        _imgUrl = "Umisa"
        _sensitive = 50
        _spellsInuse = [Spell.SummonCopy, Spell.CriticalBite]
    }
    override func create(level: CGFloat) {
        levelTo(level: level)
        _extensions.health *= 4
        _extensions.hp = _extensions.health
        _extensions.mpMax *= 4
        _extensions.mp = _extensions.mpMax
    }
    var isCopy = false
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
