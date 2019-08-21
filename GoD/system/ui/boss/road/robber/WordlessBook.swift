//
//  WordlessBook.swift
//  GoD
//
//  Created by kai chen on 2019/7/13.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class WordlessBook: Item {
    override init() {
        super.init()
        usable = true
        usableInBattle = false
        _price = 448
        _storePrice = 448
        _name = "无字天书"
        _description = "获得一个随机的神之技"
        _quality = Quality.SACRED
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override func use() {
        removeFromChar()
        let l = Loot()
        let char = Game.instance.char!
        let book = SpellBook()
        book.spell = l.getSacredSpell(id: l._sacredSpellArray.one())
        char.addProp(p: book)
    }
}
