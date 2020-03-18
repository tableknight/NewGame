//
//  WindPunish.swift
//  GoD
//
//  Created by kai chen on 2019/3/16.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class WindPunish: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.WindPunish
        isWater = true
        _name = "双龙卷风"
        _description = "对目标和身后目标造成精神75%的冰冷伤害"
        _rate = 0.75
        _quality = Quality.GOOD
        _cooldown = 1
        _mpCost = 20 * _costRate
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        let damage = waterDamage(t)
        c.actionCast {
            if !self.hadSpecialAction(t: t, completion: completion) {
                t.actionAttacked {
                    t.showValue(value: damage, damageType: DamageType.WATER, textColor: ElementColor.WATER) {
                        completion()
                    }
                }
                t.wind4()
                t.play("wind")
            }
            let seat = self.getUnitBehindTarget(seat: t._unit._seat)
            let tb = self._battle.getUnitBySeat(seat: seat)
            if nil != tb {
                let damage = self.waterDamage(tb!)
                if !self.hadSpecialAction(t: tb!) {
                    tb!.actionAttacked {
                        tb!.showValue(value: damage, damageType: DamageType.WATER, textColor: ElementColor.WATER)
                    }
                    tb!.wind4()
                    tb!.play("wind")
                }
            }
        }
    }
    override func findTarget() {
        findRandomTargetInLineFirst()
    }
}


