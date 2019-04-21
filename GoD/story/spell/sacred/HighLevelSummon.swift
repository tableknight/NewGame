//
//  HighLevelSummon.swift
//  GoD
//
//  Created by kai chen on 2019/2/21.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class HighLevelSummon:Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "高阶召唤"
        _description = "召唤一个亡灵巫师为你而战，最多只能控制一个亡灵巫师"
        _quality = Quality.SACRED
        _cooldown = 5
        autoCast = true
    }
    override func cast(completion: @escaping () -> Void) {
        let seats = _battle.getEmptySeats()
        let b = _battle!
        _battle._curRole.actionCast {
            let seat = seats.one()
            let uw = UndeadWitch()
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
            if u._unit is UndeadWitch {
                return false
            }
        }
        return true
    }
}

