//
//  TurnAttack.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/20.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class MagicConvert: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.MagicConvert
        _cooldown = 2
        _quality = Quality.SACRED
        _name = "法术吸收"
        _description = "对己方单位释放护盾，将下一次法术伤害转化为生命回复"
        targetEnemy = false
        canBeTargetSelf = true
        cost(value: 25)
    }
    override func cast(completion:@escaping () -> Void) {
        //        let r = _battle._curRole
        let t = _battle._selectedTarget!
        removeSpecialStatus(t:t)
        let status = Status()
        status._type = Status.TURN_MAGIC
        status._timeleft = 3
        status._labelText = "C"
        t.addStatus(status: status)
        
        let c = _battle._curRole
        c.actionCast {
            t.mixed2(index: 16) {
                completion()
            }
        }
        
    }
}
