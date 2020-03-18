//
//  TrueSight.swift
//  GoD
//
//  Created by kai chen on 2019/2/14.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class TrueSight:Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.TrueSight
        _name = "恶魔炸弹"
        _description = "对恶魔造成精神200%的魔法伤害，对其他种族无效"
        _quality = Quality.GOOD
        _cooldown = 1
        _mpCost = 10 * _costRate
    }
    override func cast(completion: @escaping () -> Void) {
        let t = _battle._selectedTarget!
        let damage = t._unit._race == EvilType.DEMON ? magicalDamage(t) : 0
        _battle._curRole.actionCast {
            t.stateDown3s()
            if !self.hadSpecialAction(t: t, completion: completion) {
                t.actionAttacked {
                    t.showValue(value: damage) {
                        completion()
                    }
                }
                t.play("Slash5")
            }
        }
    }
}



