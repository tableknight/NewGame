//
//  LastChance.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/18.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class LastChance: Physical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "殊死一搏"
        _description = "对目标造成攻击300%的物理伤害，或者为目标恢复75%最大生命"
        _quality = Quality.GOOD
        _cooldown = 3
        _rate = 3
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        _damageValue = physicalDamage(t)
        let damage = _damageValue
        let this = self
        c.actionAttack {
            if !this.hadSpecialAction(t:t, completion: completion) {
                if !this.hasMissed(target: t, completion: completion) {
                    if this.d2() {
                        t.actionAttacked(defend: t.isDefend, completion: {
                            t.showValue(value: damage) {
                                completion()
                            }
                        })
                        t.attacked1()
                    } else {
                        let heal = t.getHealth() * 0.75
                        t.showValue(value: heal) {
                            completion()
                        }
                    }
                }
            }
        }
    }
}
