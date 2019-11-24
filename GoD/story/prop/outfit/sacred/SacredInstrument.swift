//
//  SacredInstrument.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/30.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class TheMonatNotes:Instrument {
    static let EFFECTION = "the_monat_notes"
    override init() {
        super.init()
        _name = "莫纳手记"
        _description = "该法器提供的技能可以使用两次"
        _level = 52
        _chance = 10
        _quality = Quality.SACRED
        _effection = TheMonatNotes.EFFECTION
        price = 1820
    }
    override func create() {
        createSelfAttrs()
        createSpell()
        createAttr(attrId: INTELLECT, value: 30, remove: true)
        createAttr(attrId: SPEED, value: 30, remove: true)
        createAttr(attrId: FIREPOWER, value: 30, remove: true)
        createAttr(attrId: RHYTHM, value: 12, remove: true)
        _attrCount = 2
        createAttrs()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class NoPants:Instrument {
    override init() {
        super.init()
        _name = "真空"
        _description = "施法时有一定几率走光"
        _level = 12
        _chance = 100
        _quality = Quality.SACRED
        price = 100
    }
    override func create() {
        createSelfAttrs()
        createSpell()
        createAttr(attrId: MAGICAL_POWER, value: 5, remove: true)
        createAttr(attrId: FIREPOWER, value: seedFloat(min: 10, max: 21), remove: true)
        createAttr(attrId: WATERPOWER, value: seedFloat(min: 10, max: 21), remove: true)
        createAttr(attrId: THUNDERPOWER, value: seedFloat(min: 10, max: 21), remove: true)
        
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class CreationMatrix:Instrument {
    override init() {
        super.init()
        _name = "创世之矩"
        _description = "战斗开始时，移除一个技能的冷却时间"
        _level = 52
        _chance = 3
        _quality = Quality.SACRED
        price = 1020
    }
    override func create() {
        createSelfAttrs()
        createSpell()
        createAttr(attrId: INTELLECT, value: 0, remove: true)
        createAttr(attrId: HEALTH, value: 0, remove: true)
        createAttr(attrId: DEFENCE, value: 0, remove: true)
        createAttr(attrId: MIND, value: 0, remove: true)
        createAttr(attrId: AVOID, value: 0, remove: true)
        _attrCount = 2
        createAttrs()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class IssHead:Instrument {
    override init() {
        super.init()
        _name = "艾斯斯之颅"
        _description = "傀儡师的头也是木头做的"
        _level = 10
        _chance = 10
        _quality = Quality.SACRED
        price = 181
    }
    override func create() {
        createSelfAttrs()
        _spell = [LowerSummon(), HighLevelSummon(), SummonFlower(), WaterCopy()].one()
        createAttr(attrId: INTELLECT, value: 12, remove: true)
        _attrCount = 3
        createAttrs()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class TheSurvive:Instrument {
    static let EFFECTION = "the_survive"
    override init() {
        super.init()
        _name = "生之书"
        _description = "提升生灵召唤物的属性"
        _level = 35
        _chance = 10
        _quality = Quality.SACRED
        _effection = TheSurvive.EFFECTION
        price = 366
    }
    override func create() {
        createSelfAttrs()
        createSpell()
        createAttr(attrId: STAMINA, value: seedFloat(min: 20, max: 26), remove: true)
        createAttr(attrId: INTELLECT, value: seedFloat(min: 20, max: 26), remove: true)
        _attrCount = 3
        createAttrs()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class TheDeath:Instrument {
    static let EFFECTION = "the_death"
    override init() {
        super.init()
        _name = "死之书"
        _description = "提升亡灵召唤物的属性"
        _level = 35
        _chance = 10
        _quality = Quality.SACRED
        _effection = TheDeath.EFFECTION
        price = 366
    }
    override func create() {
        createSelfAttrs()
        createSpell()
        createAttr(attrId: STAMINA, value: seedFloat(min: 20, max: 26), remove: true)
        createAttr(attrId: INTELLECT, value: seedFloat(min: 20, max: 26), remove: true)
        _attrCount = 3
        createAttrs()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class TheAbandon:Instrument {
    static let EFFECTION = "the_abandon"
    override init() {
        super.init()
        _name = "弃之书"
        _description = "提升恶魔召唤物的属性"
        _level = 35
        _chance = 10
        _quality = Quality.SACRED
        _effection = TheAbandon.EFFECTION
        price = 366
    }
    override func create() {
        createSelfAttrs()
        createSpell()
        createAttr(attrId: STAMINA, value: seedFloat(min: 20, max: 26), remove: true)
        createAttr(attrId: INTELLECT, value: seedFloat(min: 20, max: 26), remove: true)
        _attrCount = 3
        createAttrs()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class TheSurpass:Instrument {
    static let EFFECTION = "the_surpass"
    override init() {
        super.init()
        _name = "越之书"
        _description = "赋予你的召唤物此物品所携带的法术"
        _level = 45
        _chance = 10
        _quality = Quality.SACRED
        _effection = TheSurpass.EFFECTION
        price = 466
    }
    override func create() {
        createSelfAttrs()
        createSpell()
        createAttr(attrId: STAMINA, value: seedFloat(min: 25, max: 33), remove: true)
        createAttr(attrId: INTELLECT, value: seedFloat(min: 25, max: 33), remove: true)
        _attrCount = 3
        createAttrs()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class TheFear:Instrument {
    static let EFFECTION = "the_fear"
    override init() {
        super.init()
        _name = "畏之书"
        _description = "移除所有召唤术的冷却世纪"
        _level = 45
        _chance = 10
        _quality = Quality.SACRED
        _effection = TheFear.EFFECTION
        price = 466
    }
    override func create() {
        createSelfAttrs()
        createSpell()
        createAttr(attrId: STAMINA, value: seedFloat(min: 25, max: 33), remove: true)
        createAttr(attrId: INTELLECT, value: seedFloat(min: 25, max: 33), remove: true)
        _attrCount = 3
        createAttrs()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

