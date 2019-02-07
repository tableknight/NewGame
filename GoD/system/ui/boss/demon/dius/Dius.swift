//
//  Dius.swift
//  GoD
//
//  Created by kai chen on 2019/2/7.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class Dius:Boss {
    static let DEFENCE = 0
    static let SPIRIT = 1
    static let FIRE = 2
    static let WATER = 3
    static let THUNDER = 4
    override init() {
        super.init()
        _name = "迪乌斯"
        _img = SKTexture(imageNamed: "Dius")
    }
    override func create(level: CGFloat) {
        _quality = Quality.SACRED
        _growth.stamina = 3
        _growth.strength = 3
        _growth.agility = 3
        _growth.intellect = 3
        levelTo(level: level)
        _extensions.health *= 4
        _extensions.hp = _extensions.health
        _extensions.defence = 0
        _ElementalResistance.fire = 0
        _ElementalResistance.water = 0
        _ElementalResistance.thunder = 0
        
        _spellsInuse = [ExposeWeakness()]
    }
    var _wwakness = 0
}
