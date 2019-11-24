//
//  ElementMaster.swift
//  GoD
//
//  Created by kai chen on 2019/2/14.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class ElementMaster:Passive {
    override init() {
        super.init()
        _name = "元素大师"
        _description = "行动结束，强化一种元素，获得50伤害和抵抗，强化顺序，火，冰，雷"
        _quality = Quality.SACRED
        hasAfterMoveAction = true
        _delay = 1.25
    }
    override func cast(completion: @escaping () -> Void) {
        let c = _battle._curRole
        let s = _battle._round % 3
        if 0 == _battle._round {
            c._elementalPower.thunder += 50
            c._elementalResistance.thunder += 50
        }
        var text = "error"
        if 0 == s {
            c._elementalPower.fire += 50
            c._elementalResistance.fire += 50
            c._elementalPower.thunder -= 50
            c._elementalResistance.thunder -= 50
            text = "火"
        } else if 1 == s {
            c._elementalPower.fire -= 50
            c._elementalResistance.fire -= 50
            c._elementalPower.water += 50
            c._elementalResistance.water += 50
            text = "冰"
        } else if 2 == s {
            c._elementalPower.water -= 50
            c._elementalResistance.water -= 50
            c._elementalPower.thunder += 50
            c._elementalResistance.thunder += 50
            text = "雷"
        } else {
            
        }
        c.mixed2(index: 13)
        c.showText(text: text) {
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
