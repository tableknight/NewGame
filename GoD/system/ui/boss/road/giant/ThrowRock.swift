//
//  ThrowRock.swift
//  GoD
//
//  Created by kai chen on 2019/7/6.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class ThrowRock: Magical, BossOnly {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.ThrowRock
        _name = "巨石投掷"
        _description = "向目标投掷一块巨大的岩石，造成攻击力180%的物理伤害"
        _quality = Quality.NORMAL
        _cooldown = 1
        isClose = false
        cost(value: 18)
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        let damage = physicalDamage(t)
        c.actionShoot {
            if !self.hasPhysicalEvent(t: t, completion: completion) {
                t.actionAttacked {
                    t.showValue(value: damage) {
                        completion()
                    }
                }
                t.hit2()
            }
        }
    }
    
    override func findTarget() {
        findSingleTargetNotBlocked()
    }
    
}


