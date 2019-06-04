//
//  MultipleHit.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class MultipleHit: Physical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        isClose = true
        _quality = Quality.GOOD
        _cooldown = 1
        _rate = 0.25
        _name = "连击"
        _description = "对同一目标造成2-6次伤害，每次造成攻击25%的物理伤害"
    }
    override func cast(completion:@escaping () -> Void) {
        let times = seed(min: 2, max: 7)
        attack(time: times, completion: completion)
    }
    private func attack(time:Int, completion:@escaping () -> Void) {
        if time < 1 {
            completion()
            return
        }
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        let damage = physicalDamage(t)
        c.actionAttack {
            if !self.hadSpecialAction(t: t, completion: {
                self.attack(time: time - 1, completion: completion)
            }) {
                if !self.hasMissed(target: t, completion: {
                    self.attack(time: time - 1, completion: completion)
                }) {
                    t.actionAttacked {
                        t.showValue(value: damage) {
                            self.attack(time: time - 1, completion: completion)
                        }
                    }
                    t.attacked1()
                }
            }
        }
    }
    
}
