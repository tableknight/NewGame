//
//  FrancisBattle.swift
//  GoD
//
//  Created by kai chen on 2019/2/6.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class FrancisBattle: BossBattle {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func createAI() {
        if _curRole._unit is Francis {
            if _enemyPart.count < 6 {
//                _selectedSpell = SummonServant()
                _selectedAction = SummonServant()
//                _selectedAction.ba
            } else {
//                _selectedSpell = Nova()
                _selectedAction = Nova()
            }
            _selectedAction._battle = self
            _selectedAction.findTarget()
            execOrder()
        } else {
            super.createAI()
        }
    }
    
    override func setEnemyPart(minions: Array<Creature>) {
        let level:CGFloat = Francis.LEVEL
        var es = Array<Creature>()
        
        let t = Francis()
        t.create(level: level)
        t._seat = BUnit.TTM
        es.append(t)
        
        super.setEnemyPart(minions: es)
    }
    override func specialLoot() -> Array<Item> {
        var list = Array<Item>()
        let lucky = _char._lucky * 0.01 + 1
        
        if seedFloat() < lucky * 10 {
            let i = Outfit(Outfit.MagicMark)
            i.create(effection: Sacred.FireMark)
            list.append(i)
        }
        
        if seedFloat() < lucky * 5 {
            let i = Outfit(Outfit.MagicMark)
            i.create(effection: Sacred.MoltenFire)
            list.append(i)
        }
        
        if seedFloat() < lucky * 10 {
            let i = Outfit(Outfit.EarRing)
            i.create(effection: Sacred.LavaCrystal)
            list.append(i)
        }
        
        if seedFloat() < lucky * 15 {
            let i = Outfit(Outfit.Shield)
            i.create(effection: Sacred.FrancisFace)
            list.append(i)
        }
        
        if seedFloat() < lucky * 15 {
            let i = Outfit(Outfit.Shield)
            i.create(effection: Sacred.Accident)
            list.append(i)
        }
        
        if seedFloat() < lucky * 15 {
            let i = Outfit(Outfit.Instrument)
            i.create(effection: Sacred.TheFear)
            list.append(i)
        }
        
        if seedFloat() < lucky * 15 {
            let i = Outfit(Outfit.Instrument)
            i.create(effection: Sacred.TheSurpass)
            list.append(i)
        }
        
        let l = Loot()
        l.loot(level: Francis.LEVEL.toInt())
        return list + l.getList()
    }
}

class SummonServant: Magical, BossOnly {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.SummonServant
        _name = "亡灵召唤"
        _description = "召唤一个随机的亡灵随从"
    }
    override func cast(completion: @escaping () -> Void) {
        let b = _battle
        let c = b._curRole
        c.speak(text: "来自地狱的召唤！")
        setTimeout(delay: 1, completion: {
            c.actionCast {
                let seats = [BUnit.TBM, BUnit.TBL, BUnit.TBR, BUnit.TTL, BUnit.TTR]
                for s in seats {
                    var hasRole = false
                    for u in b._enemyPart {
                        if u._unit._seat == s {
                            hasRole = true
                        }
                    }
                    if !hasRole {
                        let m = self.getUndeadMinionById(id: self.seed(max: 5))
                        m.create(level: c._unit._level)
                        m._seat = s
                        let unit = b.addEnemy(unit: m)
                        unit.actionSummon {
                            completion()
                        }
                        break
                    }
                }
            }
        })
    }
    private func getUndeadMinionById(id:Int) -> BossMinion {
        if id == 0 {
            return UndeadMinion1()
        } else
        if id == 1 {
            return UndeadMinion2()
        } else
        if id == 2 {
            return UndeadMinion3()
        } else
        if id == 3 {
            return UndeadMinion4()
        } else
        if id == 4 {
            return UndeadMinion5()
        }
        return UndeadMinion1()
    }
}

