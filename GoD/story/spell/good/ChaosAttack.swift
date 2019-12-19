//
//  ChaosArrow.swift
//  GoD
//
//  Created by kai chen on 2019/2/12.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class ChaosAttack:Physical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.ChaosAttack
        _name = "混沌攻击"
        _description = "对目标造成攻击75%的物理或元素伤害"
        _quality = Quality.GOOD
        _cooldown = 1
//        autoCast = true
        _rate = 0.75
    }
    override func cast(completion: @escaping () -> Void) {
        let t = _battle._selectedTarget!
        let sd = seed(to: 6)
        var damage:CGFloat = 0
        var color = DamageColor.DAMAGE
        var type = DamageType.PHYSICAL
        var cfs = false
        if 1 == sd {
            damage = fireDamage(t)
            color = DamageColor.FIRE
            type = DamageType.FIRE
        } else if 2 == sd {
            damage = waterDamage(t)
            color = DamageColor.WATER
            type = DamageType.WATER
        } else if 0 == sd {
            damage = thunderDamage(t)
            color = DamageColor.THUNDER
            type = DamageType.THUNDER
        } else {
            damage = physicalDamage(t)
            cfs = true
        }
        _battle._curRole.actionAttack {
            if !self.hasPhysicalEvent(t: t, completion: completion) {
                t.actionAttacked {
                    t.showValue(value: damage, criticalFromSpell: cfs, damageType: type, textColor: color, completion: completion)
                }
                t.darkness4fifth()
            }
        }
    }
    
}

