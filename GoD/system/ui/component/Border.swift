//
//  Border.swift
//  GoD
//
//  Created by kai chen on 2018/12/28.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Border:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
