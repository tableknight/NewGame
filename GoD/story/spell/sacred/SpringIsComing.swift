//
//  SpringIsComing.swift
//  GoD
//
//  Created by kai chen on 2019/2/14.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class SpringIsComing:Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "春暖花开"
        _description = "在目标体内种下一颗种子，使目标行动前恢复最大生命的10%，持续3回合开花，开花后的一回合恢复最大生命的25%"
        _quality = Quality.SACRED
        _cooldown = 3
        targetEnemy = false
        canBeTargetSelf = true
    }
    override func cast(completion: @escaping () -> Void) {
        let t = _battle._selectedTarget!
        _battle._curRole.actionCast {
            t.actionBuff {
                completion()
                let s = Status()
//                s._labelText = "L"
                s._type = "seed_of_life"
                s.hasBeforeMoveAction = true
                let spell = SeedOfLife()
                spell._target = t
                spell._battle = self._battle
                s._castSpell = spell
                s._timeleft = 4
                t.addStatus(status: s)
            }
        }
    }
}

