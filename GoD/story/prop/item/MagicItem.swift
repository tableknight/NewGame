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
        _price = 112
        _storePrice = _price * 4
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

class ExpBook:MagicItem {
    override init() {
        super.init()
        _price = 68
        _storePrice = 16
        _name = "传承之书"
        _description = "使己方单位获得640点经验值"
        _quality = Quality.RARE
        usable = true
        usableInBattle = false
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override func use(target: Creature) {
        removeFromChar()
        target.expUp(up: 640)
    }
}

class StarStone:MagicItem {
    override init() {
        super.init()
        _price = 0
        _storePrice = _price * 4
        _name = "星之石"
        _description = "获得若干个天使之泪"
        let sd = seed()
        if sd < 45 {
            _quality = Quality.NORMAL
        } else if sd < 70 {
            _quality = Quality.GOOD
        } else if sd < 90 {
            _quality = Quality.RARE
        } else {
            _quality = Quality.SACRED
        }
        usable = true
        usableInBattle = false
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override func use() {
        removeFromChar()
        var count = seed(min: 2, max: 6)
        if _quality == Quality.GOOD {
            count = seed(min: 4, max: 9)
        } else if _quality == Quality.RARE {
            count = seed(min: 6, max: 11)
        } else if _quality == Quality.SACRED {
            count = seed(min: 9, max: 16)
        }
        let t = TheWitchsTear()
        t._count = count
        Game.instance.char.addProp(p: t)
        showMsg(text: "获得天使之泪\(count)个")
    }
}

class SoulEssence:MagicItem {
    override init() {
        super.init()
        _price = 0
        _storePrice = _price * 4
        _name = "灵魂精华"
        _description = "获得一个1级的"
        _quality = Quality.RARE
        _level = 1
        usable = true
        usableInBattle = false
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override func use() {
        let char = Game.instance.char!
        if char._minions.count >= 6 {
            showMsg(text: "不能携带更多随从！")
            return
        }
        removeFromChar()
        let c = Creature.getCreatureByClass(c: _soul)
        c.create(level: 1)
        char._minions.append(c)
        
    }
    private var _soul:Creature!
    func create(soul:Creature) {
        _soul = soul
        _description = "获得一个1级的\(soul._name)"
    }
}
