//
//  CityOfSorrow.swift
//  GoD
//
//  Created by kai chen on 2019/3/25.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class CityOfSorrow: DemonTown {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let oa4 = Game.instance.dungeon_a4
        _mapSet = GroundSets(ground: oa4.getCell(4, 2, 2, 2), wall: oa4.getCell(4, 4, 2, 2))
        _monsterEnum = [1,2,3,4]
        _name = "悲伤之城"
        _floorSize = 6
        _level = 33
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
//    override func createEnemy() {
//        
//    }
    override func getMonsterByIndex(index: Int) -> Creature {
        if index == 1 {
            return DreamSucker()
        }
        if index == 2 {
            return TheFallen()
        }
        if index == 3 {
            return DarkWizard()
        }
        if index == 4 {
            return CriticalJoker()
        }
        return DreamSucker()
    }
    
    override func getSelfScene() -> BossRoad {
        return CityOfSorrow()
    }
    
    override func getPortalFinal() -> UIItem {
        return RoleDius()
    }
    
    
    override func finalBattle() {
        let b = DiusBattle()
        let es = Array<Creature>()
        b.setEnemyPart(minions: es)
        let char = Game.instance.char!
        let cs:Array<Creature> = [char] + char.getReadyMinions()
        b.setPlayerPart(roles: cs)
        Game.instance.curStage.addBattle(b)
        b.battleStart()
    }
    
}
class RoleDius: UIRole {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.texture = SKTexture(imageNamed: "Dius")
        self.size = CGSize(width: cellSize * 2, height: cellSize * 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class DreamSucker: Demon {
    override init() {
        super.init()
        _stars.strength = 1.5
        _stars.stamina = 1
        _stars.agility = 0.7
        _stars.intellect = 2.5
        _name = "食梦魔"
        _img = SKTexture(imageNamed: "dream_sucker")
    }
}
class DarkWizard: Man {
    override init() {
        super.init()
        _stars.strength = 0.4
        _stars.stamina = 1
        _stars.agility = 1.4
        _stars.intellect = 2.8
        _name = "安吉拉"
        _img = SKTexture(imageNamed: "dark_wizard")
    }
}
class CriticalJoker: Man {
    override init() {
        super.init()
        _stars.strength = 2.5
        _stars.stamina = 1.8
        _stars.agility = 0.6
        _stars.intellect = 0.6
        _name = "安吉拉"
        _img = SKTexture(imageNamed: "critical_joker")
    }
}
class TheFallen: Man {
    override init() {
        super.init()
        _stars.strength = 2
        _stars.stamina = 1
        _stars.agility = 2
        _stars.intellect = 0.8
        _name = "堕落者"
        _img = SKTexture(imageNamed: "the_fallen")
    }
}
