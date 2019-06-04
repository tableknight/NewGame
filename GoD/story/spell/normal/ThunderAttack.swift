//
//  ThunderAttack.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/19.
//  Copyright © 2018年 Chen. All rights reserved.
//


import SpriteKit
class ThunderAttack: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        isThunder = true
        _name = "闪电"
        _description = "对目标造成精神80%的雷电伤害，降低目标10点雷电抗性"
        _rate = 0.8
        _quality = Quality.NORMAL
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
        _damageValue = thunderDamage(t)
        let damage = _damageValue
        if !hadSpecialAction(t:t, completion: completion) {
            t.actionAttacked {
                t.showValue(value: damage, damageType: DamageType.THUNDER, textColor: ElementColor.THUNDER) {
                    if t.isDead() {
                        completion()
                    } else {
                        t.showText(text: "TR -10") {
                            completion()
                        }
                        t._elementalResistance.thunder -= 10
                    }
                }
            }
            t.lighting1()
        }
    }
}

