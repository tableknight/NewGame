//
//  DeathGaze.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/19.
//  Copyright © 2018年 Chen. All rights reserved.
//


import SpriteKit
class DeathGaze: Magical {
    override init() {
        super.init()
        _name = "死亡凝视"
        _description = "对目标造成精神65%的魔法伤害，小概率立即杀死目标"
        _rate = 0.65
        _quality = Quality.SACRED
        _cooldown = 2
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
                        if this.seed() < 15 {
                            t.showText(text: "SLASHED") {
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
        }
    }
    
}
