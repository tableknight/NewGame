//
//  BallLighting.swift
//  GoD
//
//  Created by kai chen on 2019/5/9.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class BallLighting: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "球状闪电"
        _description = "对中心单位造成85%雷电伤害，外层单位受到递减的雷电伤害"
        _rate = 0.85
        _cooldown = 1
        isThunder = true
        _quality = Quality.RARE
        autoCast = true
    }
    override func cast(completion: @escaping () -> Void) {
        let b = _battle!
        let c = _battle._curRole
        let p = c.playerPart
        c.actionCast {
            var u = b.getUnitBySeat(seat: (p ? BUnit.TBM : BUnit.BTM))
            if u != nil {
                self.attack(u!)
            }
            self._rate = 0.55
            u = b.getUnitBySeat(seat: (p ? BUnit.TTM : BUnit.BBM))
            if u != nil {
                self.attack(u!)
            }
            u = b.getUnitBySeat(seat: (p ? BUnit.TBL : BUnit.BTL))
            if u != nil {
                self.attack(u!)
            }
            u = b.getUnitBySeat(seat: (p ? BUnit.TBR : BUnit.BTR))
            if u != nil {
                self.attack(u!)
            }
            self._rate = 0.25
            u = b.getUnitBySeat(seat: (p ? BUnit.TTL : BUnit.BBL))
            if u != nil {
                self.attack(u!)
            }
            u = b.getUnitBySeat(seat: (p ? BUnit.TTR : BUnit.BBR))
            if u != nil {
                self.attack(u!)
            }
            setTimeout(delay: 2.5, completion: completion)
        }
    }
    private func attack(_ t:BUnit) {
        if !hadSpecialAction(t: t) {
            let damage = thunderDamage(t)
            t.actionAttacked {
                t.showValue(value: damage, damageType: DamageType.THUNDER, textColor: ElementColor.THUNDER)
            }
            t.lighting2()
        }
    }
    override func findTarget() {
//        findSingleTargetNotBlocked()
//        _battle._selectedTargets = getAdajcentUnits(target: _battle._selectedTarget!)
//        _battle._selectedTargets.append(_battle._selectedTarget!)
    }
}
