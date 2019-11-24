//
//  SoulSlay.swift
//  GoD
//
//  Created by kai chen on 2019/7/15.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class SoulSlay: Physical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        isClose = true
        _name = "灵魂撕裂"
        _description = "对目标造成60%攻击力的伤害，令其在3回合内 无法恢复生命"
        _rate = 0.6
        _quality = Quality.RARE
        _cooldown = 3
    }
    override func cast(completion:@escaping () -> Void) {
        let b = _battle!
        let c = b._curRole
        let t = b._selectedTarget!
        let damage = physicalDamage(t)
        c.actionAttack {
            if !self.hasPhysicalEvent(t: t, completion: completion) {
                t.darkness1f()
                t.actionAttacked {
                    t.showValue(value: damage) {
                        completion()
                    }
                    let s = Status()
                    s._type = Status.SOUL_SLAY
                    s._labelText = "S"
                    s._timeleft = 3
                    t.addStatus(status: s)
                }
            }
        }
    }
    
    
}

