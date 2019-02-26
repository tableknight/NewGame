//
//  Cruel.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Cruel: Passive {
    
    override init() {
        super.init()
        _name = "凶残"
        _description = "攻击生命低于20%的单位时，必定暴击"
        _quality = Quality.NORMAL
        
    }
}
