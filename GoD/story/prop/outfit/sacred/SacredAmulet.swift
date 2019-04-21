//
//  SacredAmulet.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/4.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class TrueLie: Amulet {
    override init() {
        super.init()
        _name = "真实的谎言"
        _description = "获得一个额外的技能栏"
        _level = 68
        _chance = 5
        _quality = Quality.SACRED
        price = 1689
    }
    override func create() {
        createSelfAttrs()
        createAttr(attrId: AVOID, value: 35, remove: true)
        createAttr(attrId: REVENGE, value: seedFloat(min: 15, max: 21), remove: true)
        createAttr(attrId: SPIRIT, value: seedFloat(min: 50, max: 81), remove: true)
        _attrCount = 2
        createAttrs()
    }
    override func on() {
        super.on()
        Game.instance.char._spellCount += 1
    }
    
    override func off() {
        super.off()
        let c = Game.instance.char!
        if c._spellsInuse.count >= c._spellCount {
            let last = c._spellsInuse.popLast()
            c._spells.append(last!)
        }
        c._spellCount -= 1
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class MedalOfCourage:Amulet {
    override init() {
        super.init()
        _name = "勇气勋章"
        _description = "最下面写着一行小字，二等功J·R"
        _level = 5
        _chance = 100
        _quality = Quality.SACRED
        price = 18
    }
    
    override func create() {
        createSelfAttrs()
        createAttr(attrId: STAMINA, value: 4, remove: true)
        createAttr(attrId: STRENGTH, value: 4, remove: true)
        createAttr(attrId: AGILITY, value: 4, remove: true)
        createAttr(attrId: INTELLECT, value: 4, remove: true)
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

class FangOfVampire:Amulet {
    override init() {
        super.init()
        _name = "吸血鬼獠牙"
        _description = "提升所有物理吸血效果100%。"
        _level = 35
        _chance = 75
        _quality = Quality.SACRED
        price = 229
    }
    
    override func create() {
        createSelfAttrs()
        createAttr(attrId: STRENGTH, value: 25, remove: true)
        createAttr(attrId: CRITICAL, value: 25, remove: true)
        createAttr(attrId: FIREPOWER, value: 25, remove: true)
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
class MoonShadow:Amulet {
    override init() {
        super.init()
        _name = "月影"
        _level = 15
//        _description = "迅捷无影踪"
        _chance = 60
        _quality = Quality.SACRED
        price = 82
    }
    override func create() {
        createAttr(attrId: AGILITY, value: 25, remove: true)
        _attrCount = seed(min: 2, max: 5)
        createAttrs()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class EternityNight:Amulet {
    override init() {
        super.init()
        _name = "永夜"
        _level = 28
        _chance = 80
        _quality = Quality.SACRED
        price = 126
    }
    override func create() {
        createSelfAttrs()
        createAttr(attrId: AVOID, value: 15, remove: true)
        createAttr(attrId: WATERPOWER, value: 25, remove: true)
        createAttr(attrId: WATERRESISTANCE, value: 35, remove: true)
        createAttr(attrId: LUCKY, value: seedFloat(min: 10, max: 16), remove: true)
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class Sparkling:Amulet {
    override init() {
        super.init()
        _name = "群星闪耀"
        _level = 12
        _chance  = 75
        _quality = Quality.SACRED
        price = 98
    }
    override func create() {
        createSelfAttrs()
        createAttr(attrId: STAMINA, value: 10, remove: true)
        createAttr(attrId: DEFENCE, value: 20, remove: true)
        createAttr(attrId: SPEED, value: seedFloat(min: 10, max: 16), remove: true)
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
class MedalOfHero:Amulet {
    override init() {
        super.init()
        _name = "英雄勋章"
        _description = "低挡一次致命伤害"
        _level = 18
        _chance = 60
        _quality = Quality.SACRED
        price = 186
    }
    override func create() {
        createSelfAttrs()
        createAttr(attrId: FIRERESISTANCE, value: seedFloat(min: 20, max: 31), remove: true)
        createAttr(attrId: WATERRESISTANCE, value: seedFloat(min: 20, max: 31), remove: true)
        createAttr(attrId: THUNDERRESISTANCE, value: seedFloat(min: 20, max: 31), remove: true)
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
class JadeHeart:Amulet {
    override init() {
        super.init()
        _name = "翡翠之心"
        _description = "降低来自首领的伤害"
        _level = 43
        _chance = 20
        _quality = Quality.SACRED
        price = 654
    }
    override func create() {
        createSelfAttrs()
        createAttr(attrId: STAMINA, value: seedFloat(min: 30, max: 41), remove: true)
        createAttr(attrId: THUNDERRESISTANCE, value: seedFloat(min: 30, max: 41), remove: true)
        createAttr(attrId: SPEED, value: seedFloat(min: 30, max: 41), remove: true)
        _attrCount = seed(min: 2, max: 4)
        createAttrs()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
