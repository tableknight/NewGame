//
//  Petrify.swift
//  GoD
//
//  Created by kai chen on 2019/5/29.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class Petrify: Magical, Curse {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
//        _id = Spell.
        _name = "石化"
        _description = "诅咒目标，使其变成一块石头，持续2回合"
        _quality = Quality.NORMAL
        _cooldown = 0
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        c.actionCast {
            if !self.statusMissed(baseline: 80, target: t, bossImmnue: true, completion: completion) {
                t.actionDebuff {
                    t.petrify()
                    completion()
                }
            }
        }
    }
    
    override func findTarget() {
        findSingleTargetNotBlocked()
    }
}

