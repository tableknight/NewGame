//
//  CityOfDeath.swift
//  GoD
//
//  Created by kai chen on 2019/3/25.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class CityOfDeath: DemonTown {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let oa4 = Game.instance.dungeon_a4
        _mapSet = GroundSets(ground: oa4.getCell(4, 2, 2, 2), wall: oa4.getCell(4, 4, 2, 2))
        _monsterEnum = [1,2,3,4]
        _name = "死亡之城"
        _floorSize = 12
        _level = 54
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func getMonsterByIndex(index: Int) -> Creature {
        if index == 1 {
            return Crawler()
        }
        if index == 2 {
            return UnderworldRider()
        }
        if index == 3 {
            return EvilCurse()
        }
        if index == 4 {
            return DeathGod()
        }
        return Crawler()
    }
    
    override func getSelfScene() -> BossRoad {
        return CityOfDeath()
    }
    
    override func getPortalFinal() -> UIItem {
        return RoleUmisa()
    }
    
    override func finalBattle() {
        let b = UmisaBattle()
        let es = Array<Creature>()
        b.setEnemyPart(minions: es)
        let char = Game.instance.char!
        let cs:Array<Creature> = [char] + char.getReadyMinions()
        b.setPlayerPart(roles: cs)
        Game.instance.curStage.addBattle(b)
        b.battleStart()
    }
    
    override func getWallTexture() -> SKTexture {
        let node = SKSpriteNode()
        let top = getRoof()
        top.anchorPoint = CGPoint(x: 0.5, y: 0)
        node.addChild(top)
        let btop = Game.instance.dungeon_a4.getNode(4, 7.5, 1, 0.5)
        btop.anchorPoint = CGPoint(x: 0.5, y: 1)
        node.addChild(btop)
        let bb = Game.instance.dungeon_a4.getNode(4, 9, 1, 0.5)
        bb.anchorPoint = CGPoint(x: 0.5, y: 1)
        bb.yAxis = -cellSize * 0.5
        node.addChild(bb)
        return node.toTexture()
    }
    
}
class RoleUmisa: UIRole {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.texture = SKTexture(imageNamed: "Umisa")
        self.size = CGSize(width: cellSize * 2, height: cellSize * 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class Crawler: Demon {
    override init() {
        super.init()
        _stars.strength = 2
        _stars.stamina = 2
        _stars.agility = 1
        _stars.intellect = 0.8
        _name = "爬行者"
        _img = SKTexture(imageNamed: "crawler")
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class UnderworldRider: Demon {
    override init() {
        super.init()
        _stars.strength = 1.8
        _stars.stamina = 1.2
        _stars.agility = 2.1
        _stars.intellect = 0.6
        _name = "灵界骑士"
        _img = SKTexture(imageNamed: "underworld_rider")
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class DeathGod: Demon {
    override init() {
        super.init()
        _stars.strength = 0.6
        _stars.stamina = 1.1
        _stars.agility = 1.6
        _stars.intellect = 2.4
        _name = "死神"
        _img = SKTexture(imageNamed: "death_god")
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class EvilCurse: Man {
    override init() {
        super.init()
        _stars.strength = 2.2
        _stars.stamina = 0.8
        _stars.agility = 2.2
        _stars.intellect = 0.6
        _name = "恶咒"
        _img = SKTexture(imageNamed: "evil_curse")
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

