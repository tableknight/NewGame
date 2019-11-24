//
//  NervousPoison.swift
//  GoD
//
//  Created by kai chen on 2019/7/11.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class NervousPoison: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _cooldown = 3
        _name = "神经毒素"
        _description = "使目标有一定几率麻痹，持续3回合"
        _quality = Quality.RARE
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
//        let status = Status()
//        status._type = Status.NERVOUS_POISON
//        status._labelText = "P"
//        status._timeleft = 3
        c.actionCast {
            if !self.statusMissed(baseline: 85, target: t, completion: completion) {
                t.statePoison() {
//                    t.addStatus(status: status)
                    t.poisoning()
                    completion()
                }
            }
        }
    }
    override func findTarget() {
        findSingleTargetNotBlocked()
    }
}
