//
//  SacredShield.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/4.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Faceless:Shield {
    override init() {
        super.init()
        _name = "无面者"
        _description = "每三个回合释放一次法术反射。"
        _level = 30
        _chance = 30
        _quality = Quality.SACRED
        price = 301
    }
    override func create() {
        createSelfAttrs()
        createAttr(attrId: STAMINA, value: seedFloat(min: 15, max: 26), remove: true)
        _attrCount = 4
        createAttrs()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class Accident:Shield {
    override init() {
        super.init()
        _name = "无妄之灾"
        _description = "将所有受到的法术伤害转移给队友"
        _level = 42
        _chance = 20
        _quality = Quality.SACRED
        price = 388
    }
    override func create() {
        createSelfAttrs()
        createAttr(attrId: FIRERESISTANCE, value: 30, remove: true)
        createAttr(attrId: WATERRESISTANCE, value: 30, remove: true)
        createAttr(attrId: THUNDERRESISTANCE, value: 30, remove: true)
        createAttr(attrId: HEALTH, value: seedFloat(min: 30, max: 76), remove: true)
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
class FrancisFace:Shield {
    override init() {
        super.init()
        _name = "佛朗西斯的面容"
        _description = "受到伤害时有一定几率获得5暴击"
        _level = 40
        _chance = 25
        _quality = Quality.SACRED
        price = 422
    }
    override func create() {
        createSelfAttrs()
        createAttr(attrId: STRENGTH, value: seedFloat(min: 20, max: 31), remove: true)
        createAttr(attrId: STAMINA, value: seedFloat(min: 20, max: 31), remove: true)
        createAttr(attrId: AVOID, value: 20, remove: true)
        createAttr(attrId: REVENGE, value: 10, remove: true)
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
class EvilExpel:Shield {
    override init() {
        super.init()
        _name = "辟邪"
        _description = "有一定几率低挡来自恶魔的伤害"
        _level = 23
        _chance = 50
        _quality = Quality.SACRED
        price = 228
    }
    override func create() {
        createSelfAttrs()
        createAttr(attrId: STAMINA, value: 12, remove: true)
        createAttr(attrId: HEALTH, value: 30, remove: true)
        createAttr(attrId: THUNDERRESISTANCE, value: 20, remove: true)
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
