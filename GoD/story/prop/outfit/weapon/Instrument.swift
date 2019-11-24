//
//  Instrument.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/25.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Instrument: Weapon {
    override init() {
        super.init()
        _name = "法器"
        _outfitName = "法器"
        _attackSpeed = 1.0
        _selfAttrs = [SPIRIT_BASE]
    }
    override func create(level: CGFloat) {
        _level = level
        createQuality()
        createSelfAttrs()
    
        createSpell()
        
        createPrice()
        _price *= 2
        _storePrice *= 2
        
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
    override func create() {
        create(level: _level)
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
//    var _spellAppended = false
//    var _spell = Spell()
//    private func getName() -> String {
//        let names = ["颌骨","水晶","灵珠","魔首"]
//        return names.one()
//    }
//    override func on() {
//        super.on()
//        let char = Game.instance.char!
//        if !(char.hasSpell(spell: _spell)) {
//            char._spells.append(_spell)
//            _spellAppended = true
//        }
//    }
//    override func off() {
//        super.off()
//        if _spellAppended {
//            let char = Game.instance.char!
//            char.removeSpell(spell: _spell)
//            _spellAppended = false
//        }
//    }
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
}
