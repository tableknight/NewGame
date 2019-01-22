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
        levelTo(level: 51)
        _extensions.health *= 4
        _extensions.hp = _extensions.health
        _extensions.accuracy = 200
        _extensions.avoid = 200
        _extensions.critical = 100
        
        let bow = Bow()
        bow.create(level: 51)
        _weapon = bow
        
        _spellsInuse = [ShootAll(), ShootTwo(), FrozenShoot(), OneShootDoubleKill(), Attack()]
    }
}

