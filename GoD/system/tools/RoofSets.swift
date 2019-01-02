//
//  RoofSets.swift
//  GoD
//
//  Created by kai chen on 2019/1/1.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class roofSets:Core {
    var _t:SKTexture!
    var _corner:SKTexture!
    private var cellSize:CGFloat = 48
    init(texture:SKTexture = Game.instance.inside_a4.getCell(4, 7, 2, 2), corner:SKTexture = Game.instance.inside_a4.getCell(5, 5)) {
        _t = texture
        _corner = corner
    }
    
    var roofConnectH:SKSpriteNode {
        get {
            let t = _t.getNode(0.5, -0.5, 1, 0.5)
            let b = _t.getNode(0.5, 1, 1, 0.5)
            t.anchorPoint = CGPoint(x: 0.5, y: 0)
            b.anchorPoint = CGPoint(x: 0.5, y: 1)
            t.yAxis = cellSize * 0.5
            b.yAxis = t.yAxis
            let node = SKSpriteNode()
            node.addChild(t)
            node.addChild(b)
            return node
        }
    }
    var leftEnd:SKSpriteNode {
        get {
            let t = _t.getNode(1, -0.5, 1, 0.5)
            let b = _t.getNode(1, 1, 1, 0.5)
            t.anchorPoint = CGPoint(x: 0.5, y: 0)
            b.anchorPoint = CGPoint(x: 0.5, y: 1)
            t.yAxis = cellSize * 0.5
            b.yAxis = t.yAxis
            let node = SKSpriteNode()
            node.addChild(t)
            node.addChild(b)
            return node
        }
    }
    var rightEnd:SKSpriteNode {
        get {
            let t = _t.getNode(0, -0.5, 1, 0.5)
            let b = _t.getNode(0, 1, 1, 0.5)
            t.anchorPoint = CGPoint(x: 0.5, y: 0)
            b.anchorPoint = CGPoint(x: 0.5, y: 1)
            t.yAxis = cellSize * 0.5
            b.yAxis = t.yAxis
            let node = SKSpriteNode()
            node.addChild(t)
            node.addChild(b)
            return node
        }
    }
    var roofConnectV:SKSpriteNode {
        get {
            let l = _t.getNode(0, 0.5, 0.5, 1)
            let r = _t.getNode(1.5, 0.5, 0.5, 1)
            l.anchorPoint = CGPoint(x: 1, y: 0)
            r.anchorPoint = CGPoint(x: 0, y: 0)
            let node = SKSpriteNode()
            node.addChild(l)
            node.addChild(r)
            return node
        }
    }
    var topLeftCorner:SKSpriteNode {
        get {
            let node = _t.getNode(0, 0)
            let corner = _corner.getNode(0.5, 0, 0.5, 0.5)
            corner.anchorPoint = CGPoint(x: 0, y: 1)
            corner.zPosition = node.zPosition + 1
            node.addChild(corner)
            return node
        }
    }
    var topRightCorner:SKSpriteNode {
        get {
            let node = _t.getNode(1, 0)
            let corner = _corner.getNode(0, 0, 0.5, 0.5)
            corner.anchorPoint = CGPoint(x: 1, y: 1)
            corner.zPosition = node.zPosition + 1
            node.addChild(corner)
            return node
        }
    }
    var bottomLeftCorner:SKSpriteNode {
        get {
            let node = _t.getNode(0, 1)
            let corner = _corner.getNode(0.5, -0.5, 0.5, 0.5)
            corner.anchorPoint = CGPoint(x: 0, y: 0)
            corner.zPosition = node.zPosition + 1
            node.addChild(corner)
            return node
        }
    }
    var bottomRightCorner:SKSpriteNode {
        get {
            let node = _t.getNode(1, 1)
            let corner = _corner.getNode(0, -0.5, 0.5, 0.5)
            corner.anchorPoint = CGPoint(x: 1, y: 0)
            corner.zPosition = node.zPosition + 1
            node.addChild(corner)
            return node
        }
    }
    func getCombinationH(x1:CGFloat, y1:CGFloat, x2:CGFloat, y2:CGFloat) -> SKSpriteNode {
        let l = _t.getNode(x1, y1, 0.5, 1)
        let r = _t.getNode(x2, y2, 0.5, 1)
        l.anchorPoint = CGPoint(x: 1, y: 0)
        r.anchorPoint = CGPoint(x: 0, y: 0)
        let node = SKSpriteNode()
        node.addChild(l)
        node.addChild(r)
        return node
    }
    func getCombinationV(x1:CGFloat, y1:CGFloat, x2:CGFloat, y2:CGFloat) -> SKSpriteNode {
        let t = _t.getNode(x1, y1, 1, 0.5)
        let b = _t.getNode(x2, y2, 1, 0.5)
        t.anchorPoint = CGPoint(x: 0.5, y: 0)
        b.anchorPoint = CGPoint(x: 0.5, y: 1)
        t.yAxis = cellSize * 0.5
        b.yAxis = t.yAxis
        //        b.yAxis = 0
        let node = SKSpriteNode()
        node.addChild(t)
        node.addChild(b)
        //        node.color = UIColor.red
        //        node.size = CGSize(width: cellSize, height: cellSize)
        return node
    }
}
