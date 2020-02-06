//
//  Character.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/20.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Character: Unit {
    override init() {
        super.init()
        _name = "冒险者"
        _race = EvilType.MAN
    }
    func create() {
        let val:CGFloat = 15
        staminaChange(value: val)
        strengthChange(value: val)
        agilityChange(value: val)
        intellectChange(value: val)
        _leftPoint = 20
        _extensions.hp = _extensions.health
    }
    
    func hasSpell(spell:Spell) -> Bool {
        return hasSpell(id: spell._id)
    }
    func hasSpell(id:Int) -> Bool {
        var spells = _spells + _spellsInuse
        for m in _minions {
            spells += m._spellsInuse
        }
        for m in _minions {
            spells += m._spellsInuse
        }
        for m in _storedMinions {
            spells += m._spellsInuse
        }
        
        for s in spells {
            if s == id {
                return true
            }
        }

        return false
    }
    func hasSpellHidden(spell:Spell) -> Bool {
        return false
    }
    func removeSpell(id:Int) {
        var index = _spellsInuse.firstIndex(of: id)
        if nil != index {
            _spellsInuse.remove(at: index!)
            return
        }
        index = _spells.firstIndex(of: id)
        if nil != index {
            _spells.remove(at: index!)
            return
        }
        for m in _minions + _storedMinions {
            index = m._spellsInuse.firstIndex(of: id)
            if nil != index {
                m._spellsInuse.remove(at: index!)
                return
            }
        }
        
    }
    func removeSpellHidden(spell:Spell) {
    }
    override func levelup() {
        _leftPoint += _levelPoint
        _level += 1
        _extensions.hp = _extensions.health
        Game.instance.curStage.setBarValue()
    }
    
    func levelTo(level: CGFloat) {
        for _ in 0...level.toInt() - 1 {
            for _ in 1..._levelPoint {
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
    }
    func addItem(_ item: Item) {
        if item is Outfit {
            _armors.insert(item as! Outfit, at: 0)
            return
        }
        if item.stackable {
            var exist = false
            for i in _items {
                if i._type == item._type {
//                    i._count += item._count
                    i._count += 1
                    exist = true
                    break
                }
            }
            if !exist {
                _items.insert(item, at: 0)
            }
        } else {
            _items.insert(item, at: 0)
        }
    }
    func removeItem(_ item:Item, _ count:Int = 1) {
        if item is Outfit {
            _armors.remove(at: _armors.firstIndex(of: item as! Outfit)!)
            return
        }
        for idx in 0..._items.count - 1 {
            let i = _items[idx]
            if i._type == item._type {
                i._count -= count
                if i._count < 1 {
                    _items.remove(at: idx)
                }
                break
            }
        }
    }
    func searchItem(type:String) -> Item? {
        for i in _items {
            if i ._type == type && i._count > 0 {
                return i
            }
        }
        return nil
    }
    func addMoney(num:Int) {
        _money += num
    }
    func lostMoney(num:Int) {
        _money -= num
    }
    
    func getReadyMinions() -> Array<Creature> {
        var ms = Array<Creature>()
        for m in _minions {
            if m._seat != BUnit.STAND_BY && m._extensions.hp >= 1 {
                ms.append(m)
            }
        }
        return ms
    }
    
    var _dungeonLevel:Int = 1
    var _minionsCount = 2
    var _items = Array<Item>()
    var _armors = Array<Outfit>()
    var _minions = Array<Creature>()
    var _storedMinions = Array<Creature>()
    
    var hasShield = true
    var hasEarring = true
    var hasWeapon = true
    var hasMark = true
    var _amulet:Outfit?
    var _leftRing:Outfit?
    var _rightRing:Outfit?
    var _shield:Outfit?
    var _magicMark:Outfit?
    var _soulStone:Outfit?
    var _weapon:Outfit?
    var _levelPoint = 5
    var _money = 0
    var _key = ""
    var _pro = ""
    
    private enum CodingKeys: String, CodingKey {
        case _dungeonLevel
        case _minionsCount
        case _items
        case _armors
        case _minions
        case _storedMinions
        case hasShield
        case hasEarring
        case hasWeapon
        case hasMark
        case _amulet
        case _leftRing
        case _rightRing
        case _shield
        case _magicMark
        case _soulStone
        case _weapon
        case _levelPoint
        case _money
        case _key
        case _pro
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _dungeonLevel = try values.decode(Int.self, forKey: ._dungeonLevel)
        _minionsCount = try values.decode(Int.self, forKey: ._minionsCount)
        _items = try values.decode(Array.self, forKey: ._items)
        _armors = try values.decode(Array.self, forKey: ._armors)
        _minions = try values.decode(Array.self, forKey: ._minions)
        _storedMinions = try values.decode(Array.self, forKey: ._minions)
        hasShield = try values.decode(Bool.self, forKey: .hasShield)
        hasEarring = try values.decode(Bool.self, forKey: .hasEarring)
        hasWeapon = try values.decode(Bool.self, forKey: .hasWeapon)
        hasMark = try values.decode(Bool.self, forKey: .hasMark)
        
        _amulet = try? values.decode(Outfit.self, forKey: ._amulet)
        _leftRing = try? values.decode(Outfit.self, forKey: ._leftRing)
        _rightRing = try? values.decode(Outfit.self, forKey: ._rightRing)
        _shield = try? values.decode(Outfit.self, forKey: ._shield)
        _magicMark = try? values.decode(Outfit.self, forKey: ._magicMark)
        _soulStone = try? values.decode(Outfit.self, forKey: ._soulStone)
        _weapon = try? values.decode(Outfit.self, forKey: ._weapon)
        _levelPoint = try values.decode(Int.self, forKey: ._levelPoint)
        _money = try values.decode(Int.self, forKey: ._money)
        _key = try values.decode(String.self, forKey: ._key)
        _pro = try values.decode(String.self, forKey: ._pro)
        
    }
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_dungeonLevel, forKey: ._dungeonLevel)
        try container.encode(_minionsCount, forKey: ._minionsCount)
        try container.encode(_items, forKey: ._items)
        try container.encode(_armors, forKey: ._armors)
        try container.encode(_minions, forKey: ._minions)
        try container.encode(_storedMinions, forKey: ._storedMinions)
        try container.encode(hasShield, forKey: .hasShield)
        try container.encode(hasEarring, forKey: .hasEarring)
        try container.encode(hasWeapon, forKey: .hasWeapon)
        try container.encode(hasMark, forKey: .hasMark)
        try container.encode(_amulet, forKey: ._amulet)
        try container.encode(_leftRing, forKey: ._leftRing)
        try container.encode(_rightRing, forKey: ._rightRing)
        try container.encode(_shield, forKey: ._shield)
        try container.encode(_magicMark, forKey: ._magicMark)
        try container.encode(_soulStone, forKey: ._soulStone)
        try container.encode(_weapon, forKey: ._weapon)
        try container.encode(_levelPoint, forKey: ._levelPoint)
        try container.encode(_money, forKey: ._money)
        try container.encode(_key, forKey: ._key)
        try container.encode(_pro, forKey: ._pro)
        try super.encode(to: encoder)
    }
    
    func weaponIs(_ effection:String) -> Bool {
        if _weapon?._effection == effection {
            return true
        }
        return false
    }
    
}
