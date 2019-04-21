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
                _selectedSpell = SummonServant()
            } else {
                _selectedSpell = Nova()
            }
            _selectedSpell._battle = self
            _selectedSpell.findTarget()
            execOrder()
        } else {
            super.createAI()
        }
    }
    
    override func setEnemyPart(minions: Array<Creature>) {
        let level:CGFloat = 48
        var es = Array<Creature>()
        
        let t = Francis()
        t.create(level: level)
        t._seat = BUnit.TTM
        es.append(t)
        
        super.setEnemyPart(minions: es)
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
        _name = "亡灵召唤"
        _description = "召唤一个随机的亡灵随从"
    }
    override func cast(completion: @escaping () -> Void) {
        let b = _battle!
        let c = b._curRole
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
        _name = "冲击波"
        _description = "对所有敌方目标造成精神200%的魔法伤害"
        _rate = 2
        _quality = Quality.SACRED
    }
    override func cast(completion: @escaping () -> Void) {
        let ts = _battle._playerPart
        _battle._curRole.actionCast {
            for t in ts {
                let damage = self.magicalDamage(t)
                if !self.hadSpecialAction(t: t, completion: completion) {
//                    let damage:CGFloat = 1
                    t.actionAttacked {
                        t.showValue(value: damage)
                    }
                }
            }
            setTimeout(delay: 3.5, completion: completion)
        }
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
                    t.showValue(value: damage) {
                        if !t.isDead() {
                            if self.d4() {
                                t.showText(text: "DEATH") {
                                    t.actionDead {
                                        t.removeFromBattle()
                                        t.removeFromParent()
                                        completion()
                                    }
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
}

class AttackPowerUp: Passive {
    override init() {
        super.init()
        _name = "力量增强"
        _description = "行动结束提升15%基础攻击力"
        _quality = Quality.RARE
        hasAfterMoveAction = true
    }
    override func cast(completion: @escaping () -> Void) {
        let c = _battle._curRole
        let up = c._unit._extensions.attack * 0.15
        c._extensions.attack += up
        c.actionBuff {
            completion()
        }
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
        _name = "强化"
        _description = "提升目标60%的基础攻击力和基础防御力，持续2回合"
        targetEnemy = false
        _quality = Quality.RARE
        canBeTargetSelf = true
    }
    override func cast(completion: @escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        c.actionCast {
            t.actionBuff {
                let s = Status()
                let atk = t._unit._extensions.attack * 0.6
                let def = t._unit._extensions.defence * 0.6
                t._extensions.attack += atk
                t._extensions.defence += def
                s._timeleft = 2
                s.timeupAction = {
                    t._extensions.attack -= atk
                    t._extensions.defence -= def
                }
                t.addStatus(status: s)
                t.showText(text: "POWER UP") {
                    completion()
                }
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
                        t.showText(text: "LOST") {
                            t.strengthChange(value: -1)
                            t.staminaChange(value: -1)
                            t.agilityChange(value: -1)
                            t.intellectChange(value: -1)
                            c.strengthChange(value: 1)
                            c.staminaChange(value: 1)
                            c.agilityChange(value: 1)
                            t.intellectChange(value: 1)
                            completion()
                        }
                    }
                }
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
