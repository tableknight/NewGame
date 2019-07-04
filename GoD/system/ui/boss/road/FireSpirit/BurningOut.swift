//
//  BurningOut.swift
//  GoD
//
//  Created by kai chen on 2019/7/4.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class BurningOut: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        isFire = true
        _name = "燃烧殆尽"
        _description = "降低目标50点火焰强度和50点火焰抵抗"
        _quality = Quality.NORMAL
        _cooldown = 0
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        c.actionCast {
            if !self.statusMissed(baseline: 100, target: t, bossImmnue: false, completion: completion) {
                t.actionDebuff {
                    t._elementalPower.fire -= 50
                    t._elementalResistance.fire -= 50
                    let s = Status()
                    s._type = "_burning_out"
                    s._labelText = "O"
                    s._timeleft = 5
                    t.addStatus(status: s)
                    s.timeupAction = {
                        t._elementalPower.fire += 50
                        t._elementalResistance.fire += 50
                    }
                    t.showText(text: "BURNED") {
                        completion()
                    }
                }
            }
            
        }
    }
    
}

