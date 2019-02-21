//
//  WaterCopy.swift
//  GoD
//
//  Created by kai chen on 2019/2/21.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class WaterCopy:Magical {
    override init() {
        super.init()
        _name = "水分身"
        _description = "召唤一个水分身，继承所有属性，无法攻击"
        _quality = Quality.RARE
        _cooldown = 3
        autoCast = true
    }
    override func cast(completion: @escaping () -> Void) {
        let b = _battle!
        let c = _battle._curRole
        c.actionCast {
            let copy = SummonUnit()
            copy._level = c._unit._level
            copy._img = c._unit._img
            copy._spellsInuse = [NoAction()]
            copy._extensions.health = c.getHealth()
            copy._extensions.hp = c.getHp()
            copy._extensions.defence = c.getDefence()
            copy._extensions.attack = c.getAttack()
            copy._extensions.spirit = c.getSpirit()
            copy._extensions.speed = c.getSpeed()
            copy._extensions.avoid = c.getAvoid()
            copy._extensions.mind = c.getMind()
            copy._elementalResistance.water = 50
            let seats = b.getEmptySeats()
            copy._seat = seats.one()
            let u = b.addPlayerMinion(unit: copy)
            u.alpha = 0.75
            u.actionSummon {
                completion()
            }
        }
    }
    override func selectable() -> Bool {
        if _battle._curRole.playerPart {
            return _battle._playerPart.count < 6
        } else {
            return _battle._enemyPart.count < 6
        }
    }
}

