//
//  SceneMeadow.swift
//  GoD
//
//  Created by kai chen on 2018/12/9.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class SecretMeadow: AcientRoad {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _monsterEnum = [
            Creature.SnowLady,
            Creature.IceBeast,
            Creature.SnowSpirit,
            Creature.SnowLady
        ]
        let oa4 = Game.instance.dungeon_a4
        _mapSet = GroundSets(ground: oa4.getCell(8, 2, 2, 2), wall: oa4.getCell(8, 4, 2, 2))
        _name = "秘境沼泽"
        _id = AcientRoad.SECRET_MEADOW
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func getItemByIndex(index: Int) -> UIItem {
        switch index {
        case 11:
            return MI11()
        case 12:
            return MI12()
        case 13:
            return MI13()
        case 14:
            return MI14()
        case 15:
            return MI15()
        case 16:
            return MI16()
        case 17:
            return MI17()
        case 18:
            return MI18()
        case 19:
            return MI19()
        case 110:
            return MI110()
        case 21:
            return MI21()
        case 22:
            return MI22()
        case 23:
            return MI23()
        case 24:
            return MI24()
        default:
            return MI24()
        }
    }
    
//    override func getMonsterByIndex(index: Int) -> Creature {
//        switch index {
//        case 1:
//            return VirulentToad()
//        case 2:
//            return TreeSpirit()
//        case 3:
//            return Python()
//        case 4:
//            return GiantWasp()
//        default:
//            return TreeSpirit()
//        }
//    }
    
    override func getWallTexture() -> SKTexture {
        return Game.instance.sf_outside_b.getCell(13, 2, 1, 2)
    }
    
}
//
//class VirulentToad: Natrue {
//    override init() {
//        super.init()
//        _stars.strength = 1.0
//        _stars.stamina = 2.8
//        _stars.agility = 0.6
//        _stars.intellect = 1.0
//        _natural.strength = 18
//        _natural.stamina = 28
//        _natural.agility = 12
//        _natural.intellect = 10
//        _name = "绿精灵"
//        _imgUrl = "green_spirit"
//        _img = SKTexture(imageNamed: _imgUrl)
////        spell12()
////        if d() {
////            _spellsInuse = [AttackHard()]
////        }
////        if _spellCount > 1 {
////            if d(baseRate: -50) {
////                _spellsInuse.append(LastChance())
////            }
////        }
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}
//class GiantWasp: Man {
//    override init() {
//        super.init()
//        _stars.strength = 2.2
//        _stars.stamina = 0.5
//        _stars.agility = 2.0
//        _stars.intellect = 0.8
//        _natural.strength = 22
//        _natural.stamina = 15
//        _natural.agility = 22
//        _natural.intellect = 15
//        _name = "露琪"
//        _imgUrl = "luki"
//        _img = SKTexture(imageNamed: _imgUrl)
////        spell13()
////        if d4() {
////            _spellsInuse = [Reborn()]
////        }
////        if _spellCount > 1 {
////            if d(baseRate: -40) {
////                _spellsInuse.append(Disappear())
////            }
////        }
////        if _spellCount > 2 {
////            if d(baseRate: -70) {
////                _spellsInuse.append(LeeAttack())
////            }
////        }
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}
//class TreeSpirit: Man {
//    override init() {
//        super.init()
//        _stars.strength = 1.0
//        _stars.stamina = 2.0
//        _stars.agility = 1.0
//        _stars.intellect = 2.2
//        _natural.strength = 10
//        _natural.stamina = 12
//        _natural.agility = 12
//        _natural.intellect = 29
//        _name = "树妖"
//        _imgUrl = "tree_spirit"
//        _img = SKTexture(imageNamed: _imgUrl)
////        spell12()
////        if d4() {
////            _spellsInuse = [FragileCurse()]
////        }
////        if _spellCount > 1 {
////            if d(baseRate: -50) {
////                _spellsInuse = [DeathGaze()]
////            }
////        }
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}
//class Python: Man {
//    override init() {
//        super.init()
//        _stars.strength = 1.5
//        _stars.stamina = 1.4
//        _stars.agility = 1.3
//        _stars.intellect = 1.2
//        _natural.strength = 28
//        _natural.stamina = 17
//        _natural.agility = 12
//        _natural.intellect = 16
//        _name = "花仙子"
//        _imgUrl = "flower_fairy"
////        spell13()
////        _img = SKTexture(imageNamed: _imgUrl)
////        if d4() {
////            _spellsInuse = [AttackPowerUp()]
////        }
////        if _spellCount > 1 {
////            if d(baseRate: -75) {
////                _spellsInuse.append(DancingDragon())
////            }
////        }
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}

class MI24:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
//        let itemPoints:Array<Array<CGFloat>> = [
//            [6, 3],
//            [7, 2],
//            [0, 5],
//            [1, 5],
//            [2, 5],
//            [2, 7],
//            [3, 7],
//        ]
//        let it = itemPoints.one()
//        setTexture(Game.instance.tiled_dungeons.getCell(it[0], it[1], 1, 2))
        setTexture(Game.instance.dungeon_b.getCell(4, 9, 1, 2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class MI23:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.dungeon_b.getCell(3, 11, 1, 2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class MI110:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
//        let itemPoints:Array<Array<CGFloat>> = [
//            [6, 1],
//            [7, 0],
//            [7, 3],
//            [6, 5],
//            [2, 5],
//        ]
//        let it = itemPoints.one()
//        setTexture(Game.instance.tiled_dungeons.getCell(it[0], it[1]))
        setTexture(Game.instance.dungeon_b.getCell(4, 7))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class MI19:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.dungeon_b.getCell(1, 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class MI11:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.outside_b.getCell(14, 5))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class MI12:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.outside_b.getCell(6, 9))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class MI13:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.outside_b.getCell(14, 6))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class MI14:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.outside_b.getCell(0, 13))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class MI15:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.outside_b.getCell(4, 12))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class MI16:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.outside_b.getCell(6, 12))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class MI17:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.outside_b.getCell(3, 10))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class MI18:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.outside_b.getCell(3, 9))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class MI21:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.outside_b.getCell(5, 12, 1, 2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class MI22:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.outside_b.getCell(12, 6, 1, 2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
