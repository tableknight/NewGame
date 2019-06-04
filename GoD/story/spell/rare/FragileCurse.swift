//
//  FragileCurse.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class FragileCurse: Magical, Curse {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "虚弱诅咒"
        _description = "降低目标100%基础防御"
        _quality = Quality.RARE
    }
    override func cast(completion:@escaping () -> Void) {
        let t = _battle._selectedTarget!
        let c = _battle._curRole
        let this = self
        c.actionCast {
            if !this.statusMissed(baseline: 65, target: t, completion: completion) {
                t.actionWait {
                    let s = Status()
                    s._timeleft = this.getTimeleft()
                    s._type = Status.FRAGILE
                    s._labelText = "W"
                    t.addStatus(status: s)
                    t._extensions.defence -= t._unit._extensions.defence
                    s.timeupAction = {
                        t._extensions.defence += t._unit._extensions.defence
                    }
                    completion()
                }
                t.mixed2(index: 13)
            }
        }
    }
    
    override func findTarget() {
        findSingleTargetNotBlocked()
    }
}
