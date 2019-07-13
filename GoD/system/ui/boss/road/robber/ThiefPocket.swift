//
//  ThiefPocket.swift
//  GoD
//
//  Created by kai chen on 2019/7/13.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class ThiefPocket: Item {
    override init() {
        super.init()
        usable = true
        usableInBattle = false
        _price = 1
        _sellingPrice = 1
        _name = "盗墓人的财宝"
        _description = "获得一大笔不菲的金币"
        _quality = Quality.GOOD
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override func use() {
        removeFromChar()
        let char = Game.instance.char!
        char.addMoney(num: seed(min: 50, max: 301))
        let s = Game.instance.curStage!
        if nil != s._curPanel {
            if s._curPanel is ItemPanel {
                (s._curPanel as! ItemPanel).reshowMoney()
            }
        }
    }
}

