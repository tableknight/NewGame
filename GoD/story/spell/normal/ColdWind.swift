//
//  ColdWind.swift
//  GoD
//
//  Created by kai chen on 2019/8/18.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class ColdWind: Magical {
    override init() {
        super.init()
        isWater = true
        _name = "凛风"
        _description = "对生命值最少的目标造成精神80%的b冰冷伤害"
        _rate = 0.8
        _quality = Quality.NORMAL
        _cooldown = 1
        autoCast = true
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        let d = self.waterDamage(t)
        c.actionCast {
            if !self.hadSpecialAction(t: t, completion: completion) {
                t.actionAttacked {
                    t.showValue(value: d, source: c, criticalFromSpell: false, critical: false, damageType: DamageType.WATER, textColor: DamageColor.WATER, completion: completion)
                }
                t.cure4()
            }
        }
    }
    
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    
    override func findTarget() {
        findHpLowestUnit()
    }
}



