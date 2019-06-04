//
//  BurningAll.swift
//  GoD
//
//  Created by kai chen on 2019/5/25.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class BurningAll: Magical, Curse {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        isFire = true
        _name = "烈焰焚心"
        _description = "诅咒敌方所有目标，有较大概率将其点燃"
        _quality = Quality.GOOD
        _cooldown = 0
        autoCast = true
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let ts = _battle._selectedTargets
        c.actionCast {
            for t in ts {
                if !self.statusMissed(baseline: 65, target: t) {
                    t.actionDebuff {
                        t.burning()
                    }
                }
            }
            setTimeout(delay: 1.5, completion: completion)
        }
    }
    
    override func findTarget() {
        findtargetAll()
    }
}

