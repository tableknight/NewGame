//
//  PharmicPanel.swift
//  GoD
//
//  Created by kai chen on 2020/2/3.
//  Copyright © 2020 Chen. All rights reserved.
//

import SpriteKit
class PharmicPanel: UIPanel {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        let touchPoint = touches.first?.location(in: self)
        for n in _listBox.children {
            let rn = n as! RecipeNode
            rn.removeDisplayInfo()
        }
        if _nextButton.contains(touchPoint!) {
           let size = _recipeNodes.count / _pageSize
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
        if _confirmButton.contains(touchPoint!) {
            Game.instance.curStage.removePanel(self)
            makePotion()
        }
    }
    internal var _confirmButton = Button()
    override func create() {
        _label.text = "卸下/装备：再次点击已选中的物品。"
        _pageSize = 4
        createCloseButton()
        createPageButtons()
        
        _confirmButton.text = "确 定"
        _confirmButton.position.x = -_closeButton.position.x - _closeButton.width
        _confirmButton.position.y = -_closeButton.position.y + cellSize * 0.6
        _confirmButton.zPosition = self.zPosition + 2
        addChild(_confirmButton)
        addChild(_listBox)
        
        loadData()
        
        createRecipes()
    }
    
    func loadData() {
        var recipeNodes = Array<RecipeNode>()
        let recipes = [
            [Item.Caesalpinia, 2, Item.DragonRoot, 3, Item.LittlePotion, 2],
            [Item.Caesalpinia, 3, Item.Curium, 2, Item.DragonRoot, 4, Item.Potion, 2],
            [Item.Caesalpinia, 4, Item.Curium, 4, Item.Angelsfuther, 1, Item.GiantPotion, 1],
            [Item.SkyAroma, 2, Item.Curium, 4, Item.LittleMPPotion, 1],
            [Item.SkyAroma, 4, Item.Curium, 3, Item.PanGrass, 3, Item.MPPotion, 1],
            [Item.Curium, 6, Item.PanGrass, 6, Item.DemonsBlood, 1, Item.SoulMPPotion, 1]
        ]
        for each in recipes {
            let rn = RecipeNode()
            var rs = Array<Recipe>()
            for i in stride(from: 0, to: each.count - 2, by: 2) {
                let r = Recipe()
                r._item = each[i] as! String
                r._count = each[i + 1] as! Int
                rs.append(r)
            }
            let rt = Recipe()
            rt._item = each[each.count - 2] as! String
            rt._count = each[each.count - 1] as! Int
            rn.result = rt
            rn.recipes = rs
            recipeNodes.append(rn)
        }
        _recipeNodes = recipeNodes
    }
    
    func createRecipes() {
        let startY = _standardHeight * 0.5 - _standardGap
        let end = getPageEnd(_recipeNodes.count)
        let start = getPageStart(end)
        
        for i in start...end - 1 {
            let base = i - (_curPage - 1) * _pageSize
            let rn = _recipeNodes[i]
            rn.yAxis = startY - base.toFloat() * cellSize * 1.625
            _listBox.addChild(rn)
            rn._parent = self
        }
        
//        _listBox.addChild(recipeNodes[0])
        
    }
    func unselect(node:RecipeNode) {
        for n in _listBox.children {
            let rn = n as! RecipeNode
            if n != node {
                rn.selected = false
            }
            rn.removeDisplayInfo()
        }
    }
    func makePotion() {
        let c = Game.instance.char!
        for n in _recipeNodes {
            if n.selected {
                for each in n.recipes {
                    let i = c.searchItem(type: each._item)
                    if i != nil {
                        if i!._count >= each._count * n._resultCount {
                            
                        } else {
                            materialNotEnough()
                            return
                        }
                    } else {
                        materialNotEnough()
                        return
                    }
                }
            }
        }
        for n in _recipeNodes {
            if n.selected {
                for each in n.recipes {
                    let i = c.searchItem(type: each._item)
                    i?._count -= each._count * n._resultCount
                }
                let resultItem = Item(n.result._item)
                let count = n.result._count * n._resultCount
                for _ in 0...count - 1 {
                    c.addItem(resultItem)
                }
                showMsg(text: "你获得了[\(resultItem._name)]x\(count)")
            }
        }
    }
    private func materialNotEnough() {
        let mh = Game.instance.curStage._curScene as! MagicHouse
        mh.notEnough()
    }
//    override func createPanelbackground() {
//        
//    }
    override func pageReload() {
        _listBox.removeAllChildren()
        loadData()
        createRecipes()
    }
    private var _recipeNodes = Array<RecipeNode>()
    private var _listBox:SKSpriteNode = SKSpriteNode()
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.zPosition = MyStage.UI_PANEL_Z
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class RecipeNode: SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.zPosition = MyStage.UI_PANEL_Z + 2
        isUserInteractionEnabled = true
        createbg()
        addChild(_listBox)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        removeDisplayInfo()
        for i in _icons {
            if i.contains(touchPoint!) {
                displayInfos(icon: i)
                if !selected {
                    _parent.unselect(node: self)
                    selected = true
                }
                return
            }
        }
        if selected {
            _listBox.removeAllChildren()
            _icons.removeAll()
            _resultCount += 1
            createNode()
        } else {
            _parent.unselect(node: self)
            selected = true
        }
    }
    var _parent:PharmicPanel!
    func createbg() {
        _bg = createBackground(width: cellSize * 11, height: cellSize * 2)
        _bg.fillColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.15)
