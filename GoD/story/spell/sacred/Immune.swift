//
//  Immune.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/22.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
//unchecked
class Immune: Magical {
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.Immune
        _tear = 1
        _name = "免疫"
        _description = "目标在本回合内，免疫所有控制和诅咒"
        targetAll = true
        canBeTargetSelf = true
        _quality = Quality.SACRED
        _cooldown = 3
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        let status = Status()
        status._type = Status.IMMUNE
        status._timeleft = 2
        status.inEndOfRound = {
            t.removeStatus(type: Status.IMMUNE)
        }
        t.addStatus(status: status)
        c.actionCast {
            t.stateUp2() {
                completion()
            }
        }
    }
    
}

