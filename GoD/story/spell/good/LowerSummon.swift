//
//  LowerSummon.swift
//  GoD
//
//  Created by kai chen on 2019/2/16.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class LowerSummon:Magical, SummonSkill {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "低阶召唤"
        _description = "召唤一个亡灵战士为你而战，最多只能控制一个亡灵战士"
        _quality = Quality.GOOD
        _cooldown = 5
        autoCast = true
    }
    override func cast(completion: @escaping () -> Void) {
        let b = _battle!
        let seats = _battle.getEmptySeats(top: !b._curRole.playerPart)
        _battle._curRole.actionCast {
            let seat = seats.one()
            let uw = UndeadWarrior()
            uw.create(level: b._curRole._unit._level)
            uw._seat = seat
            let bu = self._battle._curRole.playerPart ? b.addPlayerMinion(unit: uw) : b.addEnemy(unit: uw)
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
            for u in _battle._playerPart {
                if u._unit is UndeadWarrior {
                    return false
                }
            }
        } else {
            if _battle._enemyPart.count >= 6 {
                return false
            }
            for u in _battle._enemyPart {
                if u._unit is UndeadWarrior {
                    return false
                }
            }
        }
        return true
    }
}

