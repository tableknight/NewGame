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
        _tear = 1
        _quality = Quality.RARE
        _name = "寒冰护盾"
        _description = "对自己释放护盾，提升100%防御，持续5回合，有一定几率降低攻击者10点速度"
        targetEnemy = false
        canBeTargetSelf = true
        _cooldown = 3
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let status = Status()
        status._type = Status.ICE_GUARD
        status._timeleft = 5
        c.addStatus(status: status)
        
        c.actionCast {
            c.actionBuff {
                completion()
            }
        }
        
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
