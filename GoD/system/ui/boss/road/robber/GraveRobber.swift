//
//  GraveRobber.swift
//  GoD
//
//  Created by kai chen on 2019/7/8.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class GraveRobber:Boss {
    static let LEVEL:CGFloat = 33
    static let IMG = "GraveRobber"
    override init() {
        super.init()
        _name = "盗墓者"
        _quality = Quality.SACRED
        _growth.stamina = 1.8
        _growth.strength = 2
        _growth.agility = 2
        _growth.intellect = 2.6
        _level = GraveRobber.LEVEL
        _race = EvilType.MAN
        _img = SKTexture(imageNamed: "GraveRobber")
        _imgUrl = "GraveRobber"
        _spellsInuse = [RobberHasMoral(), SummonMummy(), CutThroat(), MakeEverythingRight(), NervousPoison(), HorribleImage(), KickAss(), ReduceLife()]
    }
    override func create(level: CGFloat) {
        levelTo(level: level)
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

class RobberMinion:BossMinion {
    override init() {
        super.init()
        _name = "手下"
        _img = SKTexture(imageNamed: "robber_minion")
    }
    override func create(level: CGFloat) {
        _quality = Quality.NORMAL
        _growth.stamina = 2
        _growth.strength = 2
        _growth.agility = 2
        _growth.intellect = 1.1
        _sensitive = 33
        levelTo(level: level)
        
        _extensions.health *= 2
        _extensions.hp = _extensions.health
        
        _spellsInuse = [CutThroat(), KickAss(), NervousPoison()]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
