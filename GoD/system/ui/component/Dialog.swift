//
//  Dialog.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/9.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Dialog: SKSpriteNode {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        if _closeButton.contains(touchPoint!) {
            Game.instance.curStage.removeDialog(dlg: self)
        } else if _nextButton.contains(touchPoint!) {
            _nextAction()
        } else if _confirmButton.contains(touchPoint!) {
            _confirmAction()
        } else if _battleButton.contains(touchPoint!) {
            _battleAction()
        }
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.zPosition = MyStage.UI_TOPEST_Z + 10
        _dialog = createBackground(width: cellSize * 13, height: cellSize * 3.5)
        _dialog.fillColor = UIColor.black
        _dialog.alpha = 0.75
        _dialog.position.x = 0
        addChild(_dialog)
        isUserInteractionEnabled = true
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func create(img:SKTexture) {
        let actor = SKSpriteNode(texture: img)
        actor.size = CGSize(width: -cellSize * 1, height: cellSize * 1)
        actor.position.x = -cellSize * 5.5
        actor.position.y = cellSize * 0.5
        actor.zPosition = _dialog.zPosition + 1
        addChild(actor)
        
        let name = Label()
        name.position.x = actor.position.x + cellSize * 0.5
        name.position.y = 22
        name.zPosition = _dialog.zPosition + 1
        name.text = _name
        name.fontSize = 20
        addChild(name)
        
        _closeButton.position.x = cellSize * 4
        _closeButton.position.y = cellSize * 0.95
        _closeButton.text = "关闭"
        addChild(_closeButton)
        
        addBattleButton()
    }
    
    func addConfirmButton() {
        _confirmButton.position.x = _closeButton.xAxis
        _confirmButton.position.y = _closeButton.yAxis - cellSize * 3.2
        _confirmButton.text = "确定"
        _confirmButton._bg.removeFromParent()
        addChild(_confirmButton)
    }
    
    func addNextButton() {
        _nextButton.position.x = _closeButton.xAxis
        _nextButton.position.y = _closeButton.yAxis - cellSize * 3
        _nextButton._bg.removeFromParent()
        _nextButton.text = "继续"
        addChild(_nextButton)
    }
    
    func addBattleButton() {
//        _battleButton.position.x = _closeButton.xAxis - _closeButton.width - cellSize * 0.25
//        _battleButton.position.y = _closeButton.yAxis
//        _battleButton.text = "战斗"
//        addChild(_battleButton)
    }
    
    var text:String {
        set {
            _textlabel.removeFromParent()
            
            _textlabel = MultipleLabel()
            _textlabel._fontSize = 20
            _textlabel._lineCharNumber = 26
            _textlabel._lineHeight = 30
            _textlabel.position.x = -cellSize * 5.5
            _textlabel.position.y = -cellSize
            _textlabel.text = newValue
            addChild(_textlabel)
            
        }
        get {
            return ""
        }
    }
    
    func remove() {
        Game.instance.curStage.removeDialog(dlg: self)
    }
    
    private var _dialog = SKShapeNode()
    var _closeButton = Button()
    var _confirmButton = Button()
    var _nextButton = Button()
    var _battleButton = Button()
    var _textlabel = MultipleLabel()
    var _nextAction = {}
    var _confirmAction = {}
    var _battleAction = {}
    var _name = ""
}
