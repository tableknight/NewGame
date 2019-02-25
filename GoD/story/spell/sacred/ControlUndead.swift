//
//  ControlUndead.swift
//  GoD
//
//  Created by kai chen on 2019/2/20.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class ControlUndead:Magical {
    override init() {
        super.init()
        _name = "控制亡灵"
        _description = "有一定几率控制一个地方亡灵生物"
        _quality = Quality.SACRED
        _cooldown = 0
    }
    override func cast(completion: @escaping () -> Void) {
        let t = _battle._selectedTarget!
        _battle._curRole.actionCast {
            if t._unit._race == EvilType.RISEN {
                if self.d4() {
                    t.actionDebuff {
                        t.removeFromBattle()
                        t.removeFromParent()
                        let seats = self._battle.getEmptySeats()
                        t._unit._seat = seats.one()
                        self._battle.addPlayerMinion(bUnit: t)
                        completion()
                    }
                } else {
                    t.showMiss {
                        completion()
                    }
                }
            } else {
                t.showMiss {
                    completion()
                }
            }
        }
    }
    override func selectable() -> Bool {
        return _battle._playerPart.count < 6
    }
}
