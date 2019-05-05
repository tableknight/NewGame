//
//  Burning.swift
//  GoD
//
//  Created by kai chen on 2019/2/10.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class Burning:Derivant {
    override init() {
        super.init()
        _delay = 1.25
    }
    override func cast(completion: @escaping () -> Void) {
        let s = _target.getStatus(type: Status.BURNING) as! BurningStatus
        let damage = s.getBurningDamage(unit: _target)
//        let damage = -self._target.getHealth()
        if !hadSpecialAction(t: _target, completion: completion) {
            self._target.showValue(value: damage, criticalFromSpell: false) {
                completion()
            }
//            self._target.actionAttacked {
//            }
        }
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
