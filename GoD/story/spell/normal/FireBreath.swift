//
//  FireBreath.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/23.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class FireBreath: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.FireBreath
        isFire = true
        _name = "火焰呼吸"
        _description = "对目标造成精神75%的火焰伤害， 有一定几率点燃目标"
        _rate = 0.75
        _quality = Quality.NORMAL
        _cooldown = 1
        _mpCost = 10 * _costRate
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let this = self
        c.actionCast {
            this.attack {
                completion()
            }
        }
    }
    
    func attack(completion:@escaping () -> Void) {
        let t = _battle._selectedTarget!
        _damageValue = fireDamage(t)
        let damage = _damageValue
        if !hadSpecialAction(t:t, completion: completion) {
            t.actionAttacked {
                t.showValue(value: damage, damageType: DamageType.FIRE, textColor: ElementColor.FIRE) {
                    completion()
//                    if t.ringIs(FireCore.EFFECTION) {
//                        t.burning()
//                    } else {
//                        if self.d3() {
//                            t.burning()
//                        }
//                    }
                }
            }
            t.breath()
        }
    }
}
