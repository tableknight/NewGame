//
//  MessGhost.swift
//  GoD
//
//  Created by kai chen on 2019/7/14.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class MessGhost: Magical {
    override init() {
        super.init()
        _name = "鬼影重重"
        _description = "被诅咒的目标会收到两次法术伤害"
        _quality = Quality.RARE
        _cooldown = 3
    }
    override func cast(completion:@escaping () -> Void) {
        let b = _battle!
        let c = b._curRole
        let ts = _battle._selectedTargets
        c.actionCast {
            for t in ts {
                if !self.statusMissed(baseline: 35, target: t) {
                    t.actionDebuff {
                        let s = Status()
                        s._type = "_mess_ghost"
                        s._timeleft = 2
                        s._labelText = "G"
                        t.addStatus(status: s)
                    }
                }
            }
            setTimeout(delay: 2.2, completion: completion)
        }
        
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