class Nova: Magical, BossOnly {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.Nova
        _name = "冲击波"
        _description = "当佛朗西斯集齐了他的军队，那么就轮到他发挥真正实力的时候了，对所有敌方目标造成精神200%的魔法伤害"
        _rate = 2
        _quality = Quality.SACRED
    }
    override func cast(completion: @escaping () -> Void) {
        let ts = _battle._playerPart
        _battle._curRole.speak(text: "感受力量的绝望吧！")
        setTimeout(delay: 1, completion: {
            self._battle._curRole.actionCast {
                for t in ts {
                    let damage = self.magicalDamage(t)
                    if !self.hadSpecialAction(t: t) {
                        //                    let damage:CGFloat = 1
                        t.actionAttacked {
                            t.showValue(value: damage, source: self._battle._curRole, damageType: DamageType.MAGICAL)
                        }
                        t.hit1()
                    }
                }
                setTimeout(delay: 2.5, completion: completion)
            }
        })
    }
}

class DeathAttack:Physical, BossOnly {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.DeathAttack
        _name = "死亡一击"
        _description = "命中时有25%几率直接杀死目标"
        _quality = Quality.SACRED
    }
    override func cast(completion: @escaping () -> Void) {
        let t = _battle._selectedTarget!
        let damage = self.physicalDamage(t)
        _battle._curRole.actionAttack {
            if !self.hadSpecialAction(t: t, completion: completion) {
                if !self.hasMissed(target: t, completion: completion) {
                    t.actionAttacked {
                        t.showValue(value: damage) {
                            if !t.isDead() {
                                if self.d4() {
                                    t.showText(text: "DEATH") {
                                        t.actionDead {
                                            t.removeFromBattle()
                                            t.removeFromParent()
                                            if t._unit is Character {
                                                self._battle.defeated()
                                            } else {
                                                completion()
                                            }
                                        }
                                    }
                                } else {
                                    completion()
                                }
                            }
                        }
                        t.darkness4fifth()
                    }
                    
                }
            }
        }
    }
}

class AttackPowerUp: Passive {
    override init() {
        super.init()
        _id = Spell.AttackPowerUp
        _name = "充能"
        _description = "行动结束提升8%基础攻击力"
        _quality = Quality.RARE
        hasAfterMoveAction = true
    }
    override func cast(completion: @escaping () -> Void) {
        let c = _battle._curRole
        let up = c._unit._extensions.attack * 0.08
        c._valueUnit._extensions.attack += up
        c.showText(text: _name)
        c.mixed2(index: 14, completion: completion)
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class Reinforce: Magical {
    override init() {
        super.init()
        _id = Spell.Reinforce
        _name = "强化"
        _description = "提升目标60%的基础攻击力和基础护甲，持续2回合"
        targetEnemy = false
        _quality = Quality.RARE
        canBeTargetSelf = true
    }
    override func cast(completion: @escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        c.actionCast {
            t.stateUp2() {
                let s = Status()
                let atk = t._unit._extensions.attack * 0.6
                let def = t._unit._extensions.defence * 0.6
                t._valueUnit._extensions.attack += atk
                t._valueUnit._extensions.defence += def
                s._timeleft = 2
                s.timeupAction = {
                    t._valueUnit._extensions.attack -= atk
                    t._valueUnit._extensions.defence -= def
                }
                s._labelText = "E"
                t.addStatus(status: s)
                completion()
            }
        }
    }

    override func findTarget() {
        findSingleTargetNotBlocked()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class SoulExtract: Magical {
    override init() {
        super.init()
        _id = Spell.SoulExtract
        _name = "灵魂抽取"
        _description = "对目标造成60%精神的魔法伤害，并抽取其基础属性各一点"
        _quality = Quality.SACRED
        _rate = 0.6
        _cooldown = 3
    }
    override func cast(completion: @escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        let damage = self.magicalDamage(t)
        c.actionCast {
            if !self.hadSpecialAction(t: t, completion: completion) {
                t.actionAttacked {
                    t.showValue(value: damage) {
                        t.showText(text: "Lost") {
                            t._valueUnit.strengthChange(value: -1)
                            t._valueUnit.staminaChange(value: -1)
                            t._valueUnit.agilityChange(value: -1)
                            t._valueUnit.intellectChange(value: -1)
                            c._valueUnit.strengthChange(value: 1)
                            c._valueUnit.staminaChange(value: 1)
                            c._valueUnit.agilityChange(value: 1)
                            t._valueUnit.intellectChange(value: 1)
                            completion()
                        }
                    }
                }
                t.darkness5()
            }
        }
    }
    override func findTarget() {
        findSingleTargetNotBlocked()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
