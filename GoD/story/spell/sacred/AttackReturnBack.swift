//
//  AttackReturnBack.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/21.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class AttackReturnBack: Magical {
    override init() {
        super.init()
        _tear = 1
        _name = "以牙还牙"
        _description = "对己方单位释放护盾，将下一次近战物理伤害反弹攻击者"
        targetEnemy = false
        _quality = Quality.SACRED
        _cooldown = 3
        canBeTargetSelf = true
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        removeSpecialStatus(t:t)
        let status = Status()
        status._type = Status.ATTACK_RETURN_BACK
        status._timeleft = 2
        t.addStatus(status: status)
        c.actionCast {
            t.actionBuff {
                completion()
            }
        }
    }
}
