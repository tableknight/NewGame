//
//  LootPanel.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/23.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class LootPanel:UIPanel {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        _infosDisplay.removeFromParent()
        if _closeButton.contains(touchPoint!) {
            Game.instance.curStage.removePanel(self)
            confirmAction()
            for u in _propBox.children {
                let icon = u as! PropIcon
                if icon.selected {
                    _char.addProp(p: icon._displayItemType as! Prop)
                }
            }
            return
        }
        for u in _propBox.children {
            if u.contains(touchPoint!) {
                let icon = u as! PropIcon
                icon.selected = !icon.selected
                displayInfos(icon: icon)
            }
        }
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        addChild(_propBox)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func createPanelbackground() {
        _bg = createBackground(width: _standardWidth * 0.75, height: _standardHeight * 0.5)
        _bg.position = CGPoint(x: 0, y: 0)
        _bg.zPosition = self.zPosition + 1
        addChild(_bg)
        
    }
    
    func create(props:Array<Prop>) {
        _props = props
        createCloseButton()
        listProps()
    }
    
    override func createCloseButton() {
        _closeButton.text = "确定"
        _closeButton.position.y = _standardHeight * 0.25 + cellSize * 0.5
        _closeButton.position.x = _standardWidth * 0.25 - cellSize * 0.5
        _closeButton.zPosition = self.zPosition + 2
        addChild(_closeButton)
//        _selectButton.text = "确定"
//        _selectButton.position.x = _closeButton.xAxis
//        _selectButton.position.y = -_closeButton.yAxis + cellSize * 0.5
//        _selectButton.zPosition = _closeButton.zPosition
//        addChild(_selectButton)
    }
    
    private func listProps() {
        let startX = -cellSize * 2.5
        let startY = cellSize * 1.25
        let gap = cellSize * 1.25
        var i = 0
        for p in _props {
            let lc = PropIcon()
            let y = i / 4
            let mod = i % 4
            lc.iconLabel = p._name
            lc.count = p._count
            lc.selected = true
            lc._displayItemType = p
            lc.position.x = startX + mod.toFloat() * gap
            lc.position.y = startY - y.toFloat() * gap
            lc.zPosition = self.zPosition + 3
            _propBox.addChild(lc)
            i += 1
        }
    }
    
    private func removeProp(p:PropComponent) {
//        let index = _propComponents.index(of: p)
//        if nil != index {
//            _propComponents.remove(at: index!)
////            _props.remove(at: index!)
//            p.removeFromParent()
//        }
        
    }
    
    private func addProps() {
//        let c = Game.instance.char!
//        for pc in _propComponents {
//            c.addProp(p: pc.prop)
//        }
//        removeFromParent()
//        _battle.fadeOutBattle()
    }
    
    private var _propBox = SKSpriteNode()
    private var _props = Array<Prop>()
    private var _selectButton = Button()
    private var _infoPanel = SKSpriteNode()
    var confirmAction = {}
//    private var _
}
