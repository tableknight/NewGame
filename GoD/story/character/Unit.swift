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
        _spells = try values.decode(Array.self, forKey: ._spells)
        _spellsInuse = try values.decode(Array.self, forKey: ._spellsInuse)
        _spellsHidden = try values.decode(Array.self, forKey: ._spellsHidden)
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
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
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
        return level * level * level * CGFloat(sqrt(Double(level))) * level * 0.01
    }
    
    func strengthChange(value: CGFloat) {
        _mains.strength += value
        _extensions.attack += value * 2
        _extensions.defence += value * 0
        _extensions.speed += value * 0.5
        _extensions.accuracy += value * 0.1
        _extensions.avoid += value * 0
        _extensions.critical += value * 0.1
        _extensions.spirit += value * -0.5
        _extensions.health += value * 1
        _extensions.hp += value * 1
        _extensions.mp += value * 0
        if _extensions.hp < 1 {
            _extensions.hp = 1
        }
    }
    func staminaChange(value: CGFloat) {
        _mains.stamina += value
        _extensions.attack += value * 1
        _extensions.defence += value * 1.4
        _extensions.speed += value * 0
        _extensions.accuracy += value * 0
        _extensions.avoid += value * 0
        _extensions.critical += value * 0
        _extensions.spirit += value * -0.5
        _extensions.health += value * 4
        _extensions.hp += value * 4
        _extensions.mp += value * 0
        if _extensions.hp < 1 {
            _extensions.hp = 1
        }
    }
    func agilityChange(value: CGFloat) {
        _mains.agility += value
        _extensions.attack += value * 0.5
        _extensions.defence += value * 0.3
        _extensions.speed += value * 2
        _extensions.accuracy += value * 0.4
        _extensions.avoid += value * 0.3
        _extensions.critical += value * 0.3
        _extensions.spirit += value * 0
        _extensions.health += value * 1
        _extensions.hp += value * 1
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
        _extensions.avoid += value * 0.1
        _extensions.critical += value * 0
        _extensions.spirit += value * 2
        _extensions.health += value * 0.5
        _extensions.hp += value * 0.5
        _extensions.mp += value * 3
        if _extensions.hp < 1 {
            _extensions.hp = 1
        }
    }
}
