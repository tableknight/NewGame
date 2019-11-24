//
//  Maze.swift
//  GoD
//
//  Created by kai chen on 2019/4/2.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class Maze: Dungeon {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
//        let oa4 = Game.instance.sf_inside_a4
        let o4 = Game.instance.dungeon_a4
        _mapSet = GroundSets(ground: o4.getCell(4, 2, 2, 2), wall: o4.getCell(4, 4, 2, 2))
        _name = "魔王之城"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func createSize() {
        hSize = 12
        vSize = 12
    }
    
    override func create() {
        createSize()
        _nameLabel.text = _name
        createMap()
        createMapMatrix()
        _visiblePoints = findVisiblePoints()
        createWallShadow()
    }
    internal var _fragment = Array<Array<CGFloat>>()
    override func createMapMatrix() {
        let wallTexture = getWallTexture()
        _mapMatrix = []
        for _ in 0...vSize.toInt() {
            var row:Array<Int> = []
            for _ in 0...hSize.toInt() {
                row.append(CELL_EMPTY)
            }
            _mapMatrix.append(row)
        }
        var index = 0
        for y in 0...vSize.toInt() {
            var row:Array<Int> = []
            //            let xd = y / 3 % 2 == 0 ? 0 : 1
            for x in 0...hSize.toInt() {
                if y % 3 == 0 {
                    if x % 3 == 0 {
                        if index < _fragment.count {
                            let landFragment:Array<CGFloat> = _fragment[index]
                            debug("index \(index)")
                            index += 1
                            if landFragment.count > 0 {
                                for i in 0...landFragment.count - 1 {
                                    if i % 2 == 0 {
                                        let x0 = x.toFloat() + landFragment[i]
                                        let y0 = y.toFloat() + landFragment[i + 1]
                                        if x0 <= hSize && y0 <= vSize {
                                            let wall = UIItem()
                                            wall.setTexture(wallTexture)
                                            addWall(x: x0, y: y0, item: wall)
                                            _mapMatrix[y0.toInt()][x0.toInt()] = CELL_ITEM
                                        }
                                    }
                                }
                            }
                        }
                        
                    }
                }
                row.append(CELL_EMPTY)
            }
            _mapMatrix.append(row)
        }
    }
    
    override func getWallTexture() -> SKTexture {
        let node = SKSpriteNode()
        let top = getRoof()
        top.anchorPoint = CGPoint(x: 0.5, y: 0)
        node.addChild(top)
        let btop = Game.instance.inside_a4.getNode(6, 2.5, 1, 0.5)
        btop.anchorPoint = CGPoint(x: 0.5, y: 1)
        node.addChild(btop)
        let bb = Game.instance.inside_a4.getNode(6, 4, 1, 0.5)
        bb.anchorPoint = CGPoint(x: 0.5, y: 1)
        bb.yAxis = -cellSize * 0.5
        node.addChild(bb)
        return node.toTexture()
    }
    
}
