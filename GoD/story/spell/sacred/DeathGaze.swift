//
//  DeathGaze.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/19.
//  Copyright © 2018年 Chen. All rights reserved.
//


import SpriteKit
class DeathGaze: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.DeathGaze
        _name = "死亡凝视"
        _description = "对目标造成精神65%的魔法伤害，有小概率立即杀死目标"
        _rate = 0.65
        _quality = Quality.SACRED
        _cooldown = 1
        cost(value: 18)
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
//        let b = _battle
        //        let c = _battle._curRole
        _damageValue = magicalDamage(t)
        let damage = _damageValue
        let this = self
        if !hadSpecialAction(t:t, completion: completion) {
            t.actionAttacked {
//                t.hpChange(value: damage)
                t.showValue(value: damage) {
                    if t.isDead() {
                        completion()
                    } else {
                        if this.seed() < 7 {
                            t.showText(text: "Slash") {
                                t.actionDead {
                                    completion()
                                    t.removeFromBattle()
                                    t.removeFromParent()
                                }
                            }
                        } else {
                            completion()
                        }
                    }
                }
                
            }
            t.stateDeathf()
        }
    }
    
}
