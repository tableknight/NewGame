//
//  SoulReaping.swift
//  GoD
//
//  Created by kai chen on 2019/7/14.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class SoulReaping: Magical {
    override init() {
        super.init()
        _id = Spell.SoulReaping
        _name = "灵魂收割"
        _description = "对所有敌方单位造成精神50%的魔法伤害，偷取每个受伤单位15点精神"
        _rate = 0.5
        _quality = Quality.SACRED
        _cooldown = 3
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let ts = _battle._selectedTargets
        c.actionCast {
            var i = 0
            for t in ts {
                let damage = self.magicalDamage(t)
                if !self.hasPhysicalEvent(t: t) {
                    i += 1
                    t.darkness4fifth()
                    t.actionAttacked {
                        t.showValue(value: damage)
                        setTimeout(delay: 0.5, completion: {
                            t.showText(text: "SPT -15")
                            t._valueUnit._extensions.spirit -= 15
                        })
                    }
                }
            }
            setTimeout(delay: 2.1, completion: {
                let v = i * 15
                c.showText(text: "SPT +\(v)")
                c._valueUnit._extensions.spirit += v.toFloat()
            })
            setTimeout(delay: 2.6, completion: completion)
        }
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override func findTarget() {
        findTargetPartAll()
    }
}
