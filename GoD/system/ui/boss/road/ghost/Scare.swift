//
//  Scare.swift
//  GoD
//
//  Created by kai chen on 2019/7/15.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class Sacre: Physical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        isClose = true
        _name = "恐吓"
        _description = "降低目标100%防御"
        _quality = Quality.NORMAL
        _cooldown = 1
    }
    override func cast(completion:@escaping () -> Void) {
        let b = _battle!
        let c = b._curRole
        let t = b._selectedTarget!
        c.actionCast {
            if !self.statusMissed(baseline: 75, target: t, completion: completion) {
                t.actionDebuff {
                    let s = Status()
                    s._type = "_scared"
                    s._labelText = "A"
                    s._timeleft = 3
                    let v = t._unit._extensions.defence
                    t._extensions.defence -= v
                    s.timeupAction = {
                        t._extensions.defence += v
                    }
                    t.addStatus(status: s)
                    completion()
                }
            }
        }
    }
    
    
}

