//
//  MightOfOaks.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/8/1.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class MightOfOaks: Magical {
    override init() {
        super.init()
        _name = "橡树之力"
        _description = "对己方目标释放橡树魔法，减少15%物理伤害，持续5回合"
        _tear = 1
        _quality = Quality.GOOD
        targetEnemy = false
        canBeTargetSelf = true
        _cooldown = 1
    }
    override func cast(completion: @escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        c.actionCast {
            t.actionBuff {
                let s = Status()
                s._type = Status.MIGHT_OF_OAKS
                s._timeleft = 5
                t.addStatus(status: s)
                completion()
            }
        }
    }
    override func findTarget() {
        findSingleTargetNotBlocked()
    }
}
