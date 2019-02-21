//
//  FireBreath.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/23.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class FireBreath: Magical {
    override init() {
        super.init()
        isFire = true
        _name = "火焰呼吸"
        _description = "对目标造成精神25%的火焰伤害， 有一定几率点燃目标"
        _rate = 0.25
        _quality = Quality.NORMAL
        _cooldown = 1
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
                    if self.d3() {
                        t.burning()
                    }
                }
            }
        }
    }
}
