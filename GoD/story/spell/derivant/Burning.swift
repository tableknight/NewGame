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
    }
    override func cast(completion: @escaping () -> Void) {
        let s = _target.getStatus(type: Status.BURNING) as! BurningStatus
        let damage = s.getBurningDamage(unit: _target)
        if !hadSpecialAction(t: _target, completion: completion) {
            self._target.showValue(value: damage) {
                completion()
            }
//            self._target.actionAttacked {
//            }
        }
    }
}
