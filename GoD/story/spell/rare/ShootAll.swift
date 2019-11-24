//
//  ShootAll.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/5.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class ShootAll: Physical, BowSkill {
    override init() {
        super.init()
        _name = "万箭齐发"
        _description = "对所有敌方单位造成攻击65%的物理伤害"
        isClose = false
        _rate = 0.65
        autoCast = true
        _quality = Quality.RARE
        _cooldown = 2
    }
    
    override func cast(completion: @escaping () -> Void) {
        let this = self
        _battle._curRole.actionShoot {
            for t in this._battle._selectedTargets {
                this.attack(t: t)
            }
            setTimeout(delay: 2.2, completion: completion)
        }
    }
    
    private func attack(t:BUnit) {
        let damage = physicalDamage(t)
        
        if !hadSpecialAction(t: t) {
            if !hasMissed(target: t) {
                t.actionAttacked {
                    t.showValue(value: damage, criticalFromSpell: false, critical: self.beCritical)
                }
                t.hit2()
            }
        }
        
    }
    
    override func findTarget() {
        findTargetPartAll()
    }
    
    override func selectable() -> Bool {
        return isWeaponBow()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
