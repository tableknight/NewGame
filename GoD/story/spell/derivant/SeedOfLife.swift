//
//  SeedOfLife.swift
//  GoD
//
//  Created by kai chen on 2019/2/14.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class SeedOfLife:Derivant {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "生命之种"
        _description = "在目标体内种下一颗种子，使目标行动前恢复最大生命的10%，持续3回合开花，开花后的一回合恢复最大生命的25%"
        _quality = Quality.SACRED
        _delay = 1.25
    }
    private var _turn = 0
    override func cast(completion: @escaping () -> Void) {
        let t = _target!
        let v = (_turn < 3 ? 0.1 : 0.25) * t.getHealth()
        t.actionHealed {
            t.showValue(value: v) {
                completion()
            }
        }
    }
}
