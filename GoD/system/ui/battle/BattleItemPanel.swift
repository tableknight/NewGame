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
        if nil != _lastSelectedIcon && _lastSelectedIcon.contains(touchPoint!) {
            close()
            let item = _lastSelectedIcon._displayItem as! Item
            selectedItem = item
            selectAction()
            return
        }
        let rlt = showInfosAction(node: _propBox, touchPoint: touchPoint!)
        if !rlt {
            _lastSelectedIcon?.selected = false
            _lastSelectedIcon = nil
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
                props[i]._battle = self._battle
                let base = i - (_curPage - 1) * _pageSize
                let y = base / 6
                let x = base % 6
                let icon = BattleItemIcon()
                icon.count = props[i]._count
                icon.iconLabel = props[i]._name
                icon._displayItem = props[i]
                icon.quality = props[i]._quality
                icon.position.y = startY - (cellSize + _standardGap) * y.toFloat()
                icon.position.x = startX + (cellSize + _standardGap) * x.toFloat()
                icon.zPosition = self.zPosition + 3
                _propBox.addChild(icon)
            }
        }
    }
    
    private func getPropsInBattle() -> Array<Item> {
        var ps = Array<Item>()
        for p in _char._items {
            if p._type == Item.SealScroll {
                if Game.instance.curStage._curScene is BossRoad || _battle is BossBattle{
                    
                } else {
                    ps.append(p)
                }
            } else {
                p._battle = _battle
                if p._count > 0 && p.castable && p.selectable() {
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
    var _battle:Battle!
}

