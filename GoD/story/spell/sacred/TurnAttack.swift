//
//  TurnAttack.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/20.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class TurnAttack: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _tear = 1
        _quality = Quality.SACRED
        _name = "攻击吸收"
        _description = "对己方单位释放护盾，将下一次物理伤害转化为生命回复"
        targetEnemy = false
        _cooldown = 2
        canBeTargetSelf = true
    }
    override func cast(completion:@escaping () -> Void) {
        let t = _battle._selectedTarget!
        removeSpecialStatus(t:t)
        let status = Status()
        status._type = Status.TURN_ATTACK
        status._timeleft = 2
        t.addStatus(status: status)
        
        let c = _battle._curRole
        c.actionCast {
            t.mixed1(index: 16) {
                completion()
            }
        }
        
    }
}
