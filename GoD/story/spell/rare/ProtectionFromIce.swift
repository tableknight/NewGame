//
//  ProtectionFromIce.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/19.
//  Copyright © 2018年 Chen. All rights reserved.
//


import SpriteKit
class ProtectionFromIce: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.ProtectionFromIce
        _tear = 2
        isWater = true
        _quality = Quality.RARE
        _name = "冰棺"
        _description = "对己方单位释放护盾，抵挡一次致命攻击"
        targetEnemy = false
        canBeTargetSelf = true
        _cooldown = 3
        cost(value: 25)
    }
    override func cast(completion:@escaping () -> Void) {
        let t = _battle._selectedTarget!
        let status = Status()
        status._type = Status.PROTECTION_FROM_ICE
        status._timeleft = 3
        t.addStatus(status: status)
        
        let c = _battle._curRole
        c.actionCast {
            t.magic1f() {
                completion()
            }
        }
        
    }
    override func findTarget() {
        findSingleTargetNotBlocked()
    }
}
