//
//  IceFist.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/16.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class IceFist: Physical, HandSkill {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        isClose = true
        _name = "碎冰拳"
        _description = "对目标造成60%攻击力的伤害，附加当前生命15%的寒冰伤害"
        isWater = true
        _rate = 0.6
        _quality = Quality.GOOD
        _cooldown = 1
    }
    override func cast(completion:@escaping () -> Void) {
        let b = _battle!
        let c = b._curRole
        let this = self
        c.actionAttack {
            this.attack {
                completion()
            }
        }
    }
    
    private func attack(completion:@escaping () -> Void) {
        let b = _battle!
        let t = b._selectedTarget!
        let c = b._curRole
        let damage = physicalDamage(t)
        if !hadSpecialAction(t:t, completion: completion) {
            if !hasMissed(target: t, completion: completion) {
                let attechment = c.getHp() * -0.15
                t.actionAttacked(defend: t.isDefend) {
                    t.showValue(value: damage)
                    let waterDamage:CGFloat = attechment * self.waterFactor(from: c, to: t)
                    setTimeout(delay: 0.5, completion: {
                        t.showValue(value: waterDamage, damageType: DamageType.WATER, textColor: ElementColor.WATER, completion: completion)
                    })
                }
            }
        }
    }
    
    override func selectable() -> Bool {
        return isEmptyHand()
    }
}

