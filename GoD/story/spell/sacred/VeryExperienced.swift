//
//  VeryExperienced.swift
//  GoD
//
//  Created by kai chen on 2019/11/10.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class VeryEcperienced: Passive {
    
    override init() {
        super.init()
        _id = Spell.VeryEcperienced
        _name = "熟能生巧"
        _description = "提升50%经验获取"
        _quality = Quality.SACRED
        
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
