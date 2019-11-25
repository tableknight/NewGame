//
//  FearGhost.swift
//  GoD
//
//  Created by kai chen on 2019/7/14.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class FearGhost:Boss {
    static let LEVEL:CGFloat = 38
    static let IMG = "FearGhost"
    override init() {
        super.init()
        _name = "恐怖镜像"
        _quality = Quality.SACRED
        _growth.stamina = 1.8
        _growth.strength = 1
        _growth.agility = 2.7
        _growth.intellect = 2.8
        _level = FearGhost.LEVEL
        _race = EvilType.RISEN
        _img = SKTexture(imageNamed: "FearGhost")
        _imgUrl = "FearGhost"
        _spellsInuse = [DarkFall(), MessGhost(), SoulReaping(), SoulLash(), LifeDraw(), SoulSlay()]
    }
    override func create(level: CGFloat) {
        levelTo(level: level)
        _extensions.health *= 4
        _extensions.hp = _extensions.health
        _extensions.mind = 100
        
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class Nightmare:BossMinion {
    override init() {
        super.init()
        _name = "噩梦"
        _race = EvilType.RISEN
        _img = SKTexture(imageNamed: "nightmare")
    }
    override func create(level: CGFloat) {
        _quality = Quality.RARE
        _growth.stamina = 1.8
        _growth.strength = 2.1
        _growth.agility = 1.2
        _growth.intellect = 2.1
        _sensitive = 50
        levelTo(level: level)
        
        _extensions.health *= 2
        _extensions.hp = _extensions.health
        
        _spellsInuse = [SoulLash(), SoulSlay(), Sacre()]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

