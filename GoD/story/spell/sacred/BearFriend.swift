//
//  BearFriend.swift
//  GoD
//
//  Created by kai chen on 2019/2/21.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class BearFriend:Magical, SummonSkill {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.BearFriend
        _name = "熊人之友"
        _description = "召唤一个熊战士为你而战，最多只能控制一个熊战士"
        _quality = Quality.SACRED
        _cooldown = 5
        autoCast = true
        cost(value: 60)
    }
    override func cast(completion: @escaping () -> Void) {
        let seats = _battle.getEmptySeats()
        let b = _battle
        let c = _battle._curRole
        c.actionCast {
            let seat = seats.one()
            let uw = BearWarrior()
            if c.weaponIs(Sacred.TheSurvive) {
                uw._mains.stamina *= SummonUnit.POWERUP_RATE
                uw._mains.strength *= SummonUnit.POWERUP_RATE
                uw._mains.agility *= SummonUnit.POWERUP_RATE
                uw._mains.intellect *= SummonUnit.POWERUP_RATE
//            } else if c.weaponIs(Sacred.TheSurpass) {
//               uw._spellsInuse.append(Game.instance.char._weapon!._spell)
            }
            
            uw.create(level: b._curRole._unit._level)
            uw._seat = seat
            let bu = c.playerPart ? b.addPlayerMinion(unit: uw) : b.addEnemy(unit: uw)
//            let bu = b.addPlayerMinion(unit: uw)
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

