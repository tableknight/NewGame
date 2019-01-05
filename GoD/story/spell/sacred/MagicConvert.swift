//
//  TurnAttack.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/20.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class MagicConvert: Magical {
    override init() {
        super.init()
        _cooldown = 3
        _quality = Quality.SACRED
        _name = "法术吸收"
        _description = "对己方单位释放护盾，将下一次法术伤害转化为生命回复"
        targetEnemy = false
    }
    override func cast(completion:@escaping () -> Void) {
        //        let r = _battle._curRole
        let t = _battle._selectedTarget!
        removeSpecialStatus(t:t)
        let status = Status()
        status._type = Status.TURN_MAGIC
        status._timeleft = 2
        t.addStatus(status: status)
        
        let c = _battle._curRole
        c.actionCast {
            t.actionBuff {
                completion()
            }
        }
        
    }
}
