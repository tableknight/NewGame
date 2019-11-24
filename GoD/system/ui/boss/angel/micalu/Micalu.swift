//
//  Micalu.swift
//  GoD
//
//  Created by kai chen on 2019/1/22.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class Micalu:Boss {
    static let LEVEL:CGFloat = 36
    override init() {
        super.init()
        _name = "米卡路"
        _quality = Quality.SACRED
        _growth.stamina = 2.5
        _growth.strength = 3.5
        _growth.agility = 3.8
        _growth.intellect = 2
        _race = EvilType.ANGEL
        _level = Micalu.LEVEL
        _img = SKTexture(imageNamed: "Micalu")
        _imgUrl = "Micalu"
        _spellsInuse = [SixShooter(), ShootTwo(), OneShootDoubleKill(), MagicReflect()]
    }
    override func create(level: CGFloat) {
        
        levelTo(level: level)
        _extensions.health *= 3
        _extensions.hp = _extensions.health
        _extensions.accuracy = 200
//        _extensions.avoid = 200
//        _extensions.critical = 100
        
        let bow = Bow()
        bow.create(level: level)
        _weapon = bow
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class MicaluServant1:BossMinion {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "米卡路之子"
        _img = SKTexture(imageNamed: "son_of_micalu1")
    }
    override func create(level: CGFloat) {
        _quality = Quality.RARE
        _growth.stamina = 2.5
        _growth.strength = 3
        _growth.agility = 2.2
        _growth.intellect = 1.2
        levelTo(level: level)
        if _createForBattle {
            _extensions.health *= 2
            _extensions.hp = _extensions.health
        }
        
        
        _spellsInuse = [Bitslap(), LeeAttack()]
    }
}
class MicaluServant2:BossMinion {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "米卡路之子"
        _sensitive = 85
        _img = SKTexture(imageNamed: "son_of_micalu2")
    }
    override func create(level: CGFloat) {
        _quality = Quality.RARE
        _growth.stamina = 2
        _growth.strength = 1.2
        _growth.agility = 1.9
        _growth.intellect = 2.9
        levelTo(level: level)
        if _createForBattle {
            _extensions.health *= 2
            _extensions.hp = _extensions.health
        }
        
        _spellsInuse = [Lighting(), ThunderAttack()]
    }
}
