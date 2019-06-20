//
//  Unit.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/1/14.
//  Copyright © 2018年 Chen. All rights reserved.
//
import SpriteKit
class Unit:Core {
    override init() {
        super.init()
        
    }
    private enum CodingKeys: String, CodingKey {
        case _mains
        case _extensions
        case _level
        case _name
        case _race
        case _exp
        case _leftPoint
        case _spells
        case _spellsInuse
        case _spellsHidden
        case _slot
        case _lucky
        case _break
        case _revenge
        case _rhythm
        case _chaos
        case _power
        case _elementalPower
        case _elementalResistance
        case _magical
        case _elemental
        case _physical
        case _imgUrl
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _mains = try values.decode(Mains.self, forKey: ._mains)
        _extensions = try values.decode(Extensions.self, forKey: ._extensions)
        _level = try values.decode(CGFloat.self, forKey: ._level)
        _name = try values.decode(String.self, forKey: ._name)
        _race = try values.decode(Int.self, forKey: ._race)
        _exp = try values.decode(CGFloat.self, forKey: ._exp)
        _leftPoint = try values.decode(Int.self, forKey: ._leftPoint)
        let spells:Array<String> = try values.decode(Array.self, forKey: ._spells)
        let spellsInuse:Array<String> = try values.decode(Array.self, forKey: ._spellsInuse)
        let spellsHidden:Array<String> = try values.decode(Array.self, forKey: ._spellsHidden)
        let l = Loot()
        let allSpells = l.getAllSpells()
        for s in spells {
            for spell in allSpells {
                if NSClassFromString(s) == type(of: spell) {
                    _spells.append(spell)
                    break
                }
            }
        }
        for s in spellsInuse {
            for spell in allSpells {
                if NSClassFromString(s) == type(of: spell) {
                    _spellsInuse.append(spell)
                    break
                }
            }
        }
        for s in spellsHidden {
            for spell in allSpells {
                if NSClassFromString(s) == type(of: spell) {
                    _spellsHidden.append(spell)
                    break
                }
            }
        }
        _slot = try values.decode(Int.self, forKey: ._slot)
        _lucky = try values.decode(CGFloat.self, forKey: ._lucky)
        _break = try values.decode(CGFloat.self, forKey: ._break)
        _revenge = try values.decode(CGFloat.self, forKey: ._revenge)
        _rhythm = try values.decode(CGFloat.self, forKey: ._rhythm)
        _chaos = try values.decode(CGFloat.self, forKey: ._chaos)
        _power = try values.decode(CGFloat.self, forKey: ._power)
        _elementalPower = try values.decode(Elemental.self, forKey: ._elementalPower)
        _elementalResistance = try values.decode(Elemental.self, forKey: ._elementalResistance)
        _magical = try values.decode(Magic.self, forKey: ._magical)
        _elemental = try values.decode(Magic.self, forKey: ._elemental)
        _physical = try values.decode(Magic.self, forKey: ._physical)
        _imgUrl = try values.decode(String.self, forKey: ._imgUrl)
        if _imgUrl.isEmpty {
            _imgUrl = "test_role"
        }
        _img = SKTexture(imageNamed: _imgUrl)
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_mains, forKey: ._mains)
        try container.encode(_extensions, forKey: ._extensions)
        try container.encode(_level, forKey: ._level)
        try container.encode(_name, forKey: ._name)
        try container.encode(_race, forKey: ._race)
        try container.encode(_exp, forKey: ._exp)
        try container.encode(_leftPoint, forKey: ._leftPoint)
        var spells = Array<String>()
        var spellsInuse = Array<String>()
        var spellsHidden = Array<String>()
        for s in _spells {
            spells.append(NSStringFromClass(type(of: s)))
        }
        for s in _spellsInuse {
            spellsInuse.append(NSStringFromClass(type(of: s)))
        }
        for s in _spellsHidden {
            spellsHidden.append(NSStringFromClass(type(of: s)))
        }
        try container.encode(spells, forKey: ._spells)
        try container.encode(spellsInuse, forKey: ._spellsInuse)
        try container.encode(spellsHidden, forKey: ._spellsHidden)
        try container.encode(_slot, forKey: ._slot)
        try container.encode(_lucky, forKey: ._lucky)
        try container.encode(_break, forKey: ._break)
        try container.encode(_revenge, forKey: ._revenge)
        try container.encode(_rhythm, forKey: ._rhythm)
        try container.encode(_chaos, forKey: ._chaos)
        try container.encode(_power, forKey: ._power)
        try container.encode(_elementalPower, forKey: ._elementalPower)
        try container.encode(_elementalResistance, forKey: ._elementalResistance)
        try container.encode(_magical, forKey: ._magical)
        try container.encode(_elemental, forKey: ._elemental)
        try container.encode(_physical, forKey: ._physical)
        try container.encode(_imgUrl, forKey: ._imgUrl)
        try super.encode(to: encoder)
    }
    
