//
//  MinionsPanel.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/9.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class MinionsList:UIPanel {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        isUserInteractionEnabled = true
//        let bg = SKSpriteNode()
//        bg.size = CGSize(width: Data.instance.screenWidth, height: Data.instance.screenHeight)
//        bg.color = UIColor.darkGray
//        addChild(bg)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        if _closeButton.contains(touchPoint!) {
            Game.instance.curStage.removePanel(self)
            return
        }
        
        if _nextButton.contains(touchPoint!) && !_nextButton.isHidden {
            _nextButton.isHidden = true
            _prevButton.isHidden = false
            _minionLayer.removeAllChildren()
            var ms = Array<Creature>()
            for i in 3..._minions.count - 1 {
                ms.append(_minions[i])
            }
            
            showMinions(ms)
            return
        }
        
        if _prevButton.contains(touchPoint!) && !_prevButton.isHidden {
            _nextButton.isHidden = false
            _prevButton.isHidden = true
            _minionLayer.removeAllChildren()
            var ms = Array<Creature>()
            for i in 0...2 {
                ms.append(_minions[i])
            }
            
            showMinions(ms)
            return
        }
        
        if _discardButton.contains(touchPoint!) {
            if !_lastSelectedComponent.selected {
                return
            }
            if _discardButton.selected {
                _discardButton.selected = false
                _lastSelectedComponent.removeFromParent()
                let char = Game.instance.char!
                let index = char._minions.index(of: _lastSelectedComponent._minion)
                if nil != index {
                    char._minions.remove(at: index!)
                }
                _lastSelectedComponent = MinionComponent()
                pageReload()
            } else {
                _discardButton.selected = true
            }
        }
        
//        for c in _minionLayer.children {
//            let mc = c as! MinionComponent
//            for sn in mc._seats {
//                if sn.contains(touchPoint!) {
//                    if sn._seat == Game.instance.char._seat {
//                        return
//                    }
//                    sn.selected = true
//                    mc._minion._seat = sn._seat
//                    unselectAll(seat: sn._seat)
//                    return
//                }
//            }
//            if c.contains(touchPoint!) {
//                mc.selected = true
//                _lastSelectedComponent.selected = false
//                _lastSelectedComponent = mc
//            }
//        }
        
//        for mc in _minionComponents {
//            if mc.contains(touchPoint!) {
//                if mc.selected {
//
//                } else {
//                    mc.selected = true
//                    _lastSelectedComponent.selected = false
//                    _lastSelectedComponent = mc
//                }
//            }
//        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func unselectAll(seat:String) {
        for c in _minionLayer.children {
            let mc = c as! MinionComponent
            for sn in mc._seats {
                if sn._seat == seat {
                    sn.selected = false
                }
            }
        }
        for m in Game.instance.char._minions {
            if m._seat == seat {
                m._seat = BUnit.STAND_BY
            }
        }
    }
    
    func showMinionInfo(minion:Creature) {
        let rp = RolePanel()
        rp.create(unit: minion)
        rp._parentPanel = self
        Game.instance.curStage.showPanel(rp)
        Game.instance.curStage.removePanel(self)
    }
    
    override func pageReload() {
        _minions = _char._minions
        if _minions.count <= 3 {
            _minionLayer.removeAllChildren()
            showMinions(_minions)
            _nextButton.removeFromParent()
            _prevButton.removeFromParent()
        } else {
            if _nextButton.isHidden {
                var ms = Array<Creature>()
                for i in 3..._minions.count - 1 {
                    ms.append(_minions[i])
                }
                
                showMinions(ms)
            } else {
                var ms = Array<Creature>()
                for i in 0...2 {
                    ms.append(_minions[i])
                }
                
                showMinions(ms)
            }
        }
        self.recount()
    }
    
