//
//  MinionTradingPanel.swift
//  GoD
//
//  Created by kai chen on 2019/6/22.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class MinionTradingPanel: UIPanel {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        if _closeButton.contains(touchPoint!) {
            Game.instance.curStage.removePanel(self)
            return
        }
        
        if _leftPrev.contains(touchPoint!) {
            if _curLeftPage <= 1 {
                _curLeftPage = 1
                return
            } else {
                _curLeftPage = _curLeftPage - 1
                showLeft()
                return
            }
        }
        
        if _leftNext.contains(touchPoint!) {
            if _curLeftPage >= 3 {
                _curLeftPage = 3
                return
            } else {
                _curLeftPage = _curLeftPage + 1
                showLeft()
                return
            }
        }
        
        if _rightPrev.contains(touchPoint!) {
            if _curRightPage <= 1 {
                _curRightPage = 1
                return
            } else {
                _curRightPage = _curRightPage - 1
                showRight()
                return
            }
        }
        
        if _rightNext.contains(touchPoint!) {
            if _curRightPage >= 2 {
                _curRightPage = 2
                return
            } else {
                _curRightPage = _curRightPage + 1
                showRight()
                return
            }
        }
        
        
        for c in _leftBox.children {
            if c.contains(touchPoint!) {
                let u = c as! StoredMinionComponent
                if u.selected {
                    if _char._minions.count >= 6 {
                        showMsg(text: "最多可携带6个随从")
                        return
                    }
                    u.selected = false
                    let m = u._unit!
                    let index = _char._storedMinions.firstIndex(of: m)
                    _char._storedMinions.remove(at: index!)
                    _char._minions.insert(m, at: 0)
                    _curRightPage = 1
                    showRight()
                    showLeft()
                    reloadCount()
                } else {
                    for c1 in _leftBox.children {
                        (c1 as! StoredMinionComponent).selected = false
                    }
                    u.selected = true
                }
                return
            }
        }
        for c in _rightBox.children {
            if c.contains(touchPoint!) {
                let u = c as! StoredMinionComponent
                if u.selected {
                    if _char._storedMinions.count >= 12 {
                        showMsg(text: "储藏室已满！")
                        return
                    }
                    u.selected = false
                    let m = u._unit!
                    let index = _char._minions.firstIndex(of: m)
                    _char._minions.remove(at: index!)
                    _char._storedMinions.insert(m, at: 0)
                    showRight()
                    _curLeftPage = 1
                    showLeft()
                    reloadCount()
                    
                } else {
                    for c1 in _rightBox.children {
                        (c1 as! StoredMinionComponent).selected = false
                    }
                    u.selected = true
                }
                return
            }
        }
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func createPanelbackground() {
        let gap:CGFloat = 4
        let width = _standardWidth * 0.5
        _rightBack = createBackground(width: width - gap, height: _standardHeight)
        _rightBack.position = CGPoint(x: (width + gap) * 0.5, y: 0)
        _rightBack.zPosition = self.zPosition + 1
        addChild(_rightBack)
        _leftBack = createBackground(width: width - gap, height: _standardHeight)
        _leftBack.position = CGPoint(x: -(width + gap) * 0.5, y: 0)
        _leftBack.zPosition = self.zPosition + 1
        addChild(_leftBack)
    }
    override func create() {
        _pageSize = 4
        _label.text = "存储/取出：再次点击已选择的随从"
        createCloseButton()
        createPanelbackground()
        let x = _closeButton.xAxis
        let y = _closeButton.yAxis
        let z = _closeButton.zPosition
        let w = _closeButton.width
        let gap = cellSize * 0.125
        let yGap = cellSize * 0.7
        initButton(b: _rightNext, x: x, y: -y + yGap, z: z, text: "下一页")
        initButton(b: _rightPrev, x: x - w - gap, y: -y + yGap, z: z, text: "上一页")
        
        initButton(b: _leftPrev, x: -x - w, y: -y + yGap, z: z, text: "上一页")
        initButton(b: _leftNext, x: -x + gap, y: -y + yGap, z: z, text: "下一页")
        
        _leftText.position.x = -cellSize * 0.75
        _leftText.position.y = -y + cellSize * 0.5
        _leftText.text = "3/12"
        _leftText.zPosition = _leftNext.zPosition
        _leftText.fontSize = cellSize / 4
        addChild(_leftText)
        
        _rightText.position.x = cellSize * 0.25
        _rightText.position.y = -y + cellSize * 0.5
        _rightText.text = "3/6"
        _rightText.zPosition = _leftNext.zPosition
        _rightText.fontSize = cellSize / 4
        addChild(_rightText)
        _leftBox.zPosition = _rightPrev.zPosition
        _rightBox.zPosition = _rightPrev.zPosition
        addChild(_leftBox)
        addChild(_rightBox)
        
        showLeft()
        showRight()
        reloadCount()
    }
    
    private func showRight() {
        _rightBox.removeAllChildren()
        //        let startX:CGFloat = 0
        let ms = _char._minions
        let startX = cellSize * 0.375
        let startY = _standardHeight * 0.5 - _standardGap
        if ms.count > 0 {
            let end = getRightPageEnd(ms.count)
            let start = getRightPageStart(end)
            
            for i in start...end - 1 {
                let base = i - (_curPage - 1) * _pageSize
                let y = base % 4
                let rc = StoredMinionComponent()
                rc.create(unit: ms[i])
                rc.xAxis = startX
                rc.yAxis = startY - y.toFloat() * cellSize * 1.5
                _rightBox.addChild(rc)
                
            }
        }
    }
    
    private func showLeft() {
        _leftBox.removeAllChildren()
        //        let startX:CGFloat = 0
        let ms = _char._storedMinions
        let startX = -cellSize * 3.75
        let startY = _standardHeight * 0.5 - _standardGap
        if ms.count > 0 {
            let end = getLeftPageEnd(ms.count)
            let start = getLeftPageStart(end)
            
            for i in start...end - 1 {
                let base = i - (_curPage - 1) * _pageSize
                let y = base % 4
                let rc = StoredMinionComponent()
                rc.create(unit: ms[i])
                rc.xAxis = startX
                rc.yAxis = startY - y.toFloat() * cellSize * 1.5
                _leftBox.addChild(rc)
                
            }
        }
    }
    
    func getLeftPageEnd(_ count:Int) -> Int {
        let pages = count / _pageSize
        if pages >= _curLeftPage {
            return _curLeftPage * _pageSize
        }
        return count
    }
    func getLeftPageStart(_ end:Int) -> Int {
        var start = (_curLeftPage - 1) * _pageSize
        if start >= end {
            _curLeftPage -= 1
            start = (_curLeftPage - 1) * _pageSize
        }
        return start
    }
    
    func getRightPageEnd(_ count:Int) -> Int {
        let pages = count / _pageSize
        if pages >= _curRightPage {
            return _curRightPage * _pageSize
        }
        return count
    }
    func getRightPageStart(_ end:Int) -> Int {
        var start = (_curRightPage - 1) * _pageSize
        if start >= end {
            _curRightPage -= 1
            start = (_curRightPage - 1) * _pageSize
        }
        return start
    }
    
    private func reloadCount() {
        _rightText.text = "\(_char._minions.count)/6"
        _leftText.text = "\(_char._storedMinions.count)/12"
    }
    
    private func initButton(b:Button, x:CGFloat, y:CGFloat, z:CGFloat, text:String) {
        b.xAxis = x
        b.yAxis = y
        b.zPosition = z
        b.text = text
        addChild(b)
    }
    private var _curRightPage = 1
    private var _curLeftPage = 1
    private var _leftBox = SKSpriteNode()
    private var _rightBox = SKSpriteNode()
    private var _leftBack:SKShapeNode!
    private var _rightBack:SKShapeNode!
    private var _leftPrev = Button()
    private var _leftNext = Button()
    private var _rightPrev = Button()
    private var _rightNext = Button()
    private var _leftText = Label()
    private var _rightText = Label()
}
class StoredMinionComponent: SelectableComponent {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _background = createBackground(width: cellSize * 3.25, height: cellSize * 1.25)
        _background.strokeColor = Game.UNSELECTED_STROKE_COLOR
        addChild(_background)
        addChild(_propertyLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func create(unit:Creature) {
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
        lv.text = "Lv.\(unit._level.toInt()) \(TypeName.getName(unit._race))"
        lv.fontSize = cellSize / 4
        lv.position.x = startX + cellSize + gap
        lv.position.y = startY - gap
        _propertyLayer.addChild(lv)
        
        let name = Label()
        name.text = unit._name
        name.fontSize = cellSize / 4
        name.position.x = startX + cellSize + gap
        name.position.y = startY - cellSize * 0.125 - cellSize / 4
        _propertyLayer.addChild(name)
        
        
        
        let hpbar = HBar()
        hpbar.create(width: cellSize * 1.75, height: cellSize / 8, value: unit._extensions.hp / unit._extensions.health, color: UIColor.red)
        hpbar.position.y = name.position.y - cellSize * 0.375
        hpbar.position.x = name.position.x
        _propertyLayer.addChild(hpbar)
        _hpbar = hpbar
        
        let expbar = HBar()
        expbar.create(width: cellSize * 1.75, height: cellSize / 8, value: unit._exp / unit.expNext(), color: QualityColor.GOOD)
        expbar.position.y = hpbar.position.y - cellSize / 6
        expbar.position.x = name.position.x
        _propertyLayer.addChild(expbar)
    }
    func reload() {
        _hpbar.setBar(value: _unit._extensions.hp / _unit._extensions.health)
    }
    var _unit:Creature!
    private var _propertyLayer = SKSpriteNode()
    private var _hpbar:HBar!
}
