//
//  Creature.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/1/14.
//  Copyright © 2018年 Chen. All rights reserved.
//
import SpriteKit
class Creature: Unit {
    private enum CodingKeys: String, CodingKey {
        case _stars
        case _growth
        case _birth
        case _natural
        case _spellCount
        case _sensitive
        case _weapon
        case _weaponClass
        case _seat
        case _quality
        case isMainChar
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _stars = try values.decode(Mains.self, forKey: ._stars)
        _natural = try values.decode(Mains.self, forKey: ._natural)
        _birth = try values.decode(Mains.self, forKey: ._birth)
        _growth = try values.decode(Mains.self, forKey: ._growth)
        _spellCount = try values.decode(Int.self, forKey: ._spellCount)
        _sensitive = try values.decode(Int.self, forKey: ._sensitive)
        let wClass = try values.decode(String.self, forKey: ._weaponClass)
        if !wClass.isEmpty {
            if wClass == NSStringFromClass(type(of: PuppetMaster())) {
              _weapon = try? values.decode(PuppetMaster.self, forKey: ._weapon)
            } else 
            if wClass == NSStringFromClass(type(of: Bow())) {
                _weapon = try? values.decode(Bow.self, forKey: ._weapon)
            } else if wClass == NSStringFromClass(type(of: Sword())) {
                _weapon = try? values.decode(Sword.self, forKey: ._weapon)
            } else if wClass == NSStringFromClass(type(of: Dagger())) {
                _weapon = try? values.decode(Dagger.self, forKey: ._weapon)
            } else if wClass == NSStringFromClass(type(of: Instrument())) {
                _weapon = try? values.decode(Instrument.self, forKey: ._weapon)
            } else if wClass == NSStringFromClass(type(of: Fist())) {
                _weapon = try? values.decode(Fist.self, forKey: ._weapon)
            } else if wClass == NSStringFromClass(type(of: Blunt())) {
                _weapon = try? values.decode(Blunt.self, forKey: ._weapon)
            } else if wClass == NSStringFromClass(type(of: Wand())) {
                _weapon = try? values.decode(Wand.self, forKey: ._weapon)
            }
        }
        _seat = try values.decode(String.self, forKey: ._seat)
        _quality = try values.decode(Int.self, forKey: ._quality)
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_stars, forKey: ._stars)
        try container.encode(_growth, forKey: ._growth)
        try container.encode(_natural, forKey: ._natural)
        try container.encode(_birth, forKey: ._birth)
        try container.encode(_spellCount, forKey: ._spellCount)
        try container.encode(_sensitive, forKey: ._sensitive)
        try container.encode(_weapon, forKey: ._weapon)
        try container.encode(_seat, forKey: ._seat)
        try container.encode(_quality, forKey: ._quality)
        var weaponClass = ""
        if _weapon is Bow {
            weaponClass = NSStringFromClass(type(of: _weapon as! Bow))
        } else if _weapon is Sword {
            weaponClass = NSStringFromClass(type(of: _weapon as! Sword))
        } else if _weapon is Instrument {
            weaponClass = NSStringFromClass(type(of: _weapon as! Instrument))
        } else if _weapon is Wand {
            weaponClass = NSStringFromClass(type(of: _weapon as! Wand))
        } else if _weapon is Dagger {
            weaponClass = NSStringFromClass(type(of: _weapon as! Dagger))
        } else if _weapon is Blunt {
            weaponClass = NSStringFromClass(type(of: _weapon as! Blunt))
        } else if _weapon is Fist {
            weaponClass = NSStringFromClass(type(of: _weapon as! Fist))
        }
        try container.encode(weaponClass, forKey: ._weaponClass)
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
    }
    var _quality:Int = Quality.NORMAL
    
    var _stars:Mains = Mains(stamina: 0, strength: 0, agility: 0, intellect: 0)
    var _growth:Mains = Mains(stamina: 0, strength: 0, agility: 0, intellect: 0)
    var _birth = Mains(stamina: 0, strength: 0, agility: 0, intellect: 0)
    var _natural = Mains(stamina: 20, strength: 20, agility: 20, intellect: 20)
    var _spellSlot:SpellSlot = SpellSlot(max: 3, min: 0)
    var _spellCount = 1
    var _moveSpeed:CGFloat = 0
    var _sensitive = 33
    var _weapon:Weapon?
    var _seat = BUnit.STAND_BY
    var isMainChar = false
    //矩阵图第三行和第四行特殊
    var specialUnit = false
    //非行动单位
    var hasAction = true
    func beMore() -> Bool {
        let sed = seed(max: 100)
        if sed < _quality * 20 {
            return true
        }
        
        return false
    }
    func extraProperty(value: CGFloat) -> CGFloat {
        let max = (value * 10).toInt()
        var float = seed(to: max) / 100
        if !beMore() {
            float *= -1
        }
        return value + value
    }
    func createQuality() {
        let l = _level.toInt()
        let sed = seed(to: 100 + l / 2)
        if sed < 50 {
            _quality = Quality.NORMAL
        } else if sed < 80 {
            _quality = Quality.GOOD
        } else if sed < 96 {
            _quality = Quality.RARE
        } else {
            _quality = Quality.SACRED
        }
    }
    func createBirthValue() {
        _birth.strength = extraProperty(value: _natural.strength)
        _birth.stamina = extraProperty(value: _natural.stamina)
        _birth.agility = extraProperty(value: _natural.agility)
        _birth.intellect = extraProperty(value: _natural.intellect)
    }
    func createGrowthValue() {
        _growth.stamina = extraProperty(value: _stars.stamina)
        _growth.strength = extraProperty(value: _stars.strength)
        _growth.agility = extraProperty(value: _stars.agility)
        _growth.intellect = extraProperty(value: _stars.intellect)
    }
    func create(level:CGFloat) {
        _level = level
        createQuality()
        createBirthValue()
        createGrowthValue()
        levelTo(level: level)
        _extensions.hp = _extensions.health
        magicSensitive()
        let l = _level.toInt()
        if _level > 30 {
            _elementalResistance.fire = seed(to: l).toFloat()
            _elementalResistance.water = seed(to: l).toFloat()
            _elementalResistance.thunder = seed(to: l).toFloat()
        }
        if _spellCount > _spellsInuse.count && d3() {
            let l = Loot()
            let spells = [l.getRandomNormalSpell(), l.getRandomGoodSpell(), l.getRandomRareSpell(), l.getRandomSacredSpell()]
            let spell = spells.one()
            if !(spell is BowSkill) && !(spell is HandSkill) && !(spell is Interchange) && !(spell is SwapHealth) {
                _spellsInuse.append(spell)
            }
        }
    }
    func spell12() {
        _spellCount = seed(min: 1, max: 3)
    }
    func spell13() {
        _spellCount = seed(min: 1, max: 4)
    }
    func spell23() {
        _spellCount = seed(min: 2, max: 4)
    }
    func magicSensitive() {
        _sensitive = seed(min: 15, max: 56)
    }
    func levelTo(level:CGFloat) {
        staminaChange(value: (level + _birth.stamina) * _growth.stamina)
        strengthChange(value: (level + _birth.strength) * _growth.strength)
        agilityChange(value: (level + _birth.agility) * _growth.agility)
        intellectChange(value: (level + _birth.intellect) * _growth.intellect)
        _level = level
        for _ in 1...level.toInt() {
            let sd = seed()
            if sd < 25 {
                staminaChange(value: 1)
            } else if sd < 50 {
                strengthChange(value: 1)
            } else if sd < 75 {
                agilityChange(value: 1)
            } else {
                intellectChange(value: 1)
            }
        }
    }
    
    func levelup() {
        staminaChange(value: _growth.stamina)
        strengthChange(value: _growth.strength)
        agilityChange(value: _growth.agility)
        intellectChange(value: _growth.intellect)
        _level += 1
        _leftPoint += 1
        _extensions.hp = _extensions.health
//        Game.instance.curStage._curScene._role.speak(text: "LEVEL UP!")
    }
    
    func expUp(up:CGFloat) {
        _exp += up
        let en = expNext()
        if _exp >= en {
            _exp = _exp - en
            levelup()
        }
    }
    func isClose() -> Bool {
        if nil == _weapon {
            return true
        }
        return _weapon!.isClose
    }
    func d(baseRate:Int = 45) -> Bool {
        return seed() < baseRate + _level.toInt()
    }
    static func getCreatureByClass(c:Creature) -> Creature {
        if c.classForCoder == DarkNinja.classForCoder() {
            return DarkNinja()
        }
        return Creature()
    }
}