//    override func createPanelbackground() {
//        let b = CGRect(x: -cellSize * 6.5, y: -cellSize * 3, width: cellSize * 13, height: cellSize * 6)
//        let bg = SKShapeNode(rect: b, cornerRadius: 4)
//        bg.fillColor = UIColor.black
//        bg.zPosition = self.zPosition + 2
//        addChild(bg)
//        _bg = bg
//    }
    
    var _minionComponents = Array<MinionComponent>()
    var _lastSelectedComponent = MinionComponent()
    var _minions = Array<Creature>()
    var _discardButton = Button()
    func create(minions:Array<Creature>) {
        createCloseButton()
        
        _discardButton.position.x = _closeButton.position.x - cellSize * 1.75
        _discardButton.position.y = _closeButton.position.y
        _discardButton.zPosition = _closeButton.zPosition
        _discardButton.text = "丢弃"
        addChild(_discardButton)
        
        _label.text = "查看：再次点击已选中单位。"
        
        let count = Label()
        count.position.y = -_label.position.y + _label.fontSize
        count.position.x = _label.position.x
        count.zPosition = _label.zPosition
        count.align = "left"
        count.fontSize = _label.fontSize
        count.text = ""
        addChild(count)
        _counter = count
        recount()
        
        _minions = minions
        addChild(_minionLayer)
        var ms = minions
        if minions.count > 3 {
            ms = [minions[0],minions[1],minions[2]]
            createPageButtons()
            _nextButton.position.x = -cellSize * 0.75
            _nextButton.yAxis = -_closeButton.position.y + cellSize * 0.5
            _prevButton.xAxis = _nextButton.xAxis
            _prevButton.yAxis = _nextButton.yAxis
            _prevButton.isHidden = true
        }
        showMinions(ms)
    }
    
    func recount() {
        _counter.text = "随从：\(_char.getReadyMinions().count)/\(_char._minionsCount)，\(_char._minions.count)/6"
    }
    
    func showMinions(_ minions:Array<Creature>) {
        let size = minions.count - 1
        let startY = _standardHeight * 0.5 - _standardGap
        for i in 0...size {
            let y = i % 3
            let mc = MinionComponent()
            mc.create(minion: minions[i])
            mc.position.x = 0
            mc.zPosition = self.zPosition + 5
            mc.position.y = startY - y.toFloat() * cellSize * 2.25
            mc._panelMinionsList = self
            _minionLayer.addChild(mc)
            _minionComponents.append(mc)
        }
    }
    private var _minionLayer = SKSpriteNode()
    private var _counter:Label!
}

