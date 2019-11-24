//
//  SelectDocument.swift
//  GoD
//
//  Created by kai chen on 2019/4/25.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class SelectDocument: UIPanel {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        if nil != _selectedDc && _selectedDc.contains(touchPoint!){
            go()
            return
        }
        for dc in _dcLayer.children {
            if dc.contains(touchPoint!) {
                if nil != _selectedDc {
                    _selectedDc.selected = false
                }
                _selectedDc = (dc as! DocComponent)
                _selectedDc.selected = true
                return
            }
        }
        
        if _closeButton.contains(touchPoint!) {
            self.removeFromParent()
            let welcome = Welcome()
            welcome.create()
            welcome._gameScene = Game.instance.scene
            Game.instance.scene.addChild(welcome)
        }
        
        if _prevButton.contains(touchPoint!) {
            self.removeFromParent()
            let flow = CreationFlow()
            flow.create()
            flow.gameScene = _gameScene
            flow.actionCreate = {
                flow.removeFromParent()
            }
            _gameScene.addChild(flow)
            return
        }
        
        if _delButton.contains(touchPoint!) {
            if nil == _selectedDc {
                return
            }
            Game.remove(doc: _selectedDc._doc)
            reload()
            _selectedDc = nil
            return
        }
        
        if nil != _selectedDc {
            if _nextButton.contains(touchPoint!) {
                go()
                return
            }
        }
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        isUserInteractionEnabled = true
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private func go() {
        self.removeFromParent()
        let role = Game.load(key: _selectedDc._doc._key)!
        let stage = MyStage()
        let scene = SelfHome()
        scene.create()
        scene.setRole(x: 2, y: 1, role: role)
        stage.loadScene(scene: scene)
        stage.createMenu()
        _gameScene!.addChild(stage)
    }
    private func reload() {
        _dcLayer.removeAllChildren()
        let roles = Game.loadRoles()
        if roles != nil {
            _roleDocs = roles!
            Game.roles = _roleDocs
        } else {
            return
        }
        
        showDocs()
        showCreationButton()
    }
    override func create() {
        createCloseButton()
        createPageButtons()
        _closeButton.text = "返回"
        _prevButton.text = "创建角色"
        _nextButton.text = "进入游戏"
        _delButton.zPosition = _closeButton.zPosition
        _delButton.yAxis = _prevButton.yAxis
        _delButton.xAxis = -_nextButton.xAxis - cellSize * 1.5
        _delButton.text = "删除角色"
        addChild(_delButton)
        _dcLayer.zPosition = self.zPosition + 2
        addChild(_dcLayer)
//        for i in 0...7 {
//            let rd = RoleDocument()
//            rd._level = 10
//            rd._name = "骑士"
//            _roleDocs.append(rd)
//        }
        let roles = Game.loadRoles()
        if roles != nil {
            _roleDocs = roles!
            Game.roles = _roleDocs
        } else {
            return
        }
        showDocs()
        showCreationButton()
    }
    
    func showDocs() {
        if _roleDocs.count < 1 {
            return
        }
        let row1x = -cellSize * 2
        let row2x = cellSize * 1.5
        let startY = cellSize * 3
        for i in 0..._roleDocs.count - 1 {
            let rd = _roleDocs[i]
            let dc = DocComponent()
            dc._imgUrl = rd._imgUrl
            dc._doc = rd
            dc.create(doc: rd)
            if i % 2 == 0 {
                dc.xAxis = row1x
            } else {
                dc.xAxis = row2x
            }
            let y = Int(i / 2)
            dc.yAxis = startY - y.toFloat() * cellSize * 1.5
            _dcLayer.addChild(dc)
        }
    }
    private func showCreationButton() {
        if _roleDocs.count < 8 {
            _prevButton.isHidden = false
        } else {
            _prevButton.isHidden = true
        }
    }
    internal var _delButton = Button()
    var _gameScene:GameScene!
    private var _dcLayer = SKSpriteNode()
    private var _selectedDc:DocComponent!
    private var _roleDocs = Array<RoleDocument>()
}
class DocComponent:SelectableComponent {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private func createBg() {
        let width = cellSize * 3
        let height = cellSize * 1.25
        _background = createBackground(width: width, height: height)
        _background.position.x = 0
        _background.zPosition = self.zPosition
        _background.lineWidth = 0
        addChild(_background)
    }
    var _doc:RoleDocument!
    var _imgUrl = ""
    func create(doc:RoleDocument) {
        createBg()
        let m = doc
//        let size = cellSize * 1.5
//        let gap = cellSize * 0.25
//        let startX = -cellSize * 3.5
        
        let img = SKSpriteNode(texture: SKTexture(imageNamed: _imgUrl).getCell(1, 0))
        img.position.x = -cellSize * 1.5
        img.position.y = 0
        img.anchorPoint = CGPoint(x: 0, y: 1)
        img.size = CGSize(width: cellSize, height: cellSize)
        addChild(img)
        
//        let roleImageBorder = SKShapeNode(rectOf: CGSize(width: size, height: size), cornerRadius: 4)
//        roleImageBorder.position.x = size * 0.5 + gap + startX
//        roleImageBorder.position.y = -size * 0.5 - gap
//        roleImageBorder.lineWidth = 1
//        roleImageBorder.zPosition = self.zPosition + 3
//        roleImageBorder.strokeColor = Game.UNSELECTED_STROKE_COLOR
//
//        addChild(roleImageBorder)
        
        let level = Label()
        level.text = m._name
        level.fontColor = UIColor.white
        level.fontSize = 24
        level.position.x = img.xAxis + cellSize * 1.25
        level.position.y = -cellSize * 0.25
        addChild(level)
        
        let race = Label()
        race.text = "lv.\(m._level)[\(m._pro)]"
        race.fontSize = 20
        race.position.x = level.position.x
        race.position.y = level.position.y - level.fontSize - 6
        addChild(race)
    }
    
    override var selected:Bool {
        set {
            if newValue {
                _background.lineWidth = Game.SELECTED_STROKE_WIDTH
            } else {
                _background.lineWidth = 0
            }
            _selected = newValue
        }
        get {
            return _selected
        }
    }
}
