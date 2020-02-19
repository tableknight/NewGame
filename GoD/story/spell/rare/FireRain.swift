//
//  FireRain.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/23.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class FireRain: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.FireRain
        isFire = true
        _name = "耀斑"
        autoCast = true
        targetEnemy = true
        _description = "对所有敌方目标造成精神45%的火焰伤害，有小概率点燃目标"
        _quality = Quality.RARE
        _rate = 0.45
        _cooldown = 2
        cost(value: 35)
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
        let c = _battle._curRole
        for t in ts {
            let damage = fireDamage(t)
            if !hadSpecialAction(t:t) {
//                setTimeout(delay: 0.5, completion: {
                    t.actionAttacked {
                        t.showValue(value: damage, damageType: DamageType.FIRE, textColor: ElementColor.FIRE)
//                        if c.ringIs(FireCore.EFFECTION) {
//                            t.burning()
//                        } else {
//                            if self.d8() {
//                                t.burning()
//                            }
//                        }
                    }
//                })
//                t.flame2(index: 1, line: 1)
                
            }
        }
        c.light4() {
            completion()
        }
//        setTimeout(delay: 2.5, completion: completion)
    }
    
    override func findTarget() {
        findTargetPartAll()
    }
    
}
