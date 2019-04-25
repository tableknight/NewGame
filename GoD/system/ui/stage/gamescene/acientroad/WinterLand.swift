//
//  WinterLand.swift
//  GoD
//
//  Created by kai chen on 2019/1/2.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class WinterLand: AcientRoad {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _itemEnum = [1,2,3,4,5,6,7,8,9,10]
        for _ in 0...10 {
            _itemEnum.append(11)
        }
        _monsterEnum = [1,2,3,4]
        let oa4 = Game.instance.outside_a4
        _mapSet = GroundSets(ground: oa4.getCell(6, 12, 2, 2), wall: oa4.getCell(6, 14, 2, 2))
        _name = "寒冰大陆"
        _id = AcientRoad.WINTER_LAND
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func getItemByIndex(index: Int) -> UIItem {
        switch index {
        case 1:
            return MP11()
        case 2:
            return MP12()
        case 3:
            return MP13()
        case 4:
            return MP14()
        case 5:
            return MP15()
        case 6:
            return MP16()
        case 7:
            return MP17()
        case 8:
            return MP18()
        case 9:
            return MP19()
        case 10:
            return MP110()
        case 11:
            return MP21()
        default:
            return MP11()
        }
    }
    
    override func getMonsterByIndex(index: Int) -> Creature {
        switch index {
        case 1:
            return SnowLady()
        case 2:
            return FrozenSlime()
        case 3:
            return IceBeast()
        case 4:
            return SnowSpirit()
        default:
            return SnowLady()
        }
    }
    override func getWallTexture() -> SKTexture {
        return Game.instance.outside_b.getCell(13, 4, 1, 2)
    }
}
class WinterItem2:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
//        let itemPoints:Array<Array<CGFloat>> = [
//            [14, 3],
//            [8, 5],
//            [9, 5],
//            [10, 5],
//            [10, 7],
//            [11, 7]
//        ]
//        let it = itemPoints.one()
//        setTexture(Game.instance.tiled_dungeons.getCell(it[0], it[1], 1, 2))
        setTexture(Game.instance.dungeon_b.getCell(3, 9, 1, 2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class WinterItem3:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.dungeon_b.getCell(4, 11, 1, 2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class WinterItem1:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
//        let itemPoints:Array<Array<CGFloat>> = [
//            [14, 0],
//            [14, 1],
//            [15, 3],
//            ]
//        let it = itemPoints.one()
//        setTexture(Game.instance.tiled_dungeons.getCell(it[0], it[1]))
        setTexture(Game.instance.dungeon_b.getCell(3, 7))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class SnowLady: Man {
    override init() {
        super.init()
        _stars.strength = 1.3
        _stars.stamina = 1.8
        _stars.agility = 2.0
        _stars.intellect = 0.5
        _name = "冰雪女妖"
        _spellSlot = SpellSlot(max: 2, min: 0)
        _img = Game.instance.pictureBaldo.getCell(3, 3, 3, 4)
    }
    override func create(level: CGFloat) {
        super.create(level: level)
        if _spellCount > 0 && aQuarter() {
            _spellsInuse = [Disappear()]
        }
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class FrozenSlime: Rizen {
    override init() {
        super.init()
        _stars.strength = 1.1
        _stars.stamina = 1.4
        _stars.agility = 2.5
        _stars.intellect = 0.6
        _name = "冰冻史莱姆"
        _spellSlot = SpellSlot(max: 2, min: 0)
        _img = SKTexture(imageNamed: "slime.png")
    }
    override func create(level: CGFloat) {
        super.create(level: level)
        if _spellCount > 0 && aQuarter() {
            _spellsInuse = [BargeAbout()]
        }
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class IceBeast: Natrue {
    override init() {
        super.init()
        _stars.strength = 1.5
        _stars.stamina = 1.5
        _stars.agility = 1.5
        _stars.intellect = 1.5
        _name = "冰兽"
        _spellSlot = SpellSlot(max: 1, min: 0)
        _img = Game.instance.pictureMonster.getCell(3, 3, 3, 4)
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class SnowSpirit: Natrue {
    override init() {
        super.init()
        _stars.strength = 1.1
        _stars.stamina = 0.8
        _stars.agility = 2.5
        _stars.intellect = 1.9
        _name = "雪精"
        _spellSlot = SpellSlot(max: 2, min: 0)
        _img = Game.instance.pictureCollabo8_1.getCell(6, 7, 3, 4)
    }
    override func create(level: CGFloat) {
        super.create(level: level)
        if _spellCount > 0 && aQuarter() {
            _spellsInuse = [FrozenShoot()]
        }
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}