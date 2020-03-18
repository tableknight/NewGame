//
//  LowlevelFlame.swift
//  GoD
//
//  Created by kai chen on 2019/1/27.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class LowlevelFlame: Magical {
    override init() {
        super.init()
        _id = Spell.LowlevelFlame
        isFire = true
        _name = "低阶火焰"
        _description = "对目标造成精神60%的火焰伤害"
        _rate = 0.6
        _quality = Quality.NORMAL
        _cooldown = 0
        _mpCost = 5 * _costRate
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        if c.amuletIs(Sacred.LavaCrystal) {
            _rate = 1.1
        }
        c.actionCast {
            self.attack {
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
                }
            }
            t.hitFire()
            t.play("fire")
//            t.flame1(index: 0)
        }
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}


