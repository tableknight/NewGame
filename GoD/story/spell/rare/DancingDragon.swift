//
//  DancingDragon.swift
//  GoD
//
//  Created by kai chen on 2019/2/25.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class DancingDragon: Physical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.DancingDragon
        _name = "乱舞"
        _description = "对目标造成2-5次攻击，每次造成攻击力35%的物理伤害"
        _rate = 0.35
        _cooldown = 2
        _quality = Quality.RARE
        _mpCost = 10 * _costRate
    }
    override func cast(completion: @escaping () -> Void) {
        hasRevenge = false
        let t = _battle._selectedTarget!
        var max = 3
        if _battle._curRole.weaponIs(Sacred.IberisHand) {
            max = 6
        }
        let times = 1 + seed(to: max)
        _battle._curRole.actionAttack {
            t.clawSpecial1()
            t.play("freeze")
            for i in 0...times {
                if i == 0 {
                    let damage = self.physicalDamage(t)
                    if !self.hadSpecialAction(t: t) {
                        if !self.hasMissed(target: t) {
                            t.actionAttacked {
                                t.showValue(value: damage)
                            }
                        }
                    }
                } else {
                    setTimeout(delay: i.toFloat() * 0.25, completion: {
                        if !self.hasMissed(target: t) {
                            let damage = self.physicalDamage(t)
                            t.showValue(value: damage)
                        }
                    })
                }
            }
            setTimeout(delay: 1.5 + times.toFloat() * 0.25, completion: {
//                debug("revenge \(self.hasRevenge)")
                if !self.hasRevenge {
                    completion()
                } else {
                    setTimeout(delay: 2.25, completion: completion)
                }
            })
        }
    }
    override func selectable() -> Bool {
        return _battle._curRole.isClose()
    }
}
