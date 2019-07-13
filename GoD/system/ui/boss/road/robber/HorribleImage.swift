//
//  HorribleImage.swift
//  GoD
//
//  Created by kai chen on 2019/7/11.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class HorribleImage: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _cooldown = 3
        _name = "恐怖怪像"
        _description = "降低所有目标50%防御和50%精神"
        _quality = Quality.RARE
        autoCast = true
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let ts = _battle._selectedTargets
        c.actionCast {
            for t in ts {
                let status = Status()
                status._type = "_horrible_image"
                status._labelText = "I"
                status._timeleft = 3
                let v1 = t._unit._extensions.spirit * 0.5
                let v2 = t._unit._extensions.defence * 0.5
                t._extensions.spirit -= v1
                t._extensions.defence -= v2
                status.timeupAction = {
                    t._extensions.spirit += v1
                    t._extensions.defence += v2
                }
                if !self.statusMissed(baseline: 55, target: t) {
                    t.actionDebuff {
                        t.addStatus(status: status)
                    }
                }
            }
            setTimeout(delay: 2.2, completion: completion)
        }
    }
    override func findTarget() {
        findTargetPartAll()
    }
}
