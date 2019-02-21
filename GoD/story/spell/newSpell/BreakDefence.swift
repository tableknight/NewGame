//
//  BreakDefence.swift
//  GoD
//
//  Created by kai chen on 2019/2/12.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class BreakDefence:Physical {
    override init() {
        super.init()
        _name = "气功波"
        _description = "对防御目标造成50%-100%攻击力的物理伤害"
        _quality = Quality.NORMAL
        _cooldown = 0
    }
    override func cast(completion: @escaping () -> Void) {
        let t = _battle._selectedTarget!
        _rate = seed(min: 50, max: 100).toFloat() * 0.01
        _battle._curRole.actionAttack {
            if t.isDefend {
                let damage = self.physicalDamage(t)
                t.isDefend = false
                if !self.hasPhysicalEvent(t: t, completion: completion) {
                    t.actionAttacked {
                        t.showValue(value: damage) {
                            completion()
                        }
                    }
                }
            } else {
                t.showMiss {
                    completion()
                }
            }
        }
    }
    
}

