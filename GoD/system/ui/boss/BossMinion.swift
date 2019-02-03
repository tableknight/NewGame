//
//  BossMinion.swift
//  GoD
//
//  Created by kai chen on 2019/1/27.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class BossMinion: Creature {
    override func createQuality() {
        _quality = Quality.NORMAL
    }
    override func extraProperty(value: CGFloat) -> CGFloat {
        return 0
    }
    override func levelTo(level: CGFloat) {
        staminaChange(value: (level + 10) * _growth.stamina)
        strengthChange(value: (level + 10) * _growth.strength)
        agilityChange(value: (level + 10) * _growth.agility)
        intellectChange(value: (level + 10) * _growth.intellect)
        _level = level
    }
}

class BossAttack: Physical {
    override init() {
        super.init()
    }
    override func cast(completion:@escaping () -> Void) {
        let b = _battle!
        let t = b._selectedTarget!
        let c = b._curRole
        let damage = physicalDamage(t)
        c.actionAttack {
            if !self.hadSpecialAction(t: t, completion: completion) {
                if !self.hasMissed(target: t, completion: completion) {
                    t.actionAttacked {
                        t.showValue(value: damage) {
                            completion()
                        }
                    }
                }
            }
        }
    }
    
    
}
