//
//  RoleInfo.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/12.
//  Copyright © 2018年 Chen. All rights reserved.
//
//        let ci = CharInfo()
//        addChild(ci)
import SpriteKit

class AttrLabel:SKSpriteNode {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private var _value:Int = 0
    private var _bg:SKShapeNode!
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.size = CGSize(width: cellSize * 1.25, height: cellSize * 0.5)
        _label.fontSize = 18
        _label.position.x = 5
        _label.position.y = -8
        background = true
        addChild(_label)
    }
    private var _label = Label()
    private var _text = ""
    var editable:Bool {
        set {
            if newValue {
                _bg.strokeColor = QualityColor.GOOD
                _bg.lineWidth = 2
                _label.fontColor = QualityColor.GOOD
            } else {
                _bg.strokeColor = UIColor.white
                _bg.lineWidth = 1
                _label.fontColor = UIColor.white
            }
        }
        get {
            return false
        }
    }
    var background:Bool {
        set {
            if newValue {
                _bg = SKShapeNode(rect: CGRect(origin: CGPoint(x: 0, y: -self.size.height), size: self.size), cornerRadius: 2 )
//                _bg.fillColor = UIColor.black
                _bg.strokeColor = UIColor.white
                addChild(_bg)
            } else {
//                _bg?.removeFromParent()
                
            }
        }
        get {
            return false
        }
    }
    private var _plus = " +"
    var plus:Bool {
        set {
            if newValue {
                _label.text = self._text + " \(self._value)" + " +"
            } else {
                _label.text = self._text + " \(self._value)"
            }
        }
        get {
            return false
        }
    }
    var text:String {
        set {
            _text = newValue
        }
        get {
            return ""
        }
    }
    
    var value:Int {
        set {
            _value = newValue
//            if(_value < 0) {
//                _label.text = self._text
//            } else {
//            }
            
            _label.text = self._text + " \(self._value)"
        }
        get {
            return _value
        }
    }
    
}
