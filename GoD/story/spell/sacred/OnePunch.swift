//
//  OnePunch.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class OnePunch: Passive {
    
    override init() {
        super.init()
        _name = "玻璃大炮"
        _description = "将防御算作攻击力"
        _quality = Quality.SACRED
        
    }
}
