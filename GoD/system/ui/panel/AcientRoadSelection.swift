//
//  AcientRoadSelection.swift
//  GoD
//
//  Created by kai chen on 2018/12/28.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class AcientRoadSelection:UIPanel {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        if _closeButton.contains(touchPoint!) {
            close()
            return
        }
        if _nextButton.contains(touchPoint!) {
            let size = _dungeonLevel / _pageSize
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
        
//        if _selectedRoad != nil {
//            let floorLevel = _selectedRoad!._floor
//            let stage = Game.instance.curStage!
//            stage.removePanel(self)
//            stage.enterFloor(floor: floorLevel.toFloat())
//        }
        
        for c in _roadBox.children {
            if c.contains(touchPoint!) {
                let rc = c as! RoadComponent
                if rc.selected {
                    let floorLevel = rc._floor
                    let stage = Game.instance.curStage!
                    stage.removePanel(self)
                    stage.enterFloor(floor: floorLevel.toFloat())
                } else {
                    rc.selected = true
                    _selectedRoad?.selected = false
                    _selectedRoad = nil
                    _selectedRoad = rc
                }
            }
        }
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        addChild(_roadBox)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func create() {
        createCloseButton()
        _pageSize = 16
        
         _dungeonLevel  = Game.instance.char._dungeonLevel
        if Mode.debug {
            _dungeonLevel = 99
        }
//        if _dungeonLevel > _pageSize {
//        }
        createPageButtons()
        pageReload()
        _label.text = "双击选择前往的层数。"
    }
    override func pageReload() {
        _roadBox.removeAllChildren()
        let sX = -_standardWidth * 0.5 + cellSize * 0.5
        let sY = _standardHeight * 0.5 - cellSize * 0.5
        let gap = cellSize * 0.75
        let gapx = cellSize * 3.75
        let end = getPageEnd(_dungeonLevel)
        let xx = getPageStart(end)
        
        for i in xx...end - 1 {
            let base = i - (_curPage - 1) * _pageSize
            let x = base % 2
            let y = base / 2
            let rc = RoadComponent()
            rc.zPosition = self.zPosition + 3
            rc.create(floor: i + 1)
            rc.xAxis = sX + x.toFloat() * gapx
            rc.yAxis = sY - y.toFloat() * gap
            rc._floor = i + 1
            _roadBox.addChild(rc)
        }
    }
    override func close() {
        Game.instance.curStage.removePanel(self)
    }
    private var _dungeonLevel = 0
    private var _roadBox = SKSpriteNode()
    private var _selectedRoad:RoadComponent?
}

class RoadComponent: SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.zPosition = MyStage.UI_PANEL_Z
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func create(floor:Int) {
        _border = createBorder(width: 8, height: cellSize * 0.75)
        addChild(_border)
        let label = Label()
        label.text = "远古之路 第\(floor)层"
        label.fontSize = 28
        label.position.x = cellSize * 0.5
        label.position.y = -6
        addChild(label)
        _label = label
        _floor = floor
    }
    var selected:Bool {
        set {
            _selected = newValue
            if newValue {
                _border.color = SELECTED_COLOR
                _label.fontColor = SELECTED_COLOR
            } else {
                _border.color = UNSELECTED_COLOR
                _label.fontColor = UNSELECTED_COLOR
            }
        }
        get {
            return _selected
        }
    }
    var _floor:Int = 0
    private var _label:Label!
    private var _selected = false
    private let SELECTED_COLOR = QualityColor.RARE
    private let UNSELECTED_COLOR = UIColor.white
    private var _border:SKSpriteNode!
}
