//
//  MicaluBattle.swift
//  GoD
//
//  Created by kai chen on 2019/1/22.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class SumahlBattle: BossBattle {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func createAI() {
        if _curRole._unit is Sumahl {
            let sd = seed()
            if sd < 50 {
                _selectedSpell = MindIntervene()
            } else if sd < 70 {
                _selectedSpell = HealAll()
            } else if sd < 90 {
                _selectedSpell = SilenceAll()
            } else {
                _selectedSpell = BossAttack()
            }
            _selectedSpell._battle = self
            _selectedSpell.findTarget()
            execOrder()
        } else {
            super.createAI()
        }
    }
    override func setEnemyPart(minions: Array<Creature>) {
        let level:CGFloat = 50
        var es = Array<Creature>()
        
        let mx1 = SumahlServant1()
        mx1.create(level: level)
        mx1._seat = BUnit.TBL
        
        let mx2 = SumahlServant1()
        mx2.create(level: level)
        mx2._seat = BUnit.TBM
        
        let mx3 = SumahlServant1()
        mx3.create(level: level)
        mx3._seat = BUnit.TBR
        
        let lq1 = SumahlServant2()
        lq1.create(level: level)
        lq1._seat = BUnit.TTL
        
        let lq2 = SumahlServant2()
        lq2.create(level: level)
        lq2._seat = BUnit.TTR
        
        es.append(mx1)
        es.append(mx2)
        es.append(mx3)
        
        es.append(lq1)
        es.append(lq2)
        
        let t = Sumahl()
        t.create(level: level)
        t._seat = BUnit.TTM
        es.append(t)
        
        super.setEnemyPart(minions: es)
    }
    override func getBossYAxis() -> CGFloat {
        return cellSize * 4.25
    }
}

class MindIntervene: Physical, Curse {
    override init() {
        super.init()
        _name = "精神扰乱"
        _description = "对目标释放诅咒术，有100%几率使其精神产生混乱，随机攻击目标，不分敌友"
        _quality = Quality.SACRED
        _cooldown = 2
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        c.actionCast {
            if !self.statusMissed(baseline: 100, target: t, completion: completion) {
                t.actionDebuff {
                    t.showText(text: "CONFUSED") {
                        completion()
                        let s = Status()
                        s._type = Status.CONFUSED
                        s._timeleft = 3
                        t.addStatus(status: s)
                        
                    }
                }
            }
        }
    }
    override func findTarget() {
        findSingleTargetNotBlocked()
    }
}
class HealAll: Magical {
    override init() {
        super.init()
        _name = "群体治疗"
        _quality = Quality.SACRED
        _description = "恢复所有己方单位25%的最大生命"
        _cooldown = 3
        autoCast = true
        targetEnemy = false
    }
    override func cast(completion: @escaping () -> Void) {
        let c = _battle._curRole
        let ts = _battle._selectedTargets
        c.actionCast {
            for t in ts {
                t.actionHealed {
                    let value = t.getHealth() * 0.25
                    t.showValue(value: value)
                }
            }
            setTimeout(delay: 2.5, completion: completion)
        }
    }
    override func findTarget() {
        findTargetPartAll()
    }
}
class SilenceAll: Magical, Curse {
    override init() {
        super.init()
        _name = "群体静默"
        _description = "对敌方所有单位释放诅咒术，令其有50%的几率静默"
        _quality = Quality.SACRED
        _cooldown = 1
        autoCast = true
    }
    override func cast(completion: @escaping () -> Void) {
        let c = _battle._curRole
        let ts = _battle._selectedTargets
        c.actionCast {
            for t in ts {
                if !self.statusMissed(baseline: 50, target: t, completion: {}) {
                    t.actionDebuff {
                        self._battle.silenceUnit(unit: t)
                    }
                }
            }
            setTimeout(delay: 3.5, completion: completion)
        }
    }
    override func findTarget() {
        findTargetPartAll()
    }
}
class HolySacrifice: Physical {
    override init() {
        super.init()
        _name = "神圣牺牲"
        _description = "牺牲15%当前生命，作为额外攻击。对目标造成攻击100%的物理伤害"
        _quality = Quality.RARE
        _cooldown = 1
    }
    override func getAttack(from: BUnit) -> CGFloat {
        return from.getAttack() + _battle._curRole.getHp() * 0.15
    }
    override func cast(completion: @escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        let selfDamage = -c.getHp() * 0.15
        let damage = physicalDamage(t)
        c.showValue(value: selfDamage) {
            c.actionAttack {
                if !self.hadSpecialAction(t: t, completion: completion) {
                    if !self.hasMissed(target: t, completion: completion) {
                        t.actionAttacked {
                            t.showValue(value: damage) {
                                completion()
                            }
                        }
                    }
                }
            }
            
        }
    }
}
class LifeFlow: Magical {
    override init() {
        super.init()
        _name = "生命分涌"
        _description = "牺牲15%当前生命，作为额外精神。对目标造成精神100%的魔法伤害"
        _quality = Quality.RARE
        _cooldown = 1
    }
    override func getSelfSpirit() -> CGFloat {
        return _battle._curRole.getSpirit() + _battle._curRole.getHp() * 0.15
    }
    override func cast(completion: @escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        let selfDamage = -c.getHp() * 0.15
        let damage = magicalDamage(t)
        c.showValue(value: selfDamage) {
            c.actionCast {
                if !self.hadSpecialAction(t: t, completion: completion) {
                    t.actionAttacked {
                        t.showValue(value: damage) {
                            completion()
                        }
                    }
                }
            }
            
        }
    }
}
