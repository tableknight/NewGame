//
//  BeingTired.swift
//  GoD
//
//  Created by kai chen on 2019/7/6.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class BeingTired: Magical, BossOnly {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "疲倦"
        _description = "进入疲倦状态，降低50%的护甲"
        _quality = Quality.NORMAL
        _cooldown = 3
        autoCast = true
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        c.actionWait {
            let s = Status()
            s._type = "_being_tired"
            let v = c.getDefence() * 0.5
            c._valueUnit._extensions.defence -= v
            s._timeleft = 3
            s.timeupAction = {
                c._valueUnit._extensions.defence += v
            }
            c.addStatus(status: s)
            completion()
        }
    }
    
    override func findTarget() {
    }
    
}

