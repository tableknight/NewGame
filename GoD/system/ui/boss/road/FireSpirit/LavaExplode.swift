//
//  BurnLeft.swift
//  GoD
//
//  Created by kai chen on 2019/7/4.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class LavaExplode: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        isFire = true
        _name = "熔岩暴击"
        _description = "对目标造成精神80%的火焰伤害，并将其引燃"
        _quality = Quality.GOOD
        _cooldown = 2
        _rate = 0.8
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        let damage = fireDamage(t)
        c.actionCast {
            if !self.hadSpecialAction(t: t, completion: completion) {
                t.flame1(index: 0, line: 1)
                t.actionAttacked {
                    t.showValue(value: damage, criticalFromSpell: false, critical: false, damageType: DamageType.FIRE, textColor: DamageColor.FIRE, completion: {})
                    if t.isDead() {
                        completion()
                    } else {
                        setTimeout(delay: 0.5, completion: {
                            if t.hasStatus(type: Status.BURNING) {
                                let s = t.getStatus(type: Status.BURNING) as! BurningStatus
                                let d = s._level * t.getHealth() * 0.05
                                t.showValue(value: -d, criticalFromSpell: false, critical: false, damageType: DamageType.FIRE, textColor: DamageColor.FIRE, completion: completion)
                            }
                        })
                    }
                }
            }
        }
    }
    
}


