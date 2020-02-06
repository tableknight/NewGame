//
//  Refresh.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Refresh: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.Refresh
        _name = "回溯"
        _description = "刷新其他技能的冷却时间"
        _quality = Quality.SACRED
        _cooldown = 5
        autoCast = true
        cost(value: 35)
    }
    override func cast(completion: @escaping () -> Void) {
        if !(_battle._curRole._unit is Character) {
            completion()
            return
        }
        _battle._curRole.mixed2(index: 13) {
            let ss = self._battle._curRole.spells
            for s in ss {
                s._timeleft = 0
            }
            self._timeleft = 5
            self._battle.hideOrder()
            self._battle.showOrder()
            self._battle.hideCancel()
            self._battle.cancelTouch = false
        }
        
    }
}
