//
//  SongOfElement.swift
//  GoD
//
//  Created by kai chen on 2019/2/14.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class SongOfElement:Magical {
    override init() {
        super.init()
        _name = "冰火之歌"
        _description = "对目标造成精神40%的冰火混合伤害，有小概率点燃或冰冻目标"
        _quality = Quality.RARE
        _cooldown = 2
        _rate = 0.4
    }
    override func cast(completion: @escaping () -> Void) {
        let t = _battle._selectedTarget!
        let fd = fireDamage(t)
        let wd = waterDamage(t)
        _battle._curRole.actionCast {
            if !self.hadSpecialAction(t: t, completion: completion) {
                t.actionAttacked {
                    t.showValue(value: fd + wd) {
                        completion()
                        if self.d9() {
                            if self.d2() {
                                t.burning()
                            } else {
                                t.freezing()
                            }
                        }
                    }
                }
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


