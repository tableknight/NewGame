//
//  Toppur.swift
//  GoD
//
//  Created by kai chen on 2019/1/17.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class Toppur:Boss {
    static let LEVEL:CGFloat = 21
    static let IMG = "Toppur"
    override init() {
        super.init()
        _name = "托普尔"
        _quality = Quality.SACRED
        _growth.stamina = 3
        _growth.strength = 2.5
        _growth.agility = 1.8
        _growth.intellect = 3
        _race = EvilType.ANGEL
        _level = Toppur.LEVEL
        _img = SKTexture(imageNamed: "Toppur")
        _imgUrl = "Toppur"
//        _spellsInuse = [LineAttack(), LeeAttack(), BreakDefence()]
    }
    override func create(level: CGFloat) {
        
        levelTo(level: Toppur.LEVEL)
        _extensions.health *= 4
        _extensions.hp = _extensions.health
        
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class ToppurServant:BossMinion {
    override init() {
        super.init()
        _name = "艾琪"
        _img = SKTexture(imageNamed: "aiki")
    }
    override func create(level: CGFloat) {
        _quality = Quality.RARE
        _growth.stamina = 2.2
        _growth.strength = 3.1
        _growth.agility = 1.6
        _growth.intellect = 1
        levelTo(level: level)
        if _createForBattle {
            _extensions.health *= 2
            _extensions.hp = _extensions.health
        }
        
//        _spellsInuse = [LineAttack(), LeeAttack()]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
