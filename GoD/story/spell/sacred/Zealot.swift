//
//  Zealot.swift
//  GoD
//
//  Created by kai chen on 2019/7/30.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class Zealot:Physical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.Zealot
        _name = "狂战士"
        _description = "对目标造成攻击100%的物理伤害，对周围单位造成50%的分裂伤害"
        _quality = Quality.SACRED
        _cooldown = 2
        _rate = 1
    }
    override func cast(completion: @escaping () -> Void) {
        let t = _battle._selectedTarget!
        let c = _battle._curRole
        c.actionAttack {
            let damage = self.physicalDamage(t)
            if !self.hasPhysicalEvent(t: t, completion: completion) {
                t.attacked1()
                t.actionAttacked {
                    t.showValue(value: damage)
                }
                setTimeout(delay: 0.25, completion: {
                    self._damageValue = damage * 0.5
                    let l = self.getUnitInTheLeftOfTarget(seat: t._unit._seat)
                    let r = self.getUnitInTheRightOfTarget(seat: t._unit._seat)
                    let b = self.getUnitBehindTarget(seat: t._unit._seat)
                    let ts = self.getTargetsBySeats(seats: [l, r, b])
                    var delay:CGFloat = 0
                    if ts.count > 0 {
                        delay = 1.3
                        for t0 in ts {
                            if !self.hasPhysicalEvent(t: t0) {
                                t0.attacked1()
                                t0.actionAttacked {
                                    t0.showValue(value: self._damageValue)
                                }
                            }
                        }
                    }
                    
                    
                    setTimeout(delay: delay, completion: completion)
                })
            }
        }
        
    }
    override func selectable() -> Bool {
        return _battle._curRole.isClose()
    }
}

