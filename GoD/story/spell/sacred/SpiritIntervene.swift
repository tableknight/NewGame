//
//  SpiritIntervene.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/21.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class SpiritIntervene: Magical {
    override init() {
        super.init()
        _name = "精神干涉"
        _description = "使目标的精神变为随机的数字"
        _quality = Quality.SACRED
        _tear = 1
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
            t._extensions.spirit = change - t._unit._extensions.spirit
            t.showText(text: "SPIRIT \(change.toInt())", color: Colors.STATUS_CHANGE, completion: completion)
        }
    }
    
    override func findTarget() {
        var all = _battle._playerPart + _battle._enemyPart
        all.remove(at: all.index(of: _battle._curRole)!)
        _battle._selectedTarget = all.one()
    }
    
}


