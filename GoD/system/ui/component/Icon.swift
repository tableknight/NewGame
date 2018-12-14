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
    init(quality:Int) {
        let size = CGSize(width: Game.CELLSIZE, height: Game.CELLSIZE)
        super.init(texture: nil, color: UIColor.red, size: size)
//        isUserInteractionEnabled = true
        _background = createBackground(width: cellSize, height: cellSize)
//        _background.position.x = cellSize * 0.5
//        _background.position.y = -cellSize * 0.5
        addChild(_background)
        self.quality = quality
//        _text.text = text
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
//        self.anchorPoint = CGPoint(x: 0, y: 1)
        _background = createBackground(width: cellSize, height: cellSize)
        addChild(_background)
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
        }
        get {
            return _quality
        }
    }
    
    internal var _selected:Bool = false
    internal var _background:SKShapeNode = SKShapeNode()
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
    override init(quality: Int) {
        super.init(quality: quality)
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private var _spell:Spell?
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
