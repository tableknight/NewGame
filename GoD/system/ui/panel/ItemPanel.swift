////
////  ArmorPanel.swift
////  TheWitchNight
////
////  Created by kai chen on 2018/4/15.
////  Copyright © 2018年 Chen. All rights reserved.
////
//
import SpriteKit
class ItemPanel: UIPanel {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        _infosDisplay.removeFromParent()
        let touchPoint = touches.first?.location(in: self)
//        if _closeButton.contains(touchPoint!) {
//            Data.instance.stage.removeItemPanel(panel: self)
//            return
//        }
        if _nextButton.contains(touchPoint!) {
            let size = getPropsCountMoreThan1().count / _pageSize
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
        if _discardButton.contains(touchPoint!) {
            if _lastSelectedIcon != nil {
                _char.discardProp(p: _lastSelectedIcon._displayItemType as! Item)
                pageReload()
                return
            }
        }
        for node in _propBox.children {
            if node.contains(touchPoint!) {
                let icon = node as! Icon
                if icon.selected {
                    icon.selected = false
                    if icon._displayItemType is SpellBook {
                        let spellBook = icon._displayItemType as! SpellBook
                        if !_char.hasSpell(spell: spellBook.spell) {
                            _char._spells.append(spellBook.spell)
                            _char.removeProp(p: spellBook)
                            pageReload()
                        } else {
                            showMsg(text: "\(spellBook.spell._name) 不能重复学习！")
                        }
                        return
                    }
                    let item = icon._displayItemType as! Item
                    if !item.usable {
                        return
                    }
                    if item is Potion {
                        let rl = RoleList()
                        let ml = [_char] + _char._minions
                        rl._parentNode = self
                        self.isHidden = true
                        rl.create(list: ml)
                        rl.selectAction = {
                            if item._count > 0 {
                                let unit = rl._lastSelected!._unit
                                item.use(target: unit!)
                                rl._lastSelected!.reload()
                            }
                        }
                        rl.closeAction = {
                            self.pageReload()
                            self.isHidden = false
                            Game.instance.curStage._curPanel = self
                        }
                        Game.instance.curStage.showPanel(rl)
                        return
                    }
                    
                    if item is TownScroll {
                        Game.instance.curStage.removePanel(self)
                    }
                    item.use()
                    pageReload()
                } else {
                    _lastSelectedIcon?.selected = false
                    icon.selected = true
                    _lastSelectedIcon = icon
                    displayInfos(icon: icon)
                }
            }
        }
//        if _lastSelectedIcon.contains(touchPoint!) {
//            if _lastSelectedIcon._displayItemType is SpellBook {
//                let spellBook = _lastSelectedIcon._displayItemType as! SpellBook
//                if !_char.hasSpell(spell: spellBook.spell) {
//                    _char._spells.append(spellBook.spell)
//                    _char.removeProp(p: spellBook)
////                    showMsg(text: "你学会了技能[\(spellBook._name)]！")
//                    debug("你学会了技能[\(spellBook._name)]！")
//                    _lastSelectedIcon = Icon()
//                    pageReload()
//                    return
//                }
//            }
//            let item = _lastSelectedIcon._displayItemType as! Item
//            if !item.usable {
//                return
//            }
//            if item is Potion {
//                let rl = RoleList()
//                let ml = [_char] + _char._minions
//                rl._parentNode = self
//                self.isHidden = true
//                rl.create(list: ml)
//                rl.selectAction = {
//                    if item._count > 0 {
//                        let unit = rl._lastSelected!._unit
//                        item.use(target: unit!)
//                        rl._lastSelected!.reload()
//                        item.reduce()
//                    }
//                }
//                let this = self
//                rl.closeAction = {
//                    this.pageReload()
//                    this.isHidden = false
//                }
//                Game.instance.curStage.showPanel(rl)
//                return
//            }
////            if item is SpellBook {
////                let book = item as! SpellBook
////
////            }
//            //else
//            if item is TownScroll {
//                Game.instance.curStage.removePanel(self)
//            }
//            item.use(target: _char)
//            _lastSelectedIcon = Icon()
//            pageReload()
//            return
//        }
//        let rlt = showInfosAction(node: _propBox, touchPoint: touchPoint!)
//        if !rlt {
//            _lastSelectedIcon.selected = false
//            _lastSelectedIcon = Icon(quality: 1)
//        }

    }
    private var _discardButton = Button()
    override func create() {
        _label.text = "使用：再次点击已选中的物品。"
        _pageSize = 30
        createCloseButton()
        createPageButtons()
        _discardButton.xAxis = _closeButton.xAxis - _closeButton.width - _standardGap
        _discardButton.yAxis = _closeButton.yAxis
        _discardButton.zPosition = _closeButton.zPosition
        _discardButton.text = "丢弃"
        addChild(_discardButton)
        addChild(_propBox)
        createPropList()
        let moneyLabel = Label()
        moneyLabel.text = "金钱：\(_char._money)G"
        moneyLabel.position.x = _label.position.x
        moneyLabel.position.y = -_label.position.y + _label.fontSize
        moneyLabel.zPosition = _label.zPosition
        moneyLabel.fontSize = _label.fontSize
        addChild(moneyLabel)
    }
    func createPropList() {
        let props = getPropsCountMoreThan1()
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
                let icon = PropIcon()
                icon.iconLabel = props[i]._name
                icon.count = props[i]._count
                icon._displayItemType = props[i]
                icon.position.y = startY - (cellSize + _standardGap) * y.toFloat()
                icon.position.x = startX + (cellSize + _standardGap) * x.toFloat()
                icon.zPosition = self.zPosition + 3
                icon.quality = props[i]._quality
                _propBox.addChild(icon)
            }
        }
    }
    
    private func getPropsCountMoreThan1() -> Array<Prop> {
        var ps = Array<Prop>()
        for p in _char._props {
            if p._count > 0 && !(p is Outfit) {
                ps.append(p)
            }
        }
        
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
}

