////
////  SacredMark.swift
////  TheWitchNight
////
////  Created by kai chen on 2018/7/30.
////  Copyright © 2018年 Chen. All rights reserved.
////
//
//import SpriteKit
//class PuppetMark: MagicMark {
//    static let EFFECTION = "puppet_mark"
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//    override init() {
//        super.init()
//        _name = "傀儡印记"
//        _description = "减少一个技能栏，增加一个随从位"
//        _level = 32
//        _chance = 10
//        _quality = Quality.SACRED
//        _effection = PuppetMark.EFFECTION
//        price = 996
//    }
//    override func create() {
//        createSpell()
//    }
////    override func on() {
////        super.on()
////        let char = Game.instance.char!
////        char._spellCount -= 1
////        if char._spellsInuse.count > char._spellCount {
////            let spell = char._spellsInuse.popLast()!
////            char._spells.append(spell)
////        }
////        char._minionsCount += 1
////    }
////    override func off() {
////        super.off()
////        let char = Game.instance.char!
////        char._minionsCount -= 1
////        let minions = char.getReadyMinions()
////        if minions.count > char._minionsCount {
////            minions[0]._seat = BUnit.STAND_BY
////        }
////        char._spellCount += 1
////    }
//}
//class MarkOfOaks:MagicMark {
//    static let EFFECTION = "mark_of_oaks"
//    override init() {
//        super.init()
//        _name = "橡树印记"
//        _description = "受物理伤害时有几率对释放橡树之力"
//        _level = 25
//        _chance = 75
//        _quality = Quality.SACRED
//        _effection = MarkOfOaks.EFFECTION
//        price = 110
//    }
//    override func create() {
//        _spell = MightOfOaks()
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}
//class MarkOfDeathGod:MagicMark {
//    static let EFFECTION = "mark_of_death_god"
//    override init() {
//        super.init()
//        _name = "死神印记"
//        _description = "免疫即死和静默"
//        _level = 23
//        _chance = 25
//        _quality = Quality.SACRED
//        _effection = MarkOfDeathGod.EFFECTION
//        price = 225
//    }
//    override func create() {
//        createSpell()
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}
//class MarkOfVitality:MagicMark {
//    static let EFFECTION = "mark_of_vitality"
//    override init() {
//        super.init()
//        _name = "生命印记"
//        _description = "提升生命之花的治疗效果"
//        _level = 18
//        _chance = 100
//        _quality = Quality.SACRED
//        _effection = MarkOfVitality.EFFECTION
//        price = 100
//    }
//    override func create() {
//        _spell = SummonFlower()
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}
//class MarkOfHeaven:MagicMark {
//    static let EFFECTION = "mark_of_heaven"
//    override init() {
//        super.init()
//        _name = "天堂印记"
//        _description = "降低来自恶魔的伤害"
//        _level = 31
//        _chance = 75
//        _quality = Quality.SACRED
//        _effection = MarkOfHeaven.EFFECTION
//        price = 187
//    }
//    override func create() {
//        createSpell()
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}
//class MoltenFire:MagicMark {
////    static let EFFECTION = "molten_fire"
//    override init() {
//        super.init()
//        _name = "融火"
//        _description = "大幅提升火元素伤害"
//        _level = 28
//        _chance = 30
//        _quality = Quality.SACRED
//        price = 420
//    }
//    override func create() {
//        createSpell()
//        createAttr(attrId: FIREPOWER, value: seedFloat(min: 40, max: 51), remove: true)
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}
//class TheEye:MagicMark {
//    static let EFFECTION = "the_eye"
//    override init() {
//        super.init()
//        _name = "撒旦之眼"
//        _description = "获得一个额外的技能卡槽"
//        _level = 40
//        _chance = 5
//        _quality = Quality.SACRED
//        _effection = TheEye.EFFECTION
//        price = 2880
//    }
//    override func create() {
//        createSpell()
//    }
////    override func on() {
////        super.on()
////        Game.instance.char._spellCount += 1
////    }
////    override func off() {
////        super.off()
////        let char = Game.instance.char!
////        char._spellCount -= 1
////        if char._spellsInuse.count > char._spellCount {
////            let spell = char._spellsInuse.popLast()!
////            if !char.hasSpell(spell: spell) {
////                char._spells.append(spell)
////            } else {
////                debug("spell exist in TheEye \(spell._name)")
////            }
////        }
////    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}
//class FireMark:MagicMark {
//    static let EFFECTION = "fire_mark"
//    override init() {
//        super.init()
//        _name = "火焰纹章"
//        _description = "延长燃烧效果一回合"
//        _level = 33
//        _chance = 27
//        _quality = Quality.SACRED
//        _effection = FireMark.EFFECTION
//        price = 210
//    }
//    override func create() {
//        _spell = [LavaExplode(), Combustion(), BurnHeart(), BurningOut(), FireRain(), FireBreath()].one()
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}
//
//class IssMark:MagicMark {
//    override init() {
//        super.init()
//        _name = "艾斯斯之印"
//        _description = "获得一个召唤系技能"
//        _level = 10
//        _chance = 75
//        _quality = Quality.SACRED
//        price = 190
//    }
//    override func create() {
//        _spell = [LowerSummon(), HighLevelSummon(), SummonFlower(), WaterCopy()].one()
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}
