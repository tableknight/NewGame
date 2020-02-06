//
//  Steal.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/18.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Steal: HandSkill {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.Steal
        _name = "行窃"
        _description = "对目标和自己造成敏捷50%的物理伤害，或者偷取目标1防御，1力量，1敏捷，1智力"
        _quality = Quality.SACRED
        _cooldown = 1
        _rate = 0.5
        cost(value: 5)
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
                    t.howl()
                } else {
                    setTimeout(delay: 1, completion: {
                        t.showText(text: "STOLEN") {
                            completion()
                        }
                        setTimeout(delay: 1, completion: {
                            c.showText(text: "HAHA")
                        })
                        
                    })
                    t._valueUnit.strengthChange(value: -1)
                    t._valueUnit.staminaChange(value: -1)
                    t._valueUnit.agilityChange(value: -1)
                    t._valueUnit.intellectChange(value: -1)
                    c._valueUnit.strengthChange(value: 1)
                    c._valueUnit.staminaChange(value: 1)
                    c._valueUnit.agilityChange(value: 1)
                    c._valueUnit.intellectChange(value: 1)
                }
            }
        }
    }
    
    override func selectable() -> Bool {
        return isEmptyHand()
    }
    
}

