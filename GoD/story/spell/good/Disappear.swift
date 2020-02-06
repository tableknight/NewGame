//
//  Disappear.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/7.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Disappear: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.Disappear
        _cooldown = 3
        _name = "影匿"
        _description = "对自己释放法术，使自己融入周围影子之中，提升50点闪避，持续5回合"
        targetEnemy = false
        _quality = Quality.GOOD
        autoCast = true
        _mpCost = 20 * _costRate
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        
        let status = Status()
        status._type = Status.DISAPPEAR
        status._labelText = "H"
        status._timeleft = 5
        c._valueUnit._extensions.avoid += 50
        status.timeupAction = {
            c._valueUnit._extensions.avoid -= 50
        }
        c.actionCast {
            c.revival1f() {
                c.addStatus(status: status)
                completion()
            }
        }
    }
    override func findTarget() {
    }
}
