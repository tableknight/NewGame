//
//  SelectableComponent.swift
//  GoD
//
//  Created by kai chen on 2018/12/15.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class SelectableComponent:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    
    var selected:Bool {
        set {
            if newValue {
                _background.lineWidth = Game.SELECTED_STROKE_WIDTH
            } else {
                _background.lineWidth = Game.UNSELECTED_STROKE_WIDTH
            }
            _selected = newValue
        }
        get {
            return _selected
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    internal var _selected = false
    internal var _background:SKShapeNode = SKShapeNode()
}
