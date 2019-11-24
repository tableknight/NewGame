//
//  AttackReturnBack.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/21.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class AttackReturnBack: Magical {
    override init() {
        super.init()
        _name = "攻击反弹"
        _description = "对己方单位释放护盾，将下一次近战物理伤害反弹攻击者"
        targetEnemy = false
        _quality = Quality.SACRED
        _cooldown = 2
        canBeTargetSelf = true
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        removeSpecialStatus(t:t)
        let status = Status()
        status._type = Status.ATTACK_RETURN_BACK
        status._timeleft = 2
        t.addStatus(status: status)
        c.actionCast {
            t.mixed2(index: 16) {
                completion()
            }
        }
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
