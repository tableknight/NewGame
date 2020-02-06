//
//  BurnHeart.swift
//  GoD
//
//  Created by kai chen on 2019/7/4.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class BurnHeart: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        isFire = true
        _name = "烈焰焚心"
        _description = "对目标造成精神80%的火焰伤害，每一层燃烧效果为施法者恢复5%的最大生命"
        _quality = Quality.SACRED
        _cooldown = 3
        _rate = 0.8
        cost(value: 20)
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        let damage = fireDamage(t)
        c.actionCast {
            if !self.hadSpecialAction(t: t, completion: completion) {
                t.magic2t()
                t.actionAttacked {
                    t.showValue(value: damage, criticalFromSpell: false, critical: false, damageType: DamageType.FIRE, textColor: DamageColor.FIRE, completion: completion)
                    setTimeout(delay: 0.5, completion: {
                        if t.hasStatus(type: Status.BURNING) {
                            let s = t.getStatus(type: Status.BURNING) as! BurningStatus
                            let d = s._level * c.getHealth() * 0.05
                            c.showValue(value: d)
                        }
                    })
                }
            }
            
        }
    }
    
}
