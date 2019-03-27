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
        _monsterEnum = [1,2,3,4,5]
        _name = "死亡之城"
        _floorSize = 12
        _level = 54
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func getMonsterByIndex(index: Int) -> Creature {
        if index == 1 {
            return UndeadMinion11()
        }
        if index == 2 {
            return UndeadMinion12()
        }
        if index == 3 {
            return UndeadMinion13()
        }
        if index == 4 {
            return UndeadMinion14()
        }
        if index == 5 {
            return UndeadMinion15()
        }
        return UndeadMinion1()
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
        let top = Game.instance.inside_a5.getNode(0, 0)
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