//        _bg.strokeColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.75)
        selected = false
        _bg.alpha = 1
        _bg.position.x = 0
        self.zPosition = MyStage.UI_PANEL_Z + 1
        addChild(_bg)
    }
    
    private func createNode() {
        let startX = -cellSize * 5
        let gap = cellSize * 2.875
        var x:CGFloat = 0
        for r in _recipe {
            let item = Item(r._item)
            let icon = ItemIcon()
            icon.iconLabel = item._name
            icon.count = r._count * _resultCount
            icon.displayItem = item
            icon.quality = item._quality
            icon.yAxis = -cellSize * 0.25
            icon.xAxis = startX + x * gap
            x += 1
            _listBox.addChild(icon)
            _icons.append(icon)
            
            let plusLabel = Label()
            plusLabel.text = "+"
            if x.toInt() == _recipe.count {
                plusLabel.text = "="
            }
            plusLabel.fontSize = 48
            plusLabel.position.y = -cellSize * 0.75
            plusLabel.position.x = icon.position.x + cellSize * 1.875
            _listBox.addChild(plusLabel)
            
        }
        let resultItem = Item(_result._item)
        let resultIcon = ItemIcon()
        resultIcon.yAxis = -cellSize * 0.25
        resultIcon.xAxis = startX + x * gap
        resultIcon.quality = resultItem._quality
        resultIcon.count = _result._count * _resultCount
        resultIcon.iconLabel = resultItem._name
        resultIcon.displayItem = resultItem
        
        _listBox.addChild(resultIcon)
        _icons.append(resultIcon)
        
    }
    func removeDisplayInfo() {
        _infosDisplay.removeFromParent()
    }
    func displayInfos(icon:Icon) {
        let item = icon._displayItem as! Item
        let node = ItemInfo()
        node.create(item: item)
        node.position.x = icon.position.x
        if icon.position.y < 0 {
            node.position.y = icon.position.y + node._displayHeight + 5
        } else {
            node.position.y = icon.position.y - cellSize - 5
        }
        if icon.position.x > 0 {
            node.position.x = icon.position.x - node._displayWidth + cellSize
        }
        addChild(node)
        _infosDisplay = node
    }
        
    var recipes:Array<Recipe> {
        set {
            _recipe = newValue
            createNode()
        }
        get {
            return _recipe
        }
    }
    var result:Recipe {
        set {
            _result = newValue
        }
        get {
            return _result
        }
    }
    var _resultCount = 1
    private var _selected = false
    var selected:Bool {
        set {
            _selected = newValue
            if newValue {
                _bg.strokeColor = Game.SELECTED_HIGHLIGH_COLOR
                _bg.lineWidth = Game.SELECTED_STROKE_WIDTH
            } else {
                _bg.strokeColor = Game.UNSELECTED_STROKE_COLOR
                _bg.lineWidth = Game.UNSELECTED_STROKE_WIDTH
            }
        }
        get {
            return _selected
        }
    }
    private var _listBox:SKSpriteNode = SKSpriteNode()
    private var _recipe = Array<Recipe>()
    private var _result:Recipe!
    private var _bg:SKShapeNode!
    private var _icons = Array<ItemIcon>()
    internal var _infosDisplay = SKSpriteNode()
}
class Recipe {
    var _item = Item.GoldCoin
    var _count = 1
}
