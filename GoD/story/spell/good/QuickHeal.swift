//
//  QuickHeal.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/15.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class QuickHeal: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.QuickHeal
        _quality = Quality.GOOD
        targetEnemy = false
        _name = "快速治疗"
        _description = "恢复己方目标最大生命25%的生命值"
        canBeTargetSelf = true
    }
    override func cast(completion:@escaping () -> Void) {
        let t = _battle._selectedTarget!
        let h = t.getHealth() * 0.25
        let c = _battle._curRole
        c.actionCast {
            t.recovery2f {
                t.showValue(value: h) {
                    completion()
                }
            }
        }
    }
    
    override func findTarget() {
        findHpLowestUnit()
    }
    
}
