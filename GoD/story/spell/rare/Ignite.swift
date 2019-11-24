//
//  Ignite.swift
//  GoD
//
//  Created by kai chen on 2019/5/26.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class Ignite: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        isFire = true
        _name = "引爆"
        _description = "引爆所有点燃目标，每层燃烧效果造成精神50%的火焰伤害"
        _quality = Quality.RARE
        _cooldown = 0
        autoCast = true
        _rate = 0.5
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let ts = _battle._selectedTargets
        c.actionCast {
            for t in ts {
                if t.hasStatus(type: Status.BURNING) {
                    let bs = t.getStatus(type: Status.BURNING) as! BurningStatus
                    let damage = self.fireDamage(t) * bs._level
                    t.actionAttacked {
                        t.showValue(value: damage, criticalFromSpell: false, critical: false, damageType: DamageType.FIRE, textColor: DamageColor.FIRE)
                    }
                    t.removeStatus(type: Status.BURNING)
//                    t.flame1(index: 0, line: 2)
                    t.fire2f()
                }
            }
            setTimeout(delay: 1.5, completion: completion)
        }
    }
    
    override func findTarget() {
        findtargetAll()
    }
}

