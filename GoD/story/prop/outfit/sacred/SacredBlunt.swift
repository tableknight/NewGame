//
//  SacredBlunt.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/30.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class IberisThignbone:Blunt {
    override init() {
        super.init()
        _name = "伊比利斯的腿骨"
        _description = "打人特别疼"
        _chance = 90
        _quality = Quality.SACRED
        _level = 23
        price = 126
    }
    
    override func create() {
        createSelfAttrs()
        createAttr(attrId: STRENGTH, value: 15, remove: true)
        createAttr(attrId: STAMINA, value: 15, remove: true)
        createAttr(attrId: REVENGE, value: 15, remove: true)
        createAttr(attrId: SPEED, value: -15, remove: true)
        _attrCount = 1
        createAttrs()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class GiantFang:Blunt {
    override init() {
        super.init()
        _name = "巨牙"
        _description = "攻击吸血"
        _level = 42
        _chance = 60
        _quality = Quality.SACRED
        price = 288
    }
    override func create() {
        createSelfAttrs()
        createAttr(attrId: STAMINA, value: 30, remove: true)
        createAttr(attrId: HEALTH, value: seedFloat(min: 40, max: 66), remove: true)
        createAttr(attrId: DEFENCE, value: seedFloat(min: 30, max: 41), remove: true)
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

class ThorsHammer:Blunt {
    override init() {
        super.init()
        _name = "雷神之锤"
        _description = "提升落雷伤害100%"
        _level = 48
        _chance = 30
        _quality = Quality.SACRED
        price = 882
    }
    override func create() {
        createSelfAttrs()
        createAttr(attrId: STRENGTH, value: 40, remove: true)
        createAttr(attrId: THUNDERPOWER, value: 40, remove: true)
        createAttr(attrId: THUNDERRESISTANCE, value: 40, remove: true)
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

class HolyPower:Blunt {
    override init() {
        super.init()
        _name = "神圣力量"
        _description = "对亡灵的伤害提升100%"
        _level = 65
        _chance = 35
        _quality = Quality.SACRED
        price = 998
    }
    override func create() {
        createSelfAttrs()
        createAttr(attrId: STRENGTH, value: seedFloat(min: 40, max: 51), remove: true)
        createAttr(attrId: STAMINA, value: seedFloat(min: 40, max: 51), remove: true)
        createAttr(attrId: INTELLECT, value: seedFloat(min: 40, max: 51), remove: true)
        createAttr(attrId: HEALTH, value: seedFloat(min: 80, max: 101), remove: true)
        _attrCount = 1
        createAttrs()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class IdyllssHand:Blunt {
    override init() {
        super.init()
        _name = "埃迪斯之手"
        _description = "普通攻击有一定几率造成两次伤害"
        _level = 71
        _chance = 5
        _quality = Quality.SACRED
        price = 2882
    }
    override func create() {
        createAttr(attrId: ATTACK_BASE)
        createAttr(attrId: CRITICAL, value: 60, remove: true)
        createAttr(attrId: STRENGTH, value: seedFloat(min: 45, max: 56), remove: true)
        createAttr(attrId: AGILITY, value: seedFloat(min: 45, max: 56), remove: true)
        createAttr(attrId: REVENGE, value: seedFloat(min: 10, max: 21), remove: true)
        createAttr(attrId: RHYTHM, value: seedFloat(min: 10, max: 21), remove: true)
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
