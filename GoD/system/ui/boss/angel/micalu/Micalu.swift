//
//  Micalu.swift
//  GoD
//
//  Created by kai chen on 2019/1/22.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class Micalu:Boss {
    override init() {
        super.init()
        _name = "米卡路"
        _img = SKTexture(imageNamed: "Micalu")
    }
    override func create(level: CGFloat) {
        _quality = Quality.SACRED
        _growth.stamina = 2.5
        _growth.strength = 3.5
        _growth.agility = 3.8
        _growth.intellect = 2
        levelTo(level: level)
        _extensions.health *= 3
        _extensions.hp = _extensions.health
        _extensions.accuracy = 200
//        _extensions.avoid = 200
//        _extensions.critical = 100
        
        let bow = Bow()
        bow.create(level: level)
        _weapon = bow
        
        _spellsInuse = [SixShooter(), ShootTwo(), OneShootDoubleKill(), MagicReflect()]
    }
}

class MicaluServant1:BossMinion {
    override init() {
        super.init()
        _name = "米卡路之子"
        _img = Game.instance.pictureActor3.getCell(10, 3, 3, 4)
    }
    override func create(level: CGFloat) {
        _quality = Quality.SACRED
        _growth.stamina = 2
        _growth.strength = 3
        _growth.agility = 2.2
        _growth.intellect = 1.2
        levelTo(level: level)
        _extensions.health *= 2
        _extensions.hp = _extensions.health
        
        _spellsInuse = [Bitslap(), RecoveryFromAttack()]
    }
}
class MicaluServant2:BossMinion {
    override init() {
        super.init()
        _name = "米卡路之子"
        _sensitive = 85
        _img = Game.instance.pictureActor3.getCell(10, 7, 3, 4)
    }
    override func create(level: CGFloat) {
        _quality = Quality.SACRED
        _growth.stamina = 2
        _growth.strength = 1.2
        _growth.agility = 1.6
        _growth.intellect = 2.5
        levelTo(level: level)
        _extensions.health *= 2
        _extensions.hp = _extensions.health
        
        _spellsInuse = [Lighting(), ThunderAttack()]
    }
}
