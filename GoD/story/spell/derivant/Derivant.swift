//
//  Derivant.swift
//  GoD
//
//  Created by kai chen on 2019/2/10.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class Derivant:Magical {
    override init() {
        super.init()
        _name = "衍生法术"
    }
    
    var _target:BUnit!
    var _caster:BUnit!
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
