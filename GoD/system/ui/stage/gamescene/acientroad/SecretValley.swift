//
//  SecretValley.swift
//  GoD
//
//  Created by kai chen on 2019/3/16.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class SecretValley: AcientRoad {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _itemEnum = []
        for i in 1...10 {
            _itemEnum.append(i)
            _itemEnum.append(11)
        }
        _monsterEnum = [1,2,3,4]
        let oa4 = Game.instance.dungeon_a4
        _mapSet = GroundSets(ground: oa4.getCell(8, 12, 2, 2), wall: oa4.getCell(8, 14, 2, 2))
        _name = "神秘小径"
        _id = AcientRoad.SECRET_VALLEY
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func getItemByIndex(index: Int) -> UIItem {
        switch index {
        case 1:
            return getUIItem1(9, 6)
        case 2:
            return getUIItem1(10, 6)
        case 3:
            return getUIItem1(8, 7)
        case 4:
            return getUIItem1(6, 9)
        case 5:
            return getUIItem1(7, 12)
        case 6:
            return getUIItem1(7, 11)
        case 7:
            return getUIItem1(13, 5)
        case 8:
            return getUIItem1(11, 7)
        case 9:
            return getUIItem1(14, 5)
        case 10:
            return getUIItem2(12, 6)
        case 11:
            return getUIItem2(8, 6)
        default:
            return getUIItem2(5, 12)
        }
    }
    
    override func getWallTexture() -> SKTexture {
        return Game.instance.outside_b.getCell(12, 6, 1, 2)
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
    
    override func getMonsterByIndex(index: Int) -> Creature {
        switch index {
        case 4:
            return DarkNinja()
        case 1:
            return HellNight()
        case 2:
            return BloodQueen()
        case 3:
            return ManWizard()
        default:
            return HellNight()
        }
    }
}
class DarkNinja: Man {
    override init() {
        super.init()
        _stars.strength = 2.0
        _stars.stamina = 0.8
        _stars.agility = 2.0
        _stars.intellect = 0.6
        _natural.strength = 16
        _natural.stamina = 11
        _natural.agility = 21
        _natural.intellect = 14
        _name = "黑暗忍着"
        _imgUrl = "dark_ninja"
        _img = SKTexture(imageNamed: _imgUrl)
        spell12()
        if d3() {
            _spellsInuse = [Disappear()]
        }
        if _spellCount > 1 && d(baseRate: -40) {
            _spellsInuse.append(WindAttack())
        }
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class HellNight: Rizen {
    override init() {
        super.init()
        _stars.strength = 1.3
        _stars.stamina = 3.0
        _stars.agility = 0.5
        _stars.intellect = 0.6
        _natural.strength = 18
        _natural.stamina = 21
        _natural.agility = 13
        _natural.intellect = 17
        _name = "地狱骑士"
        _imgUrl = "hell_rider"
        _img = SKTexture(imageNamed: _imgUrl)
        spell13()
        if d3() {
            _spellsInuse = [BargeAbout()]
        }
        if _spellCount > 1 && d(baseRate: -50) {
            _spellsInuse.append(Taunt())
        }
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class BloodQueen: Demon {
    override init() {
        super.init()
        _stars.strength = 0.4
        _stars.stamina = 1.2
        _stars.agility = 1.2
        _stars.intellect = 2.6
        _natural.strength = 21
        _natural.stamina = 15
        _natural.agility = 18
        _natural.intellect = 21
        _name = "鲜血女王"
        _imgUrl = "blood_queen"
        _img = SKTexture(imageNamed: _imgUrl)
        _spellCount = 3
        if _spellCount > 1 && d(baseRate: -60) {
            _spellsInuse.append(DeathGaze())
        }
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    
}

class ManWizard: Man {
    override init() {
        super.init()
        _stars.strength = 1.1
        _stars.stamina = 0.8
        _stars.agility = 2.5
        _stars.intellect = 1.9
        _natural.strength = 16
        _natural.stamina = 11
        _natural.agility = 19
        _natural.intellect = 22
        _name = "旅法师"
        _imgUrl = "wander_wizard"
        _img = SKTexture(imageNamed: _imgUrl)
        spell23()
        if d6() {
            _spellsInuse = [FrozenShoot()]
        }
        if _spellCount > 1 && d(baseRate: -30) {
            _spellsInuse.append(IceSpear())
        }
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
