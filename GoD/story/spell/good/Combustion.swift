//
//  Combustion.swift
//  GoD
//
//  Created by kai chen on 2019/12/24.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class Combustion: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        isFire = true
        _name = "助燃"
        _description = "延长目标燃烧效果3回合"
        _quality = Quality.GOOD
        _cooldown = 3
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        c.actionCast {
            if t.hasStatus(type: Status.BURNING) {
                t.stateDown3s() {
                    let s = t.getStatus(type: Status.BURNING) as! BurningStatus
                    s._timeleft += 3
                    t.showText(text: "COMBUST") {
                        completion()
                    }
                }
            } else {
                t.showMiss {
                    completion()
                }
            }
        }
    }
}

