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
        _id = Spell.HorribleImage
        _cooldown = 3
        _name = "恐怖怪像"
        _description = "降低所有目标50%护甲和50%精神"
        _quality = Quality.RARE
        autoCast = true
        cost(value: 25)
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let ts = _battle._selectedTargets
        c.actionCast {
            for t in ts {
                if !self.statusMissed(baseline: 55, target: t) {
                    let status = Status()
                    status._type = "_horrible_image"
                    status._labelText = "I"
                    status._timeleft = 3
                    let v1 = t._unit._extensions.spirit * 0.5
                    let v2 = t._unit._extensions.defence * 0.5
                    t._valueUnit._extensions.spirit -= v1
                    t._valueUnit._extensions.defence -= v2
                    status.timeupAction = {
                        t._valueUnit._extensions.spirit += v1
                        t._valueUnit._extensions.defence += v2
                    }
                    t.stateSleepf() {
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
