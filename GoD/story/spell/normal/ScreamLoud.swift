//
//  ScreamLoud.swift
//  GoD
//
//  Created by kai chen on 2019/2/12.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class ScreamLoud:Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "尖啸"
        _description = "大声的吼叫，大概率降低目标30%防御和30点命中，持续3回合"
        _quality = Quality.NORMAL
        _cooldown = 1
        autoCast = true
    }
    override func cast(completion: @escaping () -> Void) {
        let ts = _battle._selectedTargets
        _battle._curRole.actionCast {
            for t in ts {
                if !self.statusMissed(baseline: 80, target: t, completion: {}) {
                    t.actionDebuff {
                        t.showText(text: "SCARED")
                        let s = Status()
                        s._timeleft = 3
                        let atk = t.getAttack() * 0.3
                        t._extensions.attack -= atk
                        t._extensions.accuracy -= 30
                        s.timeupAction = {
                            t._extensions.attack += atk
                            t._extensions.accuracy += 30
                        }
                    }
                }
            }
            setTimeout(delay: 2.8, completion: completion)
        }
    }
    
    override func findTarget() {
        findTargetPartAll()
    }
    
}

