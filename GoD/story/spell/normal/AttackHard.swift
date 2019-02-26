//
//  AttackHard.swift
//  GoD
//
//  Created by kai chen on 2019/2/12.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class AttackHard:Physical {
    override init() {
        super.init()
        _name = "奋力一击"
        _description = "牺牲30点命中，对目标造成攻击105%的物理伤害"
        _quality = Quality.NORMAL
        _cooldown = 1
        _rate = 1.05
    }
    override func cast(completion: @escaping () -> Void) {
        let t = _battle._selectedTarget!
        _battle._curRole.actionAttack {
            if !self.hasPhysicalEvent(t: t, completion: completion) {
                let damage = self.physicalDamage(t)
                t.actionAttacked {
                    t.showValue(value: damage) {
                        completion()
                    }
                }
            }
        }
    }
    
    override func getAccuracy() -> CGFloat {
        return _battle._curRole.getAccuracy() - 30
    }
    
}
