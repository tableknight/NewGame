//
//  George.swift
//  GoD
//
//  Created by kai chen on 2019/2/10.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class George:Boss {
    override init() {
        super.init()
        _name = "乔治·安顿比尔"
        _img = SKTexture(imageNamed: "George")
    }
    override func create(level: CGFloat) {
        _quality = Quality.SACRED
        _growth.stamina = 2
        _growth.strength = 3
        _growth.agility = 2.2
        _growth.intellect = 2.5
        levelTo(level: level)
        _extensions.health *= 3
        _extensions.hp = _extensions.health
        _spellsInuse = [Reborn(), Infection(), DrawBlood(), Screaming()]
        _sensitive = 25
        //        _spellsInuse = [ChopChop(), FlameAttack(), ElementPwoerUp()]
        //        for _ in 0...3 {
        //            _spellsInuse.append(BossAttack())
        //        }
    }
}

class GeorgeServant1:BossMinion {
    override init() {
        super.init()
        _name = "眷族"
        _img = SKTexture(imageNamed: "george_servant1")
    }
    override func create(level: CGFloat) {
        _quality = Quality.NORMAL
        _growth.stamina = 2.2
        _growth.strength = 2.8
        _growth.agility = 1.5
        _growth.intellect = 0.8
        levelTo(level: level)
        _extensions.health *= 2
        _extensions.hp = _extensions.health
        _spellsInuse = [Reborn()]
    }
}
class GeorgeServant2:BossMinion {
    override init() {
        super.init()
        _name = "眷族"
        _img = SKTexture(imageNamed: "george_servant2")
    }
    override func create(level: CGFloat) {
        _quality = Quality.NORMAL
        _growth.stamina = 2
        _growth.strength = 1.6
        _growth.agility = 1.2
        _growth.intellect = 2.6
        levelTo(level: level)
        _extensions.health *= 2
        _extensions.hp = _extensions.health
        _sensitive = 60
        _spellsInuse = [Reborn(), Screaming()]
    }
}
