//
//  HighLevelSummon.swift
//  GoD
//
//  Created by kai chen on 2019/2/21.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class HighLevelSummon:Magical, SummonSkill {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.HighLevelSummon
        _name = "高阶召唤"
        _description = "召唤一个亡灵巫师为你而战，最多只能控制一个亡灵巫师"
        _quality = Quality.SACRED
        _cooldown = 5
        autoCast = true
    }
    override func cast(completion: @escaping () -> Void) {
        let b = _battle
        let c = b._curRole
        let seats = _battle.getEmptySeats(top: !b._curRole.playerPart)
        c.actionCast {
            let seat = seats.one()
            let uw = UndeadWitch()
//            if c.weaponIs(TheDeath.EFFECTION) {
//                uw._mains.stamina *= SummonUnit.POWERUP_RATE
//                uw._mains.strength *= SummonUnit.POWERUP_RATE
//                uw._mains.agility *= SummonUnit.POWERUP_RATE
//                uw._mains.intellect *= SummonUnit.POWERUP_RATE
//            } else if c.weaponIs(TheSurpass.EFFECTION) {
//                           uw._spellsInuse.append(Game.instance.char._weapon!._spell)
//                       }
            uw.create(level: b._curRole._unit._level)
            uw._seat = seat
            let bu = c.playerPart ? b.addPlayerMinion(unit: uw) : b.addEnemy(unit: uw)
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
                if u._unit is UndeadWitch {
                    return false
                }
            }
        } else {
            if _battle._enemyPart.count >= 6 {
                return false
            }
            for u in _battle._enemyPart {
                if u._unit is UndeadWitch {
                    return false
                }
            }
        }
        return true
    }
}

