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
        _id = Spell.Heal
        _quality = Quality.NORMAL
        targetEnemy = false
        canBeTargetSelf = true
        _name = "恢复"
        _cooldown = 2
        _description = "恢复己方目标最大生命55%的生命值"
        _mpCost = 18 * _costRate
    }
    override func cast(completion:@escaping () -> Void) {
        let t = _battle._selectedTarget!
        let h = t.getHealth() * 0.55
        let c = _battle._curRole
        c.actionCast {
            t.recovery1f() {
                t.showValue(value: h) {
                    completion()
                }
            }
//            t.actionHealed {
//
//            }
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
