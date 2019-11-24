//
//  HandSkill.swift
//  GoD
//
//  Created by kai chen on 2019/2/24.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class HandSkill:Physical {
    override init() {
        super.init()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override func getAttack(from: BUnit) -> CGFloat {
        return from.getAgility()
    }
}
protocol BowSkill {
    
}
protocol Curse {
    
    
}
protocol BossOnly {
    
}
protocol SummonSkill {
    
    
}
protocol CloseSkill {
    
}

