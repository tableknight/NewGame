//
//  ElementDestory.swift
//  GoD
//
//  Created by kai chen on 2019/5/26.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class ElementDestory:Magical, Curse {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.ElementDestory
        _name = "元素毁灭"
        _description = "释放可怕的诅咒，降低所有敌方目标30点元素抗性"
        _quality = Quality.GOOD
        _cooldown = 1
        autoCast = true
        _mpCost = 20 * _costRate
    }
    override func cast(completion: @escaping () -> Void) {
        let ts = _battle._selectedTargets
        _battle._curRole.actionCast {
            for t in ts {
                if !self.statusMissed(baseline: 65, target: t, completion: {}) {
                    self.setDown(t: t)
                }
            }
            setTimeout(delay: 2.1, completion: completion)
        }
    }
    
    private func setDown(t:BUnit) {
        t.stateDown2() {
        if t.hasStatus(type: "_element_destory") {
            let s = t.getStatus(type: "_element_destory")
            s?._timeleft = 3
            t.showStatusText()
        } else {
            let s = Status()
            s._type = "_element_destory"
            s._labelText = "E"
            s._timeleft = 3
            t._valueUnit._elementalResistance.fire -= 30
            t._valueUnit._elementalResistance.water -= 30
            t._valueUnit._elementalResistance.thunder -= 30
            s.timeupAction = {
                t._valueUnit._elementalResistance.fire += 30
                t._valueUnit._elementalResistance.water += 30
                t._valueUnit._elementalResistance.thunder += 30
            }
            t.addStatus(status: s)
        }
    }
    }
    
    override func findTarget() {
        findTargetPartAll()
    }
    
}

