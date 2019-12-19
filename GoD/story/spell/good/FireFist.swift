//
//  FireFist.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class FireFist:HandSkill {
    override init() {
        super.init()
        _id = Spell.FireFist
        isClose = true
        _name = "烈焰拳"
        _description = "对目标造成敏捷100%的火焰伤害"
        isFire = true
        _rate = 1.0
        _quality = Quality.GOOD
        _cooldown = 2
    }
    override func cast(completion:@escaping () -> Void) {
        let b = _battle
        let c = b._curRole
//        if c.weaponIs(DragonClaw.EFFECTION) {
//            _cooldown = 0
//        } else {
//            _cooldown = 2
//        }
        c.actionAttack {
            self.attack {
                completion()
            }
        }
    }
    
    private func attack(completion:@escaping () -> Void) {
        let b = _battle
        let t = b._selectedTarget!
        let damage = fireDamage(t)
        if !hadSpecialAction(t:t, completion: completion) {
            if !hasMissed(target: t, completion: completion) {
                t.actionAttacked {
                    t.showValue(value: damage, damageType: DamageType.FIRE, textColor: ElementColor.FIRE) {
                        completion()
                    }
                }
            }
            t.hitSpecial2()
        }
    }
    
    override func selectable() -> Bool {
        return isEmptyHand()
        
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
