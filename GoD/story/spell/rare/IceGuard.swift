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
        _description = "对己方单位释放护盾，提升100%防御，持续5回合，有一定几率降低攻击者10点速度"
        targetEnemy = false
        canBeTargetSelf = true
    }
    override func cast(completion:@escaping () -> Void) {
        let t = _battle._selectedTarget!
        let status = Status()
        status._type = Status.ICE_GUARD
        status._timeleft = 5
        t.addStatus(status: status)
        
        let c = _battle._curRole
        c.actionCast {
            t.actionBuff {
                completion()
            }
        }
        
    }
}
