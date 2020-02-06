//
//  PoisonCurse.swift
//  GoD
//
//  Created by kai chen on 2019/8/18.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class PoisonCurse: Magical, Curse {
    override init() {
        super.init()
        _id = Spell.PoisonCurse
        _name = "毒咒"
        _description = "对目标下毒"
        _quality = Quality.NORMAL
        _cooldown = 0
        _mpCost = 5 * _costRate
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        c.actionCast {
            if !self.statusMissed(baseline: 85, target: t, bossImmnue: false, completion: completion) {
                t.statePoison() {
                    t.poisoning()
                }
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

