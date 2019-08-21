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
        _label.text = "抉择：选择角色形象"
        _closeButton.text = "返回"
        _prevButton.text = "上一步"
        _prevButton.isHidden = true
        _nextButton.text = "下一步"
        
        addChild(_listBox)
        _images = [
//            Game.instance.pictureCollabo8_2.getCell(6, 3, 3, 4),
//            Game.instance.pictureActor3.getCell(3, 7, 3, 4),
//            Game.instance.pictureActor1.getCell(0, 7, 3, 4),
//            Game.instance.pictureActor1.getCell(9, 3, 3, 4),
//            Game.instance.picturePeople1.getCell(0, 3, 3, 4),
//            Game.instance.picturePeople1.getCell(3, 3, 3, 4),
//            SKTexture(imageNamed: "role_1"),
//            SKTexture(imageNamed: "role_2"),
//            SKTexture(imageNamed: "role_3"),
//            SKTexture(imageNamed: "role_4"),
//            SKTexture(imageNamed: "role_5"),
//            SKTexture(imageNamed: "role_6"),
//            SKTexture(imageNamed: "role_7"),
//            SKTexture(imageNamed: "role_8")
            "role_1",
            "role_2",
            "role_3",
            "role_4",
            "role_5",
            "role_6",
            "role_7",
            "role_8",
            "role_9",
            "role_10",
            "role_11",
            "role_12",
        ]
        _names = ["塞西", "洛斯利", "莫贝尔", "弑羽", "安瑟玛薇", "狄尔菲" , "夜薇", "伊凡", "露薇雅", "云如海", "梅露露", "兰特西亚"]
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
    var _images = Array<String>()
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
    func create(image:String, name:String) {
        let i = SKTexture(imageNamed: image)
        let images:Array<SKTexture> = [i.getCell(0, 0), i.getCell(1, 0), i.getCell(2, 0)]
//        let i0 = SKAction.setTexture(images[0])
////        let i1 = SKAction.setTexture(images[1])
//        let i2 = SKAction.setTexture(images[2])
//        let wait = SKAction.wait(forDuration: TimeInterval(0.5))
//
//        let squ = SKAction.sequence([i0, wait, i2, wait])
//        let r = SKAction.repeatForever(squ)
        let role = SKSpriteNode()
        role.xAxis = cellSize * 0.75
        role.yAxis = -cellSize * 0.75
        role.texture = images[1]
        role.size = CGSize(width: cellSize * 1.25, height: cellSize * 1.25)
//        role.run(r)
        addChild(role)
        _image = i
        _imgUrl = image
        _name = name
        let nl = Label()
        nl.text = name
        nl.align = "center"
        nl.position.x = role.size.width * 0.5 + 6
        nl.position.y = role.yAxis - 12 - role.size.height * 0.5
        nl.fontSize = 18
        addChild(nl)
    }
    var _image:SKTexture!
    var _imgUrl = ""
    var _name = ""
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
