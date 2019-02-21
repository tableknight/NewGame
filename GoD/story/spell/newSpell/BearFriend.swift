//
//  BearFriend.swift
//  GoD
//
//  Created by kai chen on 2019/2/21.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class BearFriend:Magical {
    override init() {
        super.init()
        _name = "熊人之友"
        _description = "召唤一个熊战士为你而战，最多只能控制一个熊战士"
        _quality = Quality.SACRED
        _cooldown = 3
        autoCast = true
    }
    override func cast(completion: @escaping () -> Void) {
        let seats = _battle.getEmptySeats()
        let b = _battle!
        _battle._curRole.actionCast {
            let seat = seats.one()
            let uw = BearWarrior()
            uw.create(level: b._curRole._unit._level)
            uw._seat = seat
            let bu = b.addPlayerMinion(unit: uw)
            bu.actionSummon {
                completion()
            }
        }
    }
    override func selectable() -> Bool {
        if _battle._playerPart.count >= 6 {
            return false
        }
        for u in _battle._playerPart {
            if u._unit is BearWarrior {
                return false
            }
        }
        return true
    }
}

