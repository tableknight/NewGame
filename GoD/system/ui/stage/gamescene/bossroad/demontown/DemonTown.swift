//
//  DemonTown.swift
//  GoD
//
//  Created by kai chen on 2019/3/24.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class DemonTown: BossRoad, InnerMaze {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let oa4 = Game.instance.dungeon_a4
        _mapSet = GroundSets(ground: oa4.getCell(2, 2, 2, 2), wall: oa4.getCell(2, 4, 2, 2))
        _monsterEnum = [1]
        _name = "黄昏之城"
        _floorSize = 5
        _level = 23
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func getMonsterByIndex(index: Int) -> Creature {
        switch index {
        case 1:
            return ToppurServant()
        default:
            return ToppurServant()
        }
    }
    override func getSelfScene() -> BossRoad {
        return DemonTown()
    }
    override func getPortalFinal() -> UIItem {
        return RoleToppur()
    }
    override func finalBattle() {
        let b = ToppurBattle()
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
        
        let btop = Game.instance.dungeon_a4.getNode(10, 7.5, 1, 0.5)
        btop.anchorPoint = CGPoint(x: 0.5, y: 1)
        node.addChild(btop)
        let bb = Game.instance.dungeon_a4.getNode(10, 9, 1, 0.5)
        bb.anchorPoint = CGPoint(x: 0.5, y: 1)
        bb.yAxis = -cellSize * 0.5
        node.addChild(bb)
        return node.toTexture()
    }
    
    override func addWall(x:CGFloat, y:CGFloat, item:SKSpriteNode) {
        item.anchorPoint = CGPoint(x: 0.5, y: 0)
        item.position.x = (-hSize / 2 + x) * cellSize
        item.position.y = (vSize / 2 - 0.5 - y) * cellSize
        item.zPosition = MyScene.ITEM_LAYER_Z + y
        item.name = getItemName(CGPoint(x: x, y: y))
        _itemLayer.addChild(item)
    }
    
    override func addPortalItem() {
        if _index < _floorSize {
            addGround(x: _portalNext.x, y: _portalNext.y, item: PortalDungeon())
        } else {
            addItem(x: _portalNext.x, y: _portalNext.y, item: getPortalFinal())
        }
        //        addGround(x: _portalPrev.x, y: _portalPrev.y, item: PortalPrev())
    }
}
class PortalDungeon:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let s = Game.instance.dungeon_b.getCell(3, 1)
        setTexture(s)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func triggerEvent() {
    }
}
