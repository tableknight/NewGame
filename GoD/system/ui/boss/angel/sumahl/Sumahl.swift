//
//  Sumahl.swift
//  GoD
//
//  Created by kai chen on 2019/1/23.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class Sumahl:Boss {
    override init() {
        super.init()
        _name = "苏玛尔"
        _img = SKTexture(imageNamed: "Sumahl")
    }
    override func create(level: CGFloat) {
        _quality = Quality.SACRED
        _growth.stamina = 3.5
        _growth.strength = 1.5
        _growth.agility = 2.8
        _growth.intellect = 3.5
        levelTo(level: level)
        _extensions.health *= 3
        _extensions.hp = _extensions.health
        
        
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class SumahlServant1:BossMinion {
    override init() {
        super.init()
        _name = "蜜雪"
        _img = Game.instance.pictureActor3.getCell(9, 3, 3, 4)
    }
    override func create(level: CGFloat) {
        _quality = Quality.NORMAL
        _growth.stamina = 2.5
        _growth.strength = 2.5
        _growth.agility = 2.8
        _growth.intellect = 1.6
        levelTo(level: level)
        
        _spellsInuse = [HolySacrifice()]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class SumahlServant2:BossMinion {
    override init() {
        super.init()
        _name = "露琪"
        _img = Game.instance.pictureNature.getCell(6, 7, 3, 4)
    }
    override func create(level: CGFloat) {
        _quality = Quality.NORMAL
        _growth.stamina = 2.1
        _growth.strength = 1.5
        _growth.agility = 2.8
        _growth.intellect = 2.6
        levelTo(level: level)
        
        _spellsInuse = [LifeFlow()]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
