//
//  TakeRest.swift
//  GoD
//
//  Created by kai chen on 2019/7/6.
//  Copyright © 2019 Chen. All rights reserved.
//
import SpriteKit
class TakeRest: Magical, BossOnly {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.TakeRest
        _name = "休息"
        _description = "休息一回合，恢复5%最大生命"
        _quality = Quality.NORMAL
        _cooldown = 1
        autoCast = true
        cost(value: 15)
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        c.recovery2f {
            let r = c.getHealth() * 0.05
            c.showValue(value: r) {
                completion()
            }
        }
    }
    
    override func findTarget() {
    }
    
}

