//
//  UIItem.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/2/25.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class UIItem:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    internal func setTexture(_ texture:SKTexture) {
        self.texture = texture
        self.size = texture.size()
    }
    
    var _xSize:Int = 1
    var _ySize:Int = 1
    var _key = ""
    
    func triggerEvent() {
        
    }
    
    private var _speakNode = SKSpriteNode()
    func speak(text:String, autoRemove:Bool = true, duration:CGFloat = 3) {
        let node = SKSpriteNode()
        _speakNode.removeFromParent()
        var width = cellSize * 2.25
        if text.count >= 6 {
            width = width + ((text.count - 6) * 18).toFloat()
        }
        let rect = CGRect(x: -width * 0.5, y: -cellSize * 0.375, width: width, height: cellSize * 0.75)
        let bg = SKShapeNode(rect: rect, cornerRadius: 4)
        bg.fillColor = UIColor.black
        bg.alpha = 0.65
        node.addChild(bg)
        
        let border = SKShapeNode(rect: rect, cornerRadius: 4)
        border.lineWidth = 1
        node.addChild(border)
        
        let l = Label()
        l.fontSize = 18
        l.fontColor = UIColor.white
        l.align = "center"
        l.position.y = 9
        l.text = text
        node.addChild(l)
        
        node.zPosition = MyScene.UI_LAYER_Z + 100
        node.position.y = cellSize * 1.5
        addChild(node)
        if autoRemove {
            setTimeout(delay: duration, completion: {
                node.removeFromParent()
            })
        }
        _speakNode = node
    }
    
    func removeSpeak() {
        _speakNode.removeFromParent()
    }
}

class PortalNext:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.tilesets.getCell(5, 2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func triggerEvent() {
//        let stage = Data.instance.stage!
//        let index = stage._curScene._index
//        let nextIndex = index + 1
//        var nextScene = UIScene()
//        var exist = false
//        for scn in stage._scenes {
//            if scn._index == nextIndex {
//                nextScene = scn
//                exist = true
//                break
//            }
//        }
//        if !exist {
//            nextScene = stage.getSceneById(id: stage._curScene._id)
//            nextScene.create()
//            nextScene._index = nextIndex
//            stage._scenes.append(nextScene)
//        }
//        stage.switchScene(next: nextScene)
    }
}
class PortalFinal:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.tilesets.getCell(0, 1, 1, 2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class PortalPrev:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let s = Game.instance.tilesets
        let t = s.getCell(6, 2)
        setTexture(t)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func triggerEvent() {
    }
}

