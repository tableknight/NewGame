//
//  FlashPowder.swift
//  GoD
//
//  Created by kai chen on 2019/7/8.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class FlashPowder: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _cooldown = 3
        _name = "闪光粉"
        _description = "降低敌方所有单位75点命中"
        targetEnemy = true
        _quality = Quality.GOOD
        autoCast = true
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let ts = _battle._selectedTargets
        c.actionShoot {
            for t in ts {
                if !self.hasMissed(target: t) {
                    t.hit1() {
                        let status = Status()
                        status._type = "_flash_powder"
                        status._labelText = "F"
                        status._timeleft = 3
                        t._extensions.accuracy -= 75
                        status.timeupAction = {
                            t._extensions.accuracy += 75
                        }
                        t.addStatus(status: status)
                    }
                }
            }
            setTimeout(delay: 2.1, completion: completion)
        }
    }
    override func findTarget() {
        findTargetPartAll()
    }
}

