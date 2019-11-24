//
//  MagicMark.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/28.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class MagicMark: Armor {
    override init() {
        super.init()
        _name = "魔印"
        _outfitName = "魔印"
        _level = 1
        _type = Outfit.TYPE_MAGIC_MARK
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
//    private enum CodingKeys: String, CodingKey {
//        case _spellAppended
//        case _spell
//    }
//    required init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        let s = try values.decode(String.self, forKey: ._spell)
//        let l = Loot()
//        let allSpells = l.getAllSpells()
//        for spell in allSpells {
//            if NSClassFromString(s) == type(of: spell) {
//                _spell = spell
//                break
//            }
//        }
//        _spellAppended = try values.decode(Bool.self, forKey: ._spellAppended)
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(_spellAppended, forKey: ._spellAppended)
//        try container.encode(NSStringFromClass(type(of: _spell)), forKey: ._spell)
//    }
    
    override func create(level: CGFloat) {
        _level = 1
        createQuality()
        createSpell()
    }
    override func create() {
        _level = 1
        createQuality()
        createSpell()
    }
    override func createQuality() {
        let _seed = seed()
        if _seed < 70 {
            _quality = Quality.NORMAL
            _price = 6
            _storePrice = 24
        } else if _seed < 90 {
            _quality = Quality.GOOD
            _price = 18
            _storePrice = 72
        } else if _seed < 96 {
            _quality = Quality.RARE
            _price = 36
            _storePrice = 144
        } else {
            _quality = Quality.SACRED
            _price = 64
            _storePrice =  256
        }
    }
    internal func createSpell() {
        let l = Loot()
        if _quality == Quality.NORMAL {
            _spell = l.getNormalSpell(id: seed(to: l.normalSpellCount))
        } else if _quality == Quality.GOOD {
            _spell = l.getGoodSpell(id: seed(to: l.goodSpellCount))
        } else if _quality == Quality.RARE {
            _spell = l.getRareSpell(id: seed(to: l.rareSpellCount))
        } else {
            _spell = l.getSacredSpell(id: seed(to: l.sacredSpellCount))
        }
    }
    
//    override func on() {
//        let char = Game.instance.char!
//        if !(char.hasSpell(spell: _spell)) {
//            char._spells.append(_spell)
//            _spellAppended = true
//        }
//    }
//    override func off() {
//        if _spellAppended {
//            let char = Game.instance.char!
//            char.removeSpell(spell: _spell)
//            _spellAppended = false
//        }
//    }
}
