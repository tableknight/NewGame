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
        //confirm
        if _closeButton.contains(touchPoint!) {
            Game.instance.curStage.removePanel(self)
            confirmAction()
            for u in _propBox.children {
                let icon = u as! PropIcon
                _char.addProp(p: icon._displayItemType as! Prop)
            }
            return
        } else if _discardButton.contains(touchPoint!) {
            for u in _propBox.children {
                let icon = u as! PropIcon
                if icon.selected {
                    let p = icon._displayItemType as! Prop
                    let index = _props.index(of: p)
                    _props.remove(at: index!)
                }
            }
            pageReload()
            return
        }
        for u in _propBox.children {
            if u.contains(touchPoint!) {
                let icon = u as! PropIcon
                if icon.selected {
                    icon.selected = false
//                    let p = icon._displayItemType as! Prop
//                    let index = _props.index(of: p)
//                    _props.remove(at: index!)
//                    pageReload()
//                    _lastSelectedIcon = nil
                } else {
                    icon.selected = true
                }
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
        
    }
    private var _bgHeight:CGFloat = 0
    func createSelfPanelbackground() {
        _bg = createBackground(width: _standardWidth * 0.75, height: _bgHeight)
        _bg.position = CGPoint(x: 0, y: 0)
        _bg.zPosition = self.zPosition + 1
        addChild(_bg)
        
    }
    
    func create(props:Array<Prop>) {
        _props = props
        createCloseButton()
        listProps()
        if _props.count > 8 {
            let extY = ceil(_props.count.toFloat() / 4) - 2
            _bgHeight = _standardHeight * 0.5 + extY * cellSize * 1.25
        } else {
            _bgHeight = _standardHeight * 0.5
        }
        createSelfPanelbackground()
    }
    
    override func createCloseButton() {
        _closeButton.text = "确定"
        _closeButton.position.y = _standardHeight * 0.25 + cellSize * 0.65
        _closeButton.position.x = _standardWidth * 0.25 - cellSize * 0.5
        _closeButton.zPosition = self.zPosition + 2
        addChild(_closeButton)
        _discardButton.xAxis = _closeButton.xAxis - _closeButton.width - _standardGap
        _discardButton.yAxis = _closeButton.yAxis
        _discardButton.zPosition = _closeButton.zPosition
        _discardButton.text = "丢弃"
        addChild(_discardButton)
//        _selectButton.text = "确定"
//        _selectButton.position.x = _closeButton.xAxis
//        _selectButton.position.y = -_closeButton.yAxis + cellSize * 0.5
//        _selectButton.zPosition = _closeButton.zPosition
//        addChild(_selectButton)
    }
    private var _discardButton = Button()
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
//            lc.selected = true
            lc._displayItemType = p
            lc.iconLabel = p._name
            lc.quality = p._quality
            lc.position.x = startX + mod.toFloat() * gap
            lc.position.y = startY - y.toFloat() * gap
            lc.zPosition = self.zPosition + 3
            _propBox.addChild(lc)
            i += 1
        }
    }
    override func pageReload() {
        _propBox.removeAllChildren()
        listProps()
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
