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
        zPosition = UIStage.UILAYER
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
        zPosition = UIStage.UILAYER
        _label.fontSize = 14
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
    }
    var _label = Label()
}