class PropComponent:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        zPosition = UIStage.PANEL_LAYER
        self.size = CGSize(width: cellSize, height: cellSize)
        let bg = SKShapeNode(rect: CGRect(origin: CGPoint(x: -cellSize * 0.5, y: -cellSize * 0.5), size: self.size), cornerRadius: 2 )
        bg.fillColor = UIColor.black
//        bg.lineWidth = 2
        _bg = bg
        addChild(bg)
        _iconLabel.align = "center"
        _iconLabel.position.x = cellSize * 0.5
        _iconLabel.position.y = -cellSize * 0.25
        _iconLabel.fontSize = cellSize * 0.5
        addChild(_iconLabel)
    }

    var armor:Prop {
        set {
            _outfit = newValue
            _armorImg = SKSpriteNode(texture: newValue._img)
            _bg.strokeColor = QualityColor.getColor(newValue._quality)
            if newValue.initialized {
                _bg.lineWidth = 2
            } else {
                _bg.lineWidth = 1
            }
            addChild(_armorImg)
            _prop = newValue
        }
        get {
            return _outfit
        }
    }
    private var _prop = Prop()
    private var _countLabel = Label()
    var prop:Prop {
        set {
            _prop = newValue
            _armorImg = SKSpriteNode(texture: newValue._img)
            _bg.strokeColor = QualityColor.getColor(newValue._quality)
            addChild(_armorImg)
            
            var n = ""
            for s in newValue._name {
                n.append(s)
                break
            }
            _iconLabel.text = n

            if newValue is Item && !(newValue is SpellBook) {
                let num = "\((newValue as! Item)._count)"
                _countLabel.removeFromParent()
                let count = Label()
                count.align = "left"
                count.fontSize = 12
                count.position.x = -22
                count.position.y = -cellSize * 0.5 + 2
                count.text = num
                //                    count.fontColor = UIColor.black
                addChild(count)
                _countLabel = count
                var width = (4 + 7 * num.count)
                if num.count < 2 {
                    width = 14
                }
                let shape = SKShapeNode(rect: CGRect(x: Int(-cellSize * 0.5), y: Int(-cellSize * 0.5), width: width, height: 14), cornerRadius: 2)
                //                    shape.fillColor = UIColor.white
                addChild(shape)
            }
        }
        get {
            return _prop
        }
    }
    internal var _iconLabel = Label()
    private var _selected = false
    var selected:Bool {
        set {
            if newValue {
                _bg.strokeColor = Game.SELECTED_HIGHLIGH_COLOR
                _bg.lineWidth = 4
            } else {
                _bg.strokeColor = QualityColor.getColor(_prop._quality)
                _bg.lineWidth = 1
            }
            _selected = newValue
        }
        get {
            return _selected
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var _bg:SKShapeNode!
    var _outfit = Prop()
    private var _armorImg = SKSpriteNode()

}


