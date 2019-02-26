//
//  ThunderArray.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class ThunderArray:Magical {
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
        let this = self
        let times = seed(min: 1, max: 5)
//        let times = 5;
//        debug("雷电次数 \(times + 1)")
        let timeSpace:CGFloat = 0.5
        _step = times
        c.actionCast {
            for i in 0...times {
//                let wait = SKAction.wait(forDuration: TimeInterval(i.toFloat() * timeSpace))
                c.actionWait(i.toFloat() * timeSpace) {
                    this.attack()
                }
            }
            let delay = times.toFloat() * timeSpace + 1.5
            setTimeout(delay: delay, completion: completion)
        }
        
    }
    
    private func attack() {
        findTarget()
        let t = _battle._selectedTarget
        if nil == t {
            debug("no target")
            return
        }
        _damageValue = thunderDamage(t!)
        let damage = _damageValue
        if !hadSpecialAction(t: t!, completion: {}) {
            t!.actionAttacked {
                t!.showValue(value: damage)
            }
        }
    }
    override func findTarget() {
        findSingleTargetNotBlocked()
    }
}
