//
//  SoulLash.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/19.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class SoulLash: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.SoulLash
        _name = "灵魂鞭笞"
        _description = "对目标造成精神80%的魔法伤害，有一定几率静默目标"
        _rate = 0.8
        _quality = Quality.SACRED
        _cooldown = 2
        cost(value: 12)
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
        let b = _battle
//        let c = _battle._curRole
        _damageValue = magicalDamage(t)
        let damage = _damageValue
        let this = self
        if !hadSpecialAction(t:t, completion: completion) {
            t.actionAttacked {
//                t.hpChange(value: damage)
                t.showValue(value: damage) {
                    if this.seed() < 25 && !t.isDead() {
                        b.silenceUnit(unit: t)
                        completion()
                    } else {
                        completion()
                    }
                }
                
            }
            t.stateDarkf()
        }
    }
    override func findTarget() {
        findSingleTargetNotBlocked()
    }
    
}


