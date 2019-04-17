//
//  BlackCat.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/20.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class BlackCat: Natrue {
    override init() {
        super.init()
        _stars.strength = 1.4
        _stars.stamina = 1.1
        _stars.agility = 2.1
        _stars.intellect = 1.1
        _name = "奇奇"
        _race = EvilType.NATURE
        _img = Game.instance.pictureNature.getCell(3, 3, 3, 4)
        _spellsInuse = []
    }
    override func createQuality() {
        _quality = Quality.NORMAL
    }
    override func create(level: CGFloat) {
        super.create(level: level)
        _spellCount = 1
    }
    override func protectNew() {
        
    }
}
