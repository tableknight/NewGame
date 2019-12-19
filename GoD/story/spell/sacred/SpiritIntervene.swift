//
//  SpiritIntervene.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/21.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class SpiritIntervene: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.SpiritIntervene
        _name = "精神干涉"
        _description = "使目标的精神变为随机的数字"
        _quality = Quality.SACRED
//        _tear = 1
        targetAll = true
        canBeTargetPlayer = true
        canBeTargetSelf = false
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        let this = self
        c.actionCast {
            let ro = Creature()
            ro.intellectChange(value: t._unit._level * 3)
            let max = ro._extensions.spirit.toInt()
            let change = this.seed(min: 0, max: max).toFloat()
            t._valueUnit._extensions.spirit = change - t._unit._extensions.spirit
            t.sonic() {
                t.showText(text: "\(change.toInt())", color: Colors.STATUS_CHANGE, completion: completion)
            }
            
        }
    }
    
    override func findTarget() {
        var all = _battle._playerPart + _battle._enemyPart
        all.remove(at: all.firstIndex(of: _battle._curRole)!)
        _battle._selectedTarget = all.one()
    }
    
}


