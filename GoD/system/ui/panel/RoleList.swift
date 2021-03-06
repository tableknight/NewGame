//
//  MinionsPanel.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/9.
//  Copyright © 2018年 Chen. All rights reserved.

import SpriteKit
class RoleList:UIPanel {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        _lastSelected?.selected = false
        if _closeButton.contains(touchPoint!) {
            closeAction()
            self.removeFromParent()
            return
        }
//        if nil != _lastSelected {
//            if _lastSelected!.contains(touchPoint!) {
//                useAction()
//                return
//            }
//            
//        }
        for cc in _curPageList {
            if cc.contains(touchPoint!) {
                cc.selected = true
                _lastSelected = cc
                selectAction()
                useAction()
                
                
                
                break
            }
        }
    }
    func create(list:Array<Unit>) {
        _listBox.zPosition = self.zPosition + 2
        addChild(_listBox)
        createCloseButton()
        _closeButton.xAxis = cellSize * 1.5
        _closeButton.yAxis = cellSize * 3.95
        _list = list
        showList()
    }
    override func createPanelbackground() {
        _bg = createBackground(width: _standardWidth * 0.75, height: cellSize * 6.5)
        _bg.position = CGPoint(x: 0, y: 0)
        _bg.strokeColor = UIColor.white
        _bg.zPosition = self.zPosition + 1
        addChild(_bg)
    }
    private func showList() {
        let startX = cellSize * 0.25 - cellSize * 3
        let startY = cellSize * 3
        let width = cellSize * 3
        let height = cellSize * 1.5
        var i = 0
        for unit in _list {
            let rc = RoleComponent()
            if nil == _item {
                // in battle
                rc._itemType = Item.Potion
            } else {
                rc._itemType = _item._type
            }
            rc.create(unit: unit)
            rc.xAxis = startX + (i % 2).toFloat() * width
            rc.yAxis = startY - (i / 2).toFloat() * height
            _listBox.addChild(rc)
            _curPageList.append(rc)
            i += 1
        }
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        zPosition = MyStage.UI_SUB_PANEL_Z
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private var _list = Array<Unit>()
    private var _listBox = SKSpriteNode()
    private var _curPageList = Array<RoleComponent>()
    var _item:Item!
    var _lastSelected:RoleComponent?
    var closeAction = {}
    var selectAction = {}
    var useAction = {}
    var _parentNode:UIPanel!
}
class RoleComponent: SelectableComponent {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _background = createBackground(width: cellSize * 2.5, height: cellSize * 1.25)
        _background.strokeColor = Game.UNSELECTED_STROKE_COLOR
        addChild(_background)
        addChild(_propertyLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func create(unit:Unit) {
        _unit = unit
//        _propertyLayer.zPosition = self.zPosition + 2
        
        let startX = cellSize * 0.125
        let startY = -cellSize * 0.125
        let roleImage = SKSpriteNode(texture: unit._img.getCell(1, 0))
        roleImage.anchorPoint = CGPoint(x: 0, y: 1)
        roleImage.size = CGSize(width: cellSize * 0.75, height: cellSize * 0.75)
        roleImage.position.x = startX + cellSize * 0.125
        roleImage.position.y = startY - cellSize * 0.125
        _propertyLayer.addChild(roleImage)
        
        let roleImageBorder = SKShapeNode(rect: CGRect(x: startX, y: startY - cellSize, width: cellSize, height: cellSize), cornerRadius: 4)
        roleImageBorder.lineWidth = 1
        roleImageBorder.strokeColor = Game.UNSELECTED_STROKE_COLOR
        
        _propertyLayer.addChild(roleImageBorder)
        
        let gap = cellSize * 0.125
        
        let lv = Label()
        lv.text = "lv.\(unit._level.toInt())"
        lv.fontSize = 20
        lv.position.x = startX + cellSize + gap
        lv.position.y = startY - gap
        _propertyLayer.addChild(lv)
        _lvLabel = lv
        
        let name = Label()
        name.text = unit._name
        name.fontSize = 20
        name.position.x = startX + cellSize + gap
        name.position.y = startY - cellSize * 0.25 - 10
        _propertyLayer.addChild(name)
        
        
        
        let hpbar = HBar()
        if _itemType == Item.MPPotion || _itemType == Item.LittleMPPotion || _itemType == Item.SoulMPPotion {
            hpbar.create(width: cellSize, height: 10, value: unit._extensions.mp / unit._extensions.mpMax, color: Game.MPBAR_COLOR)
        } else if _itemType == Item.ExpBook {
            hpbar.create(width: cellSize, height: 10, value: unit._exp / unit.expNext(), color: Game.EXPBAR_COLOR)
        } else {
            hpbar.create(width: cellSize, height: 10, value: unit._extensions.hp / unit._extensions.health, color: Game.HPBAR_COLOR)
        }
        hpbar.position.y = name.position.y - 32
        hpbar.position.x = name.position.x
        _propertyLayer.addChild(hpbar)
        _hpbar = hpbar
    }
    func reload() {
        if _itemType == Item.MPPotion || _itemType == Item.LittleMPPotion || _itemType == Item.SoulMPPotion {
            _hpbar.setBar(value: _unit._extensions.mp / _unit._extensions.mpMax)
        } else if _itemType == Item.ExpBook {
            _hpbar.setBar(value: _unit._exp / _unit.expNext())
            _lvLabel.text = "lv.\(_unit._level.toInt())"
        } else {
            _hpbar.setBar(value: _unit._extensions.hp / _unit._extensions.health)
        }
        
    }
    var _unit:Unit!
    private var _propertyLayer = SKSpriteNode()
    private var _hpbar:HBar!
    private var _lvLabel:Label!
    var _itemType = ""
}
