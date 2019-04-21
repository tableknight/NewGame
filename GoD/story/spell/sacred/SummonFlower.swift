//
//  SummonFlower.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/15.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class SummonFlower: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "生命之花"
        _description = "召唤生命之花，生命之花会在行动结束后治疗相邻单位，恢复其15%最大生命，持续5回合"
        _quality = Quality.SACRED
        _cooldown = 5
        autoCast = true
    }
    override func cast(completion: @escaping () -> Void) {
        let b = _battle!
        let _curRole = _battle._curRole
        _battle._curRole.actionCast {
            let flower = FlowerOfHeal()
            flower.create(level: _curRole._unit._level)
            flower._seat = b.getEmptySeats().one()
            let bu = b.addPlayerMinion(unit: flower)
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
            if u._unit is FlowerOfHeal {
                return false
            }
        }
        return true
    }
}
