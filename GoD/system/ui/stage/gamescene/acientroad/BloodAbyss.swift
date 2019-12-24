//
//  BloodAbyss.swift
//  GoD
//
//  Created by kai chen on 2019/1/2.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class BloodAbyss: AcientRoad {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _monsterEnum = [
            Creature.BloodBat,
            Creature.Kodagu,
            Creature.EvilSpirit,
            Creature.HellBaron
        ]
        let oa4 = Game.instance.dungeon_a4
        _mapSet = GroundSets(ground: oa4.getCell(12, 2, 2, 2), wall: oa4.getCell(12, 4, 2, 2))
        _name = "鲜血深渊"
        _id = AcientRoad.BLOOD_ABYSS
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    override func getItemByIndex(index: Int) -> UIItem {
//        switch index {
//        case 1:
//            return BloodItem1()
//        case 2:
//            return BloodItem2()
//        case 12:
//            return BloodItem12()
//        case 13:
//            return BloodItem13()
//        case 22:
//            return BloodItem22()
//        default:
//            return BloodItem2()
//        }
//    }
    
//    override func getMonsterByIndex(index: Int) -> Creature {
//        switch index {
//        case 1:
//            return BloodBat()
//        case 2:
//            return Kodagu()
//        case 3:
//            return EvilSpirit()
//        case 4:
//            return HellBaron()
//        default:
//            return BloodBat()
//        }
//    }
    override func getWallTexture() -> SKTexture {
        return Game.instance.dungeon_b.getCell(6, 9, 1, 2)
    }
}
//
//class BloodBat: Demon {
//    override init() {
//        super.init()
//        _stars.strength = 1.1
//        _stars.stamina = 2.2
//        _stars.agility = 1.4
//        _stars.intellect = 0.9
//        _natural.strength = 13
//        _natural.stamina = 22
//        _natural.agility = 18
//        _natural.intellect = 16
//        _name = "血色蝙蝠"
//        _imgUrl = "blood_bat"
//        _img = SKTexture(imageNamed: _imgUrl)
////        spell13()
////        if d9() {
////            _spellsInuse = [VampireBlood()]
////        }
////        if _spellCount > 1 && d(baseRate: -40) {
////            _spellsInuse.append(AttackPowerUp())
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
//class Kodagu: Demon {
//    override init() {
//        super.init()
//        _stars.strength = 2.2
//        _stars.stamina = 2.2
//        _stars.agility = 0.6
//        _stars.intellect = 0.6
//        _natural.strength = 22
//        _natural.stamina = 22
//        _natural.agility = 10
//        _natural.intellect = 10
//        _name = "达古"
//        _imgUrl = "Kodagu"
//        _img = SKTexture(imageNamed: _imgUrl)
////        spell12()
////        if d9() {
////            _spellsInuse = [VampireBlood()]
////        }
////        if _spellCount > 1 && d(baseRate: -40) {
////            _spellsInuse.append(MagicConvert())
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
//class EvilSpirit: Demon {
//    override init() {
//        super.init()
//        _stars.strength = 0.5
//        _stars.stamina = 1.5
//        _stars.agility = 0.8
//        _stars.intellect = 2.5
//        _natural.strength = 18
//        _natural.stamina = 11
//        _natural.agility = 11
//        _natural.intellect = 29
//        _name = "邪灵"
//        _imgUrl = "evil_spirit"
//        _img = SKTexture(imageNamed: _imgUrl)
////        spell23()
////        if d5() {
////            _spellsInuse = [FireOrFired()]
////        }
////        if _spellCount > 1 && d(baseRate: -60) {
////            _spellsInuse.append(ElementMaster())
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
//class HellBaron: Demon {
//    override init() {
//        super.init()
//        _stars.strength = 0.6
//        _stars.stamina = 0.6
//        _stars.agility = 2.1
//        _stars.intellect = 2.4
//        _natural.strength = 26
//        _natural.stamina = 21
//        _natural.agility = 11
//        _natural.intellect = 11
//        _name = "地狱男爵"
//        _imgUrl = "hell_baron"
//        _img = SKTexture(imageNamed: _imgUrl)
////        spell13()
////        if d3() {
////            _spellsInuse = [LifeDraw()]
////        }
////        if _spellCount > 1 && d(baseRate: -50) {
////            _spellsInuse.append(SilenceAll())
////        }
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}

//class BloodItem2:UIItem {
//    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
//        super.init(texture: texture, color: color, size: size)
//        setTexture(Game.instance.dungeon_b.getCell(6, 9, 1, 2))
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//}
//class BloodItem22:UIItem {
//    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
//        super.init(texture: texture, color: color, size: size)
//        setTexture(Game.instance.dungeon_b.getCell(7, 9, 1, 2))
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//}
//class BloodItem1:UIItem {
//    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
//        super.init(texture: texture, color: color, size: size)
//        setTexture(Game.instance.dungeon_b.getCell(6, 7))
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//}
//class BloodItem12:UIItem {
//    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
//        super.init(texture: texture, color: color, size: size)
//        setTexture(Game.instance.dungeon_b.getCell(7, 7))
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//}
//class BloodItem13:UIItem {
//    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
//        super.init(texture: texture, color: color, size: size)
//        setTexture(Game.instance.outside_b.getCell(10, 6))
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//}
