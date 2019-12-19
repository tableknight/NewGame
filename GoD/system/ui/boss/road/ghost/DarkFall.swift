//
//  DarkFall.swift
//  GoD
//
//  Created by kai chen on 2019/7/14.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class DarkFall: Magical {
    override init() {
        super.init()
        _name = "黑暗降临"
        _description = "降低所有目标的法术伤害，提升己方单位的法术伤害"
        _rate = 0.6
        _quality = Quality.RARE
        _cooldown = 3
    }
    override func cast(completion:@escaping () -> Void) {
        let b = _battle
        let c = b._curRole
        let ts = _battle._selectedTargets
        c.actionCast {
            for t in ts {
                if !self.statusMissed(baseline: 55, target: t) {
                    t.mixed2(index: 16) {
                        let s = Status()
                        s._type = "_dark_fall"
                        s._timeleft = 3
                        s._labelText = "F"
                        t._valueUnit._magical.damage -= 20
                        t._valueUnit._magical.resistance -= 20
                        s.timeupAction = {
                            t._valueUnit._magical.damage += 20
                            t._valueUnit._magical.resistance += 20
                        }
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

