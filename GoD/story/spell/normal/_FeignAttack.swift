//
//  FeignAttack.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/20.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class FeignAttack: Physical {
    override init() {
        super.init()
        isClose = true
        _quality = Quality.NORMAL
        _cooldown = 1
        _name = "佯攻"
        _rate = 2
        _description = "对目标相邻随机单位造成攻击200%的物理伤害"
    }
    override func cast(completion:@escaping () -> Void) {
        var t = _battle._selectedTarget!
        let c = _battle._curRole
        let this = self
        c.actionAttack {
            let seat = t._unit._seat
            let seats = [this.getUnitBeyondTarget(seat: seat), this.getUnitUnderTarget(seat: seat), this.getUnitInTheLeftOfTarget(seat: seat), this.getUnitInTheRightOfTarget(seat: seat)]
            let ts = this.getTargetsBySeats(seats: seats)
            if ts.count > 0 {
                t = ts.one()
                let damage = self.physicalDamage(t)
                t.actionAttacked(defend: t.isDefend) {
                    t.showValue(value: damage) {
                        completion()
                    }
                }
                t.attacked1()
            } else {
                t.showMiss {
                    completion()
                }
            }
        }
        
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    
}
