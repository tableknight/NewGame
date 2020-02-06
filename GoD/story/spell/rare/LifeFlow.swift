//
//  LifeFlow.swift
//  GoD
//
//  Created by kai chen on 2019/11/6.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class LifeFlow: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.LifeFlow
        _name = "生命分涌"
        _description = "牺牲15%当前生命，作为额外精神。对目标造成精神100%的魔法伤害"
        _quality = Quality.RARE
        _cooldown = 1
        cost(value: 18)
    }
    override func getSelfSpirit() -> CGFloat {
        return _battle._curRole.getSpirit() + _battle._curRole.getHp() * 0.15
    }
    override func cast(completion: @escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        let selfDamage = -c.getHp() * 0.15
        let damage = magicalDamage(t)
        c.showValue(value: selfDamage) {
            c.actionCast {
                if !self.hadSpecialAction(t: t, completion: completion) {
                    t.actionAttacked {
                        t.showValue(value: damage) {
                            completion()
                        }
                    }
                    t.mixed2(index: 16)
                }
            }
            
        }
    }
}

