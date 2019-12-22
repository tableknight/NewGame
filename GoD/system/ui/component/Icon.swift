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
        _background.fillColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: Game.BG_ALPHA)
        _background.strokeColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.8)
//        _background.alpha = 0.55
        addChild(_background)
//        _iconLabel.text = "封"
        _iconLabel.align = "center"
        _iconLabel.position.x = cellSize * 0.5
        _iconLabel.position.y = -cellSize * 0.25
        _iconLabel.fontSize = cellSize * 0.5
        addChild(_iconLabel)
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
            return _displayItem._name
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
    
    var displayItem:Showable! {
        set {
            _displayItem = newValue
            var n = ""
            for s in newValue._name {
                n.append(s)
                break
            }
            _iconLabel.text = n
        }
        get {
            return _displayItem
        }
    }
    
    internal var _iconLabel = Label()
    internal var _selected:Bool = false
    internal var _background = SKShapeNode()
    internal var _text:Label = Label()
    internal var _quality:Int = 1
    internal var _color:UIColor = UIColor.white
    var _displayItem:Showable!
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

class ItemIcon: Icon {
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
            var showCount = false
            if _displayItem is Item {
                let item = _displayItem as! Item
                showCount = item.showCount
            }
            if newValue > 1 || showCount {
                _label.removeFromParent()
                addChild(_label)
                _label.text = "\(newValue)"
            } else {
                _label.removeFromParent()
            }
            _count = newValue
        }
        get {
            return _count
        }
    }
    private var _count:Int = 0
    private var _label = Label()
}
class BattleItemIcon: ItemIcon {
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
            } else {
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
