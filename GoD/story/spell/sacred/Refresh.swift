//
//  Refresh.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Refresh: Magical {
    
    override init() {
        super.init()
        _name = "回溯"
        _description = "刷新其他技能的冷却时间"
        _quality = Quality.SACRED
        _cooldown = 5
        autoCast = true
    }
    override func cast(completion: @escaping () -> Void) {
        let ss = _battle._curRole._unit._spellsInuse
        for s in ss {
            s._timeleft = 0
        }
        self._timeleft = 5
        _battle.hideOrder()
        _battle.showOrder()
    }
}
