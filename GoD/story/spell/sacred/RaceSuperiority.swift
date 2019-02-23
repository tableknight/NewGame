//
//  RaceSuperiority.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
//unchecked
class RaceSuperiority: Passive {
    
    override init() {
        super.init()
        _quality = Quality.SACRED
        _name = "种族优势"
        _description = "免疫冻结、静默"
    }
}
