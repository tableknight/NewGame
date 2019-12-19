//
//  Reborn.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Reborn: Passive {
    
    override init() {
        super.init()
        _id = Spell.Reborn
        _quality = Quality.SACRED
        _name = "重生"
        _description = "行动结束后恢复10%最大生命"
        hasAfterMoveAction = true
        _delay = 1.25
    }
    override func cast(completion: @escaping () -> Void) {
        let c = _battle._curRole
        _rate = 0.1
//        if c.soulstoneIs(HeartOfTarrasque.EFFECTION) {
//            _rate = 0.2
//        }

        let h = c.getHealth() * _rate
        c.showValue(value: h) {
            completion()
        }
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
