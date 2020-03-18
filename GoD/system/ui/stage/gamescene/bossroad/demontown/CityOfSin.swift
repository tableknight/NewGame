//
//  CityOfSin.swift
//  GoD
//
//  Created by kai chen on 2019/3/25.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class CityOfSin: DemonTown {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let oa4 = Game.instance.dungeon_a4
        _mapSet = GroundSets(ground: oa4.getCell(4, 2, 2, 2), wall: oa4.getCell(4, 4, 2, 2))
        _monsterEnum = []
        _name = "罪恶之城"
        _floorSize = 5
        _level = Iberis.LEVEL //30
        _soundUrl = "city_of_sin"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func createSize() {
//        halfSize = 6
        hSize = 12
        vSize = 12
    }
    override func getMonsterByIndex(index: Int) -> Creature {
        if index == 1 {
            return LostElf()
        }
        if index == 2 {
            return Niro()
        }
        if index == 3 {
            return Gerute()
        }
        if index == 4 {
            return SoulSeaker()
        }
        return SoulSeaker()
    }
    
    override func getSelfScene() -> BossRoad {
        return CityOfSin()
    }
    
    override func getPortalFinal() -> UIItem {
        return RoleIberis()
    }
    
    override func finalBattle() {
        let b = IberisBattle()
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
        let btop = Game.instance.dungeon_a4.getNode(2, 7.5, 1, 0.5)
        btop.anchorPoint = CGPoint(x: 0.5, y: 1)
        node.addChild(btop)
        let bb = Game.instance.dungeon_a4.getNode(2, 9, 1, 0.5)
        bb.anchorPoint = CGPoint(x: 0.5, y: 1)
        bb.yAxis = -cellSize * 0.5
        node.addChild(bb)
        return node.toTexture()
    }
    
}
class RoleIberis: UIRole {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.texture = SKTexture(imageNamed: "Iberis")
        self.size = CGSize(width: cellSize * 2, height: cellSize * 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class LostElf: Man {
    override init() {
        super.init()
        _stars.strength = 1.2
        _stars.stamina = 1.2
        _stars.agility = 1
        _stars.intellect = 2.4
        _natural.strength = 17
        _natural.stamina = 18
        _natural.agility = 12
        _natural.intellect = 22
        _imgUrl = "lost_elf"
        _name = "迷失精灵"
        _img = SKTexture(imageNamed: "lost_elf")
        _spellsInuse = [Spell.ColdWind]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class Niro: Man {
    override init() {
        super.init()
        _stars.strength = 1.2
        _stars.stamina = 1.8
        _stars.agility = 1.2
        _stars.intellect = 1.1
        _natural.strength = 18
        _natural.stamina = 20
        _natural.agility = 22
        _natural.intellect = 18
        _imgUrl = "niro"
        _name = "尼路"
        _img = SKTexture(imageNamed: "niro")
        _spellsInuse = [Spell.AttackReturnBack, Spell.MagicConvert]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class Gerute: Demon {
    override init() {
        super.init()
        _stars.strength = 2.2
        _stars.stamina = 2.8
        _stars.agility = 1
        _stars.intellect = 0.5
        _natural.strength = 24
        _natural.stamina = 24
        _natural.agility = 22
        _natural.intellect = 16
        _imgUrl = "gerute"
        _name = "格鲁特"
        _img = SKTexture(imageNamed: "gerute")
        _spellsInuse = [Spell.Taunt]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class SoulSeaker: Demon {
    override init() {
        super.init()
        _stars.strength = 0.6
        _stars.stamina = 1.1
        _stars.agility = 1.5
        _stars.intellect = 2.4
        _natural.strength = 18
        _natural.stamina = 26
        _natural.agility = 19
        _natural.intellect = 25
        _imgUrl = "critical_joker"
        _name = "索魂者"
        _img = SKTexture(imageNamed: "soul_seaker")
        _spellsInuse = [Spell.SuperWater, Spell.Heal]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
