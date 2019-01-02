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
                let pi = u as! PropIcon
                if pi.selected {
                    pi.selected = false
                    let prop = pi._displayItemType as! Prop
                    let index = _selectedItems.index(of: prop)
                    _selectedItems.remove(at: index!)
                } else {
                    if _selectedItems.count < 3 {
                        let prop = pi._displayItemType as! Prop
                        _selectedItems.append(prop)
                        pi.selected = true
                    }
                }
                displayInfos(icon: pi)
            }
        }
        
        
    }
    override func create() {
        _label.text = "使用：最多可以选择三件物品。"
        _pageSize = 30
        createCloseButton()
        createPageButtons()
        _prevButton.text = "上一步"
        _nextButton.text = "下一步"
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
                let icon = PropIcon()
                icon.count = props[i]._count
                icon._displayItemType = props[i]
                icon.position.y = startY - (cellSize + _standardGap) * y.toFloat()
                icon.position.x = startX + (cellSize + _standardGap) * x.toFloat()
                icon.zPosition = self.zPosition + 3
                _propBox.addChild(icon)
            }
        }
    }
    
    private func getPropsCountMoreThan1() -> Array<Prop> {
        var ps = Array<Prop>()
        let ts = TownScroll()
        ts._count = 5
        ps.append(ts)
        
        let potion = Potion()
        potion._count = 5
        ps.append(potion)
        
        let st = SealScroll()
        st._count = 5
        ps.append(st)
        
        let tear = TheWitchsTear()
        tear._count = 5
        ps.append(tear)
        
        let bs = BlastScroll()
        bs._count = 5
        ps.append(bs)
        
        let bag = SmallGoldBag()
        ps.append(bag)
        
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
    private var _selectedItems = Array<Prop>()
    var nextAction = {}
    var prevAction = {}
    var closeAction = {}
}

class SelectItems1:UIPanel {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        
        
        for u in _listBox.children {
            if u.contains(touchPoint!) {
                let c = u as! SelectableItemComponent
                let sis = getSelectedItems()
                if sis.count >= 3 {
                    if c.selected {
                        c.selected = false
                    }
                    return
                }
                if c.selected {
                    c.selected = false
                } else {
                    c.selected = true
                }
//                _lastSelectedComponent.selected = false
//                _lastSelectedComponent = rc
//                _lastSelectedComponent.selected = true
                return
            }
        }
        
        if _prevButton.contains(touchPoint!) {
//            (parent as! CreationFlow).showMinions()
        }
        if _nextButton.contains(touchPoint!) {
            if getSelectedItems().count < 1 {
                return
            }
//            (parent as! CreationFlow).showSpells()
        }
    }
    override func create() {
        createCloseButton()
        createPageButtons()
        _label.text = "选择携带物品(最多可以选择3个)"
        _closeButton.text = "返回"
        _prevButton.text = "上一步"
        _nextButton.text = "下一步"
        
        addChild(_listBox)
        let twt = TheWitchsTear()
        twt._count = 10
//        twt._description = "出售可获得6个金币"
        let p = Potion()
        p._count = 5
        let ss = SealScroll()
        ss._count = 5
        let ts = TownScroll()
        ts._count = 5
        let sgb = SmallGoldBag()
        sgb._count = 1
        let bic = BagIncreaseContract()
        bic._count = 1
        let sic = StorageIncreaseContract()
        sic._count = 1
        let mic = MinionIncreaseContract()
        mic._count = 1
        _items = [twt,p,ss,ts,sgb,bic,sic,mic]
        createCharList()
    }
    
    private func createCharList() {
        let startX = -cellSize * 5
        let startY = cellSize * 2.75
        let width = cellSize * 5.5
        let height = cellSize * 1.4
        if _items.count > 0 {
            for i in 0..._items.count - 1 {
                let y = i % 4
                let x = i / 4
                
                let cc = SelectableItemComponent()
                //                cc.unit = _chars[i]
                cc.item = _items[i]
                if _items[i] is TheWitchsTear {
                    cc.des = "出售可获得6个金币"
                } else if _items[i] is Potion {
                    cc.des = "恢复50%最大生命值"
                }
                cc.position.x = startX + width * x.toFloat()
                cc.position.y = startY - height * y.toFloat()
                cc.zPosition = self.zPosition + 2
                _listBox.addChild(cc)
            }
        }
    }
    
    func getSelectedItems() -> Array<SelectableItemComponent> {
        var sis = Array<SelectableItemComponent>()
        for u in _listBox.children {
            let c = u as! SelectableItemComponent
            if c._selected {
                sis.append(c)
            }
        }
        return sis
    }

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var _listBox = SKSpriteNode()
    var _items = Array<Item>()
//    var _lastSelectedComponent = SelectableItemComponent()
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
    
    private var _item = Item()
    private var _bg = SKShapeNode()
}
