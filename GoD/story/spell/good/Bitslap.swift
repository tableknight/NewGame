//
//  Bitslap.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/18.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Bitslap: Physical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.Bitslap
        _quality = Quality.GOOD
        _name = "一击必中"
        _description = "造成攻击70%的物理伤害，本次攻击必定命中"
        _rate = 0.7
        _cooldown = 1
    }
    override func cast(completion:@escaping () -> Void) {
        let b = _battle
        let c = b._curRole
        let this = self
        c.actionAttack {
            this.attack {
                completion()
            }
        }
    }
    
    private func attack(completion:@escaping () -> Void) {
        let b = _battle
        let t = b._selectedTarget!
        let damage = physicalDamage(t)
        if !hadSpecialAction(t:t, completion: completion) {
            t.actionAttacked(defend: t.isDefend, completion: {
                t.showValue(value: damage) {
                    completion()
                }
            })
            t.blow()
        }
    }
    
}
