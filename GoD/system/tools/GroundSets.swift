//
//  GroundSets.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/2/23.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class GroundSets: Core {
    var _ground:SKTexture = SKTexture()
    var _wall:SKTexture = SKTexture()
    private var _gs = SKTexture()
    private var _gc = SKTexture()
    private var _ge = SKTexture()
    var __gs = SKTexture()
    var __gc = SKTexture()
    var __ge = SKTexture()
    init(ground:SKTexture, wall:SKTexture) {
        super.init()
        _ground = ground
        _wall = wall
//        let cs = Game.instance.cellSize
//        let w = SKSpriteNode()
//        w.size = CGSize(width: cs, height: cs)
//        w.addChild()
//        SKSpriteNode(texture: wall.getCell(0, 0, 2, 0.5))
//        let cs = Game.instance.cellSize
//        var top = SKSpriteNode(texture: ground.getCell(0, 0))
//        var middle = SKSpriteNode(texture: ground.getCell(0, 0.5))
//        var bottom = SKSpriteNode(texture: ground.getCell(0, 1))
//        let gs = SKSpriteNode()
//        top.position.y = cs
//        bottom.position.y = -cs
//        gs.addChild(top)
//        gs.addChild(middle)
//        gs.addChild(bottom)
//        _gs = gs.toTexture()
//
//        top = SKSpriteNode(texture: ground.getCell(0.5, 0))
//        middle = SKSpriteNode(texture: ground.getCell(0.5, 0.5))
//        bottom = SKSpriteNode(texture: ground.getCell(0.5, 1))
//        let gc = SKSpriteNode()
//        top.position.y = cs
//        bottom.position.y = -cs
//        gc.addChild(top)
//        gc.addChild(middle)
//        gc.addChild(bottom)
//        _gc = gc.toTexture()
//
//        top = SKSpriteNode(texture: ground.getCell(1, 0))
//        middle = SKSpriteNode(texture: ground.getCell(1, 0.5))
//        bottom = SKSpriteNode(texture: ground.getCell(1, 1))
//        let ge = SKSpriteNode()
//        top.position.y = cs
//        bottom.position.y = -cs
//        ge.addChild(top)
//        ge.addChild(middle)
//        ge.addChild(bottom)
//        _ge = ge.toTexture()
//
//        __gs = gStart()
//        __gc = gConnect()
//        __ge = gEnd()
//
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    func groundStart(_ size:Int = 3) -> SKTexture {
        if size == 2 {
            return _ground.getCell(0, 1, 1, 2)
        }
        return _gs
    }
    
    func groundConnect(_ size:Int = 3) -> SKTexture {
        if size == 2 {
            return _ground.getCell(0.5, 1, 1, 2)
        }
        return _gc
    }
    
    func groundEnd(_ size:Int = 3) -> SKTexture {
        if size == 2 {
            return _ground.getCell(1, 1, 1, 2)
        }
        return _ge
    }
    
    func wallStart() -> SKTexture {
        return _wall.getCell(0, 1, 1, 2)
    }
    
    func wallConnect() -> SKTexture {
        return _wall.getCell(0.5, 1, 1, 2)
    }
    
    func wallEnd() -> SKTexture {
        return _wall.getCell(1, 1, 1, 2)
    }
    func getWallPart(part:String) -> SKSpriteNode {
        var partPos:CGFloat = 0
        if part == "connect" {
            partPos = 0.5
        }
        if part == "end" {
            partPos = 1
        }
//        let wall = _wall
        let node = _wall.getNode(partPos, 1, 1, 2)
//        let nodeTop = _wall.getNode(partPos, -0.5, 1, 0.5)
//        nodeTop.anchorPoint = CGPoint(x: 0.5, y: 0)
//        node.addChild(nodeTop)
        return node
    }
    var groundHeight:CGFloat = 5
    var startTopPos: Int = 8
    func gStart() -> SKTexture {
        let cs = Game.instance.cellSize
        let top = SKSpriteNode(texture: _ground.getCell(0, 0))
        let bottom = SKSpriteNode(texture: _ground.getCell(0, 1))
        let gs = SKSpriteNode()
        top.position.y = cs * groundHeight
        bottom.position.y = -cs * groundHeight
        gs.addChild(top)
        
        for _ in 0...groundHeight.toInt() {
//            let middle = SKSpriteNode(texture: _ground.getCell(0, 0.5))
//            middle.position.y = (groundHeight - 6 - i).toFloat() * cs
//            gs.addChild(middle)
            
        }
        gs.addChild(bottom)
        
        return gs.toTexture()
    }
    func getMapPart(part:String) -> SKSpriteNode {
        var partPos:CGFloat = 0
        if part == "connect" {
            partPos = 0.5
        }
        if part == "end" {
            partPos = 1
        }
        let cs = Game.instance.cellSize
        let top = _ground.getNode(partPos, 0)
        let bottom = _ground.getNode(partPos, 1)
        let gs = SKSpriteNode()
        top.position.y = cs * (groundHeight - 1)
        bottom.position.y = -cs * groundHeight
        gs.addChild(top)
        let gh = groundHeight.toInt()
        for i in (-gh + 1)...gh - 2 {
            let middle = _ground.getNode(partPos, 0.5)
            middle.position.y = i.toFloat() * cs
            gs.addChild(middle)
            
        }
        gs.addChild(bottom)
        
        return gs
    }
    func mapStart() -> SKSpriteNode {
        let cs = Game.instance.cellSize * 1.5
        let top = _ground.getNode(0, 0)
        let bottom = _ground.getNode(0, 1)
        let gs = SKSpriteNode()
        top.position.y = cs * groundHeight
        bottom.position.y = -cs * groundHeight
        gs.addChild(top)
        let gh = groundHeight.toInt()
        for i in (-gh + 1)...gh - 1 {
            let middle = _ground.getNode(0, 0.5)
            middle.position.y = i.toFloat() * cs
            gs.addChild(middle)
            
        }
        gs.addChild(bottom)
        
        return gs
    }
    func mapConnect() -> SKSpriteNode {
        let cs = Game.instance.cellSize
        let top = _ground.getNode(0.5, 0)
        let bottom = _ground.getNode(0.5, 1)
        let gs = SKSpriteNode()
        top.position.y = cs * groundHeight
        bottom.position.y = -cs * groundHeight
        gs.addChild(top)
        let gh = groundHeight.toInt()
        for i in (-gh + 1)...gh - 1 {
            let middle = _ground.getNode(0.5, 0.5)
            middle.position.y = i.toFloat() * cs
            gs.addChild(middle)
            
        }
        gs.addChild(bottom)
        
        return gs
    }
    func mapEnd() -> SKSpriteNode {
        let cs = Game.instance.cellSize
        let top = _ground.getNode(0.5, 0)
        let bottom = _ground.getNode(0.5, 1)
        let gs = SKSpriteNode()
        top.position.y = cs * groundHeight
        bottom.position.y = -cs * groundHeight
        gs.addChild(top)
        let gh = groundHeight.toInt()
        for i in (-gh + 1)...gh - 1 {
            let middle = _ground.getNode(0.5, 0.5)
            middle.position.y = i.toFloat() * cs
            gs.addChild(middle)
            
        }
        gs.addChild(bottom)
        
        return gs
    }
    
    func gConnect() -> SKTexture {
        let cs = Game.instance.cellSize
        let top = SKSpriteNode(texture: _ground.getCell(0.5, 0))
        top.position.x = -cs * 2
        let bottom = SKSpriteNode(texture: _ground.getCell(0.5, 1))
        bottom.position.x = -cs * 2
        let gs = SKSpriteNode()
//        top.position.y = cs * (groundHeight - 1).toFloat()
//        bottom.position.y = -cs * (groundHeight - 2).toFloat()
        gs.addChild(top)
//        for i in 0...groundHeight {
//            let middle = SKSpriteNode(texture: _ground.getCell(0.5, 0.5))
//            middle.position.y = (3 - i).toFloat() * cs
//            gs.addChild(middle)
//
//        }
        gs.addChild(bottom)

        return gs.toTexture()
    }
    
    func gEnd() -> SKTexture {
//        let cs = Game.instance.cellSize
        let top = SKSpriteNode(texture: _ground.getCell(1, 0))
        let bottom = SKSpriteNode(texture: _ground.getCell(1, 1))
        let gs = SKSpriteNode()
//        top.position.y = cs * (groundHeight - 1).toFloat()
//        bottom.position.y = -cs * (groundHeight - 2).toFloat()
        gs.addChild(top)
//        for i in 0...groundHeight {
//            let middle = SKSpriteNode(texture: _ground.getCell(1, 0.5))
//            middle.position.y = (3 - i).toFloat() * cs
//            gs.addChild(middle)
//
//        }
        gs.addChild(bottom)

        return gs.toTexture()
    }
    var cellSize:CGFloat = 48
    func getCombinationV(x1:CGFloat, y1:CGFloat, x2:CGFloat, y2:CGFloat) -> SKSpriteNode {
        let t = _wall.getNode(x1, y1, 1, 0.5)
        let b = _wall.getNode(x2, y2, 1, 0.5)
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
    var thinConnection:SKSpriteNode {
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
    var groundBottomLeft:SKSpriteNode {
        get {
            return _ground.getNode(0, 1)
        }
    }
    var groundTopLeft:SKSpriteNode {
        get {
            return _ground.getNode(0, 0)
        }
    }
    var groundLeftConnection:SKSpriteNode {
        get {
            return _ground.getNode(0, 0.5)
        }
    }
    var groundTopConnection:SKSpriteNode {
        get {
            return _ground.getNode(0.5, 0)
        }
    }
    var groundTopRight:SKSpriteNode {
        get {
            return _ground.getNode(1, 0)
        }
    }
    var groundRightConnection:SKSpriteNode {
        get {
            return _ground.getNode(1, 0.5)
        }
    }
    var groundBottomRight:SKSpriteNode {
        get {
            return _ground.getNode(1, 1)
        }
    }
    var fullConnection:SKSpriteNode {
        get {
            return _ground.getNode(0.5, 0.5)
        }
    }
}

