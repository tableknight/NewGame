//
//  CityOfLethe.swift
//  GoD
//
//  Created by kai chen on 2019/3/25.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class CityOfLethe: DemonTown {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let oa4 = Game.instance.dungeon_a4
        _mapSet = GroundSets(ground: oa4.getCell(0, 2, 2, 2), wall: oa4.getCell(0, 4, 2, 2))
        _monsterEnum = [1,2,3,4,5]
        _name = "遗忘之城"
        _floorSize = 10
        _level = 61
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func createSize() {
        halfSize = seedFloat(min: 5, max: 7)
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
        return CityOfLethe()
    }
    
    override func getPortalFinal() -> UIItem {
        return RoleGeorge()
    }
    
    override func finalBattle() {
        let b = GeorgeBattle()
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
        let btop = Game.instance.dungeon_a4.getNode(12.5, 7.5, 1, 0.5)
        btop.anchorPoint = CGPoint(x: 0.5, y: 1)
        node.addChild(btop)
        let bb = Game.instance.dungeon_a4.getNode(12.5, 9, 1, 0.5)
        bb.anchorPoint = CGPoint(x: 0.5, y: 1)
        bb.yAxis = -cellSize * 0.5
        node.addChild(bb)
        return node.toTexture()
    }
    
}
class RoleGeorge: UIRole {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.texture = SKTexture(imageNamed: "George")
        self.size = CGSize(width: cellSize * 2, height: cellSize * 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

