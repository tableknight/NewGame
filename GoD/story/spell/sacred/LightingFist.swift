//
//  LightingFist.swift
//  GoD
//
//  Created by kai chen on 2019/2/12.
//  Copyright © 2019年 Chen. All rights reserved.
//


import SpriteKit
class LightingFist:HandSkill {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.LightingFist
        _name = "雷光拳"
        _description = "对目标造成敏捷185%的物理伤害，附带35%的雷电伤害，有一定几率降低目标10点雷抗"
        _quality = Quality.SACRED
        _cooldown = 1
        _rate = 1.85
        cost(value: 12)
    }
    override func cast(completion: @escaping () -> Void) {
        let t = _battle._selectedTarget!
        let c = _battle._curRole
        c.actionAttack {
            let damage = self.physicalDamage(t)
            if !self.hasPhysicalEvent(t: t, completion: completion) {
                t.actionAttacked {
                    t.showValue(value: damage)
                    let thunderDamage = self.thunderFactor(from: c, to: t) * damage * 0.35
                    setTimeout(delay: 0.5, completion: {
                        t.showValue(value: thunderDamage, criticalFromSpell: false, damageType: DamageType.THUNDER, textColor: ElementColor.THUNDER) {
                            
                            if self.d5() && !t.isDead() {
                                t.showText(text: "TR -10") {
                                    
                                }
                                t._valueUnit._elementalResistance.thunder -= 10
                            }
                        }
                        completion()
                    })
                }
                t.hitThunder()
            }
        }
    }
    
    
    override func selectable() -> Bool {
        return isEmptyHand()
    }
}

