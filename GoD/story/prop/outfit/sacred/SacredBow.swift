//
//  SacredBow.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/31.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Hawkeye:Bow {
    static let EFFECTION = "hawk_eye"
    override init() {
        super.init()
        _name = "鹰眼"
        _description = "攻击无法被闪避"
        _level = 33
        _chance = 50
        _quality = Quality.SACRED
        _effection = Hawkeye.EFFECTION
        price = 235
    }
    override func create() {
        createSelfAttrs()
        createAttr(attrId: CRITICAL, value: seedFloat(min: 20, max: 26), remove: true)
        createAttr(attrId: SPEED, value: seedFloat(min: 20, max: 26), remove: true)
        createAttr(attrId: LUCKY, value: seedFloat(min: 20, max: 26), remove: true)
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
class Boreas:Bow {
    static let EFFECTION = "boreas"
    override init() {
        super.init()
        _name = "北风之神"
        _description = "攻击力翻倍"
        _level = 31
        _chance = 100
        _quality = Quality.SACRED
        _effection = Boreas.EFFECTION
        price = 455
    }
    override func create() {
        _attackSpeed = seed(min: 5, max: 9).toFloat() * 0.1
        createSelfAttrs()
        createAttr(attrId: STRENGTH, value: 20, remove: true)
        createAttr(attrId: DEFENCE, value: 30, remove: true)
        createAttr(attrId: THUNDERRESISTANCE, value: 30, remove: true)
        createAttr(attrId: HEALTH, value: 100, remove: true)
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
class Skylark:Bow {
    override init() {
        super.init()
        _name = "云雀"
        _description = "射箭时发出云雀般的声音"
        _level = 11
        _chance = 100
        _quality = Quality.SACRED
        price = 65
    }
    override func create() {
        createSelfAttrs()
        createAttr(attrId: SPEED, value: 10, remove: true)
        createAttr(attrId: AVOID, value: 10, remove: true)
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

class Aonena:Bow {
    override init() {
        super.init()
        _name = "艾欧妮娜"
        _description = "王国一等弓箭手之弓"
        _level = 24
        _chance = 55
        _quality = Quality.SACRED
        price = 148
    }
    override func create() {
        createSelfAttrs()
        _attrCount = 6
        createAttrs()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class SoundOfWind:Bow {
    
    override init() {
        super.init()
        _name = "丧钟"
        _description = ""
        _level = 26
        _chance = 30
        _quality = Quality.SACRED
        price = 1677
    }
    override func create() {
        createAttr(attrId: ATTACK_BASE)
        createAttr(attrId: AGILITY, value: seedFloat(min: 5, max: 31), remove: true)
        createAttr(attrId: STRENGTH, value: seedFloat(min: 5, max: 31), remove: true)
        createAttr(attrId: STAMINA, value: seedFloat(min: 5, max: 31), remove: true)
        createAttr(attrId: INTELLECT, value: seedFloat(min: 5, max: 31), remove: true)
        createAttr(attrId: AVOID, value: seedFloat(min: 5, max: 31), remove: true)
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class FollowOn:Bow {
    static let EFFECTION = "follow_on"
    override init() {
        super.init()
        _name = "追击"
        _description = "你的随从会攻击你上一个攻击的的目标"
        _level = 36
        _chance = 30
        _quality = Quality.SACRED
        _effection = FollowOn.EFFECTION
        price = 400
    }
    override func create() {
        createSelfAttrs()
        createAttr(attrId: ACCURACY, remove: true)
        _attrCount = seed(min: 3, max: 6)
        createAttrs()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
