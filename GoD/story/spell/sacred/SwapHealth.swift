//
//  SwapHealth.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/16.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class SwapHealth: Magical {
    override init() {
        super.init()
        _id = Spell.SwapHealth
        _name = "换血"
        _description = "和己方单位交换生命值"
        _quality = Quality.SACRED
        targetEnemy = false
        _cooldown = 0
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        c.actionCast {
            let thp = t.getHp()
            t._unit._extensions.hp = 0
            t.hpChange(value: c.getHp())
            c._unit._extensions.hp = 0
            c.hpChange(value: thp)
            completion()
        }
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    
}
