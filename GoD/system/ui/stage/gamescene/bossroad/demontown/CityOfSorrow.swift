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
        _monsterEnum = []
        _name = "悲伤之城"
        _floorSize = 6
        _level = Dius.LEVEL //19
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
        let role = UIRole()
        role.create(roleNode: SKSpriteNode(imageNamed: "Dius"))
        role._roleNode.size = CGSize(width: cellSize * 2, height: cellSize * 2)
        
        return role
    }
    
    
    override func finalBattle() {
        let b = DiusBattle()
        let es = Array<Creature>()
        b.setEnemyPart(minions: es)
        let char = Game.instance.char!
        let cs:Array<Unit> = [char] + char.getReadyMinions()
        b.setPlayerPart(roles: cs)
        Game.instance.curStage.addBattle(b)
        b.battleStart()
        _bossBattle = b
    }
    
}
class DreamSucker: Demon {
    override init() {
        super.init()
        _stars.strength = 1.5
        _stars.stamina = 2.2
        _stars.agility = 0.7
        _stars.intellect = 2.5
        _natural.strength = 18
        _natural.stamina = 29
        _natural.agility = 10
        _natural.intellect = 20
        _name = "食梦魔"
        _img = SKTexture(imageNamed: "dream_sucker")
        _spellsInuse = [Spell.BlowMana]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class BlowMana: Magical {
    override init() {
        super.init()
        _id = Spell.ColdWind
        isWater = true
        _name = "吞食"
        _description = "吃掉目标一定量的法力"
        _rate = 0.8
        _quality = Quality.NORMAL
        _cooldown = 1
        _mpCost = 15 * _costRate
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        let l = c._unit._level.toInt()
        let value = seed(min: l, max: l * 5)
        c.actionCast {
            t.mixed2(index: 16) {
                t.mpLost(value: value.toFloat())
                t.showText(text: "MP -\(value)", color: DamageColor.WATER, completion: completion)
            }
        }
    }
    
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }

}

class DarkWizard: Man {
    override init() {
        super.init()
        _stars.strength = 0.4
        _stars.stamina = 1.6
        _stars.agility = 1.4
        _stars.intellect = 2.8
        _natural.strength = 8
        _natural.stamina = 22
        _natural.agility = 18
        _natural.intellect = 30
        _name = "黑暗巫师"
        _img = SKTexture(imageNamed: "dark_wizard")
        _spellsInuse = [Spell.SoulLash, Spell.LifeDraw]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class CriticalJoker: Man {
    override init() {
        super.init()
        _stars.strength = 2.5
        _stars.stamina = 1.9
        _stars.agility = 0.6
        _stars.intellect = 0.6
        _natural.strength = 26
        _natural.stamina = 29
        _natural.agility = 10
        _natural.intellect = 12
        _imgUrl = "critical_joker2"
        _name = "致命小丑"
        _img = SKTexture(imageNamed: "critical_joker2")
        _spellsInuse = [Spell.Burn, Spell.Ignite, Spell.BurningAll]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class TheFallen: Man {
    override init() {
        super.init()
        _stars.strength = 2
        _stars.stamina = 1.6
        _stars.agility = 2
        _stars.intellect = 0.8
        _natural.strength = 22
        _natural.stamina = 28
        _natural.agility = 22
        _natural.intellect = 10
        _imgUrl = "the_fallen"
        _name = "堕落者"
        _img = SKTexture(imageNamed: "the_fallen")
        _spellsInuse = [Spell.LeeAttack]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
