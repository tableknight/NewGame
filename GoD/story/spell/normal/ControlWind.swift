//
//  ControlWind.swift
//  GoD
//
//  Created by kai chen on 2019/6/4.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class ControlWind: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.ControlWind
        _name = "驭风者"
        _description = "对随机敌方单位造成精神100%的冰冷伤害"
        _quality = Quality.NORMAL
        _cooldown = 1
        autoCast = true
        isWater = true
        _rate = 1
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
        _damageValue = waterDamage(t)
        let damage = _damageValue
        if !hadSpecialAction(t:t, completion: completion) {
            t.actionAttacked {
                t.showValue(value: damage, damageType: DamageType.WATER, textColor: ElementColor.WATER) {
                    completion()
                }
            }
//            t.water2()
            t.wind4()
        }
    }
    
    override func findTarget() {
        findSingleTargetNotBlocked()
    }
}

