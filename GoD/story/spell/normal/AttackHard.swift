//
//  AttackHard.swift
//  GoD
//
//  Created by kai chen on 2019/2/12.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class AttackHard:Physical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "奋力一击"
        _description = "牺牲30点命中，对目标造成攻击125%的物理伤害"
        _quality = Quality.NORMAL
        _cooldown = 1
        _rate = 1.25
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
                t.attacked1()
            }
        }
    }
    
    override func getAccuracy() -> CGFloat {
        return _battle._curRole.getAccuracy() - 30
    }
    
}
