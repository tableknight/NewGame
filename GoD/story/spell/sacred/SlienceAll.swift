//
//  SlienceAll.swift
//  GoD
//
//  Created by kai chen on 2019/11/6.
//  Copyright © 2019 Chen. All rights reserved.
//

class SilenceAll: Magical, Curse {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.SilenceAll
        _name = "群体静默"
        _description = "对敌方所有单位释放诅咒术，令其有一定几率静默"
        _quality = Quality.SACRED
        _cooldown = 1
        autoCast = true
        cost(value: 20)
    }
    override func cast(completion: @escaping () -> Void) {
        let c = _battle._curRole
        let ts = _battle._selectedTargets
        c.actionCast {
            c.play("down")
            for t in ts {
                if !self.statusMissed(baseline: 50, target: t, completion: {}) {
                    t.darkness4f() {
                        self._battle.silenceUnit(unit: t)
                    }
                }
            }
            setTimeout(delay: 2.5, completion: completion)
        }
    }
    override func findTarget() {
        findTargetPartAll()
    }
}
