//
//  Emily.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/20.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Emily:Character {
    override init() {
        super.init()
//        _name = "艾米丽"
        _imgUrl = "test_role"
        _img = SKTexture(imageNamed: _imgUrl)
        _seat = BUnit.BBM
//        _name = "艾米丽"
//        _minionsCount = 2
//        staminaChange(value: 50)
//        strengthChange(value: 30)
//        agilityChange(value: 20)
//        intellectChange(value: 5)
//        _level = 1
//        self.levelTo(level: _level)
//        let bow = Bow()
//        bow.create(level: 100)
//        _weapon = bow
//        let c = Core()
//        for _ in 0..._level.toInt() {
//            let seed = c.seed()
//            if seed < 25 {
//                strengthChange(value: 5)
//            } else if seed < 50 {
//                staminaChange(value: 5)
//            } else if seed < 75 {
//                agilityChange(value: 5)
//            } else {
//                intellectChange(value: 5)
//            }
//        }
//        _spellsInuse = [ShootAll()]
//        let _minionlevel:CGFloat = _level
//        _spellCount = 2
//        _minionsCount = 2
//        let blackCat = BlackCat()
//        blackCat.create(level: _minionlevel)
//        blackCat._spellCount = 1
//        blackCat._spellsInuse = []
//        _minions.append(blackCat)
//        let darkCrow = DarkCrow()
//        darkCrow.create(level: _minionlevel)
////        darkCrow.levelup()
//        darkCrow._spellCount = 4
//        darkCrow._spellsInuse = []
////        darkCrow._spellsInuse = [Crazy()]
//        _minions.append(darkCrow)
        
//        let w = GiantWasp()
//        w.create(level: _minionlevel)
//        w._spellCount = 1
//        _minions.append(w)
//        w._spellsInuse = [FireFist()]
        
//        let bq = BloodQueen()
//        bq.create(level: _minionlevel)
////        bq.levelup()
//        bq._spellsInuse = [FireBreath()]
//        _minions.append(bq)
        
        
        
        
//        darkCrow._seat = BUnit.BTM
//        blackCat._seat = BUnit.BTL
//        bq._seat = BUnit.BBR
        
        
        
        
//        hasEarring = true
//        hasShield = true
//        _weapon = Bow()
        
//        let wt = TheWitchsTear()
//        wt._count = 10
//        wt.create()
//        _props.append(wt)
//        for i in 0...10 {
//        }
        
//        for _ in 0...80 {
//            let p = getProp(id: seed(max: 12))
//            p.create(level: seed(min: 10, max: 31).toFloat())
//            _props.append(p)
//        }
        
        
        
    }
    
    func getProp(id:Int) -> Outfit {
//        switch id {
//        case 0:
//            return Amulet()
//        case 1:
//            return Ring()
//        case 2:
//            return Ring()
//        case 3:
//            return SoulStone()
//        case 4:
//            return Shield()
//        case 6:
//            return Bow()
//        case 7:
//            return Sword()
//        case 8:
//            return Wand()
//        case 9:
//            return Dagger()
//        case 10:
//            return Blunt()
//        case 11:
//            return Fist()
//        default:
//            return Amulet()
//        }
        return Outfit()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
