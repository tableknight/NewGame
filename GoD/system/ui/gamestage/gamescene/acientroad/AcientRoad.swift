//
//  AcientRoad.swift
//  GoD
//
//  Created by kai chen on 2019/1/2.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class AcientRoad: MyScene {
    internal var index:Int {
        set {
            _index = newValue
        }
        get {
            return _index
        }
    }
    internal var _index:Int = 0
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
