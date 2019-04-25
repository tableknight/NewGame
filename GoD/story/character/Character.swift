//
//  Character.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/20.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Character: Creature {
//    static var MAX_STORED_MINIONS_COUNT = "maxStoredMinionsCount"
//    static var MAX_MINIONS_COUNT = "maxMinionsCount"
    override init() {
        super.init()
        isMainChar = true
        _name = "冒险者"
//        _setting["maxStoredMinionsCount"] = 5
//        _setting["maxMinionsCount"] = 6
//        _setting["storageSize"] = 40
//        _setting["bagSize"] = 24
        _seat = BUnit.LLM
//        _img = Data.instance
    }
    override func create(level: CGFloat = 1) {
        staminaChange(value: 15)
        strengthChange(value: 15)
        agilityChange(value: 15)
        intellectChange(value: 15)
        _extensions.hp = _extensions.health
//        _spells = [TurnAttack(), FeignAttack()]
        _level = level
        
//        _weapon = NewSword()
//        _weapon.on()
    }
    
    func hasSpell(spell:Spell) -> Bool {
        for s in _spells {
            if s._name == spell._name {
                return true
            }
        }
        for s in _spellsInuse {
            if s._name == spell._name {
                return true
            }
        }
        for m in _minions {
            for s in m._spellsInuse {
                if s._name == spell._name {
                    return true
                }
            }
        }
        return false
    }
    func removeSpell(spell:Spell) {
        var index = _spells.index(of: spell)
        if index != nil {
            _spells.remove(at: index!)
            return
        }
        index = _spellsInuse.index(of: spell)
        if index != nil {
            _spellsInuse.remove(at: index!)
            return
        }
        for m in _minions {
            index = m._spellsInuse.index(of: spell)
            if index != nil {
                m._spellsInuse.remove(at: index!)
                return
            }
        }
    }
    
    func addProp(p:Prop) {
        if p is Item && !(p is SpellBook){
            var exist = false
            for e in _props {
                if type(of: e) == type(of: p) {
                    let i = e as! Item
                    i._count += 1
                    exist = true
                    break
                }
            }
            if !exist {
                _props.insert(p, at: 0)
            }
        } else {
            _props.insert(p, at: 0)
        }
    }
    
    func addStorage(p:Prop) {
        if p is Item {
            if p is SpellBook {
                _props.append(p)
            } else {
                var exist = false
                for e in _props {
                    if type(of: e) == type(of: p) {
                        let i = e as! Item
                        i._count += p._count
                        exist = true
                        break
                    }
                }
                if !exist {
                    _props.append(p)
                }
            }
        } else {
            _props.append(p)
        }
    }
    
    func removeProp(p:Prop) {
        let i = _props.index(of: p)
        if p is Item {
            if nil != i {
//                let itm = _props[i!] as! Item
                if p._count > 1 {
                    p._count -= 1
                } else {
                    _props.remove(at: i!)
                }
            }
        } else {
            if nil != i {
                _props.remove(at: i!)
            }
        }
    }
    func hasProp(p:Prop) -> Prop? {
        let i = _props.index(of: p)
        if nil != i {
            return _props[i!]
        }
        return nil
    }
    func discardProp(p:Prop) {
        let i = _props.index(of: p)
        _props.remove(at: i!)
    }
    func removeStorage(p:Prop) {
        let i = _props.index(of: p)
        if p is Item {
            if nil != i {
                //                let itm = _props[i!] as! Item
                if p._count > 1 {
                    p._count -= 1
                } else {
                    _props.remove(at: i!)
                }
            }
        } else {
            if nil != i {
                _props.remove(at: i!)
            }
        }
    }
    
    override func levelup() {
        _leftPoint += _levelPoint
        _level += 1
        _extensions.hp = _extensions.health
    }
    
    override func levelTo(level: CGFloat) {
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
    
    var _minionsCount = 2
    var _props = Array<Prop>()
    var _storage = Array<Prop>()
    var _minions = Array<Creature>()
    var _storedMinions = Array<Creature>()
    
    var hasShield = false
    var hasEarring = false
    var hasWeapon = true
    var hasMark = false
    var _amulet:Amulet?
    var _leftRing:Ring?
    var _rightRing:Ring?
    var _earRing = EarRing()
    var _shield:Shield?
    var _magicMark:MagicMark?
    var _soulStone:SoulStone?
    
    var _dungeonLevel:Int = 1
    var _levelPoint = 5
    var _money = 0
    var _key = ""
    
    private enum CodingKeys: String, CodingKey {
        case _dungeonLevel
        case _minionsCount
        case _props
        case _minions
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
        case _levelPoint
        case _money
        case _propsClass
        case itemsClass
        case items
        case weaponsClass
        case weapons
        case armorsClass
        case armors
        case spellBooks
        case spellBooksClass
        case marks
        case instruments
        case _key
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _dungeonLevel = try values.decode(Int.self, forKey: ._dungeonLevel)
        _minionsCount = try values.decode(Int.self, forKey: ._minionsCount)
//        _props = try values.decode(Array.self, forKey: ._props)
        _minions = try values.decode(Array.self, forKey: ._minions)
        hasShield = try values.decode(Bool.self, forKey: .hasShield)
        hasEarring = try values.decode(Bool.self, forKey: .hasEarring)
        hasWeapon = try values.decode(Bool.self, forKey: .hasWeapon)
        hasMark = try values.decode(Bool.self, forKey: .hasMark)
        _amulet = try? values.decode(Amulet.self, forKey: ._amulet)
        _leftRing = try? values.decode(Ring.self, forKey: ._leftRing)
        _rightRing = try? values.decode(Ring.self, forKey: ._rightRing)
        _shield = try? values.decode(Shield.self, forKey: ._shield)
        _magicMark = try? values.decode(MagicMark.self, forKey: ._magicMark)
        _soulStone = try? values.decode(SoulStone.self, forKey: ._soulStone)
        _levelPoint = try values.decode(Int.self, forKey: ._levelPoint)
        _money = try values.decode(Int.self, forKey: ._money)
        _key = try values.decode(String.self, forKey: ._key)
//        let cls:Array<String> = try values.decode(Array.self, forKey: ._propsClass)
        let marks:Array<MagicMark> = try values.decode(Array.self, forKey: .marks)
        let instruments:Array<Instrument> = try values.decode(Array.self, forKey: .instruments)
        let weapons:Array<Weapon> = try values.decode(Array.self, forKey: .weapons)
//        let weaponsClass:Array<String> = try values.decode(Array.self, forKey: .weaponsClass)
        let armors:Array<Armor> = try values.decode(Array.self, forKey: .armors)
//        let armorsClass:Array<String> = try values.decode(Array.self, forKey: .armorsClass)
        let items:Array<Item> = try values.decode(Array.self, forKey: .items)
        let itemsClass:Array<String> = try values.decode(Array.self, forKey: .itemsClass)
        let spellBooks:Array<SpellBook> = try values.decode(Array.self, forKey: .spellBooks)
//        let spellBooksClass:Array<String> = try values.decode(Array.self, forKey: .spellBooksClass)
        
//        let allProps = [Wand(),Bow(),Blunt(),Sword(),Instrument(),Fist(),Dagger(),
//                        MagicMark(), SoulStone(), Shield(), Ring(), EarRing(), Amulet()]
        _props = []
        let l = Loot()
        var allWeapons = Array<Weapon>()
        for i in l._weaponlist {
            allWeapons.append(l.getWeaponById(id: i))
        }
        var allArmors = Array<Armor>()
        for i in l._armorlist {
            allArmors.append(l.getArmorById(id: i))
        }
        var allItems = Array<Item>()
        for i in 0...7 {
            allItems.append(l.getItemByid(id: i))
        }
        if itemsClass.count > 0 {
            for i in 0...itemsClass.count - 1 {
                let tp = NSClassFromString(itemsClass[i])
                for a in allItems {
                    if tp == type(of: a) {
                        a._count = items[i]._count
                        //                    addProp(p: a)
                        _props.append(a)
                        break
                    }
                }
            }
        }
        for w in weapons {
//            addProp(p: w)
            _props.append(w)
        }
        for a in armors {
//            addProp(p: a)
            _props.append(a)
        }
        for s in spellBooks {
//            addProp(p: s)
            _props.append(s)
        }
        for m in marks {
            _props.append(m)
        }
        for i in instruments {
            _props.append(i)
        }
        
    }
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_dungeonLevel, forKey: ._dungeonLevel)
        try container.encode(_minionsCount, forKey: ._minionsCount)
