//
//  LowlevelFlame.swift
//  GoD
//
//  Created by kai chen on 2019/1/27.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class LowlevelFlame: Magical {
    override init() {
        super.init()
        isFire = true
        _name = "低阶火焰"
        _description = "对目标造成精神65%的火焰伤害"
        _rate = 0.65
        _quality = Quality.NORMAL
        _cooldown = 0
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let this = self
        c.actionCast {
            this.attack {
                completion()
            }
        }
    }
    
    func attack(completion:@escaping () -> Void) {
        let t = _battle._selectedTarget!
        _damageValue = fireDamage(t)
        let damage = _damageValue
        if !hadSpecialAction(t:t, completion: completion) {
            t.actionAttacked {
                t.showValue(value: damage) {
                    completion()
                }
            }
        }
    }
}


