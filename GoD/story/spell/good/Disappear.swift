//
//  Disappear.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/7.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Disappear: Magical {
    override init() {
        super.init()
        _cooldown = 3
        _name = "消失"
        _description = "对自己释放消失，提升50点闪避，持续5回合"
        targetEnemy = false
        _quality = Quality.GOOD
        autoCast = true
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        
        let status = Status()
        status._type = Status.DISAPPEAR
        status._timeleft = 5
        c.addStatus(status: status)
        c._extensions.avoid += 50
        status.timeupAction = {
            c._extensions.avoid -= 50
        }
        c.actionCast {
            c.actionBuff {
                completion()
            }
        }
    }
    override func findTarget() {
        _battle._selectedTarget = _battle._curRole
    }
}
