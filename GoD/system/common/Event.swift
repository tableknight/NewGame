//
//  Event.swift
//  GoD
//
//  Created by kai chen on 2019/10/21.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class Event: Core {
    override init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    
    static func onCharLevelup(level2:Int) {
        let stage = Game.instance.curStage!
        stage.refreshCharStatusUI()
    }
    
    
}
