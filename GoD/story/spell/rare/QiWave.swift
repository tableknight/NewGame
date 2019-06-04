//
//  QiWave.swift
//  GoD
//
//  Created by kai chen on 2019/2/12.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class QiWave:Physical, HandSkill {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "气功波"
        _description = "对随机2-4个目标造成攻击力85%攻击力的物理伤害"
        _quality = Quality.RARE
        _rate = 0.85
        _cooldown = 1
        isClose = false
        autoCast = true
    }
    override func cast(completion: @escaping () -> Void) {
        let ts = _battle._selectedTargets
        _battle._curRole.actionAttack {
            for t in ts {
                let damage = self.physicalDamage(t)
                if !self.hasPhysicalEvent(t: t) {
                    t.actionAttacked {
                        t.showValue(value: damage, criticalFromSpell: false, critical: self.beCritical)
                    }
                    t.attacked2()
                }
            }
            setTimeout(delay: 2.2, completion: completion)
        }
    }
    override func findTarget() {
        let max = seed(min: 2, max: 5)
        var targets = _battle._curRole.playerPart ? _battle._enemyPart : _battle._playerPart
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
