//
//  AssassinsSword.swift
//  GoD
//
//  Created by kai chen on 2019/7/8.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class AssassinsSword:Sword {
    override init() {
        super.init()
        _name = "刺客之刃"
        _description = "提升50点暴击和50点毁灭"
        _level = 41
        _chance = 15
        _quality = Quality.SACRED
        price = 420
    }
    override func create() {
        createAttr(attrId: ATTACK_BASE)
        createAttr(attrId: AGILITY, value: seedFloat(min: 25, max: 36), remove: true)
        createAttr(attrId: ACCURACY, value: seedFloat(min: 25, max: 36), remove: true)
        createAttr(attrId: AVOID, value: seedFloat(min: 25, max: 36), remove: true)
        createAttr(attrId: LUCKY, value: seedFloat(min: 25, max: 36), remove: true)
    }
    override func on() {
        super.on()
        Game.instance.char._extensions.critical += 50
        Game.instance.char._extensions.destroy += 50
    }
    override func off() {
        super.off()
        Game.instance.char._extensions.critical -= 50
        Game.instance.char._extensions.destroy -= 50
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
