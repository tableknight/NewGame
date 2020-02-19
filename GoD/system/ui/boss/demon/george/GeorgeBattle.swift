//
//  GeorgeBattle.swift
//  GoD
//
//  Created by kai chen on 2019/2/10.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class GeorgeBattle: BossBattle {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
//    override func createAI() {
//        if _curRole._unit is Boss {
//            _selectedSpell._battle = self
//            _selectedSpell.findTarget()
//            execOrder()
//        } else {
//            super.createAI()
//        }
//    }
    
    override func setEnemyPart(minions: Array<Creature>) {
        let level:CGFloat = George.LEVEL
        var es = Array<Creature>()
        
        let s1 = GeorgeServant1()
        s1.create(level: level)
        s1._seat = BUnit.TBL
        es.append(s1)
        
        let s2 = GeorgeServant2()
        s2.create(level: level)
        s2._seat = BUnit.TBR
        es.append(s2)
        
        let t = George()
        t.create(level: level)
        t._seat = BUnit.TTM
        es.append(t)
        
        super.setEnemyPart(minions: es)
    }
    override func getSpellAttack() -> Spell {
        if _curRole.playerPart {
            return Attack()
        } else {
            return GeorgeAttack()
        }
    }
    
    override func specialLoot() -> Array<Item> {
        var list = Array<Item>()
        let lucky = _char._lucky * 0.01 + 1
        
        if seedFloat() < lucky * 95 {
            let i = Outfit(Outfit.Amulet)
            i.create(effection: Sacred.FangOfVampire)
            list.append(i)
        }
        
        if seedFloat() < lucky * 10 {
            let i = Outfit(Outfit.SoulStone)
            i.create(effection: Sacred.PandoraHeart)
            list.append(i)
        }
        
        if seedFloat() < lucky * 30 {
            let i = Outfit(Outfit.Ring)
            i.create(effection: Sacred.RingOfReborn)
            list.append(i)
        }
        
        if seedFloat() < lucky * 5 {
            let i = Outfit(Outfit.MagicMark)
            i.create(effection: Sacred.TheEye)
            list.append(i)
        }
        
        if seedFloat() < lucky * 15 {
            let i = Outfit(Outfit.Bow)
            i.create(effection: Sacred.SoundOfWind)
            list.append(i)
        }
        
        let l = Loot()
        l.loot(level: George.LEVEL.toInt())
        return list + l.getList()
    }
}

class GeorgeAttack: BossAttack {
    override func cast(completion:@escaping () -> Void) {
        let b = _battle
        let t = b._selectedTarget!
        let c = b._curRole
        let damage = physicalDamage(t)
        c.actionAttack {
            if !self.hadSpecialAction(t: t, completion: completion) {
                if !self.hasMissed(target: t, completion: completion) {
                    t.actionAttacked {
                        t.showValue(value: damage) {
                            if self.d3() {
                                let s = Status()
                                s._type = Status.INFECTED
                                s._timeleft = 3
                                s._labelText = "P"
                                t.addStatus(status: s)
                                t.showText(text: Status.INFECTED) {
                                    completion()
                                }
                            } else {
                                completion()
                            }
                            if t.hasStatus(type: Status.INFECTED) {
                                c.showValue(value: -damage * 0.8)
                            } else {
                                c.showValue(value: -damage * 0.3)
                            }
                        }
                    }
                    t.claw()
                }
            }
        }
    }
}

class Screaming: Magical, BossOnly {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.Screaming
        _name = "尖叫"
        _description = "对目标造成精神80%的法术伤害"
        _quality = Quality.NORMAL
        _cooldown = 1
        _rate = 0.8
    }
    override func cast(completion:@escaping () -> Void) {
        let b = _battle
        let t = b._selectedTarget!
        let c = b._curRole
        let damage = magicalDamage(t)
        c.actionCast {
            t.darkness1s() {
                
                if !self.hadSpecialAction(t: t, completion: completion) {
                    t.actionAttacked {
                        t.showValue(value: damage) {
                            if self.d3() {
                                let s = Status()
                                s._type = Status.INFECTED
                                s._timeleft = 3
                                s._labelText = "P"
                                t.addStatus(status: s)
                                t.showText(text: Status.INFECTED) {
                                    completion()
                                }
                            } else {
                                completion()
                            }
                        }
                        
                    }
                }
            }
        }
    }
    override func findTarget() {
        findSingleTargetNotBlocked()
    }
}

class Infection:Magical, Curse, BossOnly {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.Infection
        _name = "感染"
        _description = "对敌方所有目标释放诅咒感染，75%几率令目标感染瘟疫"
        _quality = Quality.RARE
        _cooldown = 3
    }
    override func cast(completion: @escaping () -> Void) {
        _battle._curRole.actionCast {
            for t in self._battle._selectedTargets {
                if !self.statusMissed(baseline: 75, target: t, completion: {}) {
                    t.mixed1(index: 5) {
//                    t.actionDebuff {
                        t.showText(text: Status.INFECTED)
                        let s = Status()
                        s._type = Status.INFECTED
                        s._labelText = "P"
                        s._timeleft = 3
                        t.addStatus(status: s)
                    }
                }
            }
            setTimeout(delay: 3, completion: completion)
        }
    }
    override func findTarget() {
        _battle._selectedTargets = _battle._playerPart
    }
}
class DrawBlood:Magical, BossOnly {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.DrawBlood
        _name = "群体吸血"
        _description = "对敌方所有目标造成精神60%的法术攻击，并且恢复造成伤害的总量"
        _rate = 0.6
    }
    override func cast(completion: @escaping () -> Void) {
        var recovery:CGFloat = 0
        _battle._curRole.actionCast {
            for t in self._battle._selectedTargets {
                t.mixed2(index: 3) {
                    let damage = self.magicalDamage(t)
                    if !self.hadSpecialAction(t: t) {
                        t.showValue(value: damage)
                        recovery += damage
                    }
                }
            }
            setTimeout(delay: 1.8, completion: {
                self._battle._curRole.showValue(value: -recovery)
            })
            setTimeout(delay: 3, completion: completion)
        }
    }
    override func findTarget() {
        _battle._selectedTargets = _battle._playerPart
    }
}
