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
        _quality = Quality.RARE
        _name = "雷击阵"
        _cooldown = 3
        _description = "随机造成2-5次雷电伤害，单次伤害为精神的35%"
        isThunder = true
        autoCast = true
        _rate = 0.35
    }
    private var _step = 0
    override func cast(completion: @escaping () -> Void) {
        let c = _battle._curRole
        let b = _battle!
        let times = seed(min: 1, max: 5)
//        let times = 5;
//        debug("雷电次数 \(times + 1)")
        let timeSpace:CGFloat = 0.25
        _step = times
        c.actionCast {
            for i in 0...times {
//                let wait = SKAction.wait(forDuration: TimeInterval(i.toFloat() * timeSpace))
                c.actionWait(i.toFloat() * timeSpace) {
                    let ts = c.playerPart ? b._enemyPart : b._playerPart
                    if ts.count < 1 {
                        return
                    } else {
                       self._battle._selectedTarget = ts.one()
                    }
                    self.attack()
                }
            }
            let delay = times.toFloat() * timeSpace + 1.5
            setTimeout(delay: delay, completion: completion)
        }
        
    }
    
    private func attack() {
        let t = _battle._selectedTarget!
        _damageValue = thunderDamage(t)
        let damage = _damageValue
        if !hadSpecialAction(t: t) {
            t.actionAttacked {
                t.showValue(value: damage, damageType: DamageType.THUNDER, textColor: ElementColor.THUNDER)
            }
        }
    }
    override func findTarget() {
        findSingleTargetNotBlocked()
    }
}
