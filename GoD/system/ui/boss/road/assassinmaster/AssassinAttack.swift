//
//  AssassinAttack.swift
//  GoD
//
//  Created by kai chen on 2019/7/8.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class AssassinAttack: Physical {
    override init() {
        super.init()
    }
    override func cast(completion:@escaping () -> Void) {
        let b = _battle
        let t = b._selectedTarget!
        let c = b._curRole
        let damage = physicalDamage(t)
        c.actionAttack {
            if !self.hadSpecialAction(t: t, completion: completion) {
                if !self.hasMissed(target: t, completion: completion) {
                    t.actionAttacked {
                        if self.d5() && !(t._unit is Character) {
                            t.showText(text: "Kill") {
                                t.hpChange(value: -1 - t.getHp())
                                t.die()
                                completion()
                            }
                        } else {
                            t.showValue(value: damage) {
                                completion()
                            }
                        }
                    }
                    t.attacked1()
                }
            }
        }
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    
}

