//
//  RoleSelectPanel.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/5.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class SelectMinion:UIPanel {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        
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
        if _minionComponents[0].contains(touchPoint!) {
            _minionComponents[0].selected = true
            _minionComponents[1].selected = false
            _lastSelectedComponent = _minionComponents[0]
            return
        }
        
        if _minionComponents[1].contains(touchPoint!) {
            _minionComponents[1].selected = true
            _minionComponents[0].selected = false
            _lastSelectedComponent = _minionComponents[1]
            return
        }
    }
    var nextAction = {}
    var prevAction = {}
    var closeAction = {}
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var _minionComponents = Array<SelectMinionComponent>()
    var _lastSelectedComponent = SelectMinionComponent()
    var _minions = Array<Creature>()
    override func create() {
        createCloseButton()
        createPageButtons()
        _closeButton.text = "返回"
        _prevButton.text = "上一步"
        _nextButton.text = "创建角色"
        _label.text = "抉择：选择一个随从跟随作战。"
        addChild(_minionLayer)
        
//        var minions = Array<Creature>()
//        let blackCat = BlackCat()
//        blackCat.create(level: 1)
//        let crow = DarkCrow()
//        crow.create(level: 1)
//        minions.append(crow)
//        minions.append(blackCat)
//        showMinions(minions)
    }
    
    
    func showMinions(_ minions:Array<Creature>) {
        let size = minions.count - 1
        let startY = _standardHeight * 0.5 - _standardGap
        for i in 0...size {
            let y = i % 3
            let mc = SelectMinionComponent()
            mc.create(minion: minions[i])
            mc.position.x = -cellSize * 1.25
            mc.zPosition = self.zPosition + 5
            mc.position.y = startY - y.toFloat() * cellSize * 1.75
            _minionLayer.addChild(mc)
            _minionComponents.append(mc)
        }
    }
    private var _minionLayer = SKSpriteNode()
}

class SelectMinionComponent:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func createBg() {
        let width = cellSize * 7.5
        let height = cellSize * 2
        _bg = createBackground(width: width, height: height)
        _bg.position.x = 0
        _bg.zPosition = self.zPosition
//        addChild(_bg)
        
    }
    private var _bg = SKShapeNode()
    
    var _minion:Creature!
    func create(minion:Creature) {
        createBg()
        _minion = minion
        let m = minion
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
        roleImageBorder.zPosition = self.zPosition + 3
        roleImageBorder.strokeColor = Game.UNSELECTED_STROKE_COLOR
        
        addChild(roleImageBorder)
        
        let level = Label()
        level.text = m._name
        level.fontColor = QualityColor.getColor(m._quality)
        level.fontSize = cellSize / 2
        level.align = "left"
        level.position.x = size + gap * 2 + startX
        level.position.y = -cellSize * 0.5
        addChild(level)
        
//        let _hpbar = HBar()
//        let barWidth = cellSize * 3
//        _hpbar.create(width: barWidth, height: 12, value: m._extensions.hp / m._extensions.health, color: Game.HPBAR_COLOR)
//        addChild(_hpbar)
//
//        let _expbar = HBar()
//        _expbar.create(width: barWidth, height: 10, value: m._exp / m.expNext(), color: Game.EXPBAR_COLOR)
//        addChild(_expbar)
        
        let race = Label()
        race.text = "lv.\(m._level.toInt())[\(EvilType.getTypeLabel(type: minion._race))]"
        race.fontSize = cellSize / 2
        race.position.x = level.position.x
        race.position.y = level.position.y - level.fontSize - 6
        addChild(race)
        
//        _hpbar.position.y = race.position.y - race.fontSize - 12
//        _expbar.position.y = _hpbar.position.y - 18
//        _hpbar.position.x = size + gap * 2 + startX
//        _expbar.position.x = _hpbar.position.x
//        _hpbar.zPosition = self.zPosition + 3
//        _expbar.zPosition = self.zPosition + 3
        
//        let seatGap = cellSize * 0.125
//
//        setSeatNode(node: _btl, x: _expbar.position.x + cellSize * 2 + gap, y: -gap, seat: BUnit.BTL)
//        setSeatNode(node: _bbl, x: _btl.xAxis, y: -gap - _btl.size.height - seatGap, seat: BUnit.BBL)
//        setSeatNode(node: _btm, x: _btl.xAxis + _btl.size.width + seatGap, y: -gap, seat: BUnit.BTM)
//        setSeatNode(node: _btr, x: _btm.xAxis + _btl.size.width + seatGap, y: -gap, seat: BUnit.BTR)
//        setSeatNode(node: _bbm, x: _btm.xAxis, y: _bbl.yAxis, seat: BUnit.BBM)
//        setSeatNode(node: _bbr, x: _btr.xAxis, y: _bbl.yAxis, seat: BUnit.BBR)
        
    }
    private var _select = false
    var selected:Bool {
        set {
            _bg.removeFromParent()
            if newValue {
                _bg.lineWidth = 2
                _bg.strokeColor = UIColor.white
                addChild(_bg)
            }
            _select = newValue
        }
        get {
            return _select
        }
    }
}
