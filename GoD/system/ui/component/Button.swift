//
//  Button.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/12.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Button:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        zPosition = MyScene.UI_LAYER_Z
        _width = cellSize * 1.5
        _bg = createBackground(width: _width, height: cellSize * 0.6)
        addChild(_bg)
        _label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        _label.fontColor = UIColor.white
        _label.alpha = 0.85
        _label.position.y = -cellSize * 0.125
        _label.position.x = cellSize * 0.75
        _label.fontSize = 24
        _label.align = "center"
        addChild(_label)
    }
    private var _node = SKSpriteNode()
    var _bg:SKShapeNode!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var _label = Label()
    var text:String {
        set {
            _label.text = newValue
        }
        get {
            return ""
        }
    }
    private var _selected = false
    var selected:Bool {
        set {
            _selected = newValue
            if newValue {
                _bg.strokeColor = Game.SELECTED_HIGHLIGH_COLOR
                _bg.lineWidth = Game.SELECTED_STROKE_WIDTH
            } else {
                _bg.strokeColor = Game.UNSELECTED_STROKE_COLOR
                _bg.lineWidth = Game.UNSELECTED_STROKE_WIDTH
            }
        }
        get {
            return _selected
        }
    }
    
    var width:CGFloat {
        set {
            _bg.removeFromParent()
            _bg = createBackground(width: newValue, height: cellSize * 0.75)
            addChild(_bg)
            _width = newValue
        }
        get {
            return _width
        }
    }
    
    private var _width:CGFloat = 0

}

class RectButton:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        //        let rect = SKShapeNode(
        zPosition = MyScene.UI_LAYER_Z
        let bg = SKShapeNode(rect: CGRect(x: -cellSize * 0.5, y: -cellSize * 0.5, width: cellSize, height: cellSize), cornerRadius: 2)
        bg.fillColor = QualityColor.RARE
        //        addChild(bg)
        _node.addChild(bg)
    }
    private var _node = SKSpriteNode()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var _label:Label!
    var text:String {
        set {
            let label = Label()
            label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
            label.text = newValue
            label.fontColor = UIColor.white
            label.position.y = -cellSize * 0.1
            label.fontSize = 14
            _node.addChild(label)
            
            self.texture = _node.toTexture()
            self.size = _node.size
            addChild(_node)
            _label = label
        }
        get {
            return ""
        }
    }
    
}
