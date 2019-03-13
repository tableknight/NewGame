//
//  ElementWizard.swift
//  GoD
//
//  Created by kai chen on 2019/2/10.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class ElementWizard:Boss {
    override init() {
        super.init()
        _name = "元素法师"
        _img = SKTexture(imageNamed: "element_wizard")
    }
    override func create(level: CGFloat) {
        _quality = Quality.SACRED
        _growth.stamina = 1.5
        _growth.strength = 1
        _growth.agility = 1.9
        _growth.intellect = 3.5
        levelTo(level: level)
        _extensions.health *= 4
        _extensions.hp = _extensions.health
        _spellsInuse = [FireRain(), FireMatrix(), IceBomb(), FrozenShoot()]
        _sensitive = 75
        //        _spellsInuse = [ChopChop(), FlameAttack(), ElementPwoerUp()]
        //        for _ in 0...3 {
        //            _spellsInuse.append(BossAttack())
        //        }
    }
}

class MagicStudent:BossMinion {
    override init() {
        super.init()
        _name = "魔法学徒"
        _img = SKTexture(imageNamed: "magic_student")
    }
    override func create(level: CGFloat) {
        _quality = Quality.NORMAL
        _growth.stamina = 1.2
        _growth.strength = 0.8
        _growth.agility = 2.5
        _growth.intellect = 2.8
        levelTo(level: level)
        _extensions.health *= 1.5
        _extensions.hp = _extensions.health
        _spellsInuse = [FireOrFired(), LowlevelFlame()]
        _sensitive = 65
    }
}