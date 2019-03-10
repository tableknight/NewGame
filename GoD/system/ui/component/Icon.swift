//
//  Icon.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/9/26.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Icon:SKSpriteNode {
//    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
//        super.init(texture: texture, color: color, size: size)
//    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
//        self.anchorPoint = CGPoint(x: 0, y: 1)
        _background = createBackground(width: cellSize, height: cellSize)
        addChild(_background)
//        _iconLabel.text = "封"
        _iconLabel.align = "center"
        _iconLabel.position.x = cellSize * 0.5
        _iconLabel.position.y = -cellSize * 0.25
        _iconLabel.fontSize = cellSize * 0.5
        addChild(_iconLabel)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touchPoint = touches.first?.location(in: self)
//        selected = !_selected
//        if nil != _prop {
//            displayInfos()
//        }
    }
    
    func displayInfos() {
        removeDisplay()
//        let p = _prop!
//        _displayInfos
    }
    
    func removeDisplay() {
        _displayInfos.removeFromParent()
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
    
    var quality:Int {
        set {
            _color = QualityColor.getColor(newValue)
            _quality = newValue
            _background.strokeColor = _color
            _iconLabel.fontColor = _color
        }
        get {
            return _quality
        }
    }
    
    var iconLabel:String {
        get {
            return _prop!._name
        }
        set {
            var n = ""
            for s in newValue {
                n.append(s)
                break
            }
            _iconLabel.text = n
        }
    }
    
    internal var _iconLabel = Label()
    internal var _selected:Bool = false
    internal var _background = SKShapeNode()
    internal var _text:Label = Label()
    internal var _displayInfos = SKSpriteNode()
    internal var _prop:Prop?
    internal var _quality:Int = 1
    internal var _color:UIColor = UIColor.white
    var _displayItemType:IDisplay!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
//let s = SKSpriteNode()
//let i = Icon(size: CGSize(width: 1, height: 1))
class SpellIcon: Icon {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    internal var _spell:Spell?
    var spell:Spell? {
        set {
            _spell = newValue
            quality = newValue!._quality
        }
        get {
            return _spell ?? nil
        }
    }
}

class PropIcon: Icon {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _label.position.x = 3
        _label.fontSize = 20
        _label.position.y = -cellSize + _label.fontSize
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var count:Int {
        set {
            if newValue > 1 {
                _label.removeFromParent()
                addChild(_label)
                _label.text = "\(newValue)"
            } else {
                _label.removeFromParent()
            }
            _count = newValue
//            quality = newValue!._quality
        }
        get {
            return _count
        }
    }
    private var _count:Int = 0
    private var _label = Label()
}
class BattlePropIcon: PropIcon {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _mask = createBackground(width: cellSize, height: cellSize)
        _mask.alpha = 0.65
        _mask.lineWidth = 0
        
        _label.text = "12"
        _label.fontSize = cellSize * 0.5
        _label.align = "center"
        _label.position.y = -cellSize * 0.5 + _label.fontSize * 0.5
        _label.position.x = cellSize * 0.5
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var timeleft:Int {
        set {
            if newValue > 0 {
//                addChild(_mask)
//                addChild(_label)
//                _label.text = "-\(newValue)"
//                _timeleft = newValue
            } else {
//                _mask.removeFromParent()
//                _label.removeFromParent()
            }
        }
        get {
            return _timeleft
        }
    }
    private var _timeleft:Int = 0
    private var _mask:SKShapeNode!
    private var _label = Label()
}
