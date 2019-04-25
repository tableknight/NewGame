//
//  CityOfDesire.swift
//  GoD
//
//  Created by kai chen on 2019/3/25.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class CityOfDesire: DemonTown {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let oa4 = Game.instance.dungeon_a4
        _mapSet = GroundSets(ground: oa4.getCell(8, 7, 2, 2), wall: oa4.getCell(8, 9, 2, 2))
        _monsterEnum = [1,2,3,4]
        _name = "欲望之城"
        _floorSize = 6
        _level = 25
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func createSize() {
        halfSize = seedFloat(min: 3, max: 6)
//        halfSize = 6
    }
    override func getMonsterByIndex(index: Int) -> Creature {
        if index == 1 {
            return Ayer()
        }
        if index == 2 {
            return Shuran()
        }
        if index == 3 {
            return Lanis()
        }
        if index == 4 {
            return Angela()
        }
        return Ayer()
    }
    
    override func getSelfScene() -> BossRoad {
        return CityOfDesire()
    }
    
    override func getPortalFinal() -> UIItem {
        return RoleIdlir()
    }
    
    override func finalBattle() {
        let b = IdlirBattle()
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
        let btop = Game.instance.inside_a4.getNode(0, 2.5, 1, 0.5)
        btop.anchorPoint = CGPoint(x: 0.5, y: 1)
        node.addChild(btop)
        let bb = Game.instance.inside_a4.getNode(0, 4, 1, 0.5)
        bb.anchorPoint = CGPoint(x: 0.5, y: 1)
        bb.yAxis = -cellSize * 0.5
        node.addChild(bb)
        return node.toTexture()
    }
    
}
class RoleIdlir: UIRole {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.texture = SKTexture(imageNamed: "Idlir")
        self.size = CGSize(width: cellSize * 2, height: cellSize * 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class Ayer: Demon {
    override init() {
        super.init()
        _stars.strength = 3
        _stars.stamina = 1
        _stars.agility = 1
        _stars.intellect = 1
        _name = "艾尔"
        _img = SKTexture(imageNamed: "ayer")
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class Shuran: Demon {
    override init() {
        super.init()
        _stars.strength = 1
        _stars.stamina = 3
        _stars.agility = 1
        _stars.intellect = 1
        _name = "舒兰"
        _img = SKTexture(imageNamed: "shuran")
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class Lanis: Demon {
    override init() {
        super.init()
        _stars.strength = 1
        _stars.stamina = 1
        _stars.agility = 3
        _stars.intellect = 1
        _name = "兰尼斯"
        _img = SKTexture(imageNamed: "lanis")
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class Angela: Demon {
    override init() {
        super.init()
        _stars.strength = 1
        _stars.stamina = 1
        _stars.agility = 1
        _stars.intellect = 3
        _name = "安吉拉"
        _img = SKTexture(imageNamed: "angela")
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
