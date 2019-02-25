//
//  IceSpear.swift
//  GoD
//
//  Created by kai chen on 2019/2/21.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class IceSpear: Magical {
    override init() {
        super.init()
        isWater = true
        _name = "冰刺"
        _description = "对目标造成精神10%的冰冷伤害，冻结目标，如果目标已冻结，则造成精神40%的寒冰伤害"
        _rate = 0.1
        _quality = Quality.GOOD
        _cooldown = 1
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        if t.hasStatus(type: Status.FREEZING) {
            _rate = 0.4
        }
        let damage = waterDamage(t)
        c.actionCast {
            if !self.hadSpecialAction(t: t, completion: completion) {
                t.actionAttacked {
                    t.showValue(value: damage) {
                        if !t.hasStatus(type: Status.FREEZING) {
                            t.freezing()
                        }
                        completion()
                    }
                }
            }
        }
    }
    
}


