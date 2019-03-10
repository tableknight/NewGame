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
        
        _description = "[" + _spell._name + "]"
        createPrice()
        _price *= 4
        _sellingPrice *= 4
        
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
            _spell = l.getSacredSpell(id: l.sacredSpellCount)
        }
    }
    override func create() {
        create(level: _level)
    }
    private func getName() -> String {
        let names = ["颌骨","水晶","灵珠","魔首"]
        return names.one()
    }
    var _spellAppended = false
    var _spell = Spell()
    override func on() {
        let char = Game.instance.char!
        if !(char.hasSpell(spell: _spell)) {
            char._spells.append(_spell)
            _spellAppended = true
        }
    }
    override func off() {
        if _spellAppended {
            let char = Game.instance.char!
            char.removeSpell(spell: _spell)
            _spellAppended = false
        }
    }
}
