//
//  SellingPanel.swift
//  GoD
//
//  Created by kai chen on 2019/1/6.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class SellingPanel: UIPanel {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        _infosDisplay.removeFromParent()
        let touchPoint = touches.first?.location(in: self)
        
        if _closeButton.contains(touchPoint!) {
            Game.instance.curStage.removePanel(self)
        }
        
        if _nextButton.contains(touchPoint!) {
            let size = getProps().count / _pageSize
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
        
        if _buyButton.contains(touchPoint!) {
            if nil != _lastSelectedIcon && _goodsBox.contains(_lastSelectedIcon) {
                let goods = _lastSelectedIcon as! SellingItemIcon
                let prop = goods._displayItem as! Item
                if prop._priceType == Item.PRICE_TYPE_TEAR {
                    buyByTears(goods)
                } else {
                    buyByGold(goods)
                }
                return
            }
        }

        if _sellbutton.contains(touchPoint!) {
            for p in _propBox.children {
                let i = p as! ItemIcon
                if i.selected {
                    let item = i._displayItem as! Item
                    if item._type == Item.GoldCoin {
                        return
                    }
                    _char.addMoney(num: item.price4sale)
                    _char.removeItem(item)

                    pageReload()
//                    reshowPlayerMoney()
                }
            }
            return
        }
        
        for node in _propBox.children {
            if node.contains(touchPoint!) {
                let icon = node as! Icon
                if icon.selected {
                    icon.selected = false
                } else {
                    icon.selected = true
                    displayInfos(icon: icon)
                }
            }
        }
        for node in _goodsBox.children {
            if node.contains(touchPoint!) {
                let icon = node as! Icon
                if icon.selected {
                    icon.selected = false
                } else {
                    _lastSelectedIcon?.selected = false
                    icon.selected = true
                    _lastSelectedIcon = icon
                    displayInfos(icon: icon)
                }
            }
        }
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func buyByTears(_ goods:SellingItemIcon) {
        let prop = goods._displayItem as! Item
        let props = Game.instance.char._items
        var t = Item(Item.Tear)
        t._count = 0
        for p in props {
            if p._type == Item.Tear {
                t = p
                break
            }
        }
        if t._count < goods.price {
            showMsg(text: "眼泪数量不足以支付。")
            return
        }
        t._count -= goods.price
        if t._count == 0 {
            Game.instance.char.removeItem(t)
        }
        
        if countless(prop) {
            prop._count -= 1
        }
        
        if prop._count < 1 && goods.removeWhileSellout {
            let i = _goodsList.firstIndex(of: prop)!
            _goodsList.remove(at: i)
        }
        if prop._type == Item.SpellBook {
            let book = Item(Item.SpellBook)
            book.spell = prop.spell
            _char.addItem(book)
        } else {
            if hasBuyAction {
                buyAction()
            } else {
                let copy = Item(prop._type)
                copy._count = 1
                _char.addItem(copy)
            }
        }
        pageReload()
        if !countless(prop) {
            createPropList()
        }

    }
    
    internal func countless(_ item:Item) -> Bool {
        return item._reserveBool
    }
    
    private func buyByGold(_ goods:SellingItemIcon) {
        let prop = goods._displayItem as! Item
        if goods.price > _char._money {
            showMsg(text: "金币不足以支付。")
            return
        }
        if prop._count == 0 {
            showMsg(text: "物品已售尽。")
            return
        }
        
        if !countless(prop) {
            prop._count -= 1
        }


        _char.lostMoney(num: goods.price)

        if prop._count < 1 && goods.removeWhileSellout {
            let i = _goodsList.firstIndex(of: prop)!
            _goodsList.remove(at: i)
        }
        
        if hasBuyAction {
            buyAction()
        } else {
            if prop is Outfit {
                _char.addItem(prop)
                let i = _goodsList.firstIndex(of: prop)!
                _goodsList.remove(at: i)
            } else {
                let copy = Item(prop._type)
                copy._count = 1
                _char.addItem(copy)
            }
        }

        pageReload()
        if !countless(prop) {
            createGoodsList()
        }
//        reshowPlayerMoney()
//        if hasBuyAction {
//            buyAction()
//        }
    }
    
    override func createPanelbackground() {
        let gap:CGFloat = 4
        let width = _standardWidth * 0.5
        _selfItemBoxBackground = createBackground(width: width - gap, height: _standardHeight)
        _selfItemBoxBackground.position = CGPoint(x: (width + gap) * 0.5, y: 0)
        _selfItemBoxBackground.zPosition = self.zPosition + 1
        addChild(_selfItemBoxBackground)
        _sellingBoxBackground = createBackground(width: width - gap, height: _standardHeight)
        _sellingBoxBackground.position = CGPoint(x: -(width + gap) * 0.5, y: 0)
        _sellingBoxBackground.zPosition = self.zPosition + 1
        addChild(_sellingBoxBackground)
    }
    func createPropList() {
        _propBox.removeAllChildren()
        let props = getProps()
        //        let startX:CGFloat = 0
        let startX = cellSize * 0.25
        let startY = _standardHeight * 0.5 - _standardGap
        if props.count > 0 {
            let end = getPageEnd(props.count)
            let start = getPageStart(end)
            
            for i in start...end - 1 {
                let base = i - (_curPage - 1) * _pageSize
                let y = base / 3
                let x = base % 3
                let icon = ItemIcon()
                icon.iconLabel = props[i]._name
                icon.count = props[i]._count
                icon._displayItem = props[i]
                icon.quality = props[i]._quality
                icon.position.y = startY - (cellSize + _standardGap) * y.toFloat()
                icon.position.x = startX + (cellSize + _standardGap) * x.toFloat()
                icon.zPosition = self.zPosition + 3
                _propBox.addChild(icon)
            }
        }
    }
    func createGoodsList() {
        _goodsBox.removeAllChildren()
        let startX = cellSize * 0.25 - _standardWidth * 0.5
        let startY = _standardHeight * 0.5 - _standardGap
        for i in 0..._goodsList.count - 1 {
            if _goodsList[i]._count == 0 {
                continue
            }
            let sii = SellingItemIcon()
            let y = i / 2
            let x = i % 2
            sii.iconLabel = _goodsList[i]._name
            sii._displayItem = _goodsList[i]
            sii.xAxis = startX + (cellSize * 1.5 + _standardGap) * x.toFloat()
            sii.yAxis = startY - (cellSize + _standardGap) * y.toFloat()
            sii._priceType = _goodsList[i]._priceType
            sii.price = _goodsList[i].priceInStore
            sii.zPosition = self.zPosition + 3
            sii.quality = _goodsList[i]._quality
            if _goodsList[i]._count > 1 {
                sii.count = _goodsList[i]._count
            }
//            if _goodsList[i] is Outfit {
//                sii.removeWhileSellout = true
//            }
            _goodsBox.addChild(sii)
        }
    }
    private func getProps() -> Array<Item> {
        let gc = Item(Item.GoldCoin)
        gc._count = _char._money
        gc._description = "一共有\(gc._count)枚金币"
        return [gc] + _char._items + _char._armors
    }
    override func create() {
        _pageSize = 15
        _label.text = "暂不支持7日退货服务"
        createCloseButton()
        createPageButtons()
        _buyButton.text = "购买"
        _sellbutton.text = "出售"
        _buyButton.yAxis = _prevButton.yAxis
        _sellbutton.yAxis = _prevButton.yAxis
        _sellbutton.xAxis = -_prevButton.xAxis - _nextButton.width
        _buyButton.xAxis = -_nextButton.xAxis - _nextButton.width
        _buyButton.zPosition = _nextButton.zPosition
        _sellbutton.zPosition = _nextButton.zPosition
        addChild(_buyButton)
        addChild(_sellbutton)
        addChild(_propBox)
        addChild(_goodsBox)
        createPropList()
        createGoodsList()
//        _goldlabel.align = "center"
//        _goldlabel.position.y = _nextButton.yAxis - 10
//        _goldlabel.fontSize = 20
//        _goldlabel.zPosition = _nextButton.zPosition
//        addChild(_goldlabel)
//        reshowPlayerMoney()
    }
//    private func reshowPlayerMoney() {
//        _goldlabel.text = "\(_char._money)G"
//    }
    override func pageReload() {
        _propBox.removeAllChildren()
        createPropList()
    }
    private var _sellingBoxBackground:SKShapeNode!
    private var _selfItemBoxBackground:SKShapeNode!
    private var _propBox = SKSpriteNode()
    private var _goodsBox = SKSpriteNode()
    private var _sellbutton = Button()
    private var _buyButton = Button()
//    private var _goldlabel = Label()
    var _goodsList = Array<Item>()
    //0 gold 1 tear
    var _priceType = 0
    var hasBuyAction = false
    var buyAction = {}
}

class SellingItemIcon: ItemIcon {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        addChild(_priceLabel)
        _priceLabel.fontSize = 20
        _priceLabel.position.x = cellSize * 1.125
        _priceLabel.position.y = 20 - cellSize
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var price:Int {
        set {
            _price = newValue
            let mark = _priceType == Item.PRICE_TYPE_GOLD ? "G" : "T"
            _priceLabel.text = "\(_price)\(mark)"
        }
        get {
            return _price
        }
    }
    private var _price = 0
    var _priceType = 0
    var removeWhileSellout = false
    private var _priceLabel = Label()
}
