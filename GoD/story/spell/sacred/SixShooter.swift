//
//  SixShooter.swift
//  GoD
//
//  Created by kai chen on 2019/5/14.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class SixShooter: Physical, BowSkill {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "六连发"
        _description = "进行六次快速射击，第一支箭造成攻击力100%的物理伤害，后续伤害每次递减18%"
        _rate = 1
        _quality = Quality.SACRED
        _cooldown = 2
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let p = _battle._curRole.playerPart
        c.actionShoot {
            for i in 0...5 {
                setTimeout(delay: i.toFloat() * 0.25, completion: {
                    let ts = p ? self._battle._enemyPart : self._battle._playerPart
                    if ts.count < 1 {
                        return
                    }
                    let t = ts.one()
                    self._rate = 1
                    for _ in 0...i {
                        self._rate *= 0.82
                    }
                    let damage = self.physicalDamage(t)
                    if !self.hadSpecialAction(t: t) {
                        if !self.hasMissed(target: t) {
                            t.actionAttacked {
                                t.showValue(value: damage, criticalFromSpell: false, critical: self.beCritical)
                            }
                        }
                    }
                })
            }
            setTimeout(delay: 2.5, completion: completion)
        }
    }
    override func selectable() -> Bool {
        return isWeaponBow()
    }
}
