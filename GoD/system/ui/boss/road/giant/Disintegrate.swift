//
//  Disintegrate.swift
//  GoD
//
//  Created by kai chen on 2019/7/6.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class Disintegrate: Magical, BossOnly {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "崩塌"
        _description = "无法承受自身的重量，崩塌了"
        _quality = Quality.NORMAL
        _cooldown = 1
        isClose = false
        autoCast = true
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let b = _battle
        c.actionWait {
            for t in b._playerPart {
                t.actionHealed {
                    t.showValue(value: t.getHealth() - t.getHp())
                }
            }
            c.hpChange(value: -1 - c.getHp())
            setTimeout(delay: 2.2, completion: {
                self._battle.victorys()
            })
        }
    }
    
    override func findTarget() {
    }
    
}
