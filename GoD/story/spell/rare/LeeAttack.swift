//
//  LeeAttack.swift
//  GoD
//
//  Created by kai chen on 2019/5/5.
//  Copyright © 2019 Chen. All rights reserved.
//

class LeeAttack:Physical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
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

