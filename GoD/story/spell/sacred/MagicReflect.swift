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
        _id = Spell.MagicReflect
        _cooldown = 2
        _name = "法术反射"
        _description = "对己方单位释放护盾，将下一次魔法伤害反弹施法者"
        targetEnemy = false
        _quality = Quality.SACRED
        canBeTargetSelf = true
        cost(value: 25)
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        
        c.actionCast {
            t.mixed2(index: 16) {
                let status = Status()
                self.removeSpecialStatus(t:t)
                status._type = Status.EYE_TO_EYE
                status._timeleft = 3
                status._labelText = "R"
                t.addStatus(status: status)
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
