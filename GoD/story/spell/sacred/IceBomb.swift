//
//  IceExplode.swift
//  GoD
//
//  Created by kai chen on 2019/2/10.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class IceBomb: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.IceBomb
        isFire = true
        _name = "寒冰炸弹"
        _description = "对目标释放寒冰炸弹，使其在下次行动前受到施法者精神80%的寒冰伤害，冰对周围单位造成一半的伤害，有一定几率使其冻结"
        _rate = 0.8
        _quality = Quality.SACRED
        _cooldown = 2
        cost(value: 30)
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        c.actionCast {
            t.actionWait {
                let s = Status()
                let spell = IceExplode()
                spell._caster = c
                spell._battle = self._battle
                spell._target = t
                s._castSpell = spell
                s._timeleft = 1
                s._type = Status.ICE_BOMB
                s.hasBeforeMoveAction = true
                t.addStatus(status: s)
                completion()
            }
//            t.water3f()
            t.mixed1(index: 10)
        }
    }
    
    override func findTarget() {
        findSingleTargetNotBlocked()
    }
}

class IceExplode:Derivant {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "冰暴"
        _delay = 2.5
    }
    override func cast(completion: @escaping () -> Void) {
        let ts = getAdajcentUnits(target: _target)
        let damage = self.waterDamage(self._target)
        if !self.hadSpecialAction(t: self._target) {
            self._target.actionAttacked {
                self._rate = 0.5
                self._target.showValue(value: damage, damageType: DamageType.WATER, textColor: ElementColor.WATER)
            }
            self._target.water3s()
            
            setTimeout(delay: 0.5, completion: {
                for t in ts {
                    self._rate = 0.25
                    let damage = self.waterDamage(t)
                    if !self.hadSpecialAction(t: t) {
                        t.actionAttacked {
                            t.showValue(value: damage, damageType: DamageType.WATER, textColor: ElementColor.WATER)
                        }
                        t.water3s()
                    }
                }
            })
            setTimeout(delay: 2.5, completion: completion)
        }
    }
}
