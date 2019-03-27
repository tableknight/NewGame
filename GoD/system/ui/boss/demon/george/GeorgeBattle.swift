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
        let level:CGFloat = 61
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
        return GeorgeAttack()
    }
}

class GeorgeAttack: BossAttack {
    override func cast(completion:@escaping () -> Void) {
        let b = _battle!
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
                                t.addStatus(status: s)
                                t.showText(text: "INFECTED") {
                                    completion()
                                }
                            } else {
                                completion()
                            }
                        }
                        if t.hasStatus(type: Status.INFECTED) {
//                            setTimeout(delay: 0.5, completion: {
//                            })
                            c.showValue(value: -damage * 0.5)
                        }
                    }
                }
            }
        }
    }
}

class Screaming: Magical, BossOnly {
    override init() {
        super.init()
        _name = "尖叫"
        _description = "对目标造成精神80%的法术伤害"
        _quality = Quality.NORMAL
        _cooldown = 1
        _rate = 0.8
    }
    override func cast(completion:@escaping () -> Void) {
        let b = _battle!
        let t = b._selectedTarget!
        let c = b._curRole
        let damage = magicalDamage(t)
        c.actionCast {
            if !self.hadSpecialAction(t: t, completion: completion) {
                t.actionAttacked {
                    t.showValue(value: damage) {
                        if self.d3() {
                            let s = Status()
                            s._type = Status.INFECTED
                            s._timeleft = 3
                            t.addStatus(status: s)
                            t.showText(text: "INFECTED") {
                                completion()
                            }
                        } else {
                            completion()
                        }
                    }
                    if t.hasStatus(type: Status.INFECTED) {
                        c.showValue(value: -damage * 0.5)
//                        setTimeout(delay: 0.5, completion: {
//                        })
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
    override init() {
        super.init()
        _name = "感染"
        _description = "对敌方所有目标释放诅咒感染，75%几率令目标感染瘟疫"
        _quality = Quality.RARE
        _cooldown = 3
    }
    override func cast(completion: @escaping () -> Void) {
        _battle._curRole.actionCast {
            for t in self._battle._selectedTargets {
                if !self.statusMissed(baseline: 75, target: t, completion: {}) {
                    t.actionDebuff {
                        t.showText(text: "INFECTED")
                        let s = Status()
                        s._type = Status.INFECTED
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
    override init() {
        super.init()
        _name = "群体吸血"
        _description = "对敌方所有目标造成精神40%的法术攻击，并且恢复造成伤害的总量"
        _rate = 0.4
    }
    override func cast(completion: @escaping () -> Void) {
        var recovery:CGFloat = 0
        _battle._curRole.actionCast {
            for t in self._battle._selectedTargets {
                if !self.hadSpecialAction(t: t) {
                    let damage = self.magicalDamage(t)
                    t.showValue(value: damage)
                    recovery += damage
                }
            }
            setTimeout(delay: 0.5, completion: {
                self._battle._curRole.showValue(value: -recovery)
            })
            setTimeout(delay: 3, completion: completion)
        }
    }
    override func findTarget() {
        _battle._selectedTargets = _battle._playerPart
    }
}
