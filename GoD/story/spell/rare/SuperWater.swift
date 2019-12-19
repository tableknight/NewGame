//
//  SuperWater.swift
//  GoD
//
//  Created by kai chen on 2019/10/29.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class SuperWater:Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.SuperWater
        _name = "分水弹"
        _description = "造成精神160%的冰冷伤害，由素有敌方目标分摊"
        _rate = 1.6
        _cooldown = 3
        isWater = true
        _quality = Quality.RARE
        autoCast = true
    }
    override func cast(completion: @escaping () -> Void) {
        let ts = _battle._selectedTargets
        _rate = 1.6 / ts.count.toFloat()
        _battle._curRole.actionCast {
            for t in self._battle._selectedTargets {
                let damage = self.waterDamage(t)
                if !self.hadSpecialAction(t: t) {
                    t.actionAttacked {
                        t.showValue(value: damage, criticalFromSpell: false, critical: false, damageType: DamageType.WATER, textColor: DamageColor.WATER)
                    }
                    t.water1f()
                }
            }
            setTimeout(delay: 2.5, completion: completion)
        }
    }
    override func findTarget() {
        findTargetPartAll()
    }
}
