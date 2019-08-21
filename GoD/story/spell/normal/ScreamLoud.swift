//
//  ScreamLoud.swift
//  GoD
//
//  Created by kai chen on 2019/2/12.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class ScreamLoud:Magical, Curse {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "震耳发溃"
        _description = "发出剧烈的怒吼，降低所有敌方目标30%防御和30点命中，持续3回合"
        _quality = Quality.NORMAL
        _cooldown = 2
        autoCast = true
    }
    override func cast(completion: @escaping () -> Void) {
        let ts = _battle._selectedTargets
        _battle._curRole.actionCast {
            for t in ts {
                if !self.statusMissed(baseline: 65, target: t, completion: {}) {
                    t.actionWait {
                        t.showText(text: Spell.CURSED)
                        if t.hasStatus(type: "_scared") {
                            let s = t.getStatus(type: "_scared")
                            s?._timeleft = 3
                            t.showStatusText()
                        } else {
                            let s = Status()
                            s._type = "_scared"
                            s._labelText = "S"
                            s._timeleft = 3
                            let atk = t.getAttack() * 0.3
                            t._extensions.attack -= atk
                            t._extensions.accuracy -= 30
                            s.timeupAction = {
                                t._extensions.attack += atk
                                t._extensions.accuracy += 30
                            }
                            t.addStatus(status: s)
                        }
                    }
                    t.mixed2(index: 13)
                }
            }
            setTimeout(delay: 1.5, completion: completion)
        }
    }
    
    override func findTarget() {
        findTargetPartAll()
    }
    
}

