//
//  FireRain.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/23.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class FireRain: Magical {
    override init() {
        super.init()
        isFire = true
        _name = "火雨"
        isAutoSelectTarget = true
        targetEnemy = true
        _description = "对所有敌方目标造成精神35%的火焰伤害"
        _quality = Quality.RARE
        _rate = 0.35
        _cooldown = 3
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let this = self
        c.actionCast {
            this.attack {
                completion()
            }
        }
    }
    
    func attack(completion:@escaping () -> Void) {
        let ts = _battle._selectedTargets
        for i in 0...ts.count - 1 {
            let t = ts[i]
            _damageValue = fireDamage(t)
            let damage = _damageValue
            if !hadSpecialAction(t:t, completion: completion) {
                t.actionAttacked {
                    t.showValue(value: damage)
                }
            }
        }
        setTimeout(delay: 2.5, completion: completion)
    }
    
    override func findTarget() {
        if _battle._curRole.playerPart {
            _battle._selectedTargets = _battle._enemyPart
        } else {
            _battle._selectedTargets = _battle._playerPart
        }
    }
    
}
