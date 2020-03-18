//
//  QiWave.swift
//  GoD
//
//  Created by kai chen on 2019/2/12.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class QiWave:HandSkill {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.QiWave
        _name = "气功破"
        _description = "对随机2-4个目标造成敏捷195%攻击力的物理伤害"
        _quality = Quality.RARE
        _rate = 1.95
        _cooldown = 2
        isClose = false
        autoCast = true
        cost(value: 20)
    }
    override func cast(completion: @escaping () -> Void) {
        let ts = _battle._selectedTargets
        _battle._curRole.actionAttack {
            self._battle._curRole.play("Slash4")
            for t in ts {
                let damage = self.physicalDamage(t)
                t.gun1f()
                if !self.hasPhysicalEvent(t: t) {
                    t.actionAttacked {
                        t.showValue(value: damage, criticalFromSpell: false, critical: self.beCritical)
                    }
//                    t.attacked2()
                }
                
                
            }
            setTimeout(delay: 2.2, completion: completion)
        }
    }
    override func findTarget() {
        let c = _battle._curRole
        let max = c.weaponIs(Sacred.NilSeal) ? [3,4,5,3,4,5,3,4,5,4,4,4].one() : [2,3,4,2,3,4,2,3,4,3,3,3].one()
        var targets = c.playerPart ? _battle._enemyPart : _battle._playerPart
        _battle._selectedTargets = []
        for _ in 0...max - 1 {
            if targets.count > 0 {
                let index = seed(to: targets.count)
                _battle._selectedTargets.append(targets[index])
                targets.remove(at: index)
            }
        }
        
    }
    override func selectable() -> Bool {
        return isEmptyHand()
    }
}
