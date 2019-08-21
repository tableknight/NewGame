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
        _race = EvilType.MAN
//        _img = Data.instance
    }
    override func create(level: CGFloat = 1) {
        let val:CGFloat = 20
        staminaChange(value: val)
        strengthChange(value: val)
        agilityChange(value: val)
        intellectChange(value: val)
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
        if _spells.count > 0 {
            for i in 0..._spells.count - 1 {
                if type(of: _spells[i]) == type(of: spell) {
                    _spells.remove(at: i)
                    return
                }
            }
        }
        if _spellsInuse.count > 0 {
            for i in 0..._spellsInuse.count - 1 {
                if type(of: _spellsInuse[i]) == type(of: spell) {
                    _spellsInuse.remove(at: i)
                    return
                }
            }
        }
        for m in _minions {
            if m._spellsInuse.count > 0 {
                for i in 0...m._spellsInuse.count - 1 {
                    if type(of: m._spellsInuse[i]) == type(of: spell) {
                        m._spellsInuse.remove(at: i)
                        return
                    }
                }
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
        let i = _props.firstIndex(of: p)
        if p is Item {
            if nil != i {
//                let itm = _props[i!] as! Item
                p._count -= 1
                if p._count > 0 {
                    
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
        let i = _props.firstIndex(of: p)
        if nil != i {
            return _props[i!]
        }
        return nil
    }
    func discardProp(p:Prop) {
        let i = _props.firstIndex(of: p)
        _props.remove(at: i!)
    }
    func removeStorage(p:Prop) {
        let i = _props.firstIndex(of: p)
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
        Game.instance.curStage.setBarValue()
//        Game.instance.curStage._curScene._role.speak(text: "LEVEL UP!")
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
    var _pro = ""
    
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
        case daggers
        case swords
        case blunts
        case wands
        case bows
        case fists
        case amulets
        case shields
        case rings
        case soulstones
        case _key
        case _pro
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
        _pro = try values.decode(String.self, forKey: ._pro)
//        let cls:Array<String> = try values.decode(Array.self, forKey: ._propsClass)
        let marks:Array<MagicMark> = try values.decode(Array.self, forKey: .marks)
        let instruments:Array<Instrument> = try values.decode(Array.self, forKey: .instruments)
        let swords:Array<Sword> = try values.decode(Array.self, forKey: .swords)
        let blunts:Array<Blunt> = try values.decode(Array.self, forKey: .blunts)
        let wands:Array<Wand> = try values.decode(Array.self, forKey: .wands)
        let bows:Array<Bow> = try values.decode(Array.self, forKey: .bows)
        let fists:Array<Fist> = try values.decode(Array.self, forKey: .fists)
        let daggers:Array<Dagger> = try values.decode(Array.self, forKey: .daggers)
//        let weaponsClass:Array<String> = try values.decode(Array.self, forKey: .weaponsClass)
//        let armors:Array<Armor> = try values.decode(Array.self, forKey: .armors)
//        let armorsClass:Array<String> = try values.decode(Array.self, forKey: .armorsClass)
        let items:Array<Item> = try values.decode(Array.self, forKey: .items)
        let itemsClass:Array<String> = try values.decode(Array.self, forKey: .itemsClass)
        let spellBooks:Array<SpellBook> = try values.decode(Array.self, forKey: .spellBooks)
        let amulets:Array<Amulet> = try values.decode(Array.self, forKey: .amulets)
        let rings:Array<Ring> = try values.decode(Array.self, forKey: .rings)
        let shields:Array<Shield> = try values.decode(Array.self, forKey: .shields)
        let soulstones:Array<SoulStone> = try values.decode(Array.self, forKey: .soulstones)
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
        for i in 0...l._maxItemNumber {
            allItems.append(l.getItemByid(id: i))
        }
        if itemsClass.count > 0 {
            for i in 0...itemsClass.count - 1 {
                let tp:AnyClass? = NSClassFromString(itemsClass[i])
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
        for s in spellBooks {
            _props.append(s)
        }
        for m in marks {
            _props.append(m)
        }
        for i in instruments {
            _props.append(i)
        }
        for w in swords {
            _props.append(w)
        }
        for w in bows {
            _props.append(w)
        }
        for w in fists {
            _props.append(w)
        }
        for w in wands {
            _props.append(w)
        }
        for w in daggers {
            _props.append(w)
        }
        for a in blunts {
            _props.append(a)
        }
        for a in rings {
            _props.append(a)
        }
        for a in shields {
            _props.append(a)
        }
        for a in soulstones {
            _props.append(a)
        }
        for a in amulets {
            _props.append(a)
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
        try container.encode(_pro, forKey: ._pro)
//        var weapons = Array<Weapon>()
//        var armors = Array<Armor>()
        var items = Array<Item>()
        var spellBooks = Array<SpellBook>()
//        var weaponClassNames = Array<String>()
//        var armorClassNames = Array<String>()
        var itemClassNames = Array<String>()
        var spellBookClassNames = Array<String>()
        var marks = Array<MagicMark>()
        
        var amulets = Array<Amulet>()
        var shields = Array<Shield>()
        var rings = Array<Ring>()
        var soulstones = Array<SoulStone>()
        
        //weapon
        var instrments = Array<Instrument>()
        var swords = Array<Sword>()
        var daggers = Array<Dagger>()
//        var instrments = Array<Instrument>()
        var bows = Array<Bow>()
        var wands = Array<Wand>()
        var blunts = Array<Blunt>()
        var fists = Array<Fist>()
        
        for i in _props {
            if i is MagicMark {
                marks.append(i as! MagicMark)
            } else if i is Instrument {
                instrments.append(i as! Instrument)
            } else if i is Sword {
                swords.append(i as! Sword)
            } else if i is Dagger {
                daggers.append(i as! Dagger)
            } else if i is Bow {
                bows.append(i as! Bow)
            } else if i is Wand {
                wands.append(i as! Wand)
            } else if i is Blunt {
                blunts.append(i as! Blunt)
            } else if i is Fist {
                fists.append(i as! Fist)
            } else if i is Amulet {
                amulets.append(i as! Amulet)
            } else if i is Shield {
                shields.append(i as! Shield)
            } else if i is Ring {
                rings.append(i as! Ring)
            } else if i is SoulStone {
                soulstones.append(i as! SoulStone)
            } else if i is SpellBook {
                spellBookClassNames.append(NSStringFromClass(type(of: i)))
                spellBooks.append(i as! SpellBook)
            } else if i is Item {
                itemClassNames.append(NSStringFromClass(type(of: i)))
                items.append(i as! Item)
            }
        }
        try container.encode(amulets, forKey: .amulets)
        try container.encode(rings, forKey: .rings)
        try container.encode(shields, forKey: .shields)
        try container.encode(soulstones, forKey: .soulstones)
        try container.encode(marks, forKey: .marks)
        
        try container.encode(swords, forKey: .swords)
        try container.encode(daggers, forKey: .daggers)
        try container.encode(blunts, forKey: .blunts)
        try container.encode(wands, forKey: .wands)
        try container.encode(bows, forKey: .bows)
        try container.encode(fists, forKey: .fists)
//        try container.encode(weaponClassNames, forKey: .weaponsClass)
//        try container.encode(armors, forKey: .armors)
//        try container.encode(armorClassNames, forKey: .armorsClass)
        try container.encode(items, forKey: .items)
        try container.encode(itemClassNames, forKey: .itemsClass)
        try container.encode(spellBooks, forKey: .spellBooks)
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
