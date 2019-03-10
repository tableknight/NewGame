//
//  SacredBow.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/31.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Hawkeye:Bow {
    override init() {
        super.init()
        _name = "鹰眼"
        _description = "攻击无法被闪避"
        _level = 33
        _chance = 50
        _quality = Quality.SACRED
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
}
class Boreas:Bow {
    override init() {
        super.init()
        _name = "北风之神"
        _description = "攻击力翻倍"
        _level = 55
        _chance = 100
        _quality = Quality.SACRED
        price = 455
    }
    override func create() {
        _attackSpeed = seed(min: 5, max: 9).toFloat() * 0.1
        createSelfAttrs()
        createAttr(attrId: STRENGTH, value: 35, remove: true)
        createAttr(attrId: DEFENCE, value: 35, remove: true)
        createAttr(attrId: THUNDERRESISTANCE, value: 35, remove: true)
        createAttr(attrId: HEALTH, value: 35, remove: true)
        _attrCount = 2
        createAttrs()
    }
}
class Skylark:Bow {
    override init() {
        super.init()
        _name = "云雀"
        _description = "射箭的声音像云雀的叫声"
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
}

class SoundOfWind:Bow {
    override init() {
        super.init()
        _name = "风声"
        _description = "像风一样灵巧"
        _level = 66
        _chance = 30
        _quality = Quality.SACRED
        price = 677
    }
    override func create() {
        createAttr(attrId: ATTACK_BASE)
        createAttr(attrId: AGILITY, value: seedFloat(min: 30, max: 51), remove: true)
        createAttr(attrId: STRENGTH, value: seedFloat(min: 30, max: 51), remove: true)
        createAttr(attrId: STAMINA, value: seedFloat(min: 30, max: 51), remove: true)
        createAttr(attrId: INTELLECT, value: seedFloat(min: 30, max: 51), remove: true)
        createAttr(attrId: AVOID, value: seedFloat(min: 30, max: 51), remove: true)
    }
}
