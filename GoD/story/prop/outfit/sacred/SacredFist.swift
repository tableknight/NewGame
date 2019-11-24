//
//  SacredFist.swift
//  GoD
//
//  Created by kai chen on 2019/11/10.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class FingerBone:Fist {
    static let CHANCE:Int = 25
    override init() {
        super.init()
        _name = "指骨"
        _description = ""
        _level = 25
        _chance = FingerBone.CHANCE
        price = 120
        _quality = Quality.SACRED
    }
    override func create() {
        createSelfAttrs()
        createAttr(attrId: AGILITY, value: 20, remove: true)
        createAttr(attrId: CRITICAL, value: 20, remove: true)
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

class LiosHold:Fist {
    static let EFFECTION = "lios_hold"
    static let CHANCE:Int = 25
    override init() {
        super.init()
        _name = "莱奥斯之握"
        _description = "碎冰拳附加的冰冷伤害现在为生命上限"
        _level = 33
        _chance = LiosHold.CHANCE
        _effection = LiosHold.EFFECTION
        price = 192
        _quality = Quality.SACRED
    }
    override func create() {
        createSelfAttrs()
        createAttr(attrId: HEALTH, value: 40, remove: true)
        createAttr(attrId: WATERPOWER, value: seedFloat(min: 20, max: 31), remove: true)
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


class DragonClaw:Fist {
    static let EFFECTION = "dragon_claw"
    static let CHANCE:Int = 15
    override init() {
        super.init()
        _name = "巨龙爪"
        _description = "烈焰拳不再有冷却时间"
        _level = 45
        _chance = DragonClaw.CHANCE
        price = 332
        _quality = Quality.SACRED
        _effection = DragonClaw.EFFECTION
    }
    override func create() {
        createSelfAttrs()
        createAttr(attrId: STRENGTH, value: 30, remove: true)
        createAttr(attrId: FIREPOWER, value: seedFloat(min: 20, max: 31), remove: true)
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

class NilSeal:Fist {
    static let EFFECTION = "nil_seal"
    static let CHANCE:Int = 15
    override init() {
        super.init()
        _name = "尼尔的禁锢"
        _description = "气功波增加1目标"
        _level = 58
        _chance = NilSeal.CHANCE
        price = 660
        _quality = Quality.SACRED
        _effection = NilSeal.EFFECTION
    }
    override func create() {
        createSelfAttrs()
        createAttr(attrId: STAMINA, value: 36, remove: true)
        createAttr(attrId: STRENGTH, value: 36, remove: true)
        createAttr(attrId: AGILITY, value: 36, remove: true)
        createAttr(attrId: INTELLECT, value: 36, remove: true)
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

class DeepCold:Fist {
    static let EFFECTION = "deep_cold"
    static let CHANCE:Int = 35
    override init() {
        super.init()
        _name = "极寒之握"
        _description = "进入极寒领域，冻结触碰到的一切"
        _level = 40
        _chance = DeepCold.CHANCE
        _effection = DeepCold.EFFECTION
        price = 410
        _quality = Quality.SACRED
    }
    override func create() {
        createSelfAttrs()
        createAttr(attrId: STAMINA, value: seedFloat(min: 20, max: 29), remove: true)
        createAttr(attrId: INTELLECT, value: seedFloat(min: 20, max: 29), remove: true)
        createAttr(attrId: WATERPOWER, value: seedFloat(min: 20, max: 29), remove: true)
        createAttr(attrId: MIND, value: seedFloat(min: 20, max: 29), remove: true)
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
