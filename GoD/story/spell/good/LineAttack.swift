//
//  LineAttack.swift
//  GoD
//
//  Created by kai chen on 2019/11/3.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class LineAttack: Physical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "横扫千军"
        _description = "对目标同一行单位造成攻击55%的物理伤害"
        _rate = 0.55
        _quality = Quality.GOOD
        _cooldown = 1
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let ss = getUnitsInRowOf(seat: _battle._selectedTarget!._unit._seat)
        var ts = Array<BUnit>()
        for s in ss {
            let u = _battle.getUnitBySeat(seat: s)
            if u != nil {
                ts.append(u!)
            }
        }
        c.actionAttack {
            for t in ts {
                let damage = self.physicalDamage(t)
                if !self.hadSpecialAction(t: t) {
                    if !self.hasMissed(target: t) {
                        t.actionAttacked {
                            t.showValue(value: damage, criticalFromSpell: false, critical: self.beCritical)
                        }
                        t.attacked1()
                    }
                }
            }
            setTimeout(delay: 2.5, completion: completion)
        }
    }
    override func selectable() -> Bool {
        return _battle._curRole._unit.isClose()
    }
}
