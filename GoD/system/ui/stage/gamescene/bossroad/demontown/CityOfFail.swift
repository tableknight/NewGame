//
//  CityOfFail.swift
//  GoD
//
//  Created by kai chen on 2019/3/25.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class CityOfFail: DemonTown {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let oa4 = Game.instance.dungeon_a4
        _mapSet = GroundSets(ground: oa4.getCell(12, 12, 2, 2), wall: oa4.getCell(12, 14, 2, 2))
        _monsterEnum = []
        _name = "堕落之城"
        _floorSize = 9
        _level = 48
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
//    override func createEnemy() {
//        
//    }
//    override func getMonsterByIndex(index: Int) -> Creature {
//        if index == 1 {
//            return UndeadMinion11()
//        }
//        if index == 2 {
//            return UndeadMinion12()
//        }
//        if index == 3 {
//            return UndeadMinion13()
//        }
//        if index == 4 {
//            return UndeadMinion14()
//        }
//        if index == 5 {
//            return UndeadMinion15()
//        }
//        return UndeadMinion1()
//    }
    
    override func getSelfScene() -> BossRoad {
        return CityOfFail()
    }
    
    override func getPortalFinal() -> UIItem {
        return RoleFrancis()
    }
    
    override func finalBattle() {
        let b = FrancisBattle()
        let es = Array<Creature>()
        b.setEnemyPart(minions: es)
        let char = Game.instance.char!
        let cs:Array<Unit> = [char] + char.getReadyMinions()
        b.setPlayerPart(roles: cs)
        Game.instance.curStage.addBattle(b)
        b.battleStart()
    }
    
}
class RoleFrancis: UIRole {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.texture = SKTexture(imageNamed: "Francis")
        self.size = CGSize(width: cellSize * 2, height: cellSize * 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class UndeadMinion11: Rizen {
    override init() {
        super.init()
        _stars.strength = 2.1
        _stars.stamina = 2.8
        _stars.agility = 1.1
        _stars.intellect = 1.1
        _name = "亡灵仆从"
        _race = EvilType.RISEN
        _img = SKTexture(imageNamed: "undead_minion_1")
//        _spellsInuse = [DeathAttack()]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class UndeadMinion12: Rizen {
    override init() {
        super.init()
        _stars.strength = 2.8
        _stars.stamina = 2.1
        _stars.agility = 1.5
        _stars.intellect = 1.1
        _name = "亡灵仆从"
        _race = EvilType.RISEN
        _img = SKTexture(imageNamed: "undead_minion_2")
//        _spellsInuse = [LineAttack()]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class UndeadMinion13: Rizen {
    override init() {
        super.init()
        _stars.strength = 3.1
        _stars.stamina = 1.7
        _stars.agility = 1.1
        _stars.intellect = 1
        _name = "亡灵仆从"
        _race = EvilType.RISEN
        _img = SKTexture(imageNamed: "undead_minion_3")
//        _spellsInuse = [AttackPowerUp()]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class UndeadMinion14: Rizen {
    override init() {
        super.init()
        _stars.strength = 1.1
        _stars.stamina = 1.8
        _stars.agility = 2.1
        _stars.intellect = 3.1
        _name = "亡灵仆从"
        _race = EvilType.RISEN
        _img = SKTexture(imageNamed: "undead_minion_4")
//        _spellsInuse = [SoulExtract()]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class UndeadMinion15: Rizen {
    override init() {
        super.init()
        _stars.strength = 1.5
        _stars.stamina = 1.8
        _stars.agility = 1.8
        _stars.intellect = 2.1
        _name = "亡灵仆从"
        _race = EvilType.RISEN
        _img = SKTexture(imageNamed: "undead_minion_5")
//        _spellsInuse = [Reinforce()]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
