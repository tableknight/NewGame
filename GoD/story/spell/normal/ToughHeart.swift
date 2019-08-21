//
//  ToughHeart.swift
//  GoD
//
//  Created by kai chen on 2019/7/30.
//  Copyright © 2019 Chen. All rights reserved.
//
import SpriteKit
class ToughHeart: Passive {
    static let VALUE:CGFloat = 25
    override init() {
        super.init()
        _name = "执念"
        _description = "提升25点幸运"
        _quality = Quality.NORMAL
        
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
