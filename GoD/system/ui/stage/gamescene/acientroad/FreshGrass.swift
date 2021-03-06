//
//  FreshGrass.swift
//  GoD
//
//  Created by kai chen on 2019/3/15.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class FreshGrass: AcientRoad {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _monsterEnum = [
            Creature.CrazyPlant,
            Creature.ForestGuard,
            Creature.ChildLizard,
            Creature.CrazyCow
        ]
        let oa4 = Game.instance.outside_a4
        _mapSet = GroundSets(ground: oa4.getCell(12, 2, 2, 2), wall: oa4.getCell(12, 4, 2, 2))
        _name = "青色苔地"
        _id = AcientRoad.FRESH_GRASS
        _soundUrl = "fresh_grass"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    override func getItemByIndex(index: Int) -> UIItem {
//        switch index {
//        case 1:
//            return getUIItem1(6, 12)
//        case 2:
//            return getUIItem1(4, 11)
//        case 3:
//            return getUIItem1(14, 6)
//        case 4:
//            return getUIItem1(7, 10)
//        case 5:
//            return getUIItem1(6, 9)
//        case 6:
//            return getUIItem1(1, 9)
//        case 7:
//            return getUIItem1(4, 10)
//        case 8:
//            return getUIItem1(4, 12)
//        case 9:
//            return getUIItem1(1, 13)
//        case 10:
//            return getUIItem1(0, 13)
//        case 11:
//            return getUIItem2(5, 12)
//        default:
//            return getUIItem2(5, 12)
//        }
//    }
    
    override func getWallTexture() -> SKTexture {
        return Game.instance.outside_b.getCell(5, 12, 1, 2)
    }
    
    private func getUIItem1(_ x:CGFloat, _ y:CGFloat) -> UIItem {
        let item = UIItem()
        item.setTexture(Game.instance.outside_b.getCell(x, y))
        return item
    }
    private func getUIItem2(_ x:CGFloat, _ y:CGFloat) -> UIItem {
        let item = UIItem()
        item.setTexture(Game.instance.outside_b.getCell(x, y, 1, 2))
        return item
    }
    
//    override func getMonsterByIndex(index: Int) -> Creature {
//        switch index {
//        case 1:
//            return CrazyPlant()
//        case 2:
//            return ForestGuard()
//        case 3:
//            return ChildLizard()
//        case 4:
//            return CowCow()
//        default:
//            return CowCow()
//        }
//    }
}
//
//class ChildLizard: Natrue {
//    override init() {
//        super.init()
//        _stars.strength = 2.2
//        _stars.stamina = 1.8
//        _stars.agility = 1.1
//        _stars.intellect = 0.6
//        _natural.strength = 12
//        _natural.stamina = 21
//        _natural.agility = 18
//        _natural.intellect = 18
//        _name = "小蜥蜴"
//        _imgUrl = "child_lizard"
//        _img = SKTexture(imageNamed: _imgUrl)
////        _spellCount = 2
////        if d4() {
////            _spellsInuse = [IceGuard()]
////        }
////        if _spellCount > 1 && d(baseRate: -50) {
////            _spellsInuse.append(QuickHeal())
////        }
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}
//class ForestGuard: Man {
//    override init() {
//        super.init()
//        _stars.strength = 1.1
//        _stars.stamina = 1.1
//        _stars.agility = 1.1
//        _stars.intellect = 2.6
//        _natural.strength = 14
//        _natural.stamina = 16
//        _natural.agility = 22
//        _natural.intellect = 19
//        _name = "丛林守卫"
//        _imgUrl = "forest_guard"
//        _img = SKTexture(imageNamed: "forest_guard")
//        _spellCount = 3
////        if d2() {
////            _spellsInuse = [WindPunish()]
////        }
////        if _spellCount > 1 && d(baseRate: -40) {
////            _spellsInuse.append(Energetic())
////        }
////        if _spellCount > 2 && d(baseRate: -80) {
////            _spellsInuse.append(IceBomb())
////        }
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}
//class CrazyPlant: Natrue {
//    override init() {
//        super.init()
//        _stars.strength = 1.6
//        _stars.stamina = 2.1
//        _stars.agility = 1.4
//        _stars.intellect = 0.6
//        _natural.strength = 12
//        _natural.stamina = 28
//        _natural.agility = 12
//        _natural.intellect = 18
//        _name = "疯狂植物"
//        _imgUrl = "crazy_plant"
//        _img = SKTexture(imageNamed: _imgUrl)
//        _spellCount = 2
////        if d4() {
////            _spellsInuse = [LeeAttack()]
////        }
////        
////        if d(baseRate: -55) {
////            _spellsInuse.append(OathBreaker())
////        }
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}
//class CowCow: Natrue {
//    override init() {
//        super.init()
//        _stars.strength = 1.0
//        _stars.stamina = 2.9
//        _stars.agility = 0.6
//        _stars.intellect = 0.6
//        _natural.strength = 18
//        _natural.stamina = 21
//        _natural.agility = 16
//        _natural.intellect = 16
//        _name = "奶牛"
//        _imgUrl = "cow_cow"
//        _img = SKTexture(imageNamed: _imgUrl)
////        spell12()
////        if d3() {
////            _spellsInuse = [Taunt()]
////        }
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}