//        try container.encode(_props, forKey: ._props)
        try container.encode(_minions, forKey: ._minions)
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
        try container.encode(_levelPoint, forKey: ._levelPoint)
        try container.encode(_money, forKey: ._money)
        try container.encode(_key, forKey: ._key)
        var weapons = Array<Weapon>()
        var armors = Array<Armor>()
        var items = Array<Item>()
        var spellBooks = Array<SpellBook>()
        var weaponClassNames = Array<String>()
        var armorClassNames = Array<String>()
        var itemClassNames = Array<String>()
        var spellBookClassNames = Array<String>()
        var marks = Array<MagicMark>()
        var instrments = Array<Instrument>()
        for i in _props {
            if i is MagicMark {
                marks.append(i as! MagicMark)
            } else if i is Instrument {
                instrments.append(i as! Instrument)
            } else if i is Weapon {
                weaponClassNames.append(NSStringFromClass(type(of: i)))
                weapons.append(i as! Weapon)
            } else if i is Armor {
                armorClassNames.append(NSStringFromClass(type(of: i)))
                armors.append(i as! Armor)
            } else if i is SpellBook {
                spellBookClassNames.append(NSStringFromClass(type(of: i)))
                spellBooks.append(i as! SpellBook)
            } else if i is Item {
                itemClassNames.append(NSStringFromClass(type(of: i)))
                items.append(i as! Item)
            }
        }
        try container.encode(weapons, forKey: .weapons)
        try container.encode(weaponClassNames, forKey: .weaponsClass)
        try container.encode(armors, forKey: .armors)
        try container.encode(armorClassNames, forKey: .armorsClass)
        try container.encode(items, forKey: .items)
        try container.encode(itemClassNames, forKey: .itemsClass)
        try container.encode(spellBooks, forKey: .spellBooks)
        try container.encode(marks, forKey: .marks)
        try container.encode(instrments, forKey: .instruments)
        try super.encode(to: encoder)
    }
    
    
    
