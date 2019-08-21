//
//  MagicItem.swift
//  GoD
//
//  Created by kai chen on 2019/8/10.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class MagicItem:Item {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        usable = false
        usableInBattle = true
        _quality = Quality.SACRED
        _priceType = Item.TYPE_TEAR
    }
}
class PsychicScroll:MagicItem {
    override init() {
        super.init()
        price = 12
        _name = "通灵卷轴"
        _description = "召唤一个亡灵为你而战"
        autoCast = true
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    //unit is selected target
    override func use(unit: BUnit, completion: @escaping () -> Void) {
        let b = _battle!
        let seats = _battle.getEmptySeats(top: !b._curRole.playerPart)
        _battle._curRole.actionCast {
            let seat = seats.one()
            let uw = [UndeadWarrior(), MummyMinion(), UndeadWitch(), UndeadMinion()].one()
            uw.create(level: b._curRole._unit._level)
            uw._seat = seat
            let bu = self._battle._curRole.playerPart ? b.addPlayerMinion(unit: uw) : b.addEnemy(unit: uw)
            bu.actionSummon {
                completion()
            }
        }
        removeFromChar()
    }
    override func selectable() -> Bool {
        let b = _battle!
        if b._playerPart.count >= 6 {
            return false
        }
        return true
    }
}

