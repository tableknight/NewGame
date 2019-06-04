//
//  PriceOfBlood.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/18.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class PriceOfBlood: Physical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "以血换血"
        _description = "牺牲25%当前生命，对目标造成等量的物理伤害"
        _quality = Quality.GOOD
        _cooldown = 1
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        let def = getDefRate(from: c, to: t)
        let atk = -c.getHp() * 0.25
        let damage = atk * (1 - def) * (c._unit._level / t._unit._level)
        let this = self
        setTimeout(delay: 1, completion: {
            c.showValue(value: atk) {
                c.actionAttack {
                    if !this.hadSpecialAction(t:t, completion: completion) {
                        if !this.hasMissed(target: t, completion: completion) {
                            t.actionAttacked(defend: t.isDefend, completion: {
                                t.showValue(value: damage) {
                                    completion()
                                }
                            })
                        }
                    }
                    
                }
                t.attacked1()
            }
        })
    }
    
    
    
}
