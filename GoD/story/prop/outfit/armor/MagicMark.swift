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
    }
    var _spell:Spell = Spell()
    override func create(level: CGFloat) {
        _level = level
        createQuality()
        createSpell()
        createPrice()
    }
    override func createQuality() {
        let _seed = seed()
        if _seed < 70 {
            _quality = Quality.NORMAL
        } else if _seed < 90 {
            _quality = Quality.GOOD
        } else if _seed < 96 {
            _quality = Quality.RARE
        } else {
            _quality = Quality.SACRED
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
            _spell = l.getSacredSpell(id: l.sacredSpellCount)
        }
    }
    private var _spellAppended = false
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
    override func createPrice() {
        super.createPrice()
        price = _price * 4
    }
}
