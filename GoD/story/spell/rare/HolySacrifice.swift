//
//  HolyScrifise.swift
//  GoD
//
//  Created by kai chen on 2019/11/6.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class HolySacrifice: Physical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "神圣牺牲"
        _description = "牺牲15%当前生命，作为额外攻击。对目标造成攻击100%的物理伤害"
        _quality = Quality.RARE
        _cooldown = 1
    }
    override func getAttack(from: BUnit) -> CGFloat {
        return from.getAttack() + _battle._curRole.getHp() * 0.15
    }
    override func cast(completion: @escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        let selfDamage = -c.getHp() * 0.15
        let damage = physicalDamage(t)
        c.showValue(value: selfDamage) {
            c.actionAttack {
                if !self.hadSpecialAction(t: t, completion: completion) {
                    if !self.hasMissed(target: t, completion: completion) {
                        t.actionAttacked {
                            t.showValue(value: damage) {
                                completion()
                            }
                        }
                        t.attacked1()
                    }
                }
            }
            
        }
    }
}
