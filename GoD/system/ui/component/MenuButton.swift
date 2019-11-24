//
//  MenuButton.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/8.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class MenuButton:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
//        let rect = SKShapeNode(
        zPosition = MyScene.UI_LAYER_Z
        let bg = SKShapeNode(rect: CGRect(x: -cellSize * 0.5, y: -cellSize * 0.375, width: cellSize, height: cellSize * 0.75), cornerRadius:2)
        bg.fillColor = UIColor.black
//        addChild(bg)
        _node.addChild(bg)
    }
    private var _node = SKSpriteNode()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setText(text:String) {
        let label = Label()
        label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        label.text = text
        label.fontColor = UIColor.white
//        label.position.x = cellSize * 0.5
        _node.addChild(label)
        
        self.texture = _node.toTexture()
        self.size = _node.size
        addChild(_node)
    }
}
class RoundButton:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        //        let rect = SKShapeNode(
        zPosition = MyScene.UI_LAYER_Z
        _label.fontSize = 20
        _label.align = "center"
        _label.position.y = _label.fontSize * 0.5
        addChild(_label)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func create(text:String, size:CGFloat) {
        let bg = SKShapeNode(circleOfRadius: size)
        bg.fillColor = UIColor.black
        bg.strokeColor = UIColor.lightGray
        bg.lineWidth = 2
        addChild(bg)
        _label.text = text
        _bg = bg
    }
    var _label = Label()
    internal var _bg:SKShapeNode!
}
class SpellRoundButton:RoundButton {
    private var _selectable = true
    var selectable:Bool {
        set {
            _selectable = newValue
            if newValue {
                _bg.strokeColor = UIColor.lightGray
                self.alpha = 1
            } else {
                _bg.strokeColor = UIColor.gray
                self.alpha = 0.5
            }
        }
        get {
            return _selectable
        }
    }
    var _spell:Spell!
    var spell:Spell {
        set {
            _spell = newValue
//            _label.text = newValue._name
            var n = ""
            for s in newValue._name {
                n.append(s)
                break
            }
            _label.text = n
//            _label.fontSize = 24
//            _label.position.y = 12
//            _label.fontColor = QualityColor.getColor(newValue._quality)
//            _bg.strokeColor = QualityColor.getColor(newValue._quality)
            
        }
        get {
            return _spell
        }
    }
    private var _timeleft = 0
    var timeleft:Int {
        set {
            if newValue > 0 {
                _label.text = "\(newValue)"
            }
            _timeleft = newValue
        }
        get {
            return _timeleft
        }
    }
}
