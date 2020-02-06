//
//  Taunt.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/2.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Taunt: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.Taunt
        _quality = Quality.RARE
        _name = "嘲讽"
        _cooldown = 1
//        _rate = 0.8
        autoCast = true
        _description = "嘲讽所有敌方单位，被嘲讽单位只能对施法者发动普通攻击"
        cost(value: 15)
    }
    override func cast(completion:@escaping () -> Void) {
        let ts = _battle._selectedTargets
        let c = _battle._curRole
        let this = self
        c.actionCast {
            for t in ts {
                if !this.statusMissed(baseline: 60, target: t, bossImmnue: t._unit is Boss) {
                    t.absorbt() {
                        let s = Status()
                        s._timeleft = 1
                        s._labelText = "T"
                        s._type = Status.TAUNTED
                        s._source = c
                        t.addStatus(status: s)
//                        t.showText(text: "TAUNTED")
                    }
                }
            }
            setTimeout(delay: 2, completion: completion)
        }
    }
    override func findTarget() {
        findTargetPartAll()
    }
}
