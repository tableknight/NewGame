//
//  Taunt.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/2.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Taunt: Magical {
    override init() {
        super.init()
        _quality = Quality.RARE
        _name = "嘲讽"
        _cooldown = 2
//        _rate = 0.8
        autoCast = true
        _description = "嘲讽所有敌方单位，被嘲讽单位有大概率只能对施法者发动普通攻击"
    }
    override func cast(completion:@escaping () -> Void) {
        let ts = _battle._selectedTargets
        let c = _battle._curRole
        let this = self
        c.actionCast {
            for t in ts {
                if !this.statusMissed(baseline: 60, target: t, bossImmnue: t._unit is Boss) {
                    let s = Status()
                    s._timeleft = 1
                    s._type = Status.TAUNTED
                    s._source = c
                    t.addStatus(status: s)
                    t.showText(text: "TAUNTED")
                }
            }
            setTimeout(delay: 1.5, completion: completion)
        }
    }
    override func findTarget() {
        findTargetPartAll()
    }
}
