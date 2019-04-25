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
        case _spellCount
        case _sensitive
        case _weapon
        case _seat
        case isMainChar
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _stars = try values.decode(Mains.self, forKey: ._stars)
        _growth = try values.decode(Mains.self, forKey: ._growth)
        _spellCount = try values.decode(Int.self, forKey: ._spellCount)
        _sensitive = try values.decode(Int.self, forKey: ._sensitive)
        _weapon = try? values.decode(Weapon.self, forKey: ._weapon)
        _seat = try values.decode(String.self, forKey: ._seat)
        isMainChar = try values.decode(Bool.self, forKey: .isMainChar)
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_stars, forKey: ._stars)
        try container.encode(_growth, forKey: ._growth)
        try container.encode(_spellCount, forKey: ._spellCount)
        try container.encode(_sensitive, forKey: ._sensitive)
        try container.encode(_weapon, forKey: ._weapon)
        try container.encode(_seat, forKey: ._seat)
        try container.encode(isMainChar, forKey: .isMainChar)
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
    }
    var _quality:Int = Quality.NORMAL
    
    var _stars:Mains = Mains(stamina: 0, strength: 0, agility: 0, intellect: 0)
    var _growth:Mains = Mains(stamina: 0, strength: 0, agility: 0, intellect: 0)
    var _spellSlot:SpellSlot = SpellSlot(max: 3, min: 0)
    var _spellCount = 2
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
        if _quality >= Int(sed / 25) {
            return true
        }
        
        return false
    }
    func extraProperty(value: CGFloat) -> CGFloat {
        let size = seed(max: Int(value * 10))
        let v = CGFloat(size) * 0.01
        if beMore() {
            return v
        } else {
            return -v
        }
    }
    func createQuality() {
        let sed = seed()
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
    func create(level:CGFloat) {
        _level = level
        createQuality()
        _growth.stamina = _stars.stamina + extraProperty(value: _stars.stamina)
        _growth.strength = _stars.strength + extraProperty(value: _stars.strength)
        _growth.agility = _stars.agility + extraProperty(value: _stars.agility)
        _growth.intellect = _stars.intellect + extraProperty(value: _stars.intellect)
        protectNew()
        levelTo(level: level)
        _extensions.hp = _extensions.health
        _slot = seed(min: _spellSlot.min, max: _spellSlot.max + 1)
        _spellCount = _slot
        _sensitive = seed(min: 15, max: 56)
    }
    func protectNew() {
        if _level < 10 {
            let initMax:CGFloat = 1.2
            if _growth.stamina > initMax {
                _growth.stamina = initMax
            }
            if _growth.strength > initMax {
                _growth.strength = initMax
            }
            if _growth.agility > initMax {
                _growth.agility = initMax
            }
            if _growth.intellect > initMax {
                _growth.intellect = initMax
            }
        }
    }
    func levelTo(level:CGFloat) {
        staminaChange(value: (level + 10) * _growth.stamina)
        strengthChange(value: (level + 10) * _growth.strength)
        agilityChange(value: (level + 10) * _growth.agility)
        intellectChange(value: (level + 10) * _growth.intellect)
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
    }
    
    func expUp(up:CGFloat) {
        _exp += up
        let en = expNext()
        if _exp >= en {
            levelup()
            _exp = 0
        }
    }
    func isClose() -> Bool {
        if nil == _weapon {
            return true
        }
        return _weapon!.isClose
    }
    func getLoots() -> Array<Prop> {
        return Array<Prop>()
    }
    
}
