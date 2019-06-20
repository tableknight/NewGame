//
//  Blizzard.swift
//  GoD
//
//  Created by kai chen on 2019/5/26.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class Blizzard: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        isWater = true
        _name = "暴风雪"
        _description = "冻结目标，并且有一定几率冻结目标相邻单位"
        _quality = Quality.RARE
        _cooldown = 1
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        c.actionCast {
            t.actionDebuff {
                t.freezing()
                completion()
                
                
            }
            let ts = self.getAdajcentUnits(target: t)
            if ts.count < 1 {
            } else {
                for u in ts {
                    if !self.statusMissed(baseline: 50, target: u) {
                        u.actionDebuff {
                            u.freezing()
                        }
                    }
                }
            }
        }
    }
    
    override func findTarget() {
        findSingleTargetNotBlocked()
    }
}


