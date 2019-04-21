//
//  FrozenShoot.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/21.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class FrozenShoot: Physical, BowSkill {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _quality = Quality.GOOD
        isWater = true
        isClose = false
        _name = "寒冰射击"
        _cooldown = 2
        _rate = 0.65
        _description = "对目标造成攻击力65%的冰冷伤害，有一定几率冻结目标"
    }
    override func cast(completion:@escaping () -> Void) {
        let t = _battle._selectedTarget!
        let c = _battle._curRole
        _damageValue = waterDamage(t)
        let damage = _damageValue
        c.actionShoot {
            if !self.hadSpecialAction(t:t, completion: completion) {
                if !self.hasMissed(target: t, completion: completion) {
                    t.actionAttacked {
                        t.showValue(value: damage) {
                            completion()
                        }
                        if self.d4() {
                            t.freezing()
                        }
                    }
                }
            }
        }
    }
    override func findTarget() {
        findSingleTargetNotBlocked()
    }
    override func selectable() -> Bool {
        return isWeaponBow()
    }
}
