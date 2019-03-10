//
//  SacredWand.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/30.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class LightingRod:Wand {
    override init() {
        super.init()
        _name = "避雷针"
        _description = "有效的降低雷电伤害"
        _level = 6
        _chance = 80
        _quality = Quality.SACRED
        price = 42
    }
    override func create() {
        createSelfAttrs()
        createAttr(attrId: THUNDERRESISTANCE, value: 50, remove: true)
        _attrCount = seed(min: 2, max: 4)
        createAttrs()
    }
}
class FireMaster:Wand {
    override init() {
        super.init()
        _name = "驭火者"
        _description = "降低所有火系法术1的冷却回合"
        _level = 51
        _chance = 15
        _quality = Quality.SACRED
        price = 1120
    }
    override func create() {
        createSelfAttrs()
        createAttr(attrId: STAMINA, value: 35, remove: true)
        createAttr(attrId: INTELLECT, value: 35, remove: true)
        createAttr(attrId: FIREPOWER, value: 35, remove: true)
        _attrCount = seed(min: 1, max: 4)
        createAttrs()
    }
}
class WitchWand:Wand {
    override init() {
        super.init()
        _name = "巫毒法杖"
        _description = "诅咒不再有冷却时间"
        _level = 63
        _chance = 35
        _quality = Quality.SACRED
        price = 1442
    }
    override func create() {
        createSelfAttrs()
        createAttr(attrId: STAMINA, value: 42, remove: true)
        createAttr(attrId: INTELLECT, value: 42, remove: true)
        createAttr(attrId: HEALTH, value: 0, remove: true)
        createAttr(attrId: MIND, value: 42, remove: true)
        _attrCount = seed(min: 2, max: 4)
        createAttrs()
    }
}
class PuppetMaster:Wand {
    override init() {
        super.init()
        _name = "大傀儡师"
        _description = "增加一个随从位"
        _level = 76
        _chance = 2
        _quality = Quality.SACRED
        price = 3440
    }
    override func create() {
        createSelfAttrs()
        createAttr(attrId: STAMINA, value: seedFloat(min: 50, max: 66), remove: true)
        createAttr(attrId: INTELLECT, value: seedFloat(min: 50, max: 66), remove: true)
        createAttr(attrId: MIND, value: 35, remove: true)
        createAttr(attrId: WATERRESISTANCE, value: 35, remove: true)
        _attrCount = 3
        createAttrs()
    }
    override func on() {
        super.on()
        Game.instance._char._minionsCount += 1
    }
    override func off() {
        super.off()
        let char =  Game.instance.char!
        char._minionsCount -= 1
        let minions = char.getReadyMinions()
        if minions.count > char._minionsCount {
            minions[0]._seat = BUnit.STAND_BY
        }
    }
}
