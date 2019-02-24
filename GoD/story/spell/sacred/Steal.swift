//
//  Steal.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/18.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Steal: Physical {
    override init() {
        super.init()
        _name = "行窃"
        _description = "对目标和自己造成攻击力50%的物理伤害，或者偷取目标1耐力，1力量，1敏捷，1智力"
        _quality = Quality.SACRED
        _cooldown = 2
        _rate = 0.5
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        _damageValue = physicalDamage(t)
        let damage = _damageValue
        let this = self
        c.actionAttack {
            if !this.hasMissed(target: t, completion: completion) {
                if this.d2() {
                    t.actionAttacked(defend: t.isDefend, completion: {
                        t.showValue(value: damage)
                        setTimeout(delay: 0.5, completion: {
                            c.showValue(value: damage) {
                                completion()
                            }
                        })
                    })
                } else {
                    setTimeout(delay: 1, completion: {
                        t.showText(text: "STOLEN") {
                            completion()
                        }
                    })
                    t.strengthChange(value: -1)
                    t.staminaChange(value: -1)
                    t.agilityChange(value: -1)
                    t.intellectChange(value: -1)
                    c.strengthChange(value: 1)
                    c.staminaChange(value: 1)
                    c.agilityChange(value: 1)
                    c.intellectChange(value: 1)
                }
            }
        }
    }
    
    
    
}

