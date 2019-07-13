//
//  CreationMatrix.swift
//  GoD
//
//  Created by kai chen on 2019/7/13.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
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
