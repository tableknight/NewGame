//
//  Suvya.swift
//  GoD
//
//  Created by kai chen on 2019/9/1.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class Suvya:NPCBoss {
    static let LEVEL:CGFloat = 16
    static let IMG = "Suvya"
    override init() {
        super.init()
        _name = "苏维亚"
        _img = SKTexture(imageNamed: "Suvya").getCell(1, 0)
        _level = Suvya.LEVEL
        _race = EvilType.MAN
        _quality = Quality.SACRED
        _growth.stamina = 2
        _growth.strength = 1
        _growth.agility = 2
        _growth.intellect = 3
        _spellsInuse = [Leading(), SunmmonStars(), ControlWind(), Thinking()]
    }
    override func create(level: CGFloat) {
        levelTo(level: level)
        _extensions.health *= 5
        _sensitive = 75
        _extensions.hp = _extensions.health
        
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class SuvyaBattle: NPCBattle {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func createAI() {
//        if _curRole._unit is Boss {
//            _selectedSpell = _curRole._unit._spellsInuse.one()
//            _selectedSpell._battle = self
//            _selectedSpell.findTarget()
//            execOrder()
//        } else {
//        }
        super.createAI()
    }
    
    override func setEnemyPart(minions: Array<Creature>) {
        var es = Array<Creature>()
        let t = Suvya()
        let l:CGFloat = t._level
        t.create(level: l)
        t._seat = BUnit.TTM
        es.append(t)
        super.setEnemyPart(minions: es)
    }
    override func specialLoot() -> Array<Prop> {
        var list = Array<Prop>()
        let l = Loot()
        
        if getChange(400) {
            let b = SpellBook()
            b.spell = l.getRandomNormalSpell()
            list.append(b)
        }
        if getChange(200) {
            let b = SpellBook()
            b.spell = l.getRandomGoodSpell()
            list.append(b)
        }
        if getChange(100) {
            let b = SpellBook()
            b.spell = l.getRandomRareSpell()
            list.append(b)
        }
        if getChange(50) {
            let b = SpellBook()
            b.spell = l.getRandomSacredSpell()
            list.append(b)
        }
        return list
    }
    private func getChange(_ c:CGFloat) -> Bool {
        if _char._level > Suvya.LEVEL + 5 {
            return false
        }
        let lucky = _char._lucky * 0.01 + 1
        return seed(max: 1000).toFloat() < c * lucky
    }
}

import SpriteKit
class SunmmonStars: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "天罚"
        autoCast = true
        targetEnemy = true
        isFire = true
        _description = "对所有敌方目标造成精神65%的火焰伤害"
        _quality = Quality.SACRED
        _rate = 0.65
        _cooldown = 2
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let this = self
        c.actionCast {
            c.laser2()
            this.attack {
                completion()
            }
        }
    }
    
    func attack(completion:@escaping () -> Void) {
        let ts = _battle._selectedTargets
        for t in ts {
            let damage = fireDamage(t)
            if !hadSpecialAction(t:t) {
                t.actionAttacked {
                    t.showValue(value: damage)
                }
            }
        }
        setTimeout(delay: 2.5, completion: completion)
    }
    
    override func findTarget() {
        findTargetPartAll()
    }
    
}

class Thinking: Magical {
    override init() {
        super.init()
        _quality = Quality.NORMAL
        _name = "聆听"
        _cooldown = 2
        _description = "恢复25%生命，提升25点智力"
        autoCast = true
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let h = c.getHealth() * 0.25
        c.actionCast {
            c.revival2f(){
                c.showValue(value: h) {
                    completion()
                }
                c.intellectChange(value: 25)
            }
        }
    }
    
    override func findTarget() {
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

import SpriteKit
class Leading: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _cooldown = 3
        _name = "接引众神"
        _description = "接受神的指引，降低50%收到的物理伤害，持续5回合"
        targetEnemy = false
        _quality = Quality.GOOD
        autoCast = true
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        
        let status = Status()
        status._type = "_leading"
        status._labelText = "L"
        status._timeleft = 5
        c.actionCast {
            c.revival2s() {
                c.addStatus(status: status)
                completion()
            }
        }
    }
    override func findTarget() {
    }
}
