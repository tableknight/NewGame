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
        _img = SKTexture(imageNamed: "test_role")
        _seat = BUnit.BBM
//        _name = "艾米丽"
//        _minionsCount = 2
//        staminaChange(value: 45)
//        strengthChange(value: 10)
//        agilityChange(value: 65)
//        intellectChange(value: 140)
        _level = 1
        _spellsInuse = [AttackReturnBack()]
        _spells = [
            Firelord(),
            Firelord(),
            Firelord(),Firelord(),Firelord(),
            Firelord(),Firelord(),Firelord(),Firelord(),Firelord(),Firelord(),Firelord(),
            Firelord(),Firelord(),Firelord(),Firelord(),Firelord(),
            Firelord(),Firelord(),Firelord(),Firelord(),Firelord(),
            Firelord(),Firelord(),Firelord(),Firelord(),Firelord(),
            Firelord(),Firelord(),Firelord(),Firelord(),
            Firelord(),Firelord(),Firelord(),Firelord(),Firelord(),Firelord(),
        ]
        _spellCount = 4
        let blackCat = BlackCat()
        blackCat._seat = BUnit.STAND_BY
        blackCat.create(level: 1)
        blackCat._spellCount = 1
        blackCat._spellsInuse = []
        _minions.append(blackCat)
        let darkCrow = DarkCrow()
        darkCrow.create(level: 1)
        darkCrow._seat = BUnit.STAND_BY
//        darkCrow.levelup()
        darkCrow._spellCount = 4
//        darkCrow._spellsInuse = [Crazy()]
        _minions.append(darkCrow)
        
        let w = GiantWasp()
        w.create(level: 10)
        w._spellCount = 1
        _minions.append(w)
        
        let bq = BloodQueen()
        bq.create(level: 1)
        bq._seat = BUnit.STAND_BY
//        bq.levelup()
        bq._spellsInuse = [FireBreath()]
        _minions.append(bq)
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
        switch id {
        case 0:
            return Amulet()
        case 1:
            return Ring()
        case 2:
            return Ring()
        case 3:
            return SoulStone()
        case 4:
            return Shield()
        case 6:
            return Bow()
        case 7:
            return Sword()
        case 8:
            return Wand()
        case 9:
            return Dagger()
        case 10:
            return Blunt()
        case 11:
            return Fist()
        default:
            return Amulet()
        }
    }
}
