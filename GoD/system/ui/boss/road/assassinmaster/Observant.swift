//
//  Observant.swift
//  GoD
//
//  Created by kai chen on 2019/7/8.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class Observant: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _cooldown = 3
        _name = "敏锐"
        _description = "提升自身50点暴击和100点毁灭"
        targetEnemy = false
        _quality = Quality.GOOD
        autoCast = true
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        
        let status = Status()
        status._type = "_observant"
        status._labelText = "O"
        status._timeleft = 5
        c._extensions.critical += 50
        c._extensions.destroy += 100
        status.timeupAction = {
            c._extensions.critical -= 50
            c._extensions.destroy -= 100
        }
        c.actionCast {
            c.actionBuff {
                c.addStatus(status: status)
                completion()
            }
        }
    }
    override func findTarget() {
    }
}
