//
//  ToppurBattle.swift
//  GoD
//
//  Created by kai chen on 2019/1/17.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class ToppurBattle: BossBattle {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func createAI() {
        if _curRole._unit is Toppur {
            if _round % 3 == 1 {
                _selectedSpell = FateDecision()
            } else {
                let sd = seed()
                if sd < 40 {
                    _selectedSpell = BossAttack()
                } else if sd < 70 {
                    _selectedSpell = LineAttack()
                } else if sd < 90 {
                    _selectedSpell = RecoveryFromAttack()
                } else {
                    _selectedSpell = BossAttack()
                }
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
        for _ in 0...1 {
            let lm = ToppurServant()
            lm.create(level: level)
            es.append(lm)
        }
        es[0]._seat = BUnit.TBL
        es[1]._seat = BUnit.TBR
        
        let t = Toppur()
        t.create(level: level)
        t._seat = BUnit.TTM
        es.append(t)
        
        super.setEnemyPart(minions: es)
    }
}
class FateDecision: Magical, BossOnly {
    override init() {
        super.init()
        //        isWater = true
        _name = "命运裁决"
        _description = "对随机随从目标造成当前生命值75%的伤害"
        _rate = 0.8
        _quality = Quality.SACRED
        _cooldown = 2
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        let damage = -t.getHp() * 0.75
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
    
    override func findTarget() {
        var ts = Array<BUnit>()
        var playerRole:BUnit!
        for u in _battle._playerPart {
            if u._unit is Character {
                playerRole = u
            } else {
                ts.append(u)
            }
        }
        _battle._selectedTarget = ts.count > 0 ? ts.one() : playerRole
    }
    
}
class LineAttack: Physical {
    override init() {
        super.init()
        _name = "顺劈斩"
        _description = "对目标同一行单位造成攻击55%的物理伤害"
        _rate = 0.55
        _quality = Quality.GOOD
        _cooldown = 2
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let ts = _battle._selectedTargets
        c.actionAttack {
            for t in ts {
                let damage = self.physicalDamage(t)
                if !self.hadSpecialAction(t: t) {
                    if !self.hasMissed(target: t) {
                        t.actionAttacked {
                            t.showValue(value: damage)
                        }
                    }
                }
            }
            setTimeout(delay: 2.5, completion: completion)
        }
    }
    
    override func findTarget() {
        findTargetInALine()
    }
}

class RecoveryFromAttack:Physical {
    override init() {
        super.init()
        _name = "吸血攻击"
        _description = "对目标造成攻击100%的物理伤害，并恢复50%的生命值"
        _quality = Quality.RARE
        _cooldown = 4
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        let damage = physicalDamage(t)
        c.actionAttack {
            if !self.hadSpecialAction(t: t, completion: completion) {
                if !self.hasMissed(target: t, completion: completion) {
                    t.actionAttacked {
                        t.showValue(value: damage) {
                            completion()
                        }
                        setTimeout(delay: 1, completion: {
                            c.showValue(value: abs(damage * 0.5))
                        })
                    }
                }
            }
        }
    }
}
