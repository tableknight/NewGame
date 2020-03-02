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
        _id = Spell.FragileCurse
        _name = "虚弱诅咒"
        _description = "降低目标50%的护甲和50%的攻击力"
        _quality = Quality.RARE
        cost(value: 5)
    }
    override func cast(completion:@escaping () -> Void) {
        let t = _battle._selectedTarget!
        let c = _battle._curRole
        let this = self
        c.actionCast {
            t.stateDown3f() {
                if !this.statusMissed(baseline: 65, target: t, completion: completion) {
                
                    let s = Status()
                    s._timeleft = this.getTimeleft()
                    s._type = Status.FRAGILE
                    s._labelText = "W"
                    t.addStatus(status: s)
                    let def = t._unit._extensions.defence * 0.5
                    t._valueUnit._extensions.defence -= def
                    let atk = t._unit._extensions.attack * 0.5
                    t._valueUnit._extensions.attack -= atk
                    s.timeupAction = {
                        t._valueUnit._extensions.defence += def
                        t._valueUnit._extensions.attack += atk
                    }
                    completion()
                }
//                t.mixed2(index: 13)
            }
        }
    }
    
    override func findTarget() {
        findSingleTargetNotBlocked()
    }
}
