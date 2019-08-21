//
//  AttackReturnBack.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/21.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class MagicReflect: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _cooldown = 2
        _name = "法术反射"
        _description = "对己方单位释放护盾，将下一次魔法伤害反弹施法者"
        targetEnemy = false
        _quality = Quality.SACRED
        canBeTargetSelf = true
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        removeSpecialStatus(t:t)
        let status = Status()
        status._type = Status.EYE_TO_EYE
        status._timeleft = 2
        t.addStatus(status: status)
        c.actionCast {
            t.mixed1(index: 16) {
                completion()
            }
        }
    }
    override func findTarget() {
        if _battle._curRole._unit is Boss {
            _battle._selectedTarget = _battle._curRole
        } else {
            _battle._selectedTarget = _battle._curRole.playerPart ? _battle._playerPart.one() : _battle._enemyPart.one()
        }
    }
}
