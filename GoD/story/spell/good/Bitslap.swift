//
//  Bitslap.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/18.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Bitslap: Physical {
    override init() {
        super.init()
        _quality = Quality.GOOD
        targetEnemy = true
        _name = "一击必中"
        _description = "造成攻击力90%的物理伤害，本次攻击必定命中"
    }
    override func cast(completion:@escaping () -> Void) {
        let b = _battle!
        let c = b._curRole
        let this = self
        c.actionAttack {
            this.attack {
                completion()
            }
        }
    }
    
    private func attack(completion:@escaping () -> Void) {
        let b = _battle!
        let t = b._selectedTarget!
        _damageValue = physicalDamage(t)
        let damage = _damageValue
        if !hadSpecialAction(t:t, completion: completion) {
            t.actionAttacked(defend: t.isDefend, completion: {
                t.showValue(value: damage) {
                    completion()
                }
            })
        }
    }
    
}
