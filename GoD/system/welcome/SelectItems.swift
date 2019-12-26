//
//  SelectItems.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/6.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class SelectItems: UIPanel {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        _infosDisplay.removeFromParent()
        let touchPoint = touches.first?.location(in: self)
        //        if _closeButton.contains(touchPoint!) {
        //            Data.instance.stage.removeItemPanel(panel: self)
        //            return
        //        }
        if _nextButton.contains(touchPoint!) {
            nextAction()
            return
        }
        if _prevButton.contains(touchPoint!) {
            prevAction()
            return
        }
        
        if _closeButton.contains(touchPoint!) {
            closeAction()
            return
        }
        
        for u in _propBox.children {
            if u.contains(touchPoint!) {
                let pi = u as! ItemIcon
                if pi.selected {
                    pi.selected = false
                    let prop = pi._displayItem as! Item
                    let index = _selectedItems.firstIndex(of: prop)
                    _selectedItems.remove(at: index!)
                } else {
                    if _selectedItems.count < 2 {
                        let prop = pi._displayItem as! Item
                        _selectedItems.append(prop)
                        pi.selected = true
                    }
                }
                displayInfos(icon: pi)
            }
        }
        
        
    }
    override func create() {
        _label.text = "抉择：最多可以选择两件物品。"
        _pageSize = 30
        createCloseButton()
        createPageButtons()
        _prevButton.text = "上一步"
        _nextButton.text = "下一步"
        _closeButton.text = "返回"
        addChild(_propBox)
        createPropList()
    }
    func createPropList() {
        let props = getPropsCountMoreThan1()
        let startX = -_standardWidth * 0.5 + cellSize * 0.375
//        let startX:CGFloat = 0
        let startY = _standardHeight * 0.5 - _standardGap * 2
        if props.count > 0 {
            let end = getPageEnd(props.count)
            let start = getPageStart(end)
            
            for i in start...end - 1 {
                let base = i - (_curPage - 1) * _pageSize
                let y = base / 6
                let x = base % 6
                let icon = ItemIcon()
                icon.count = props[i]._count
                icon.iconLabel = props[i]._name
                icon._displayItem = props[i]
                icon.position.y = startY - (cellSize + _standardGap) * y.toFloat()
                icon.position.x = startX + (cellSize + _standardGap) * x.toFloat()
                icon.zPosition = self.zPosition + 3
                _propBox.addChild(icon)
            }
        }
    }
    
    private func getPropsCountMoreThan1() -> Array<Item> {
        let ps = Array<Item>()
//        let ts = TownScroll()
//        ts._count = 5
//        ps.append(ts)
//
//        let potion = Potion()
//        potion._count = Mode.debug ? 100 : 5
//        ps.append(potion)
//
//        let st = SealScroll()
//        st._count = Mode.debug ? 100 : 2
//        ps.append(st)
//
//        let tear = TheWitchsTear()
//        tear._count = Mode.debug ? 100 : 5
//        ps.append(tear)
//
//        let ts2 = TransportScroll()
//        ts2._count = Mode.debug ? 100 : 3
//        ps.append(ts2)
        
        return ps
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
    var _selectedItems = Array<Item>()
    var nextAction = {}
    var prevAction = {}
    var closeAction = {}
}

class SelectableItemComponent:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        //        _char = Data.instance._char!
        //        _bg.removeFromParent()
        let rect = CGRect(x: 0, y: -cellSize * 1.125, width: cellSize * 4.5, height: cellSize)
        _bg = SKShapeNode(rect: rect, cornerRadius: 2)
        addChild(_bg)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var item: Item {
        set {
            let name = Label()
            name.position.x = cellSize * 0.25
            name.position.y = -26
            name.text = "[\(newValue._name)]x\(newValue._count)"
            name.align = "left"
            name.fontSize = 14
            addChild(name)
            let des = Label()
            des.position.x = cellSize * 0.25
            des.position.y = name.position.y - 20
            des.text = newValue._description
            des.align = "left"
            des.fontSize = 14
            addChild(des)
            _des = des
            _item = newValue
        }
        get {
            return _item
        }
    }
    
    var des: String {
        set {
            _des.text = newValue
        }
        get {
            return ""
        }
    }
    
    private var _des = Label()
    
    var selected:Bool {
        set {
            _selected = newValue
            if newValue {
                _bg.lineWidth = Game.SELECTED_STROKE_WIDTH
                _bg.strokeColor = Game.SELECTED_HIGHLIGH_COLOR
            } else {
                _bg.lineWidth = Game.UNSELECTED_STROKE_WIDTH
                _bg.strokeColor = Game.UNSELECTED_STROKE_COLOR
            }
        }
        get {
            return _selected
        }
    }
    internal var _selected = false
    
    private var _item:Item!
    private var _bg = SKShapeNode()
}