//    func hasSpell(spell:Spell) -> Bool {
//        for s in _spells {
//            if type(of: spell) == type(of: s) {
//                return false
//            }
//        }
//        for u in _minions {
//            for s in u._spellsInuse {
//                if type(of: spell) == type(of: s) {
//                    return false
//                }
//            }
//        }
//        
////        _spells.append(spell)
//        
//        return true
//    }
    
//    var _setting = Dictionary<String, Any>()
//    var _boss:Dictionary<String, Dictionary<String, String>> = [
//        "malkus" : ["name": "马尔库斯", "passed": "0", "level" : "21"],
//        "dius" : ["name": "迪乌斯", "passed": "0", "level" : "32"],
//        "umisa" : ["name": "犹弥萨", "passed": "0", "level" : "40"],
//        "francis" : ["name": "佛朗西斯", "passed": "0", "level" : "46"],
//        "idylls" : ["name": "埃迪尔斯", "passed": "0", "level" : "50"],
//        "kukur" : ["name": "库库尔", "passed": "0", "level" : "59"],
//        "pitheron" : ["name": "皮瑟隆", "passed": "0", "level" : "66"],
//        "iberis" : ["name": "伊比利斯", "passed": "0", "level" : "78"],
//        "georgeantonbill" : ["name": "乔治安顿比尔", "passed": "0", "level" : "82"],
//        "idlir" : ["name": "伊德利尔", "passed": "0", "level" : "88"],
//        "cusses" : ["name": "库塞斯", "passed": "0", "level" : "96"],
//        "eykan" : ["name": "埃坎", "passed": "0", "level" : "102"],
//    ]
    
//    var _event = Array<Int>()
    
//    var fn:() -> Void = {}
}
