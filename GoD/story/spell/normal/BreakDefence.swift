//
//  BreakDefence.swift
//  GoD
//
//  Created by kai chen on 2019/2/12.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class BreakDefence:Physical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "崩击"
        _description = "破防，并对其造成100%-200%攻击力的物理伤害，需要近战"
        _quality = Quality.NORMAL
        _cooldown = 0
    }
    override func cast(completion: @escaping () -> Void) {
        let t = _battle._selectedTarget!
        _rate = seed(min: 100, max: 200).toFloat() * 0.01
        _battle._curRole.actionAttack {
            if t.isDefend {
                t.isDefend = false
                let damage = self.physicalDamage(t)
                t.isDefend = false
                if !self.hadSpecialAction(t: t, completion: completion) {
                    t.actionAttacked {
                        t.showValue(value: damage) {
                            completion()
                        }
                    }
                    t.attacked1()
                }
            } else {
                t.showMiss {
                    completion()
                }
            }
        }
    }
    
    override func selectable() -> Bool {
        return _battle._curRole._unit.isClose()
    }
    
}

