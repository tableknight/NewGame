//
//  HealAll.swift
//  GoD
//
//  Created by kai chen on 2019/11/6.
//  Copyright © 2019 Chen. All rights reserved.
//

class HealAll: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "群体治疗"
        _quality = Quality.SACRED
        _description = "恢复所有己方单位25%的最大生命"
        _cooldown = 3
        autoCast = true
        targetEnemy = false
    }
    override func cast(completion: @escaping () -> Void) {
        let c = _battle._curRole
        let ts = _battle._selectedTargets
        c.actionCast {
            for t in ts {
                t.actionHealed {
                    let value = t.getHealth() * 0.25
                    t.showValue(value: value)
                }
            }
            setTimeout(delay: 2.5, completion: completion)
        }
    }
    override func findTarget() {
        findTargetPartAll()
    }
}
