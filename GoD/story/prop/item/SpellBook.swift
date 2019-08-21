//
//  SpellBook.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/22.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class SpellBook:Item {
    static let NORMAL_SPELL_SELLING_PRICE = 6
    static let GOOD_SPELL_SELLING_PRICE = 16
    static let RARE_SPELL_SELLING_PRICE = 36
    static let SACRED_SPELL_SELLING_PRICE = 48
    override init() {
        super.init()
        _showChar = "书"
    }
    
    private var _spell:Spell!
    var spell:Spell {
        set {
            _spell = newValue
            _name = "\(newValue._name)之书"
            _description = "使用后习得法术[\(newValue._name)]，\(newValue._description)"
            _quality = newValue._quality
            if _quality == Quality.NORMAL {
                _price = 18
                _storePrice = 6
            } else if _quality == Quality.GOOD {
                _price = 48
                _storePrice = 16
            } else if _quality == Quality.RARE {
                _price = 108
                _storePrice = 36
            } else if _quality == Quality.SACRED {
                _price = 144
                _storePrice = 48
            }
        }
        get {
            return _spell
        }
    }
    
    override func use(target: Creature) {
        let char = Game.instance.char!
        if !char.hasSpell(spell: _spell) {
            char._spells.append(_spell)
            char.removeProp(p: self)
        } else {
            debug("spell exist")
        }
    }
    private enum CodingKeys: String, CodingKey {
        case _spell
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let s = try values.decode(String.self, forKey: ._spell)
        let l = Loot()
        let allSpells = l.getAllSpells()
        for spell in allSpells {
            if NSClassFromString(s) == type(of: spell) {
                _spell = spell
                break
            }
        }
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(NSStringFromClass(type(of: _spell)), forKey: ._spell)
    }
}