//    required init(from decoder: Decoder) throws {
//        fatalError("init(from:) has not been implemented")
//    }
    
    var _mains:Mains = Mains(stamina:0, strength: 0, agility: 0, intellect: 0)
    var _extensions:Extensions = Extensions(
        attack: 0,
        defence: 0,
        speed: 0,
        accuracy: 100,
        critical: 15,
        avoid: 15,
        spirit: 0,
        hp: 0,
        mp: 0,
        health: 0,
        mind: 15
    )
    var _level:CGFloat = 1
    var _name:String = ""
    var _race:Int = 0
    var _exp:CGFloat = 0
    var _leftPoint:Int = 0
    var _spells:Array<Spell> = Array<Spell>()
    var _spellsInuse:Array<Spell> = Array<Spell>()
    var _spellsHidden:Array<Spell> = Array<Spell>()
    var _slot:Int = 0
    var _lucky:CGFloat = 5
    var _break:CGFloat = 0
    var _revenge:CGFloat = 5
    var _rhythm:CGFloat = 5
    var _chaos:CGFloat = 0
    var _power:CGFloat = 0
    var _img:SKTexture = SKTexture()
    var _imgUrl:String = ""
    
    var _elementalPower = Elemental(
        fire : 0,
        water : 0,
        thunder : 0
    )
    
    var _elementalResistance = Elemental(
        fire : 0,
        water : 0,
        thunder : 0
    )
    
    var _magical = Magic(damage: 0, resistance: 0)
    var _elemental = Magic(damage: 0, resistance: 0)
    var _physical = Magic(damage: 0, resistance: 0)
    
    func expNext() -> CGFloat {
        let level = _level + 2
        if Mode.debug {
            return level * level
        }
        return 100 * level + level * level * level * level * 0.25
    }
    
    func strengthChange(value: CGFloat) {
        _mains.strength += value
        _extensions.attack += value * 2
        _extensions.defence += value * 0
        _extensions.speed += value * 0.5
        _extensions.accuracy += value * 0.2
        _extensions.avoid += value * 0
        _extensions.critical += value * 0.2
        _extensions.spirit += value * -0.2
        _extensions.health += value * 1
        _extensions.hp += value * 1
        _extensions.mp += value * 0
        if _extensions.hp < 1 {
            _extensions.hp = 1
        }
    }
    func staminaChange(value: CGFloat) {
        _mains.stamina += value
        _extensions.attack += value * 0.1
        _extensions.defence += value * 1.1
        _extensions.speed += value * 0
        _extensions.accuracy += value * 0
        _extensions.avoid += value * -0.2
        _extensions.critical += value * 0
        _extensions.spirit += value * -0.4
        _extensions.health += value * 4
        _extensions.hp += value * 4
        _extensions.mp += value * 0
        if _extensions.hp < 1 {
            _extensions.hp = 1
        }
    }
    func agilityChange(value: CGFloat) {
        _mains.agility += value
        _extensions.attack += value * 1
        _extensions.defence += value * 0.2
        _extensions.speed += value * 2
        _extensions.accuracy += value * 0.5
        _extensions.avoid += value * 0.8
        _extensions.critical += value * 0.3
        _extensions.spirit += value * 0
        _extensions.health += value * 2
        _extensions.hp += value * 2
        _extensions.mp += value * 1
        if _extensions.hp < 1 {
            _extensions.hp = 1
        }
    }
    func intellectChange(value: CGFloat) {
        _mains.intellect += value
        _extensions.attack += value * -0.5
        _extensions.defence += value * 0.3
        _extensions.speed += value * 0.2
        _extensions.accuracy += value * 0
        _extensions.avoid += value * 0.2
        _extensions.critical += value * 0
        _extensions.spirit += value * 2
        _extensions.health += value * 1
        _extensions.hp += value * 1
        _extensions.mp += value * 3
        if _extensions.hp < 1 {
            _extensions.hp = 1
        }
    }
}
