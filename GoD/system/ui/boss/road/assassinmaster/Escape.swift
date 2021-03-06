//
//  Escape.swift
//  GoD
//
//  Created by kai chen on 2019/7/8.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class Escape: Magical, BossOnly {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.Escape
        _cooldown = 3
        _name = "逃生"
        _description = "全身而退"
        _quality = Quality.SACRED
        autoCast = true
        cost(value: 60)
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let b = _battle
        c.speak(text: "情况不妙，我闪!")
        setTimeout(delay: 1.5, completion: {
            c.actionWait {
                if self.d4() {
                    c.showText(text: "全身而退") {
                        b.isVictory = false
                        b.fadeOutBattle()
                    }
                } else {
                    c.showText(text: "逃生失败") {
                        completion()
                    }
                }
            }
        })
    }
    override func findTarget() {
    }
}
