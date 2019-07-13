//
//  ThrowWeapon.swift
//  GoD
//
//  Created by kai chen on 2019/7/8.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class ThrowWeapon: Physical, BossOnly {
    override init() {
        super.init()
        _name = "投掷暗器"
        _description = "对随机目标造成攻击力80%的物理伤害，对其身后目标造成攻击力160%物理伤害"
        _quality = Quality.SACRED
        _cooldown = 2
        _rate = 0.8
        isClose = false
        autoCast = true
    }
    override func cast(completion:@escaping () -> Void) {
        let b = _battle!
        let t = b._selectedTarget!
        let c = b._curRole
        let damage = physicalDamage(t)
        c.actionShoot {
            if !self.hasPhysicalEvent(t: t) {
                t.actionAttacked {
                    t.showValue(value: damage)
                }
                let ts = self.getUnitBehindTarget(seat: t._unit._seat)
                let t2 = b.getUnitBySeat(seat: ts)
                if nil != t2 {
                    self._rate = 1.6
                    let d2 = self.physicalDamage(t2!)
                    if !self.hasPhysicalEvent(t: t2!) {
                        t2!.showValue(value: d2)
                    }
                }
            }
            setTimeout(delay: 2.1, completion: completion)
        }
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override func findTarget() {
        findRandomTargetInLineFirst()
        
    }
}
