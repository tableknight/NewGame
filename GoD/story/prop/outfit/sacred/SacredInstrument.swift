//
//  SacredInstrument.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/30.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class TheMonatNotes:Instrument {
    override init() {
        super.init()
        _name = "莫纳手记"
        _description = "该法器提供的技能可以使用两次"
        _level = 52
        _chance = 10
        _quality = Quality.SACRED
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

