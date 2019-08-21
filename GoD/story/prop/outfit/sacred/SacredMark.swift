//
//  SacredMark.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/30.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class PuppetMark: MagicMark {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "傀儡印记"
        _description = "减少一个技能栏，增加一个随从位"
        _level = 52
        _chance = 10
        _quality = Quality.SACRED
        price = 996
    }
    override func create() {
        createSpell()
    }
    override func on() {
        super.on()
        let char = Game.instance.char!
        char._spellCount -= 1
        if char._spellsInuse.count > char._spellCount {
            let spell = char._spellsInuse.popLast()!
            char._spells.append(spell)
        }
        char._minionsCount += 1
    }
    override func off() {
        super.off()
        let char = Game.instance.char!
        char._minionsCount -= 1
        let minions = char.getReadyMinions()
        if minions.count > char._minionsCount {
            minions[0]._seat = BUnit.STAND_BY
        }
        char._spellCount += 1
    }
}
class MarkOfOaks:MagicMark {
    override init() {
        super.init()
        _name = "橡树印记"
        _description = "受物理伤害时有几率对释放橡树之力"
        _level = 25
        _chance = 75
        _quality = Quality.SACRED
        price = 110
    }
    override func create() {
        _spell = MightOfOaks()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class MarkOfDeathGod:MagicMark {
    override init() {
        super.init()
        _name = "死神印记"
        _description = "免疫即死和静默"
        _level = 43
        _chance = 25
        _quality = Quality.SACRED
        price = 225
    }
    override func create() {
        createSpell()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class MarkOfVitality:MagicMark {
    override init() {
        super.init()
        _name = "生命印记"
        _description = "提升生命之花的治疗效果"
        _level = 18
        _chance = 100
        _quality = Quality.SACRED
        price = 100
    }
    override func create() {
        _spell = SummonFlower()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class MarkOfHeaven:MagicMark {
    override init() {
        super.init()
        _name = "天堂印记"
        _description = "降低来自恶魔的伤害"
        _level = 31
        _chance = 75
        _quality = Quality.SACRED
        price = 187
    }
    override func create() {
        createSpell()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class MoltenFire:MagicMark {
    override init() {
        super.init()
        _name = "融火"
        _description = "提升火元素伤害"
        _level = 48
        _chance = 30
        _quality = Quality.SACRED
        price = 420
    }
    override func create() {
        createSpell()
        createAttr(attrId: FIREPOWER, value: seedFloat(min: 40, max: 51), remove: true)
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class TheEye:MagicMark {
    override init() {
        super.init()
        _name = "撒旦之眼"
        _description = "增加法术栏1"
        _level = 68
        _chance = 5
        _quality = Quality.SACRED
        price = 2880
    }
    override func create() {
        createSpell()
    }
    override func on() {
        super.on()
        Game.instance.char._spellCount += 1
    }
    override func off() {
        super.off()
        let char = Game.instance.char!
        char._spellCount -= 1
        if char._spellsInuse.count > char._spellCount {
            let spell = char._spellsInuse.popLast()!
            if !char.hasSpell(spell: spell) {
                char._spells.append(spell)
            } else {
                debug("spell exist in TheEye \(spell._name)")
            }
        }
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
