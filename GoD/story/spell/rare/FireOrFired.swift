//
//  FireOrFired.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/7.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class FireOrFired: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        isFire = true
        _name = "玩火"
        _description = "对目标造成精神125%的火焰伤害或者燃烧自己25%当前生命值"
        _rate = 1.25
        _quality = Quality.RARE
        _cooldown = 1
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
        _damageValue = fireDamage(t)
        var damage = _damageValue
        var chance = 50
        if c._unit is Character {
            let char = c._unit as! Character
            if char._leftRing is ApprenticeRing || char._rightRing is ApprenticeRing {
                chance = 40
            }
        }
        if chance < seed() {
            damage = c.getHp() * 0.25
            if damage < 1 {
                damage = 1
            }
            damage = -damage
            c.actionAttacked {
                c.showValue(value: damage) {
                    completion()
                }
            }
            c.flame1(index: 4, line: 1)
        } else {
            if !hadSpecialAction(t:t, completion: completion) {
                t.actionAttacked {
                    t.showValue(value: damage, damageType: DamageType.FIRE, textColor: ElementColor.FIRE) {
                        completion()
                    }
                }
                t.flame1(index: 4, line: 1)
            }
        }
    }
    
}
