//
//  OptionPanel.swift
//  GoD
//
//  Created by kai chen on 2020/3/12.
//  Copyright © 2020 Chen. All rights reserved.
//


import SpriteKit
class OptionPanel: UIPanel {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
//        let touchPoint = touches.first?.location(in: self)
        
    }
    override func create() {
        
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

