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
        _id = Spell.ThunderAttack
        isThunder = true
        _name = "闪电"
        _description = "对目标造成精神80%的雷电伤害，降低目标10点雷电抗性"
        _rate = 0.8
        _quality = Quality.NORMAL
        _cooldown = 1
        _mpCost = 12 * _costRate
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        c.actionCast {
            setTimeout(delay: 0.25, completion: {
                self.attack {
                    completion()
                }
                t.play("Thunder5")
            })
            let sd = Core().seed()
            if sd < 33 {
                t.thunder4s()
            } else if sd < 66 {
                t.thunder1f()
            } else {
                t.thunder1s()
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
                        t._valueUnit._elementalResistance.thunder -= 10
                    }
                }
            }
        }
    }
}

