//
//  MapSets.swift
//  GoD
//
//  Created by kai chen on 2018/12/25.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class MapSets: Core {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    private var _baseGround:SKTexture!
    private var _coverGround:SKTexture!
    var thinConnection:SKSpriteNode!
    private var cellSize:CGFloat = 48
    init(coverGround:SKTexture, thinConnection:SKSpriteNode) {
        _coverGround = coverGround
        self.thinConnection = thinConnection
        super.init()
    }
    var topLeftCover:SKSpriteNode {
        get {
            return _coverGround.getNode(0, 0)
        }
    }
    var topRightCover:SKSpriteNode {
        get {
            return _coverGround.getNode(1, 0)
        }
    }
    var bottomLeftCover:SKSpriteNode {
        get {
            return _coverGround.getNode(0, 1)
        }
    }
    var bottomRightCover:SKSpriteNode {
        get {
            return _coverGround.getNode(1, 1)
        }
    }
    var thinTop:SKSpriteNode {
        get {
            return getCombinationH(x1: 0, y1: 0, x2: 1.5, y2: 0)
        }
    }
    var thinConnectionV:SKSpriteNode {
        get {
            return getCombinationH(x1: 0, y1: 0.5, x2: 1.5, y2: 0.5)
        }
    }
    var thinBottom:SKSpriteNode {
        get {
            return getCombinationH(x1: 0, y1: 1, x2: 1.5, y2: 1)
        }
    }
    
    var thinConnectionH:SKSpriteNode {
        get {
            return getCombinationV(x1: 0.5, y1: -0.5, x2: 0.5, y2: 1)
        }
    }
    var thinRight:SKSpriteNode {
        get {
            return getCombinationV(x1: 1, y1: -0.5, x2: 1, y2: 1)
        }
    }
    
    var thinLeft:SKSpriteNode {
        get {
            return getCombinationV(x1: 0, y1: -0.5, x2: 0, y2: 1)
        }
    }
    
    var leftConnection:SKSpriteNode {
        get {
            return _coverGround.getNode(0, 0.5)
        }
    }
    
    var rightConnection:SKSpriteNode {
        get {
            return _coverGround.getNode(1, 0.5)
        }
    }
    
    var topConnection:SKSpriteNode {
        get {
            return _coverGround.getNode(0.5, 0)
        }
    }
    
    var bottomConnection:SKSpriteNode {
        get {
            return _coverGround.getNode(0.5, 1)
        }
    }
    
    var fullConnection:SKSpriteNode {
        get {
            return _coverGround.getNode(0.5, 0.5)
        }
    }
    
    func getCombinationH(x1:CGFloat, y1:CGFloat, x2:CGFloat, y2:CGFloat) -> SKSpriteNode {
        let l = _coverGround.getNode(x1, y1, 0.5, 1)
        let r = _coverGround.getNode(x2, y2, 0.5, 1)
        l.anchorPoint = CGPoint(x: 1, y: 0)
        r.anchorPoint = CGPoint(x: 0, y: 0)
        let node = SKSpriteNode()
        node.addChild(l)
        node.addChild(r)
        return node
    }
    func getCombinationV(x1:CGFloat, y1:CGFloat, x2:CGFloat, y2:CGFloat) -> SKSpriteNode {
        let t = _coverGround.getNode(x1, y1, 1, 0.5)
        let b = _coverGround.getNode(x2, y2, 1, 0.5)
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
