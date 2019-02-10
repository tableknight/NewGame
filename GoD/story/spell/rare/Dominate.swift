//
//  RaceSuperiority.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/22.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Dominate: Magical {
    override init() {
        super.init()
        _tear = 1
        _name = "战场主宰"
        _description = "使自己的种族属性始终处于优势，持续5回合"
        autoCast = true
        _quality = Quality.RARE
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let status = Status()
        status._type = Status.DOMINATE
        status._timeleft = 5
        c.addStatus(status: status)
        c.actionCast {
            c.actionBuff {
                completion()
            }
        }
    }
    
}

