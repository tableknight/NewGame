//
//  Burning.swift
//  GoD
//
//  Created by kai chen on 2019/5/25.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class Burn: Magical, Curse {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.Burn
        isFire = true
        _name = "燃烧"
        _description = "点燃目标，如果目标已被点燃，则增加两层燃烧效果"
        _quality = Quality.NORMAL
        _cooldown = 0
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        c.actionCast {
            t.actionDebuff {
                if t.hasStatus(type: Status.BURNING) {
                    t.burning()
                }
                t.burning()
                completion()
            }
        }
    }
    
    override func findTarget() {
        findSingleTargetNotBlocked()
    }
}

