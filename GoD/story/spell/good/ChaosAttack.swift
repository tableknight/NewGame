//
//  ChaosArrow.swift
//  GoD
//
//  Created by kai chen on 2019/2/12.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class ChaosAttack:Physical {
    override init() {
        super.init()
        _name = "混沌攻击"
        _description = "对目标造成攻击力75%的物理或元素伤害"
        _quality = Quality.GOOD
        _cooldown = 1
        autoCast = true
        _rate = 0.75
    }
    override func cast(completion: @escaping () -> Void) {
        let t = _battle._selectedTarget!
        let sd = seed(to: 6)
        var damage:CGFloat = 0
        var color = DamageColor.DAMAGE
        if 1 == sd {
            damage = fireDamage(t)
            color = DamageColor.FIRE
        } else if 2 == sd {
            damage = waterDamage(t)
            color = DamageColor.WATER
        } else if 0 == sd {
            damage = thunderDamage(t)
            color = DamageColor.THUNFER
        } else {
            damage = physicalDamage(t)
        }
        _battle._curRole.actionAttack {
            if !self.hasPhysicalEvent(t: t, completion: completion) {
                t.actionAttacked {
                    t.showValue(value: damage, isCritical: false, textColor: color, completion: completion)
                }
            }
        }
    }
    
}

