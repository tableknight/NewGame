//
//  Outfit.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/25.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit



class Outfit:Item {
    static let Wand = "Wand"
    static let Bow = "Bow"
    static let Blunt = "Blunt"
    static let Sword = "Sword"
    static let Instrument = "Instrument"
    static let Fist = "Fist"
    static let Dagger = "Dagger"
    static let MagicMark = "MagicMark"
    static let SoulStone = "SoulStone"
    static let Shield = "Shield"
    static let Ring = "Ring"
    static let Amulet = "Amulet"
    static let EarRing = "EarRing"
    
    
    override init(_ type:String = "") {
        super.init("")
        if type.isEmpty {
            return
        }
        _type = type
        setValue()
        _count = -1
        stackable = false
        showCount = false
        _all = [STAMINA,
                STRENGTH,
                AGILITY,
                INTELLECT,
                DEFENCE,
                SPEED,
                SPIRIT,
                ACCURACY,
                AVOID,
                CRITICAL,
                HEALTH,
                MIND,
                FIREPOWER,
                FIRERESISTANCE,
                WATERPOWER,
                WATERRESISTANCE,
                THUNDERPOWER,
                THUNDERRESISTANCE,
//                ELEMENTALPOWER,
//                ELEMENTALRESISTANCE,
                LUCKY,
                BREAK,
                REVENGE,
                RHYTHM
        ]
    }
    
//    required init(from decoder: Decoder) throws {
//        fatalError("init(from:) has not been implemented")
//    }
    
    override func setValue() {
        let data = ArmorData.data[_type]!
        _type = data.type
        _name = data.name
        _description = data.desc
        _attackSpeedMax = data.attackSpeedMax
        _attackSpeedMin = data.attackSpeedMin
        _baseAttrs = data.baseAttrs
        if _attackSpeedMax == _attackSpeedMin && _attackSpeedMax > 0 {
            _attackSpeed = _attackSpeedMin.toFloat() * 0.01
        } else if _attackSpeedMax > _attackSpeedMin {
            _attackSpeed = seed(min: _attackSpeedMin, max: _attackSpeedMax).toFloat() * 0.01
        }
    }

    internal var _attrCount:Int = 0
    func create(level:Int) {
        _level = level
        createQuality()
        createSelfAttrs()
        createAttrs()
        createPrice()
    }
    func create(effection:String) {
        let sd = Sacred.data[effection]!
        _type = sd.type
        _name = sd.name
        _description = sd.desc
        _level = sd.level
        _quality = Quality.SACRED
        
        if sd.randomAttrCountMax == sd.randomAttrCountMin {
            _attrCount = sd.randomAttrCountMin
        } else if sd.randomAttrCountMax > sd.randomAttrCountMin {
            _attrCount = seed(min: sd.randomAttrCountMin, max: sd.randomAttrCountMax + 1)
        }
        for attr in sd.attrs {
            let a = Attribute(type: attr.type, level: _level)
            if attr.valueMax > attr.valueMin {
                a._value = seedFloat(min: attr.valueMin, max: attr.valueMax + 1)
            } else if attr.valueMin == attr.valueMax && attr.valueMin != 0 {
                a._value = attr.valueMin.toFloat()
            }
        }
        
    }
    
    private func sacredAttrCount() {
        _quality = Quality.SACRED
        _attrCount = seed(min: 3, max: 6)
    }
    
    private func createPrice() {
        let _min = _level + 1
        let _max = _level + 3
        _price = seed(min: _min, max: _max) * _quality
    }
    
    private func createQuality() {
        let _seed = seed()
        if _seed < 70 {
            _quality = Quality.NORMAL
            _attrCount = seed(min: 1, max: 3)
        } else if _seed < 90 {
            _quality = Quality.GOOD
            _attrCount = seed(min: 2, max: 4)
        } else {
            _quality = Quality.RARE
            _attrCount = seed(min: 3, max: 6)
        }
    }
    private var _selfAttrs:Array<Int> = []
    private func createSelfAttrs() {
        for type in _baseAttrs {
            let a = Attribute(type: type, level: _level)
            let index = _all.firstIndex(of: type)
            if nil != index {
                _all.remove(at: index!)
            }
            _attrs.append(a)
        }
    }
    private func createAttr(attrId:Int, value:CGFloat = 0, remove:Bool = true, hidden:Bool = false) {
        let attr = Attribute(type: attrId, level: _level)
        if value != 0 {
            attr._value = value
        }
        if hidden {
            attr._hidden = true
        }
        _attrs.append(attr)
        if remove {
            removeAttrId(id: attrId)
        }
    }
    private func createAttrs() {
        if _attrCount < 1 {
            return
        }
        for _ in 0..._attrCount - 1 {
            let index = seed(max: _all.count)
            let attr = Attribute(type: _all[index], level: _level)
            _attrs.append(attr)
            _all.remove(at: index)
        }
    }
    
