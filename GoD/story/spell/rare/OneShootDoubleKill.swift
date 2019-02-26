//
//  OneShootDoubleKill.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class OneShootDoubleKill: Physical, BowSkill {
    
    override init() {
        super.init()
        _name = "穿刺射击"
        _description = "对目标和身后单位造成攻击60%的物理伤害"
        _quality = Quality.RARE
        _rate = 0.6
        _cooldown = 1
        isClose = false
    }
    
    override func cast(completion:@escaping () -> Void) {
        let b = _battle!
        let t = b._selectedTarget!
        let c = b._curRole
        //        let role = c._unit
        let this = self
        let seat = getUnitBeyondTarget(seat: t._unit._seat)
        let ts = getTargetsBySeats(seats: [seat])
        c.actionShoot {
            this.attack(t:t) {
                completion()
            }
            if ts.count > 0 {
                setTimeout(delay: 0.5, completion: {
                    this.attack(t: ts[0])
                })
            }
        }
    }
    
    private func attack(t:BUnit, completion:@escaping () -> Void = {}) {
        _damageValue = physicalDamage(t) * _rate
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
        return isWeaponBow()
    }
    override func findTarget() {
        findSingleTargetNotBlocked()
    }
}
