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
        _mapSet = GroundSets(ground: oa4.getCell(8, 2, 2, 2), wall: oa4.getCell(8, 4, 2, 2))
        _monsterEnum = []
        _name = "遗忘之城"
        _floorSize = 10
        _level = George.LEVEL //39
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func createSize() {
//        halfSize = seedFloat(min: 5, max: 7)
        hSize = [10,10,12,12].one()
        vSize = [10,10,12,12].one()
    }
    override func getMonsterByIndex(index: Int) -> Creature {
        if index == 1 {
            return YouXya()
        }
        if index == 2 {
            return BloodSucker()
        }
        if index == 3 {
            return Tangnad()
        }
        if index == 4 {
            return MagicEye()
        }
        return Tangnad()
    }
    
    override func getSelfScene() -> BossRoad {
        return CityOfLethe()
    }
    
    override func getPortalFinal() -> UIItem {
        let role = UIRole()
        role.create(roleNode: SKSpriteNode(imageNamed: "George"))
        role._roleNode.size = CGSize(width: cellSize * 2, height: cellSize * 2)
        role.zPosition = MyScene.BOSS_LAYER_Z
        return role
    }
    
    override func finalBattle() {
        let b = GeorgeBattle()
        let es = Array<Creature>()
        b.setEnemyPart(minions: es)
        let char = Game.instance.char!
        let cs:Array<Unit> = [char] + char.getReadyMinions()
        b.setPlayerPart(roles: cs)
        Game.instance.curStage.addBattle(b)
        b.battleStart()
        _bossBattle = b
    }
    
    override func getWallTexture() -> SKTexture {
        let node = SKSpriteNode()
        let top = getRoof()
        top.anchorPoint = CGPoint(x: 0.5, y: 0)
        node.addChild(top)
        let btop = Game.instance.dungeon_a4.getNode(8, 2.5, 1, 0.5)
        btop.anchorPoint = CGPoint(x: 0.5, y: 1)
        node.addChild(btop)
        let bb = Game.instance.dungeon_a4.getNode(8, 4, 1, 0.5)
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

class Tangnad: Rizen {
    override init() {
        super.init()
        _stars.strength = 2
        _stars.stamina = 2
        _stars.agility = 2
        _stars.intellect = 1
        _natural.strength = 22
        _natural.stamina = 22
        _natural.agility = 22
        _natural.intellect = 10
        _imgUrl = "tangnad"
        _name = "唐纳德"
        _img = SKTexture(imageNamed: "tangnad")
        _spellsInuse = [Spell.SpiritIntervene, Spell.ChaosAttack]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class MagicEye: Rizen {
    override init() {
        super.init()
        _stars.strength = 1.4
        _stars.stamina = 1.8
        _stars.agility = 1.1
        _stars.intellect = 2.6
        _natural.strength = 18
        _natural.stamina = 24
        _natural.agility = 18
        _natural.intellect = 24
        _imgUrl = "magic_eye"
        _name = "魔眼"
        _img = SKTexture(imageNamed: "magic_eye")
        _spellsInuse = [Spell.Lighting, Spell.ThunderArray]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class BloodSucker: Rizen {
    override init() {
        super.init()
        _stars.strength = 1.6
        _stars.stamina = 1.4
        _stars.agility = 2.6
        _stars.intellect = 1.1
        _natural.strength = 22
        _natural.stamina = 19
        _natural.agility = 28
        _natural.intellect = 14
        _imgUrl = "blood_sucker"
        _name = "血魔"
        _img = SKTexture(imageNamed: "blood_sucker")
        _spellsInuse = [Spell.LeeAttack, Spell.ScreamLoud]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class YouXya: Rizen {
    override init() {
        super.init()
        _stars.strength = 2.6
        _stars.stamina = 1.4
        _stars.agility = 2.1
        _stars.intellect = 1.1
        _natural.strength = 24
        _natural.stamina = 18
        _natural.agility = 24
        _natural.intellect = 10
        _imgUrl = "youxya"
        _name = "勇者"
        _img = SKTexture(imageNamed: "youxya")
        _spellsInuse = [Spell.LowerSummon, Spell.HighLevelSummon]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
