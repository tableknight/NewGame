//
//  LifeDraw.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class LifeDraw: Magical {
    override init() {
        super.init()
        _name = "生命虹吸"
        _description = "对目标造成精神80%的魔法伤害，回复造成伤害的50%"
        _rate = 0.8
        _quality = Quality.SACRED
        _cooldown = 3
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let this = self
        c.actionCast {
            this.attack {
                completion()
            }
        }
    }
    
    func attack(completion:@escaping () -> Void) {
        let t = _battle._selectedTarget!
        let c = _battle._curRole
        _damageValue = magicalDamage(t)
        let damage = _damageValue
        if !hadSpecialAction(t:t, completion: completion) {
            t.actionAttacked {
                t.showValue(value: damage)
                setTimeout(delay: 0.5, completion: {
                    c.showValue(value: -damage * 0.5) {
                        completion()
                    }
                })
            }
            t.mixed2(index: 2)
        }
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

