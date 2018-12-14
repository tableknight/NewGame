//
//  Panel.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/7.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class UIPanel:SKSpriteNode {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        if _closeButton.contains(touchPoint!) {
            Game.instance.curStage.removePanel(self)
            return
        }
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        isUserInteractionEnabled = true
        _char = Game.instance.char
        self.zPosition = MyStage.UI_PANEL_Z
        createPanelbackground()
        
        createMask()
        
        createLabel()
    }
    internal func createLabel() {
        let t = Label()
        t.align = "left"
        t.fontSize = cellSize * 0.25
        //        t.text = "传送：再次点击已选择的层数。"
        t.position.x = -_standardWidth * 0.5
        t.position.y = _standardHeight * 0.5 + cellSize * 0.5
        t.zPosition = self.zPosition + 2
        addChild(t)
        _label = t
    }
    internal func createMask() {
        let _mask = Game.createMask()
        _mask.zPosition = self.zPosition
        addChild(_mask)
    }
    
    internal func createPanelbackground() {
        _bg = createBackground(width: _standardWidth, height: _standardHeight)
        _bg.position = CGPoint(x: 0, y: 0)
        _bg.zPosition = self.zPosition + 1
        addChild(_bg)
    }
    
    func create() {
        
    }
    
    func createCloseButton() {
        _closeButton.text = "关闭"
        _closeButton.position.y = _standardHeight * 0.5 + cellSize * 0.5
        _closeButton.position.x = _standardWidth * 0.5 - cellSize * 1.5
        _closeButton.zPosition = self.zPosition + 2
        addChild(_closeButton)
    }
    
    func createPageButtons() {
        _nextButton.text = "下一页"
        _nextButton.position.x = _closeButton.position.x
        _nextButton.position.y = -_closeButton.position.y + cellSize * 0.5
        _nextButton.zPosition = self.zPosition + 2
        addChild(_nextButton)
        
        _prevButton.text = "上一页"
        _prevButton.position.x = _nextButton.position.x - cellSize * 1.875
        _prevButton.position.y = _nextButton.position.y
        _prevButton.zPosition = self.zPosition + 2
        addChild(_prevButton)
    }
    
    func getPageEnd(_ count:Int) -> Int {
        let pages = count / _pageSize
        if pages >= _curPage {
            return _curPage * _pageSize
        }
        return count
    }
    func pageReload() {
        
    }
    
//    func displayInfos(icon:Icon) {
//        let spell = icon._infosDisplay as! Spell
//        //        let id = icon._infosDisplay.getInfosDisplay()
//        let node = SpellInfo()
//        node.create(spell: spell)
//        calIconPos(node: node, icon: Icon)
//    }
    func displayInfos(icon:Icon) {
        let id = icon._displayItemType
//        var node:Any!
        if id is Spell {
            let spell = icon._displayItemType as! Spell
            let node = SpellInfo()
            node.zPosition = MyStage.UI_TOPEST_Z
            node.create(spell: spell)
            node.position.x = icon.position.x
            if icon.position.y < 0 {
                node.position.y = icon.position.y + node.getDisplayHeight() + 5
            } else {
                node.position.y = icon.position.y - cellSize - 5
            }
            if icon.position.x > 0 {
                node.position.x = icon.position.x - node.getDisplayWidth() + cellSize
            }
            addChild(node)
            _infosDisplay = node
        } else if id is Item {
            let item = icon._displayItemType as! Item
            let node = ItemInfo()
            node.create(item: item)
            node.position.x = icon.position.x + cellSize * 0.5 + 5
            if icon.position.y < 0 {
                node.position.y = icon.position.y + node.getDisplayHeight() - cellSize * 0.5
            } else {
                node.position.y = icon.position.y + cellSize * 0.5
            }
            if icon.position.x > cellSize * 4 {
                node.position.x = icon.position.x - node.getDisplayWidth()
            }
            addChild(node)
            _infosDisplay = node
        } else if id is Outfit {
            let outfit = icon._displayItemType as! Outfit
            let node = ArmorInfo()
            node.create(armor: outfit)
            node.position.x = icon.position.x
            if icon.position.y < 0 {
                node.position.y = icon.position.y + node.getDisplayHeight() + 5
            } else {
                node.position.y = icon.position.y - cellSize - 5
            }
            if icon.position.x > 0 {
                node.position.x = icon.position.x - node.getDisplayWidth() + cellSize
            }
            addChild(node)
            _infosDisplay = node
        }
    }
    
    func showInfosAction(node:SKSpriteNode, touchPoint:CGPoint) -> Bool {
        for icon in node.children {
            if icon.contains(touchPoint) {
                _lastSelectedIcon.selected = false
                _lastSelectedIcon = icon as! Icon
                _lastSelectedIcon.selected = true
                displayInfos(icon: _lastSelectedIcon)
                return true
            }
        }
        
        return false
    }

    
    internal var _bg:SKShapeNode!
    internal var _infosDisplay = SKSpriteNode()
    internal var _lastSelectedIcon = Icon(quality: 1)
    internal var _label:Label!
    internal var _closeButton = Button()
    internal var _prevButton = Button()
    internal var _nextButton = Button()
    internal var _char:Character!
    internal var _standardWidth = Game.CELLSIZE * 8
    internal var _standardHeight = Game.CELLSIZE * 7
    internal var _standardGap = Game.CELLSIZE * 0.25
    internal var _pageSize = 20
    internal var _curPage = 1
    internal var _startX:CGFloat = -Game.CELLSIZE * 4
    internal var _startY:CGFloat = Game.CELLSIZE * 3.5
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
