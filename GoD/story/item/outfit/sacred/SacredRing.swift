////
////  SacredRing.swift
////  TheWitchNight
////
////  Created by kai chen on 2018/5/5.
////  Copyright © 2018年 Chen. All rights reserved.
////
//
//import SpriteKit
//class RingOfDead:Ring {
//    static let EFFECTION = "ring_of_dead"
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//    override init() {
//        super.init()
//        _name = "亡灵之戒"
//        _description = "种族转换为亡灵。"
//        _level = 12
//        _chance = 100
//        _quality = Quality.SACRED
//        _effection = RingOfDead.EFFECTION
//        _unique = true
//        price = 108
//    }
//    override func create() {
//        createAttr(attrId: MIND, value: 10, remove: true)
//        createAttr(attrId: INTELLECT, value: 10, remove: true)
//        createAttr(attrId: WATERRESISTANCE, value: 10, remove: true)
//        _attrCount = 2
//        createAttrs()
//    }
////    private var _backup = 0
////    override func on() {
////        super.on()
//////        _backup = Data.instance._char._race
////        Game.instance.char._race = EvilType.RISEN
////    }
////    
////    override func off() {
////        super.off()
////        if nil != Game.instance.char._soulStone {
////            Game.instance.char._race = Game.instance.char._soulStone!._race
////        } else {
////            Game.instance.char._race = EvilType.MAN
////        }
////        
////    }
//}
//class IdlirWeddingRing:Ring {
//    static let EFFECTION = "idlir_wedding_ring"
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//    override init() {
//        super.init()
//        _name = "伊德利尔的婚戒"
//        _description = "变形成为伊德利尔的新娘"
//        _level = 29
//        _chance = 100
//        _quality = Quality.SACRED
//        _effection = IdlirWeddingRing.EFFECTION
//        _unique = true
//        price = 199
//    }
//    override func create() {
//        createAttr(attrId: SPIRIT, value: 0, remove: true)
//        createAttr(attrId: SPEED, value: 0, remove: true)
//        createAttr(attrId: AVOID, value: 0, remove: true)
//        _attrCount = seed(min: 2, max: 4)
//        createAttrs()
//    }
////    var _originalImage = SKTexture()
////    override func on() {
////        super.on()
////        _originalImage = Game.instance.char._img
////        let t = SKTexture(imageNamed: "idlir_bride.png")
////        Game.instance.char._img = t
////        Game.instance.curStage._curScene._role._charTexture = t
////    }
////    override func off() {
////        Game.instance.char._img = _originalImage
////        Game.instance.curStage._curScene._role._charTexture = _originalImage
////    }
//}
//class ApprenticeRing:Ring {
//    static let EFFECTION = "apprentice_ring"
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//    override init() {
//        super.init()
//        _name = "学徒法戒"
//        _description = "略微提高玩火的成功几率"
//        _level = 2
//        _chance = 50
//        _quality = Quality.SACRED
//        _effection = ApprenticeRing.EFFECTION
//        price = 40
//    }
//    override func create() {
//        createAttr(attrId: INTELLECT, value: 2, remove: true)
//        createAttr(attrId: SPIRIT, value: 2, remove: true)
//        createAttr(attrId: FIREPOWER, value: 0, remove: true)
//        _attrCount = 2
//        createAttrs()
//    }
//}
//class CopperRing:Ring {
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//    override init() {
//        super.init()
//        _name = "铜质戒指"
//        _description = "铜的比较耐火"
//        _level = 5
//        _chance = 100
//        _quality = Quality.SACRED
//        price = 28
//    }
//    override func create() {
//        createAttr(attrId: FIRERESISTANCE, value: 10, remove: true)
//        _attrCount = seed(min: 2, max: 4)
//        createAttrs()
//    }
//}
//class SilverRing:Ring {
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//    override init() {
//        super.init()
//        _name = "银质戒指"
//        _level = 15
//        _chance = 100
//        _quality = Quality.SACRED
//        price = 92
//    }
//    override func create() {
//        createAttr(attrId: STRENGTH, value: 10, remove: true)
//        createAttr(attrId: AVOID, value: 10, remove: true)
//        createAttr(attrId: FIRERESISTANCE, value: 15, remove: true)
//        _attrCount = 2
//        createAttrs()
//    }
//}
//class DellarsGoldenRing:Ring {
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//    override init() {
//        super.init()
//        _name = "德拉的金戒"
//        _description = "真金不怕火炼"
//        _level = 25
//        _chance = 60
//        _quality = Quality.SACRED
//        price = 112
//    }
//    override func create() {
//        createAttr(attrId: FIRERESISTANCE, value: 30, remove: true)
//        createAttr(attrId: FIREPOWER, value: 30, remove: true)
//        _attrCount = seed(min: 2, max: 4)
//        createAttrs()
//    }
//}
//class LuckyRing:Ring {
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//    override init() {
//        super.init()
//        _name = "幸运指环"
//        _level = 15
//        _chance = 100
//        _quality = Quality.SACRED
//        price = 88
//    }
//    override func create() {
//        createAttr(attrId: AVOID, value: 8, remove: true)
//        createAttr(attrId: RHYTHM, value: 8, remove: true)
//        createAttr(attrId: REVENGE, value: 8, remove: true)
//        createAttr(attrId: CRITICAL, value: 10, remove: true)
//        createAttr(attrId: LUCKY, value: seedFloat(min: 10, max: 21), remove: true)
//    }
//}
//
//class RingOfDeath:Ring {
//    static let EFFECTION = "ring_of_death"
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//    override init() {
//        super.init()
//        _name = "逝者之戒"
//        _description = "提升自身50%的治疗效果"
//        _level = 25
//        _chance = 30
//        _quality = Quality.SACRED
//        _effection = RingOfDeath.EFFECTION
//        _unique = true
//        price = 542
//    }
//    override func create() {
//        createAttr(attrId: SPIRIT, value: 0, remove: true)
//        _attrCount = seed(min: 3, max: 5)
//        createAttrs()
//    }
//}
//
//class RingFromElder:Ring {
//    static let EFFECTION = "ring_from_elder"
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//    override init() {
//        super.init()
//        _name = "长者之戒"
//        _description = "提升自身25%经验获取"
//        _level = 15
//        _chance = 30
//        _unique = true
//        _quality = Quality.SACRED
//        _effection = RingFromElder.EFFECTION
//        price = 129
//        
//    }
//    override func create() {
//        createAttr(attrId: INTELLECT, remove: true)
//        _attrCount = seed(min: 3, max: 5)
//        createAttrs()
//    }
//}
//
//class RingOfReborn:Ring {
//    static let EFFECTION = "ring_of_reborn"
//    override init() {
//        super.init()
//        _name = "再生指环"
//        _description = "额外刻印一个恢复系法术"
//        _level = 32
//        _chance = 10
//        _unique = true
//        _quality = Quality.SACRED
//        _effection = RingOfReborn.EFFECTION
//        price = 330
//        
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
////    var _spellAppended = false
////    var _spell = Spell()
//    override func create() {
//        createAttr(attrId: STAMINA, remove: true)
//        _attrCount = seed(min: 3, max: 5)
//        _spell = [Heal(), QuickHeal(), HealAll(), SpringIsComing()].one()
//        createAttrs()
//    }
////    private enum CodingKeys: String, CodingKey {
////        case _spellAppended
////        case _spell
////    }
////    required init(from decoder: Decoder) throws {
////        let values = try decoder.container(keyedBy: CodingKeys.self)
////        let s = try values.decode(String.self, forKey: ._spell)
////        let l = Loot()
////        let allSpells = l.getAllSpells()
////        for spell in allSpells {
////            if NSClassFromString(s) == type(of: spell) {
////                _spell = spell
////                break
////            }
////        }
////        _spellAppended = try values.decode(Bool.self, forKey: ._spellAppended)
////        try super.init(from: decoder)
////    }
////    override func encode(to encoder: Encoder) throws {
////        try super.encode(to: encoder)
////        var container = encoder.container(keyedBy: CodingKeys.self)
////        try container.encode(_spellAppended, forKey: ._spellAppended)
////        try container.encode(NSStringFromClass(type(of: _spell)), forKey: ._spell)
////    }
////    override func on() {
////        super.on()
////        let char = Game.instance.char!
////        if !(char.hasSpellHidden(spell: _spell)) {
////            char._spellsHidden.append(_spell)
////            _spellAppended = true
////        }
////    }
////    override func off() {
////        super.off()
////        if _spellAppended {
////            let char = Game.instance.char!
////            char.removeSpellHidden(spell: _spell)
////            _spellAppended = false
////        }
////    }
//}
//class FireCore:Ring {
//    static let EFFECTION = "fire_core"
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//    override init() {
//        super.init()
//        _name = "火源核心"
//        _description = "提升所有点燃成功几率"
//        _level = 28
//        _chance = 50
//        _quality = Quality.SACRED
//        price = 240
//    }
//    override func create() {
//        createAttr(attrId: FIRERESISTANCE, value: 20, remove: true)
//        createAttr(attrId: FIREPOWER, value: 20, remove: true)
//        _attrCount = seed(min: 2, max: 4)
//        createAttrs()
//    }
//}
