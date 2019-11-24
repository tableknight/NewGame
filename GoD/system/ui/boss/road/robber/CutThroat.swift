//
//  CutThroat.swift
//  GoD
//
//  Created by kai chen on 2019/7/11.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class CutThroat: Physical {
    override init() {
        super.init()
        isClose = true
        _name = "绞喉"
        _description = "对目标造成攻击60%的物理伤害，封印所有技能3回合"
        isFire = true
        _rate = 0.6
        _quality = Quality.RARE
        _cooldown = 3
    }
    override func cast(completion:@escaping () -> Void) {
        let b = _battle!
        let c = b._curRole
        let t = _battle._selectedTarget!
        let d = physicalDamage(t)
        c.actionAttack {
            if !self.hasPhysicalEvent(t: t, completion: completion) {
                t.actionAttacked {
                    t.showValue(value: d) {
//                        t.showText(text: "SEALED") {
//                            completion()
//                        }
                    }
                    for s in t._unit._spellsInuse {
                        if s is Active {
                            s._timeleft += 3
                        }
                    }
                }
                t.darkness1s()
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

