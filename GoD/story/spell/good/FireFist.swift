//
//  FireFist.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class FireFist: Physical, HandSkill {
    override init() {
        super.init()
        isClose = true
        _name = "烈焰拳"
        _description = "对目标造成攻击80%的火焰伤害"
        isFire = true
        _rate = 0.8
        _quality = Quality.GOOD
        _cooldown = 1
    }
    override func cast(completion:@escaping () -> Void) {
        let b = _battle!
        let c = b._curRole
        c.actionAttack {
            self.attack {
                completion()
            }
        }
    }
    
    private func attack(completion:@escaping () -> Void) {
        let b = _battle!
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
            t.attacked1()
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
