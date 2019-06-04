//
//  IceGuard.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/19.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class IceGuard: Magical {
    override init() {
        super.init()
        _quality = Quality.RARE
        _name = "寒冰护盾"
        _description = "对自己释放护盾，提升50%防御，持续5回合，有一定几率降低攻击者10点速度"
        targetEnemy = false
        canBeTargetSelf = true
        _cooldown = 3
        autoCast = true
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        
        c.actionCast {
            c.actionBuff {
                completion()
                let status = Status()
                status._type = Status.ICE_GUARD
                status._labelText = "G"
                status._timeleft = 5
                c.addStatus(status: status)
            }
        }
        
    }
    override func findTarget() {
        
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
