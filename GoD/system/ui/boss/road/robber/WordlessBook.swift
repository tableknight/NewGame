//
//  WordlessBook.swift
//  GoD
//
//  Created by kai chen on 2019/7/13.
//  Copyright © 2019 Chen. All rights reserved.
//

//import SpriteKit
//class WordlessBook: MagicItem {
//    override init() {
//        super.init()
//        usable = true
//        usableInBattle = false
//        _price = 448
//        _storePrice = 448
//        _name = "无字天书"
//        _description = "使劲摩擦，就可以看到书上写的内容了。"
//        _quality = Quality.SACRED
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//    override func use() {
//        removeFromChar()
//        let l = Loot()
//        let char = Game.instance.char!
//        let book = SpellBook()
//        book.spell = l.getRandomSacredSpell()
//        char.addProp(p: book)
//        showMsg(text: "你获得了技能书[\(book.spell._name)]")
//    }
//}
