//
//  BattleItemPanel.swift
//  GoD
//
//  Created by kai chen on 2018/12/19.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class BattleItemPanel: UIPanel {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        _infosDisplay.removeFromParent()
        let touchPoint = touches.first?.location(in: self)
        //        if _closeButton.contains(touchPoint!) {
        //            Data.instance.stage.removeItemPanel(panel: self)
        //            return
        //        }
        if _nextButton.contains(touchPoint!) {
            let size = getPropsInBattle().count / _pageSize
            if size > _curPage - 1 {
                _curPage += 1
                pageReload()
            }
            return
        }
        if _prevButton.contains(touchPoint!) {
            if _curPage > 1 {
                _curPage -= 1
                pageReload()
            }
            return
        }
        if _lastSelectedIcon.contains(touchPoint!) {
            close()
            let item = _lastSelectedIcon._displayItemType as! Item
            selectedItem = item
            selectAction()
            return
        }
        let rlt = showInfosAction(node: _propBox, touchPoint: touchPoint!)
        if !rlt {
            _lastSelectedIcon.selected = false
            _lastSelectedIcon = Icon(quality: 1)
        }
        
    }
    override func create() {
        _label.text = "使用：再次点击已选中的物品。"
        _pageSize = 30
        createCloseButton()
        if getPropsInBattle().count > _pageSize {
            createPageButtons()
        }
        addChild(_propBox)
        createPropList()
    }
    func createPropList() {
        let props = getPropsInBattle()
//        let startX:CGFloat = 0
        let startX = -_standardWidth * 0.5 + cellSize * 0.375
        let startY = _standardHeight * 0.5 - _standardGap * 2
        if props.count > 0 {
            let end = getPageEnd(props.count)
            let start = getPageStart(end)
            
            for i in start...end - 1 {
                let base = i - (_curPage - 1) * _pageSize
                let y = base / 6
                let x = base % 6
                let icon = BattlePropIcon()
                icon.count = props[i]._count
                icon._displayItemType = props[i]
                icon.timeleft = (props[i] as! Item)._timeleft
                icon.position.y = startY - (cellSize + _standardGap) * y.toFloat()
                icon.position.x = startX + (cellSize + _standardGap) * x.toFloat()
                icon.zPosition = self.zPosition + 3
                _propBox.addChild(icon)
            }
        }
    }
    
    private func getPropsInBattle() -> Array<Prop> {
        var ps = Array<Prop>()
        for p in _char._props {
            if p is Item {
                let item = p as! Item
                if item._count > 0 && item.useInBattle {
                    ps.append(p)
                }
            }
        }
        
        return ps
    }
    
    override func close() {
        removeFromParent()
        closeAction()
    }
    override func pageReload() {
        _propBox.removeAllChildren()
        createPropList()
    }
    private var _propBox = SKSpriteNode()
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.zPosition = MyStage.UI_PANEL_Z
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var selectedItem:Item?
    var selectAction = {}
    var closeAction = {}
}

