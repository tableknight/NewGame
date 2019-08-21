//
//  Powerful.swift
//  GoD
//
//  Created by kai chen on 2019/7/30.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class Powerful: Passive {
    static let VALUE:CGFloat = 25
    override init() {
        super.init()
        _name = "内生力量"
        _description = "提升25点力量"
        _quality = Quality.NORMAL
        
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
