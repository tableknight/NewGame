//
//  ProtectionFromIce.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/19.
//  Copyright © 2018年 Chen. All rights reserved.
//


import SpriteKit
class ProtectionFromIce: Magical {
    override init() {
        super.init()
        _tear = 2
        _quality = Quality.RARE
        _name = "冰棺"
        _description = "对己方单位释放护盾，抵挡一次致命攻击，持续3回合"
        targetEnemy = false
        canBeTargetSelf = true
    }
    override func cast(completion:@escaping () -> Void) {
        let t = _battle._selectedTarget!
        let status = Status()
        status._type = Status.PROTECTION_FROM_ICE
        status._timeleft = 3
        t.addStatus(status: status)
        
        let c = _battle._curRole
        c.actionCast {
            t.actionBuff {
                completion()
            }
        }
        
    }
}