    private var _all = Array<Int>()
    var STAMINA = 0
    var STRENGTH = 1
    var AGILITY = 2
    var INTELLECT = 3
    var ATTACK = 4
    var DEFENCE = 5
    var SPEED = 6
    var SPIRIT = 7
    var ACCURACY = 8
    var AVOID = 9
    var CRITICAL = 10
    var MIND = 11
    var HEALTH = 12
    var FIREPOWER = 13
    var WATERPOWER = 14
    var THUNDERPOWER = 15
    var FIRERESISTANCE = 16
    var WATERRESISTANCE = 17
    var THUNDERRESISTANCE = 18
    var ELEMENTALPOWER = 19
    var ELEMENTALRESISTANCE = 20
    var LUCKY = 21
    var BREAK = 22
    var REVENGE = 23
    var RHYTHM = 24
    var CHAOS = 25
    var ATTACK_BASE = 26
    var SPIRIT_BASE = 27
    var MAGICAL_POWER = 28
    var DESTROY = 29
    var HEALTH_BY_RATE = 30
    private func removeAttrId(id:Int) {
        let index = _all.firstIndex(of: id)
        if nil != index {
            _all.remove(at: index!)
        }
    }
    func on() {
        let char = Game.instance.char!
        for a in _attrs {
            a.on(unit: char)
        }
        
//        if _type == Outfit.MagicMark || _type == Outfit.Instrument || _effection == RingOfReborn.EFFECTION || _effection == PandoraHeart.EFFECTION {
//            if !(char.hasSpell(spell: _spell)) {
//                char._spells.append(_spell)
//                _spellAppended = true
//            }
//        }
//
//        if _effection == TrueLie.EFFECTION || _effection == TheEye.EFFECTION {
//            char._spellCount += 1
//        } else if _effection == PuppetMark.EFFECTION {
//            char._spellCount -= 1
//            if char._spellsInuse.count > char._spellCount {
//                let spell = char._spellsInuse.popLast()!
//                char._spells.append(spell)
//            }
//            char._minionsCount += 1
//        } else if _effection == IdlirWeddingRing.EFFECTION {
//            _originalImage = Game.instance.char._imgUrl
//            let t = SKTexture(imageNamed: "idlir_bride.png")
//            char._img = t
//            Game.instance.curStage._curScene._role._charTexture = t
//        } else if _effection == RingOfDead.EFFECTION {
//            char._race = EvilType.RISEN
//        } else if _effection == PuppetMaster.EFFECTION {
//            char._minionsCount += 1
//        }
    }
    func off() {
        let c = Game.instance.char!
        for a in _attrs {
            a.off(unit: c)
        }
        
//        if _type == Outfit.MagicMark || _type == Outfit.Instrument || _effection == RingOfReborn.EFFECTION || _effection == PandoraHeart.EFFECTION {
//            if _spellAppended {
//                let char = Game.instance.char!
//                char.removeSpell(spell: _spell)
//                _spellAppended = false
//            }
//        }
//
//        if _effection == TrueLie.EFFECTION || _effection == TheEye.EFFECTION {
//            if c._spellsInuse.count >= c._spellCount {
//                let last = c._spellsInuse.popLast()
//                c._spells.append(last!)
//            }
//            c._spellCount -= 1
//        } else if _effection == PuppetMark.EFFECTION {
//            c._minionsCount -= 1
//            let minions = c.getReadyMinions()
//            if minions.count > c._minionsCount {
//                minions[0]._seat = BUnit.STAND_BY
//            }
//            c._spellCount += 1
//        } else if _effection == IdlirWeddingRing.EFFECTION {
//            let t = SKTexture(imageNamed: _originalImage)
//            c._img = t
//            Game.instance.curStage._curScene._role._charTexture = t
//        } else if _effection == RingOfDead.EFFECTION {
//            if nil != c._soulStone {
//                c._race = c._soulStone!._race
//            } else {
//                c._race = EvilType.MAN
//            }
//        } else if _effection == PuppetMaster.EFFECTION {
//            c._minionsCount -= 1
//            let minions = c.getReadyMinions()
//            if minions.count > c._minionsCount {
//                minions[0]._seat = BUnit.STAND_BY
//            }
//        }
    }
    
    
        
        
    private enum CodingKeys: String, CodingKey {
        case _attrs
        case _outfitName
        case _unique
        case _effection
        case _spellAppended
        case _attackSpeed
//        case _attackSpeedMax
//        case _attackSpeedMin
//        case _baseAttrs
//        case _chance
        case _race
    }
    var _attrs = Array<Attribute>()
    var _outfitName = ""
    var _unique = false
    var _effection = ""
    var _spellAppended = false
    var _attackSpeed:CGFloat = -1
    var _attackSpeedMax = -1
    var _attackSpeedMin = -1
    var _baseAttrs = Array<Int>()
    var _chance = 0
    var _race = EvilType.MAN
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_attrs, forKey: ._attrs)
        try container.encode(_outfitName, forKey: ._outfitName)
        try container.encode(_unique, forKey: ._unique)
        try container.encode(_effection, forKey: ._effection)
        try container.encode(_spellAppended, forKey: ._spellAppended)
        try container.encode(_attackSpeed, forKey: ._attackSpeed)
