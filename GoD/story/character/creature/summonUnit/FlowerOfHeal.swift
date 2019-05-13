//
//  SpringOfHeal.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/15.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class FlowerOfHeal: SummonUnit {
    override init() {
        super.init()
        _stars.strength = 1.3
        _stars.stamina = 1.8
        _stars.agility = 1.0
        _stars.intellect = 1.0
        _sensitive = 100
        _name = "治疗之花"
        _img = SKTexture(imageNamed: "13000013.png")
        _spellsInuse = [HealOfFlower()]
        _race = EvilType.NATURE
        _last = 5
    }
    override func create(level: CGFloat) {
        _level = level
        levelTo(level: level)
        _extensions.hp = _extensions.health
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class HealOfFlower: Magical {
    override init() {
        super.init()
        _quality = Quality.SACRED
        _name = "花语"
        _description = "恢复相邻单位15%最大生命。"
    }
    override func cast(completion: @escaping () -> Void) {
        let c = _battle._curRole
        var rate:CGFloat = 0.15
        if Game.instance.char._magicMark is MarkOfVitality {
            rate = 0.3
        }
        c.actionCast {
            let ts = self.getAdajcentUnits(target: c)
            for u in ts {
                u.actionHealed {
                    let value = u.getHealth() * rate
                    u.showValue(value: value)
                }
            }
            setTimeout(delay: 1.5, completion: {
                let su = c._unit as! SummonUnit
                if su._last < 1 {
                    c.actionDead {
                        c.removeFromBattle()
                        c.removeFromParent()
                    }
                } else {
                    su._last -= 1
                }
                completion()
            })
        }
        
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
