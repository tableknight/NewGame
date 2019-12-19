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
        _id = Spell.IceSpear
        isWater = true
        _name = "冰刺"
        _description = "对目标造成精神30%的冰冷伤害，冻结目标，如果目标已冻结，则造成4倍伤害"
        _rate = 0.3
        _quality = Quality.GOOD
        _cooldown = 0
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        _rate = 0.3
        if t.hasStatus(type: Status.FREEZING) {
            _rate = 1.2
        }
        let damage = waterDamage(t)
        c.actionCast {
            if !self.hadSpecialAction(t: t, completion: completion) {
                t.actionAttacked {
                    t.showValue(value: damage, damageType: DamageType.WATER, textColor: ElementColor.WATER) {
                        if !t.hasStatus(type: Status.FREEZING) {
                            t.freezing()
                        }
                        completion()
                    }
                }
                t.water3()
            }
        }
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}


