//
//  ThunderArray.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class ThunderArray:Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    private var _times = 0
    override init() {
        super.init()
        _id = Spell.ThunderArray
        _quality = Quality.RARE
        _name = "雷击阵"
        _cooldown = 2
        _description = "随机造成3-6次雷电伤害，单次伤害为精神的40%"
        isThunder = true
        autoCast = true
        _rate = 0.4
        cost(value: 30)
    }
    private var _step = 0
    override func cast(completion: @escaping () -> Void) {
        let c = _battle._curRole
        let times = seed(min: 3, max: 7)
        _step = times
        c.actionCast {
            self.attack(completion: completion)
        }
        
    }
    
    private func attack(completion: @escaping () -> Void) {
        if _step < 1 {
            setTimeout(delay: 1, completion: completion)
            return
        }
        _step -= 1
        let c = _battle._curRole
        let b = _battle
        let ts = c.playerPart ? b._enemyPart : b._playerPart
        if ts.count < 1 {
            setTimeout(delay: 1, completion: completion)
            return
        }
        let t = ts.one()
        _damageValue = thunderDamage(t)
        let damage = _damageValue
        if !hadSpecialAction(t: t) {
            t.actionAttacked {}
            let sd = seed()
            if sd < 33 {
                t.thunder4s()
            } else if sd < 66 {
                t.thunder1f()
            } else {
                t.thunder1s()
            }
            t.play("Thunder4")
            t.showValue(value: damage, damageType: DamageType.THUNDER, textColor: ElementColor.THUNDER)
        }
        setTimeout(delay: 0.2) {
            self.attack(completion: completion)
        }
    }
    override func findTarget() {
        findSingleTargetNotBlocked()
    }
}
