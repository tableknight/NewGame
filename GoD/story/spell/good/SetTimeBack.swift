//
//  SetTimeBack.swift
//  GoD
//
//  Created by kai chen on 2019/5/26.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class SetTimeBack:Magical, Curse {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "时空逆转"
        _description = "释放可怕的诅咒，延长所有敌方技能两回合冷却时间"
        _quality = Quality.GOOD
        _cooldown = 1
        autoCast = true
    }
    override func cast(completion: @escaping () -> Void) {
        let ts = _battle._selectedTargets
        _battle._curRole.actionCast {
            for t in ts {
                if !self.statusMissed(baseline: 65, target: t, completion: {}) {
                    t.actionDebuff {
                        t.showText(text: Spell.CURSED)
                        for s in t._unit._spellsInuse {
                            if s._timeleft > 0 {
                                s._timeleft += 2
                            }
                        }
                    }
                }
            }
            setTimeout(delay: 1.5, completion: completion)
        }
    }
    
    override func findTarget() {
        findTargetPartAll()
    }
    
}

