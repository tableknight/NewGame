//
//  SpellBook.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/22.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class SpellBook:Item {
    override init() {
        super.init()
    }
    
    private var _spell:Spell!
    var spell:Spell {
        set {
            _spell = newValue
            _name = "\(newValue._name)之书"
            _description = "使用后习得法术[\(newValue._name)]，\(newValue._description)"
            _quality = newValue._quality
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
