//
//  DeathStrike.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/30.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class DeathStrike: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _quality = Quality.RARE
        _name = "死亡冲击"
        _cooldown = 2
        _rate = 0.6
        _description = "对目标造成精神60%的魔法伤害，每次偷取目标10点精神"
        targetEnemy = true
    }
    override func cast(completion:@escaping () -> Void) {
        let t = _battle._selectedTarget!
        let c = _battle._curRole
        _damageValue = magicalDamage(t)
        let damage = _damageValue
        let this = self
        c.actionCast {
            if !this.hadSpecialAction(t:t, completion: completion) {
                t.actionAttacked {
                    t.showValue(value: damage) {
                        t.showText(text:"SPIRIT -10", color: Colors.STATUS_CHANGE)
                        c.showText(text:"SPIRIT +10", color: Colors.STATUS_CHANGE, completion: completion)
                    }
                    t._extensions.spirit -= 10
                    c._extensions.spirit += 10
                    
                }
            }
        }
    }
}
