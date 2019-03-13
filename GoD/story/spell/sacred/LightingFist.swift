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
        _description = "对目标造成攻击65%的物理伤害，附带35%的雷电伤害，有一定几率降低目标10点雷抗"
        _quality = Quality.SACRED
        _cooldown = 2
        _rate = 0.65
    }
    override func cast(completion: @escaping () -> Void) {
        let t = _battle._selectedTarget!
        _battle._curRole.actionAttack {
            let damage = self.physicalDamage(t)
            if !self.hasPhysicalEvent(t: t, completion: completion) {
                t.actionAttacked {
                    t.showValue(value: damage)
                    let thunderDamage = self.thunderFactor(from: self._battle._curRole, to: t) * damage * 0.35
                    setTimeout(delay: 0.5, completion: {
                        t.showValue(value: thunderDamage, isCritical: false, textColor: DamageColor.THUNFER) {
                            if self.d5() {
                                t.showText(text: "TR -10") {
                                    completion()
                                }
                                t._elementalResistance.thunder -= 10
                            } else {
                                completion()
                            }
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
