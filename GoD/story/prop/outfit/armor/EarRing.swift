//
//  earRing.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/15.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class EarRing: Amulet {
    override init() {
        super.init()
        _name = "耳环"
        _outfitName = "耳环"
    }
    override func createSelfAttrs() {
//        createAttr(attrId: , value: <#T##CGFloat#>, remove: <#T##Bool#>)
        createAttr(attrId: MAGICAL_POWER)
    }
}
