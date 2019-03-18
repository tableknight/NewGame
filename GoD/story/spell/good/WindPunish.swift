//
//  WindPunish.swift
//  GoD
//
//  Created by kai chen on 2019/3/16.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class WindPunish: Magical {
    override init() {
        super.init()
        isWater = true
        _name = "风的惩罚"
        _description = "对目标和身后目标造成精神60%的冰冷伤害"
        _rate = 0.6
        _quality = Quality.GOOD
        _cooldown = 1
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        let damage = waterDamage(t)
        c.actionCast {
            if !self.hadSpecialAction(t: t, completion: completion) {
                t.actionAttacked {
                    t.showValue(value: damage) {
                        completion()
                    }
                }
            }
            let seat = self.getUnitBehindTarget(seat: t._unit._seat)
            let tb = self._battle.getUnitBySeat(seat: seat)
            if nil != tb {
                let damage = self.waterDamage(tb!)
                if !self.hadSpecialAction(t: tb!, completion: {}) {
                    tb!.actionAttacked {
                        tb!.showValue(value: damage)
                    }
                }
            }
        }
    }
    
}


