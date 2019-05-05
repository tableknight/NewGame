//
//  Lighting.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/24.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Lighting: Passive {
    
    override init() {
        super.init()
        _name = "落雷"
        isMagical = true
        isThunder = true
        _quality = Quality.RARE
        _description = "行动结束时对随机敌方目标造成雷击,雷击造成精神25%的雷电伤害"
        _rate = 0.25
        hasAfterMoveAction = true
        _delay = 1.5
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        if c._unit._weapon is ThorsHammer {
            _rate = 0.5
        }
        let t = _battle._selectedTarget!
        let damage = thunderDamage(t)
        c.showText(text: "Lighting") {
            if !self.hadSpecialAction(t:t, completion: completion) {
                t.actionAttacked {
                    t.showValue(value: damage) {
                        completion()
                    }
                }
            }
        }
    }
    
    override func findTarget() {
        findSingleTargetNotBlocked()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

