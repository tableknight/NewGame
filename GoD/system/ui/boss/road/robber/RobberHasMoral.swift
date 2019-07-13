//
//  RobberHasMoral.swift
//  GoD
//
//  Created by kai chen on 2019/7/11.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class RobberHasMoral: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _cooldown = 3
        _name = "盗亦有道"
        _description = "提升自身50点精神和50点念力"
        targetEnemy = false
        _quality = Quality.GOOD
        autoCast = true
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        
        let status = Status()
        status._type = "_robber_has_moral"
        status._labelText = "M"
        status._timeleft = 5
        c._extensions.spirit += 50
        c._extensions.mind += 50
        status.timeupAction = {
            c._extensions.spirit -= 50
            c._extensions.mind -= 50
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

