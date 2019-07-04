//
//  FireCore.swift
//  GoD
//
//  Created by kai chen on 2019/7/4.
//  Copyright © 2019 Chen. All rights reserved.
//

class FireCore:Ring {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "火源核心"
        _description = "提升所有点燃成功几率"
        _level = 28
        _chance = 50
        _quality = Quality.SACRED
        price = 240
    }
    override func create() {
        createAttr(attrId: FIRERESISTANCE, value: 20, remove: true)
        createAttr(attrId: FIREPOWER, value: 20, remove: true)
        _attrCount = seed(min: 2, max: 4)
        createAttrs()
    }
}
