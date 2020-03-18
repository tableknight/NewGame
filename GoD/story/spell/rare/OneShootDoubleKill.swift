//
//  OneShootDoubleKill.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class OneShootDoubleKill: Physical, BowSkill {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.OneShootDoubleKill
        _name = "穿刺射击"
        _description = "对随机目标和身后单位造成攻击90%的物理伤害"
        _quality = Quality.RARE
        _rate = 0.9
        _cooldown = 1
        isClose = false
        autoCast = true
        cost(value: 18)
    }
    
    override func cast(completion:@escaping () -> Void) {
        let b = _battle
        let t = b._selectedTarget!
        let c = b._curRole
        //        let role = c._unit
        let this = self
        let seat = getUnitBehindTarget(seat: t._unit._seat)
        let ts = getTargetsBySeats(seats: [seat])
        c.actionShoot {
            this.attack(t:t) {
                completion()
            }
            if ts.count > 0 {
                setTimeout(delay: 0.5, completion: {
                    this.attack(t: ts[0])
                })
            }
            c.play("bow")
        }
    }
    
    private func attack(t:BUnit, completion:@escaping () -> Void = {}) {
        _damageValue = physicalDamage(t) * _rate
        let damage = _damageValue
        if !hadSpecialAction(t:t, completion: completion) {
            if !hasMissed(target: t, completion: completion) {
                t.actionAttacked() {
                    t.showValue(value: damage, criticalFromSpell: false, critical: self.beCritical) {
                        completion()
                    }
                }
                t.hit1()
            }
        }
    }
    
    override func selectable() -> Bool {
        return _battle._curRole.weaponIs(Outfit.Bow)
    }
    override func findTarget() {
        findRandomTargetInLineFirst()
    }
}
