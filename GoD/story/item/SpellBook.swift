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
            _name = newValue._name
            _description = newValue._description
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
}
