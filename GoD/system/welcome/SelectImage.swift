//
//  SelectImage.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/6.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class SelectImage:UIPanel {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        
        
        for u in _listBox.children {
            if u.contains(touchPoint!) {
                let rc = u as! ImageComponent
                _lastSelectedComponent.selected = false
                _lastSelectedComponent = rc
                _lastSelectedComponent.selected = true
                return
            }
        }
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
        
    }
    var nextAction = {}
    var prevAction = {}
    var closeAction = {}
    override func create() {
        createCloseButton()
        createPageButtons()
        _label.text = "选择角色形象"
        _closeButton.text = "返回"
        _prevButton.text = "上一步"
        _prevButton.isHidden = true
        _nextButton.text = "下一步"
        
        addChild(_listBox)
        _images = [
            Game.instance.pictureCollabo8_2.getCell(6, 3, 3, 4),
            Game.instance.pictureActor3.getCell(3, 7, 3, 4),
            Game.instance.pictureActor1.getCell(0, 7, 3, 4),
            Game.instance.pictureActor1.getCell(9, 3, 3, 4),
            Game.instance.picturePeople1.getCell(0, 3, 3, 4),
            Game.instance.picturePeople1.getCell(3, 3, 3, 4),
        ]
        _names = ["塞西", "洛丝丽雅", "莫贝尔", "弑羽", "狄菲" ,"安瑟玛薇"]
        showImages()
        
    }
    
    func showImages() {
        let startX = -_standardWidth * 0.5 + cellSize * 0.25
        let startY = _standardHeight * 0.5 - cellSize * 0.5
        let gap = cellSize * 2
        var i = 0
        for t in _images {
            let ic = ImageComponent()
            let x = i % 4
            let y = i / 4
            ic.yAxis = startY - gap * y.toFloat()
            ic.xAxis = startX + gap * x.toFloat()
            ic.zPosition = self.zPosition + 3
            ic.create(image: t, name: _names[i])
            _listBox.addChild(ic)
            i += 1
        }
    }
    
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var _listBox = SKSpriteNode()
    var _images = Array<SKTexture>()
    var _names = Array<String>()
    var _lastSelectedComponent = ImageComponent()
}

class ImageComponent:SelectableComponent {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
//        _background.strokeColor =
        _background = createBackground(width: cellSize * 1.5, height: cellSize * 2)
        _background.lineWidth = 2
        _background.strokeColor = QualityColor.RARE
//        addChild(_background)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func create(image:SKTexture, name:String) {
        let images:Array<SKTexture> = [image.getCell(0, 0), image.getCell(1, 0), image.getCell(2, 0)]
        let i0 = SKAction.setTexture(images[0])
//        let i1 = SKAction.setTexture(images[1])
        let i2 = SKAction.setTexture(images[2])
        let wait = SKAction.wait(forDuration: TimeInterval(0.5))
        
        let squ = SKAction.sequence([i0, wait, i2, wait])
        let r = SKAction.repeatForever(squ)
        let role = SKSpriteNode()
        role.xAxis = cellSize * 0.75
        role.yAxis = -cellSize * 0.75
        role.size = CGSize(width: cellSize * 1.25, height: cellSize * 1.25)
        role.run(r)
        addChild(role)
        _image = image
        
        let nl = Label()
        nl.text = name
        nl.align = "center"
        nl.position.x = role.size.width * 0.5 + 6
        nl.position.y = role.yAxis - 12 - role.size.height * 0.5
        nl.fontSize = 18
        addChild(nl)
    }
    var _image:SKTexture!
    
    override var selected: Bool {
        set {
            _selected = newValue
            _background.removeFromParent()
            if newValue {
                addChild(_background)
            }
        }
        get {
            return _selected
        }
    }
}