//        try container.encode(_chance, forKey: ._chance)
        try container.encode(_race, forKey: ._race)
        try super.encode(to: encoder)
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _attrs = try values.decode(Array.self, forKey: ._attrs)
        _outfitName = try values.decode(String.self, forKey: ._outfitName)
        _unique = try values.decode(Bool.self, forKey: ._unique)
        _effection = try values.decode(String.self, forKey: ._effection)
        _spellAppended = try values.decode(Bool.self, forKey: ._spellAppended)
        _attackSpeed = try values.decode(CGFloat.self, forKey: ._attackSpeed)
        _race = try values.decode(Int.self, forKey: ._race)
    }
}

struct Sacred {
    var effection = ""
    var type = ""
    var name = ""
    var desc = ""
    var level = 1
    var price = 0
    var chance = 0
    var attrs = Array<SacredAttr>()
    var randomAttrCountMin = 1
    var randomAttrCountMax = 1
    var quality = Quality.SACRED
    static let data = [
        Sacred.TrueLie: Sacred(
            effection: Sacred.TrueLie,
            type: Outfit.Amulet,
            name: "真实的谎言",
            desc: "获得一个额外的技能卡槽",
            level: 38,
            price: 889,
            chance: 5,
            attrs: [
                SacredAttr(type: Attribute.AVOID, valueMin: 30, valueMax: 30),
                SacredAttr(type: Attribute.REVENGE, valueMin: 10, valueMax: 20),
                SacredAttr(type: Attribute.SPIRIT, valueMin: 30, valueMax: 60)
            ],
            randomAttrCountMin: 2,
            randomAttrCountMax: 2
        )
    ]
    static let TrueLie = "TrueLie"
}
struct SacredAttr {
    var type = 0
    var valueMin = 0
    var valueMax = 0
}
struct ArmorData {
    var type = ""
    var name = ""
    var desc = ""
    var attackSpeedMax = -1
    var attackSpeedMin = -1
    var baseAttrs = Array<Int>()
    static let data = [
        Outfit.Wand: ArmorData(type: Outfit.Wand, name: "法杖", desc: "", attackSpeedMax: 100, attackSpeedMin: 70, baseAttrs: [Attribute.INTELLECT]),
        Outfit.Bow: ArmorData(type: Outfit.Bow, name: "弓", desc: "", attackSpeedMax: 130, attackSpeedMin: 100, baseAttrs: [Attribute.ATTACK_BASE, Attribute.AGILITY]),
        Outfit.Blunt: ArmorData(type: Outfit.Blunt, name: "钝器", desc: "", attackSpeedMax: 100, attackSpeedMin: 70, baseAttrs: [Attribute.ATTACK_BASE, Attribute.STAMINA]),
        Outfit.Sword: ArmorData(type: Outfit.Sword, name: "剑", desc: "", attackSpeedMax: 120, attackSpeedMin: 90, baseAttrs: [Attribute.ATTACK_BASE, Attribute.STRENGTH]),
        Outfit.Instrument: ArmorData(type: Outfit.Instrument, name: "法器", desc: "", attackSpeedMax: 100, attackSpeedMin: 100, baseAttrs: [Attribute.SPIRIT_BASE]),
        Outfit.Fist: ArmorData(type: Outfit.Fist, name: "拳套", desc: "", attackSpeedMax: 130, attackSpeedMin: 100, baseAttrs: [Attribute.ATTACK, Attribute.BREAK]),
        Outfit.Dagger: ArmorData(type: Outfit.Dagger, name: "匕首", desc: "", attackSpeedMax: 150, attackSpeedMin: 120, baseAttrs: [Attribute.ATTACK, Attribute.AVOID]),
        Outfit.MagicMark: ArmorData(type: Outfit.MagicMark, name: "咒印", desc: "", baseAttrs: []),
        Outfit.SoulStone: ArmorData(type: Outfit.SoulStone, name: "灵魂石", desc: "", baseAttrs: []),
        Outfit.Shield: ArmorData(type: Outfit.Shield, name: "盾", desc: "", baseAttrs: [Attribute.DEFENCE]),
        Outfit.Ring: ArmorData(type: Outfit.Ring, name: "戒指", desc: "", baseAttrs: []),
        Outfit.Amulet: ArmorData(type: Outfit.Amulet, name: "项链", desc: "", baseAttrs: [Attribute.HEALTH]),
        Outfit.EarRing: ArmorData(type: Outfit.EarRing, name: "耳环", desc: "", baseAttrs: [Attribute.MAGICAL_POWER])
    ]
}
