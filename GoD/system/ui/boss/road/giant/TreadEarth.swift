//
//  TreadEarth.swift
//  GoD
//
//  Created by kai chen on 2019/7/6.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class TreadEarth: Physical, BossOnly {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.TreadEarth
        _name = "裂地重踩"
        _description = "对所有敌方单位造成150%攻击力的物理伤害"
        _quality = Quality.SACRED
        _cooldown = 3
        _rate = 1.5
        isClose = false
        autoCast = true
        cost(value: 30)
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let ts = _battle._selectedTargets
        c.actionShoot {
            c.earth5()
            for t in ts {
                let damage = self.physicalDamage(t)
                if !self.hasPhysicalEvent(t: t) {
                    t.actionAttacked {
                        t.showValue(value: damage)
                    }
                }
            }
            setTimeout(delay: 2.1, completion: completion)
        }
    }
    
    override func findTarget() {
        findtargetAll()
    }
    
}