class MinionComponent:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        isUserInteractionEnabled = true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        for sn in _seats {
            if sn.contains(touchPoint!) {
                if sn.selected {
                    sn.selected = false
                    _minion._seat = BUnit.STAND_BY
                    _panelMinionsList.recount()
                    return
                }
                let char = Game.instance.char!
                if sn._seat == char._seat {
                    return
                }
                if (char.getReadyMinions().count >= char._minionsCount) && _minion._seat == BUnit.STAND_BY {
                    return
                }
                _panelMinionsList.unselectAll(seat: sn._seat)
                for sn in _seats {
                    sn.selected = false
                    _minion._seat = BUnit.STAND_BY
                }
                sn.selected = true
                _minion._seat = sn._seat
                _panelMinionsList.recount()
                return
            }
        }
        if _panelMinionsList._lastSelectedComponent == self {
            _panelMinionsList.showMinionInfo(minion: _minion)
            return
        }
        selected = true
        _panelMinionsList._lastSelectedComponent.selected = false
        _panelMinionsList._lastSelectedComponent = self
    }
    var _panelMinionsList:MinionsList!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func createBg() {
        let width = cellSize * 7.5
        let height = cellSize * 2
        _bg = createBackground(width: width, height: height)
        _bg.position.x = 0
        addChild(_bg)
        
    }
    private var _bg = SKShapeNode()
    
    var _minion = Creature()
    func create(minion:Creature) {
        createBg()
        _minion = minion
        let m = _minion
        let size = cellSize * 1.5
        let gap = cellSize * 0.25
        let startX = -cellSize * 3.5
        
        let img = SKSpriteNode(texture: m._img.getCell(1, 0))
        img.position.x = gap * 2 + startX
        img.position.y = -gap * 2
        img.anchorPoint = CGPoint(x: 0, y: 1)
        img.size = CGSize(width: cellSize, height: cellSize)
        addChild(img)
        
        let roleImageBorder = SKShapeNode(rectOf: CGSize(width: size, height: size), cornerRadius: 4)
        roleImageBorder.position.x = size * 0.5 + gap + startX
        roleImageBorder.position.y = -size * 0.5 - gap
        roleImageBorder.lineWidth = 1
        roleImageBorder.strokeColor = Game.UNSELECTED_STROKE_COLOR
        
        addChild(roleImageBorder)
        
        let level = Label()
        level.text = m._name
        level.fontColor = QualityColor.getColor(m._quality)
        level.fontSize = 24
        level.align = "left"
        level.position.x = size + gap * 2 + startX
        level.position.y = -cellSize * 0.5
        addChild(level)
        
        let _hpbar = HBar()
        let barWidth = cellSize * 2
        _hpbar.create(width: barWidth, height: 12, value: m._extensions.hp / m._extensions.health, color: Game.HPBAR_COLOR)
        addChild(_hpbar)
        
        let _expbar = HBar()
        _expbar.create(width: barWidth, height: 10, value: m._exp / m.expNext(), color: Game.EXPBAR_COLOR)
        addChild(_expbar)
        
        let race = Label()
        race.text = "lv.\(m._level.toInt())[\(EvilType.getTypeLabel(type: minion._race))]"
        race.fontSize = 20
        race.position.x = level.position.x
        race.position.y = level.position.y - level.fontSize - 6
        addChild(race)
        
        _hpbar.position.y = race.position.y - race.fontSize - 12
        _expbar.position.y = _hpbar.position.y - 18
        _hpbar.position.x = size + gap * 2 + startX
        _expbar.position.x = _hpbar.position.x
        
        let seatGap = cellSize * 0.125
        
        setSeatNode(node: _btl, x: _expbar.position.x + cellSize * 2 + gap, y: -gap, seat: BUnit.BTL)
        setSeatNode(node: _bbl, x: _btl.xAxis, y: -gap - _btl.size.height - seatGap, seat: BUnit.BBL)
        setSeatNode(node: _btm, x: _btl.xAxis + _btl.size.width + seatGap, y: -gap, seat: BUnit.BTM)
        setSeatNode(node: _btr, x: _btm.xAxis + _btl.size.width + seatGap, y: -gap, seat: BUnit.BTR)
        setSeatNode(node: _bbm, x: _btm.xAxis, y: _bbl.yAxis, seat: BUnit.BBM)
        setSeatNode(node: _bbr, x: _btr.xAxis, y: _bbl.yAxis, seat: BUnit.BBR)
        
    }
    var _discard:MenuButton!
    
    private var _select = false
    var selected:Bool {
        set {
            if newValue {
                _bg.lineWidth = 2
                _bg.strokeColor = UIColor.white
            } else {
                _bg.lineWidth = 1
                _bg.strokeColor = UIColor.gray
            }
            _select = newValue
        }
        get {
            return _select
        }
    }
    private func setSeatNode(node:MinionSeatNode, x:CGFloat, y:CGFloat, seat:String) {
        node.position.x = x
        node.position.y = y
        node._seat = seat
        addChild(node)
        if _minion._seat == seat {
            node.selected = true
        }
        _seats.append(node)
    }
//    func selectSeat(seat:String) {
//        for msn in _seats {
//            msn.selected = false
//            if msn._seat == seat {
//                msn.selected = true
//            }
//        }
//    }
    private var _btl = MinionSeatNode()
    private var _btm = MinionSeatNode()
    private var _btr = MinionSeatNode()
    private var _bbl = MinionSeatNode()
    private var _bbm = MinionSeatNode()
    private var _bbr = MinionSeatNode()
    var _seats = Array<MinionSeatNode>()
}
class MinionSeatNode: SeatNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.size = CGSize(width: cellSize * 0.75, height: cellSize * 0.7)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private var _selected = false
    var selected:Bool {
        set {
            _selected = newValue
            if _selected {
                self.color = UIColor.white
            } else {
                self.color = UIColor.lightGray
            }
        }
        get {
            return _selected
        }
    }
}
