//
//  SacredDagger.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/4.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class NightBlade: Dagger {
    override init() {
        super.init()
        _name = "夜刃"
        _level = 16
        _description = "对亡灵造成的全伤害提升25%。"
        _chance = 48
        _quality = Quality.SACRED
        price = 48
    }
    
    override func create() {
        createAttr(attrId: ATTACK_BASE)
        createAttr(attrId: STRENGTH, value: 10, remove: true)
        createAttr(attrId: AGILITY, value: 10, remove: true)
        _attrCount = seed(min: 2, max: 5)
        createAttrs()
    }
}
class LazesPedicureKnife:Dagger {
    override init() {
        super.init()
        _name = "拉兹的修脚刀"
        _description = "普通攻击有几率获得一点敏捷"
        _level = 21
        _chance = 100
        _quality = Quality.SACRED
        price = 85
    }
    override func create() {
        createSelfAttrs()
        createAttr(attrId: ACCURACY, value: 15, remove: true)
        createAttr(attrId: AVOID, value: 15, remove: true)
        createAttr(attrId: LUCKY, value: 15, remove: true)
        _attrCount = 2
        createAttrs()
    }
}
