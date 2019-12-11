//
//  hbar.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/8.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class HBar:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
//        self.zPosition = UIStage.UILAYER
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private var _bar:SKShapeNode!
    var _color:UIColor!
    func setBar(value:CGFloat = 1) {
        _bar?.removeFromParent()
        var v = value
        if value > 1 {
            v = 1
        }
        let width = _width * v
        _bar = createBackground(width: width, height: _height, cornerRadius: 3)
        _bar.fillColor = _color
        addChild(_bar)
    }
    var _width:CGFloat = 0
    var _height:CGFloat = 6
    func create(width:CGFloat, height:CGFloat, value:CGFloat, color:UIColor) {
        _width = width
        _height = height
        _color = color
        let bg = createBackground(width: width, height: height, cornerRadius: 3)
//        let bg = SKShapeNode(rect: CGRect(x: 0, y: -_height * 0.5, width: width, height: height))
        bg.fillColor = UIColor.black
        bg.lineWidth = 1
        bg.strokeColor = UIColor.white
        addChild(bg)
        setBar(value: value)
    }
}
