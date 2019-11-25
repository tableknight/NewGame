//
//  Lewis.swift
//  GoD
//
//  Created by kai chen on 2019/1/24.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class Lewis:Boss {
    static let LEVEL:CGFloat = 31
    override init() {
        super.init()
        _name = "路易斯"
        _quality = Quality.SACRED
        _growth.stamina = 3
        _growth.strength = 2.5
        _growth.agility = 1.8
        _growth.intellect = 3
        _race = EvilType.ANGEL
        _level = Lewis.LEVEL
        _spellsInuse = [HandOfGod(), PowerUp(), OathBreaker(), SoulWatch()]
        _img = SKTexture(imageNamed: "Lewis")
        _imgUrl = "Lewis"
    }
    override func create(level: CGFloat) {
        levelTo(level: level)
        _extensions.health *= 5
        _extensions.hp = _extensions.health
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class LewisMinion:BossMinion, IFace {
    override init() {
        super.init()
        _name = "诗芬戈"
        let node = SKTexture(imageNamed: "Faces").getNode(0, 4, 2.5, 2.5)
        node.size = CGSize(width: 48, height: 48)
        _img = node.toTexture()
    }
    override func create(level: CGFloat) {
        _quality = Quality.NORMAL
        _growth.stamina = 1.5
        _growth.strength = 2.5
        _growth.agility = 1.8
        _growth.intellect = 1.6
        levelTo(level: level)
        
        _spellsInuse = [HandOfGod()]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
