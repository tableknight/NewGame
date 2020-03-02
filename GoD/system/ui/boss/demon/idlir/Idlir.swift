//
//  Idlir.swift
//  GoD
//
//  Created by kai chen on 2019/2/7.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class Idlir:Boss {
    static let LEVEL:CGFloat = 13
    override init() {
        super.init()
        _name = "伊德利尔"
        _quality = Quality.SACRED
        _growth.strength = 2.4
        _growth.stamina = 1.8
        _growth.agility = 2.5
        _growth.intellect = 1.5
        _level = Idlir.LEVEL
        _race = EvilType.DEMON
        _img = SKTexture(imageNamed: "Idlir")
        _imgUrl = "Idlir"
        _sensitive = 25
        _spellsInuse = [Spell.MagicReflect, Spell.MagicConvert]
    }
    override func create(level: CGFloat) {
        levelTo(level: level)
        _extensions.health *= 4
        _extensions.hp = _extensions.health
        _extensions.mpMax *= 4
        _extensions.mp = _extensions.mpMax
//        _extensions.hp = 1
//        _extensions.attack *= 2
        _extensions.accuracy = 200
        _extensions.avoid += 50
        _revenge = 50
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
