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
        case _spellCount
        case _leftPoint
        case _spells
        case _spellsInuse
        case _spellsHidden
        case _lucky
        case _break
        case _revenge
        case _destroy
        case _rhythm
        case _chaos
        case _power
        case _imgUrl
        case _seat
        case _quality
        case _elementalPower
        case _elementalResistance
        case _magical
        case _elemental
        case _physical
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _mains = try values.decode(Mains.self, forKey: ._mains)
        _extensions = try values.decode(Extensions.self, forKey: ._extensions)
        _level = try values.decode(CGFloat.self, forKey: ._level)
        _name = try values.decode(String.self, forKey: ._name)
        _race = try values.decode(Int.self, forKey: ._race)
        _exp = try values.decode(CGFloat.self, forKey: ._exp)
        _spellCount = try values.decode(Int.self, forKey: ._spellCount)
        _leftPoint = try values.decode(Int.self, forKey: ._leftPoint)
        _spells = try values.decode(Array.self, forKey: ._spells)
        _spellsInuse = try values.decode(Array.self, forKey: ._spellsInuse)
        _spellsHidden = try values.decode(Array.self, forKey: ._spellsHidden)
        _lucky = try values.decode(CGFloat.self, forKey: ._lucky)
        _break = try values.decode(CGFloat.self, forKey: ._break)
        _revenge = try values.decode(CGFloat.self, forKey: ._revenge)
        _destroy = try values.decode(CGFloat.self, forKey: ._destroy)
        _rhythm = try values.decode(CGFloat.self, forKey: ._rhythm)
        _chaos = try values.decode(CGFloat.self, forKey: ._chaos)
        _power = try values.decode(CGFloat.self, forKey: ._power)
        _imgUrl = try values.decode(String.self, forKey: ._imgUrl)
        _seat = try values.decode(String.self, forKey: ._seat)
        _quality = try values.decode(Int.self, forKey: ._quality)
        _elementalPower = try values.decode(Elemental.self, forKey: ._elementalPower)
        _elementalResistance = try values.decode(Elemental.self, forKey: ._elementalResistance)
        _magical = try values.decode(Magic.self, forKey: ._magical)
        _elemental = try values.decode(Magic.self, forKey: ._elemental)
        _physical = try values.decode(Magic.self, forKey: ._physical)
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
        try container.encode(_spellCount, forKey: ._spellCount)
        try container.encode(_leftPoint, forKey: ._leftPoint)
        try container.encode(_spells, forKey: ._spells)
        try container.encode(_spellsInuse, forKey: ._spellsInuse)
        try container.encode(_spellsHidden, forKey: ._spellsHidden)
        try container.encode(_lucky, forKey: ._lucky)
        try container.encode(_break, forKey: ._break)
        try container.encode(_revenge, forKey: ._revenge)
        try container.encode(_destroy, forKey: ._destroy)
        try container.encode(_rhythm, forKey: ._rhythm)
        try container.encode(_chaos, forKey: ._chaos)
        try container.encode(_power, forKey: ._power)
        try container.encode(_imgUrl, forKey: ._imgUrl)
        try container.encode(_seat, forKey: ._seat)
        try container.encode(_quality, forKey: ._quality)
        try container.encode(_elementalPower, forKey: ._elementalPower)
        try container.encode(_elementalResistance, forKey: ._elementalResistance)
        try container.encode(_magical, forKey: ._magical)
        try container.encode(_elemental, forKey: ._elemental)
        try container.encode(_physical, forKey: ._physical)
        try super.encode(to: encoder)
    }
    
    var _mains:Mains = Mains(stamina:0, strength: 0, agility: 0, intellect: 0)
    var _extensions:Extensions = Extensions(
        attack: 40,
        defence: 20,
        speed: 0,
        accuracy: 100,
        critical: 15,
        destroy: 0,
        avoid: 20,
        spirit: 40,
        hp: 100,
        health: 100,
        mp: 100,
        mpMax: 100,
        mind: 0
    )
    var _level:CGFloat = 1
    var _name:String = ""
    var _race:Int = 0
    var _exp:CGFloat = 0
    var _spellCount = 1
    var _leftPoint:Int = 0
    var _spells = Array<Int>()
    var _spellsInuse = Array<Int>()
    var _spellsHidden = Array<Int>()
    var _lucky:CGFloat = 5
    var _break:CGFloat = 0
    var _revenge:CGFloat = 5
    var _destroy:CGFloat = 0
    var _rhythm:CGFloat = 5
    var _chaos:CGFloat = 0
    var _power:CGFloat = 0
    var _img:SKTexture!
    var _imgUrl:String = ""
    
    var _seat = BUnit.STAND_BY
    var _quality:Int = Quality.NORMAL
    
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
    
    func expUp(up:CGFloat) {
        _exp += up
        let en = expNext()
        if _exp >= en {
            _exp = _exp - en
            levelup()
        }
    }
    func levelup() {
        
    }
    func expNext() -> CGFloat {
        let level = _level + 1
        let t = atan(level * 0.1)
        var rate:CGFloat = 0.5
        if level < 6 {
            
        } else if level < 11 {
            rate = 1
        } else if level < 21 {
            rate = 1.5
        } else if level < 31 {
            rate = 2
        } else {
            rate = 3
        }
        let at = t * t * rate
        return 100 * level + level * level * level * at
    }
    
    func strengthChange(value: CGFloat) {
        _mains.strength += value
        _extensions.attack += value * 2
        _extensions.defence += value * 0
        _extensions.speed += value * 0.5
        _extensions.accuracy += value * 0.2
        _extensions.avoid += value * 0
        _extensions.critical += value * 0.2
        _extensions.spirit += value * -0.6
        _extensions.health += value * 1
        _extensions.hp += value * 1
        _extensions.mp += value * 1
        _extensions.mpMax += value * 1
        if _extensions.hp < 1 {
            _extensions.hp = 1
        }
        if _extensions.mp < 1 {
            _extensions.mp = 1
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
        _extensions.spirit += value * -0.5
        _extensions.health += value * 4
        _extensions.hp += value * 4
        _extensions.mp += value * 0
        _extensions.mpMax += value * 0
        if _extensions.hp < 1 {
            _extensions.hp = 1
        }
        if _extensions.mp < 1 {
            _extensions.mp = 1
        }
    }
    func agilityChange(value: CGFloat) {
        _mains.agility += value
        _extensions.attack += value * 0.6
        _extensions.defence += value * 0.1
        _extensions.speed += value * 2
        _extensions.accuracy += value * 0.6
        _extensions.avoid += value * 0.9
        _extensions.critical += value * 0.3
        _extensions.spirit += value * 0
        _extensions.health += value * 2
        _extensions.hp += value * 2
        _extensions.mp += value * 1
        _extensions.mpMax += value * 1
        if _extensions.hp < 1 {
            _extensions.hp = 1
        }
        if _extensions.mp < 1 {
            _extensions.mp = 1
        }
    }
    func intellectChange(value: CGFloat) {
        _mains.intellect += value
        _extensions.attack += value * -0.5
        _extensions.defence += value * 0.2
        _extensions.speed += value * 0.2
        _extensions.accuracy += value * 0
        _extensions.avoid += value * 0.2
        _extensions.critical += value * 0
        _extensions.spirit += value * 2
        _extensions.health += value * 1
        _extensions.hp += value * 1
        _extensions.mp += value * 3
        _extensions.mpMax += value * 3
        if _extensions.hp < 1 {
            _extensions.hp = 1
        }
        if _extensions.mp < 1 {
            _extensions.mp = 1
        }
    }
}
