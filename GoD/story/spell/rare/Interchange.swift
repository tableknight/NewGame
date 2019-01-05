//
//  Interchange.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/15.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Interchange: Magical {
    override init() {
        super.init()
        _quality = Quality.RARE
        _name = "移行换位"
        _tear = 1
        _description = "移动到或者和目标交换位置"
        targetEnemy = false
        canBeTargetSelf = false
    }
    override func cast(completion:@escaping () -> Void) {
        let t = _battle._selectedTarget!
        let c = _battle._curRole
        let b = _battle
//        let this = self
//        c.showText(text: _name)
        c.actionCast {
            let seat = t._unit._seat
            if !t.isEmpty {
                t._unit._seat = c._unit._seat
                t._unit._seat = c._unit._seat
                b?.setRolePos(unit: t)
            } else {
                t.removeFromBattle()
                t.removeFromParent()
                b?._left[c._unit._seat] = nil
            }
            c._unit._seat = seat
            c._unit._seat = seat
            b?.setRolePos(unit: c)
            setTimeout(delay: 1, completion: completion)
        }
    }
}
