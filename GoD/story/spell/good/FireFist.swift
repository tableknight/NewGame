//
//  FireFist.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class FireFist: Physical {
    override init() {
        super.init()
        isClose = true
        _name = "火焰掌"
        _description = "对目标造成攻击力60%的火焰伤害，需要空手"
        isFire = true
        _rate = 0.6
        _quality = Quality.GOOD
        _cooldown = 1
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
        let c = b._curRole
        //        let role = c._unit
        let fireRate = fireFactor(from: c, to: t)
        _damageValue = -c.getAttack() * fireRate * _rate
        let damage = _damageValue
        if !hadSpecialAction(t:t, completion: completion) {
            if !hasMissed(target: t, completion: completion) {
                t.actionAttacked(defend: t.isDefend) {
                    t.showValue(value: damage) {
                        completion()
                    }
                }
            }
        }
    }
    
    override func selectable() -> Bool {
        return isEmptyHand()
        
    }
}
