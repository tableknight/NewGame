//
//  LightingFist.swift
//  GoD
//
//  Created by kai chen on 2019/2/12.
//  Copyright © 2019年 Chen. All rights reserved.
//


import SpriteKit
class LightingFist:Physical, HandSkill {
    override init() {
        super.init()
        _name = "闪雷破"
        _description = "对目标造成65%攻击力的物理伤害，附带35%的雷电伤害，有一定几率降低目标10点雷抗，需要空手"
        _quality = Quality.SACRED
        _cooldown = 1
        _rate = 0.65
    }
    override func cast(completion: @escaping () -> Void) {
        let t = _battle._selectedTarget!
        _battle._curRole.actionAttack {
            if !self.hasPhysicalEvent(t: t, completion: completion) {
                let damage = self.physicalDamage(t)
                t.actionAttacked {
                    t.showValue(value: damage)
                    let thunderDamage = self.thunderFactor(from: self._battle._curRole, to: t) * damage * 0.35
                    setTimeout(delay: 0.5, completion: {
                        t.showValue(value: thunderDamage, isCritical: false, textColor: DamageColor.THUNFER) {
                            completion()
                        }
                    })
                }
            }
        }
    }
    
    
    override func selectable() -> Bool {
        return isEmptyHand()
    }
}

