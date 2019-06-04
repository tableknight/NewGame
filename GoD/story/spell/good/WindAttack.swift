//
//  WindAttack.swift
//  GoD
//
//  Created by kai chen on 2019/5/7.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class WindAttack: Physical {
    override init() {
        super.init()
        isClose = true
        _name = "顺风击"
        _description = "对目标造成攻击80%的物理伤害，对身后单位造成本次伤害的一半"
        _rate = 0.8
        _quality = Quality.GOOD
        _cooldown = 1
    }
    override func cast(completion:@escaping () -> Void) {
        let b = _battle!
        let c = b._curRole
        c.actionAttack {
            self.attack {
                completion()
            }
        }
    }
    
    private func attack(completion:@escaping () -> Void) {
        let b = _battle!
        let t = b._selectedTarget!
        let damage = physicalDamage(t)
        if !hadSpecialAction(t:t, completion: completion) {
            if !hasMissed(target: t, completion: completion) {
                t.actionAttacked {
                    t.showValue(value: damage) {
                        completion()
                    }
                }
                t.attacked1()
                let seat = self.getUnitBehindTarget(seat: t._unit._seat)
                let tb = self._battle.getUnitBySeat(seat: seat)
                if nil != tb {
                    setTimeout(delay: 0.25, completion: {
                        let d2 = damage * 0.5
                        if !self.hadSpecialAction(t: tb!, completion: {}) {
                            tb!.actionAttacked {
                                tb!.showValue(value: d2)
                            }
                            tb!.attacked1()
                        }
                    })
                }
            }
        }
    }
    
    override func selectable() -> Bool {
        return _battle._curRole._unit.isClose()
        
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

