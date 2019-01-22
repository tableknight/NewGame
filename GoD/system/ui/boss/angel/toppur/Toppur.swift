//
//  Toppur.swift
//  GoD
//
//  Created by kai chen on 2019/1/17.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class Toppur:Boss {
    override init() {
        super.init()
        _name = "托普尔"
        _img = SKTexture(imageNamed: "Toppur")
    }
    override func create(level: CGFloat) {
        _quality = Quality.SACRED
        _growth.stamina = 3
        _growth.strength = 2.5
        _growth.agility = 1.8
        _growth.intellect = 3
        levelTo(level: 46)
        _extensions.health *= 5
        _extensions.hp = _extensions.health
        
        _spellsInuse = [MagicConvert(), MagicReflect()]
    }
}
