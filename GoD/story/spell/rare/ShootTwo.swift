//
//  ShootTwo.swift
//  GoD
//
//  Created by kai chen on 2019/1/5.
//  Copyright © 2019年 Chen. All rights reserved.
//


import SpriteKit
class ShootTwo: Physical, BowSkill {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "一箭双雕"
        _description = "对随机两个目标造成攻击80%的物理伤害"
        _quality = Quality.RARE
        _rate = 0.8
        isClose = false
        autoCast = true
        _cooldown = 1
    }
    
    override func cast(completion:@escaping () -> Void) {
        let b = _battle!
        let ts = b._selectedTargets
        let t = ts[0]
        let c = b._curRole
        let this = self
        c.actionShoot {
            this.attack(t:t) {
                completion()
            }
            if ts.count > 1 {
                this.attack(t: ts[1])
            }
        }
    }
    
    private func attack(t:BUnit, completion:@escaping () -> Void = {}) {
        _damageValue = physicalDamage(t) * _rate
        let damage = _damageValue
        if !hadSpecialAction(t:t, completion: completion) {
            if !hasMissed(target: t, completion: completion) {
                t.actionAttacked(defend: t.isDefend) {
                    t.showValue(value: damage, criticalFromSpell: false, critical: self.beCritical) {
                        completion()
                    }
                }
            }
        }
    }
    
    override func selectable() -> Bool {
        return isWeaponBow()
    }
    override func findTarget() {
        findTargetRandom2()
    }
}
