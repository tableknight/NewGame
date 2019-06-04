//
//  exts.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/1/20.
//  Copyright © 2018年 Chen. All rights reserved.
//
import SpriteKit
extension CGFloat {
    func toInt() -> Int {
        return Int(self)
    }
}
extension Int {
    func toFloat() -> CGFloat {
        return CGFloat(self)
    }
}

extension Array {
    func one() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
    
    
}
extension UIPanel {
    override var cellSize:CGFloat {
        get {
            return Game.CELLSIZE
        }
    }
}
extension Button {
    override var cellSize:CGFloat {
        get {
            return Game.CELLSIZE
        }
    }
}
extension RectButton {
    override var cellSize:CGFloat {
        get {
            return Game.CELLSIZE
        }
    }
}
extension AttrLabel {
    override var cellSize:CGFloat {
        get {
            return Game.CELLSIZE
        }
    }
}
extension SeatNode {
    override var cellSize:CGFloat {
        get {
            return Game.CELLSIZE
        }
    }
}
extension Icon {
    override var cellSize:CGFloat {
        get {
            return Game.CELLSIZE
        }
    }
}
extension SelectableComponent {
    override var cellSize:CGFloat {
        get {
            return Game.CELLSIZE
        }
    }
}
extension ItemInfo {
    override var cellSize:CGFloat {
        get {
            return Game.CELLSIZE
        }
    }
}
extension SpellInfo {
    override var cellSize:CGFloat {
        get {
            return Game.CELLSIZE
        }
    }
}
extension MyStage {
    override var cellSize:CGFloat {
        get {
            return Game.CELLSIZE
        }
    }
}
extension MinionComponent {
    override var cellSize:CGFloat {
        get {
            return Game.CELLSIZE
        }
    }
}
extension Battle {
    override var cellSize:CGFloat {
        get {
            return Game.CELLSIZE
        }
    }
}
extension BUnit {
    override var cellSize:CGFloat {
        get {
            return Game.CELLSIZE
        }
    }
}

extension SKSpriteNode {
    var left:CGFloat {
        set {
            position.x = -cellSize * 7 + newValue
        }
        get {
            return position.x - cellSize * 7
        }
    }
    
    var top:CGFloat {
        set {
            position.y = cellSize * 4 - newValue
        }
        get {
            return position.y + cellSize * 4
        }
    }
    @objc var cellSize:CGFloat {
        get {
            return Game.instance.cellSize
        }
    }
    
    func seed(min:Int = 0, max:Int = 100) -> Int {
        return Int(arc4random_uniform(UInt32(max - min))) + min
    }
    func seedFloat(min:Int = 0, max:Int = 101) -> CGFloat {
        return CGFloat(Int(arc4random_uniform(UInt32(max - min))) + min)
    }
    func toTexture() -> SKTexture {
        let view = SKView()
        return view.texture(from: self)!
    }
    func show() {
        self.isHidden = false
    }
    func hide() {
        self.isHidden = true
    }
    var visible: Bool {
        get {
            return !self.isHidden
        }
    }
}

extension SKTexture {
    func getCell(_ x:CGFloat, _ y:CGFloat, _ wSize:CGFloat = 1, _ hSize:CGFloat = 1) -> SKTexture {
//        let cellSize = Game.instance.cellSize
        let realSize:CGFloat = Game.instance.cellSize
        var cellSize:CGFloat = 48
        if realSize != cellSize {
            let tnode = SKSpriteNode(texture: self)
            let xw = tnode.size.width.toInt() % realSize.toInt()
            if xw == 0 {
                cellSize = realSize
            }
        }
//        if self.size().width % 64 == 0 {
//
//        }
        let w = size().width
        let h = size().height
        let _y = h / cellSize - y - 1
        let width = cellSize / w
        let height = cellSize / h
        
        let rect = CGRect(x: x * width, y: _y * height, width: width * wSize, height: height * hSize)
//        let rect = CGRect(x: 1 / 3, y: 1 / 4, width: 1 / 3, height: 1 / 4)
        let node = SKSpriteNode(texture: SKTexture(rect: rect, in: self))
        node.size = CGSize(width: realSize * wSize, height: realSize * hSize)
//        node.size.width = cellSize * 1.5
//        node.size.height = cellSize * 1.5
        let view = SKView()
        return view.texture(from: node)!
    }
    func getNode(_ x:CGFloat, _ y:CGFloat, _ wSize:CGFloat = 1, _ hSize:CGFloat = 1) -> SKSpriteNode {
        let realSize:CGFloat = Game.instance.cellSize
        var cellSize:CGFloat = 48
        if realSize != cellSize {
            let tnode = SKSpriteNode(texture: self)
            let xw = tnode.size.width.toInt() % realSize.toInt()
            if xw == 0 {
                cellSize = realSize
            }
        }
//        let cellSize = Game.instance.cellSize
        let w = size().width
        let h = size().height
        let _y = h / cellSize - y - 1
        let width = cellSize / w
        let height = cellSize / h
        
        let rect = CGRect(x: x * width, y: _y * height, width: width * wSize, height: height * hSize)
        //        let rect = CGRect(x: 1 / 3, y: 1 / 4, width: 1 / 3, height: 1 / 4)
        let node = SKSpriteNode(texture: SKTexture(rect: rect, in: self))
        node.size = CGSize(width: realSize * wSize, height: realSize * hSize)
//        node.size = CGSize(width: 48, height: 48)
//        node.size.width = cellSize * 1.5 * wSize
//        node.size.height = cellSize * 1.5 * hSize
//        if hSize > 1 {
//            node.anchorPoint = CGPoint(x: 0.5, y: 0)
//        }
//        let view = SKView()
//        return view.texture(from: node)!
        return node
    }
}
