//
//  Vanguard.swift
//  GoD
//
//  Created by kai chen on 2019/2/14.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class Vanguard:Passive {
    override init() {
        super.init()
        _name = "急先锋"
        _description = "每回合总是第一个出手"
        _quality = Quality.SACRED
    }
    
}

