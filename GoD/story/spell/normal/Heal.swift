//
//  Heal.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/24.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Heal: Magical {
    override init() {
        super.init()
        _quality = Quality.NORMAL
        targetEnemy = false
        canBeTargetSelf = true
        _name = "治疗"
        _cooldown = 2
        _description = "恢复己方目标最大生命50%的生命值"
    }
    override func cast(completion:@escaping () -> Void) {
        let t = _battle._selectedTarget!
        let h = t.getHealth() * 0.5
        let c = _battle._curRole
        c.actionCast {
            t.actionHealed {
                t.showValue(value: h) {
                    completion()
                }
            }
        }
    }
    
    override func findTarget() {
        findHpLowestUnit()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
