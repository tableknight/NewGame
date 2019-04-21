//
//  Umisa.swift
//  GoD
//
//  Created by kai chen on 2019/2/9.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class Umisa:Boss {
    override init() {
        super.init()
        _name = "尤弥萨"
        _img = SKTexture(imageNamed: "Umisa")
    }
    override func create(level: CGFloat) {
        _quality = Quality.SACRED
        _growth.stamina = 2.5
        _growth.strength = 3
        _growth.agility = 2.5
        _growth.intellect = 2
        levelTo(level: level)
//        _extensions.health *= 2
        _extensions.hp = _extensions.health
        _spellsInuse = [CriticalBite(), BossAttack()]
//        _spellsInuse = [ChopChop(), FlameAttack(), ElementPwoerUp()]
//        for _ in 0...3 {
//            _spellsInuse.append(BossAttack())
//        }
    }
    var isCopy = false
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
