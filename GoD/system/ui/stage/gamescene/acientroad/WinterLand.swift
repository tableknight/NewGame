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
        _monsterEnum = [
            Creature.SnowLady,
            Creature.IceBeast,
            Creature.SnowSpirit,
            Creature.FrozenSlime
        ]
        let oa4 = Game.instance.outside_a4
        _mapSet = GroundSets(ground: oa4.getCell(6, 12, 2, 2), wall: oa4.getCell(6, 14, 2, 2))
        _name = "寒冰大陆"
        _id = AcientRoad.WINTER_LAND
        _soundUrl = "snow_landing"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    override func getItemByIndex(index: Int) -> UIItem {
//        switch index {
//        case 1:
//            return MP11()
//        case 2:
//            return MP12()
//        case 3:
//            return MP13()
//        case 4:
//            return MP14()
//        case 5:
//            return MP15()
//        case 6:
//            return MP16()
//        case 7:
//            return MP17()
//        case 8:
//            return MP18()
//        case 9:
//            return MP19()
//        case 10:
//            return MP110()
//        case 11:
//            return MP21()
//        default:
//            return MP11()
//        }
//    }
    
//    override func getMonsterByIndex(index: Int) -> Creature {
//        switch index {
//        case 1:
//            return SnowLady()
//        case 2:
//            return FrozenSlime()
//        case 3:
//            return IceBeast()
//        case 4:
//            return SnowSpirit()
//        default:
//            return SnowLady()
//        }
//    }
    override func getWallTexture() -> SKTexture {
        return Game.instance.outside_b.getCell(13, 4, 1, 2)
    }
}
//
//class WinterItem2:UIItem {
//    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
//        super.init(texture: texture, color: color, size: size)
////        let itemPoints:Array<Array<CGFloat>> = [
////            [14, 3],
////            [8, 5],
////            [9, 5],
////            [10, 5],
////            [10, 7],
////            [11, 7]
////        ]
////        let it = itemPoints.one()
////        setTexture(Game.instance.tiled_dungeons.getCell(it[0], it[1], 1, 2))
//        setTexture(Game.instance.dungeon_b.getCell(3, 9, 1, 2))
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//}
//class WinterItem3:UIItem {
//    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
//        super.init(texture: texture, color: color, size: size)
//        setTexture(Game.instance.dungeon_b.getCell(4, 11, 1, 2))
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//}
//class WinterItem1:UIItem {
//    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
//        super.init(texture: texture, color: color, size: size)
////        let itemPoints:Array<Array<CGFloat>> = [
////            [14, 0],
////            [14, 1],
////            [15, 3],
////            ]
////        let it = itemPoints.one()
////        setTexture(Game.instance.tiled_dungeons.getCell(it[0], it[1]))
//        setTexture(Game.instance.dungeon_b.getCell(3, 7))
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//}
//
//class SnowLady: Man {
//    override init() {
//        super.init()
//        _stars.strength = 1.3
//        _stars.stamina = 1.8
//        _stars.agility = 2.0
//        _stars.intellect = 0.5
//        _natural.strength = 18
//        _natural.stamina = 21
//        _natural.agility = 22
//        _natural.intellect = 11
//        _name = "冰雪女妖"
//        _imgUrl = "snow_lady"
//        _img = SKTexture(imageNamed: _imgUrl)
////        spell13()
////        if d4() {
////            _spellsInuse = [Disappear()]
////        }
////        if _spellCount > 1 && d(baseRate: -40) {
////            _spellsInuse.append(HealAll())
////        }
////        if _spellCount > 2 && d(baseRate: -80) {
////            _spellsInuse.append(TruePower())
////        }
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}
//
//class FrozenSlime: Demon {
//    override init() {
//        super.init()
//        _stars.strength = 1.1
//        _stars.stamina = 2.4
//        _stars.agility = 1.5
//        _stars.intellect = 0.6
//        _natural.strength = 20
//        _natural.stamina = 28
//        _natural.agility = 7
//        _natural.intellect = 10
//        _name = "冰冻史莱姆"
//        _imgUrl = "slime"
//        _img = SKTexture(imageNamed: _imgUrl)
//        _spellCount = 3
////        if d4() {
////            _spellsInuse = [Sacrifice()]
////        }
////        if _spellCount > 1 && d(baseRate: -50) {
////            _spellsInuse.append(Firelord())
////        }
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}
//
//class IceBeast: Natrue {
//    override init() {
//        super.init()
//        _stars.strength = 1.5
//        _stars.stamina = 1.5
//        _stars.agility = 1.5
//        _stars.intellect = 1.5
//        _natural.strength = 12
//        _natural.stamina = 12
//        _natural.agility = 24
//        _natural.intellect = 12
//        _name = "冰兽"
//        _imgUrl = "ice_beast"
//        _img = SKTexture(imageNamed: _imgUrl)
//        _spellCount = 1
////        if d3() {
////            _spellsInuse = [QuickHeal()]
////        }
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}
//
//class SnowSpirit: Natrue {
//    override init() {
//        super.init()
//        _stars.strength = 1.1
//        _stars.stamina = 0.8
//        _stars.agility = 2.5
//        _stars.intellect = 1.9
//        _natural.strength = 15
//        _natural.stamina = 24
//        _natural.agility = 12
//        _natural.intellect = 18
//        _name = "雪精"
//        _imgUrl = "snow_spirit"
//        _img = SKTexture(imageNamed: _imgUrl)
////        spell12()
////        if d7() {
////            _spellsInuse = [FrozenShoot()]
////        }
////        if _spellCount > 1 && d(baseRate: -45) {
////            _spellsInuse.append(SuperWater())
////        }
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}
