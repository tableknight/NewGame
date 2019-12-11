//
//  Herb.swift
//  GoD
//
//  Created by kai chen on 2019/12/11.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class Herb: Item {
    
    override init() {
        super.init()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class DrangonRoot : Herb {
    static let IMAGE = Game.instance.outside_b.getCell(7, 10)
    override init() {
        super.init()
        _name = "龙根草"
        _description = "一种神奇的植物，具有活血化瘀的功效"
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class SkyAroma : Herb {
    override init() {
        super.init()
        _name = "天香草"
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class PanGrass : Herb {
    override init() {
        super.init()
        _name = "面包草"
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class Curium : Herb {
    override init() {
        super.init()
        _name = "黄姜"
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class Caesalpinia : Herb {
    override init() {
        super.init()
        _name = "黄姜"
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
