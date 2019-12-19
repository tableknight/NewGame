//
//  SummonMummy.swift
//  GoD
//
//  Created by kai chen on 2019/7/11.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class SummonMummy:Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "召唤木乃伊"
        _description = "召唤一局木乃伊加入战斗"
        _quality = Quality.SACRED
        _cooldown = 3
        autoCast = true
    }
    override func cast(completion: @escaping () -> Void) {
        let seats = _battle.getEmptySeats(top: true)
        let b = _battle
//        let c = b._curRole
        _battle._curRole.actionCast {
            let seat = seats.one()
            let uw = MummyMinion()
            uw.create(level: b._curRole._unit._level)
            uw._seat = seat
            let bu = b._curRole.playerPart ? b.addPlayerMinion(unit: uw) : b.addEnemy(unit: uw)
            bu.actionSummon {
                completion()
            }
        }
    }
    override func selectable() -> Bool {
        if _battle._curRole.playerPart {
            if _battle._playerPart.count >= 6 {
                return false
            }
//            for u in _battle._playerPart {
//                if u._unit is MummyMinion {
//                    return false
//                }
//            }
        } else {
            if _battle._enemyPart.count >= 6 {
                return false
            }
//            for u in _battle._enemyPart {
//                if u._unit is MummyMinion {
//                    return false
//                }
//            }
        }
        return true
    }
}


