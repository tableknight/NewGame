//
//  Outfit.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/25.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Outfit:Prop {
    static let TYPE_MAGIC_MARK = "magic_mark"
    static let TYPE_INSTRUMENT = "instrument"
    private enum CodingKeys: String, CodingKey {
        case _attrs
        case _attrsClass
        case _outfitName
        case _unique
        case _effection
        case _spellAppended
        case _spell
        case _originalImage
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _attrs = try values.decode(Array.self, forKey: ._attrs)
        _outfitName = try values.decode(String.self, forKey: ._outfitName)
        _effection = try values.decode(String.self, forKey: ._effection)
        _unique = try values.decode(Bool.self, forKey: ._unique)
        let cls:Array<String> = try values.decode(Array.self, forKey: ._attrsClass)
        let allAttrs = [SpiritBase(), AttackAttributeBase(), Agility(),Chaos(),Stamina(),Defence(),Break(),Rhythm(),Health(),WaterResistance(),FireResistance(),
                        ThunderResistance(),Spirit(),ThunderPower(),Strength(),Intellect(),Revenge(),AttackAttribute(),
                        Avoid(),Accuracy(),FirePower(),WaterPower(),ElementalPower(),Critical(),Speed(),Mind(),MagicalDamage(),Lucky(),ElementalResistance(), Destroy(), HealthByRate()]
//        var allAttrs = Array<Attribute>()
//        for i in _all {
//            allAttrs.append(getAttrById(id: i))
//        }
        if cls.count > 0 {
            for i in 0...cls.count - 1 {
                let tp:AnyClass? = NSClassFromString(cls[i])
                for a in allAttrs {
                    if tp == type(of: a) {
                        a._value = _attrs[i]._value
                        a._name = _attrs[i]._name
                        a._reserve1 = _attrs[i]._reserve1
                        a._hidden = _attrs[i]._hidden
                        _attrs[i] = a
                        break
                    }
                }
            }
        }
        
        let s = try? values.decode(String.self, forKey: ._spell)
        if nil != s {
            let l = Loot()
            let allSpells = l.getAllSpells()
            for spell in allSpells {
                if NSClassFromString(s!) == type(of: spell) {
                    _spell = spell
                    break
                }
            }
            _spellAppended = try values.decode(Bool.self, forKey: ._spellAppended)
        }
        
        if _effection == IdlirWeddingRing.EFFECTION {
            _originalImage = try values.decode(String.self, forKey: ._originalImage)
        }
        
    }
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_attrs, forKey: ._attrs)
        try container.encode(_outfitName, forKey: ._outfitName)
        try container.encode(_effection, forKey: ._effection)
        try container.encode(_unique, forKey: ._unique)
        var classNames = Array<String>()
        for i in _attrs {
            classNames.append(NSStringFromClass(type(of: i)))
        }
        try container.encode(classNames, forKey: ._attrsClass)
        if nil != _spell {
            try container.encode(_spellAppended, forKey: ._spellAppended)
            try container.encode(NSStringFromClass(type(of: _spell)), forKey: ._spell)
        }
        
        if _effection == IdlirWeddingRing.EFFECTION {
            try container.encode(_originalImage, forKey: ._originalImage)
        }
        
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        
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
    

    internal var _attrCount:Int = 0
    override func create(level:CGFloat) {
        _level = level
        initialized = true
        createQuality()
        createSelfAttrs()
        createAttrs()
        createPrice()
    }
    
    override func create() {
        initialized = true
        createQuality()
        createSelfAttrs()
        createAttrs()
        createPrice()
    }
    
    func sacredAttrCount() {
        _quality = Quality.SACRED
        _attrCount = seed(min: 3, max: 6)
    }
    
    func createPrice() {
        let _min = _level + 1
        let _max = _level + 3
        _price = seed(min: _min.toInt(), max: _max.toInt()) * _quality
        _storePrice = _price * 4
    }
    
    func createQuality() {
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
    internal var _selfAttrs:Array<Int> = []
    func createSelfAttrs() {
        for id in _selfAttrs {
            let a = getAttrById(id: id)
            let index = _all.firstIndex(of: id)
            if nil != index {
                _all.remove(at: index!)
            }
            a.create(level: self._level)
            _attrs.append(a)
        }
    }
    func createAttr(attrId:Int, value:CGFloat = 0, remove:Bool = true, hidden:Bool = false) {
        let attr = getAttrById(id: attrId)
        if value != 0 {
            attr._value = value
        } else {
            attr.create(level: _level)
        }
        if hidden {
            attr._hidden = true
        }
        _attrs.append(attr)
        if remove {
            removeAttrId(id: attrId)
        }
    }
    func createAttrs() {
        if _attrCount < 1 {
            return
        }
        for _ in 0..._attrCount - 1 {
            let index = seed(max: _all.count)
            let attr = getAttrById(id: _all[index])
            attr.create(level: _level)
            _attrs.append(attr)
            _all.remove(at: index)
        }
    }
    var _attrs = Array<Attribute>()
    internal var _all = Array<Int>()
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
    internal func getAttrById(id:Int) -> Attribute {
        switch id {
        case STAMINA:
            return Stamina()
        case STRENGTH:
            return Strength()
        case AGILITY:
            return Agility()
        case INTELLECT:
            return Intellect()
        case ATTACK:
            return AttackAttribute()
        case DEFENCE:
            return Defence()
        case SPEED:
            return Speed()
        case SPIRIT:
            return Spirit()
        case ACCURACY:
            return Accuracy()
        case AVOID:
            return Avoid()
        case MIND:
            return Mind()
        case CRITICAL:
            return Critical()
        case HEALTH:
            return Health()
        case LUCKY:
            return Lucky()
        case FIREPOWER:
            return FirePower()
        case WATERPOWER:
            return WaterPower()
        case THUNDERPOWER:
            return ThunderPower()
        case FIRERESISTANCE:
            return FireResistance()
        case WATERRESISTANCE:
            return WaterResistance()
        case THUNDERRESISTANCE:
            return ThunderResistance()
        case ELEMENTALPOWER:
            return ElementalPower()
        case ELEMENTALRESISTANCE:
            return ElementalResistance()
        case BREAK:
            return Break()
        case REVENGE:
            return Revenge()
        case RHYTHM:
            return Rhythm()
        case CHAOS:
            return Chaos()
        case ATTACK_BASE:
            return AttackAttributeBase()
        case SPIRIT_BASE:
            return SpiritBase()
        case MAGICAL_POWER:
            return MagicalDamage()
        case DESTROY:
            return Destroy()
        case HEALTH_BY_RATE:
            return HealthByRate()
        default:
            return Attribute()
        }
    }
    internal func removeAttrId(id:Int) {
        let index = _all.firstIndex(of: id)
        if nil != index {
            _all.remove(at: index!)
        }
    }
    internal var _originalImage:String = ""
    func on() {
        let char = Game.instance.char!
        for a in _attrs {
            a.on(unit: char)
        }
        
        if _type == Outfit.TYPE_MAGIC_MARK || _type == Outfit.TYPE_INSTRUMENT || _effection == RingOfReborn.EFFECTION || _effection == PandoraHeart.EFFECTION {
            if !(char.hasSpell(spell: _spell)) {
                char._spells.append(_spell)
                _spellAppended = true
            }
        }
        
        if _effection == TrueLie.EFFECTION || _effection == TheEye.EFFECTION {
            char._spellCount += 1
        } else if _effection == PuppetMark.EFFECTION {
            char._spellCount -= 1
            if char._spellsInuse.count > char._spellCount {
                let spell = char._spellsInuse.popLast()!
                char._spells.append(spell)
            }
            char._minionsCount += 1
        } else if _effection == IdlirWeddingRing.EFFECTION {
            _originalImage = Game.instance.char._imgUrl
            let t = SKTexture(imageNamed: "idlir_bride.png")
            char._img = t
            Game.instance.curStage._curScene._role._charTexture = t
        } else if _effection == RingOfDead.EFFECTION {
            char._race = EvilType.RISEN
        } else if _effection == PuppetMaster.EFFECTION {
            char._minionsCount += 1
        }
    }
    func off() {
        let c = Game.instance.char!
        for a in _attrs {
            a.off(unit: c)
        }
        
        if _type == Outfit.TYPE_MAGIC_MARK || _type == Outfit.TYPE_INSTRUMENT || _effection == RingOfReborn.EFFECTION || _effection == PandoraHeart.EFFECTION {
            if _spellAppended {
                let char = Game.instance.char!
                char.removeSpell(spell: _spell)
                _spellAppended = false
            }
        }
        
        if _effection == TrueLie.EFFECTION || _effection == TheEye.EFFECTION {
            if c._spellsInuse.count >= c._spellCount {
                let last = c._spellsInuse.popLast()
                c._spells.append(last!)
            }
            c._spellCount -= 1
        } else if _effection == PuppetMark.EFFECTION {
            c._minionsCount -= 1
            let minions = c.getReadyMinions()
            if minions.count > c._minionsCount {
                minions[0]._seat = BUnit.STAND_BY
            }
            c._spellCount += 1
        } else if _effection == IdlirWeddingRing.EFFECTION {
            let t = SKTexture(imageNamed: _originalImage)
            c._img = t
            Game.instance.curStage._curScene._role._charTexture = t
        } else if _effection == RingOfDead.EFFECTION {
            if nil != c._soulStone {
               c._race = c._soulStone!._race
            } else {
                c._race = EvilType.MAN
            }
        } else if _effection == PuppetMaster.EFFECTION {
            c._minionsCount -= 1
            let minions = c.getReadyMinions()
            if minions.count > c._minionsCount {
                minions[0]._seat = BUnit.STAND_BY
            }
        }
    }
    
    override func getInfosDisplay() -> IPanelSize {
        return ArmorInfo()
    }
    
    var isRandom = false
    var _chance:Int = 0
    var _outfitName = ""
    var _unique = false
    var _effection = ""
    var _spell:Spell!
    var _spellAppended = false
}
