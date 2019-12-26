//
//  MakeEverythingRight.swift
//  GoD
//
//  Created by kai chen on 2019/7/11.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class MakeEverythingRight: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.MakeEverythingRight
        _cooldown = 3
        _name = "斗转星移"
        _description = "使己方所有单位立于不败之地"
        targetEnemy = false
        _quality = Quality.SACRED
        autoCast = true
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let ts = _battle._selectedTargets
        c.actionCast {
            for t in ts {
                let status = Status()
                status._type = Status.MAKE_EVERYTHING_RIGHT
                status._labelText = "E"
                status._timeleft = 4
            
                t.magic1f() {
                    t.addStatus(status: status)
                    
                }
            }
            
        }
        setTimeout(delay: 1.5, completion: completion)
    }
    override func findTarget() {
        findTargetPartAll()
    }
}
