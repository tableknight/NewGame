//
//  SummonFlower.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/15.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class SummonFlower: Magical, SummonSkill {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.SummonFlower
        _name = "生命之花"
        _description = "召唤生命之花，生命之花会在行动结束后治疗相邻单位，恢复其15%最大生命，持续5回合"
        _quality = Quality.SACRED
        _cooldown = 5
        autoCast = true
        cost(value: 60)
    }
    override func cast(completion: @escaping () -> Void) {
        let b = _battle
        let c = _battle._curRole
        _battle._curRole.actionCast {
            let flower = FlowerOfHeal()
            if c.weaponIs(Sacred.TheSurvive) {
                flower._mains.stamina *= SummonUnit.POWERUP_RATE
                flower._mains.strength *= SummonUnit.POWERUP_RATE
                flower._mains.agility *= SummonUnit.POWERUP_RATE
                flower._mains.intellect *= SummonUnit.POWERUP_RATE
            } else if c.weaponIs(Sacred.TheSurpass) {
                flower._spellsInuse.append(Game.instance.char._weapon!._spell)
            }
            flower.create(level: c._unit._level)
            flower._seat = b.getEmptySeats(top: !b._curRole.playerPart).one()
            let bu = b._curRole.playerPart ? b.addPlayerMinion(unit: flower) : b.addEnemy(unit: flower)
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
                if u._unit is FlowerOfHeal {
                    return false
                }
            }
        } else {
            if _battle._enemyPart.count >= 6 {
                return false
            }
            for u in _battle._enemyPart {
                if u._unit is FlowerOfHeal {
                    return false
                }
            }
        }
        return true
    }
}
