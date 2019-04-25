//
//  NorthCanmping.swift
//  GoD
//
//  Created by kai chen on 2019/1/13.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class NorthCamping: StandScene {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _name = "贝拉姆村·北"
        let oa4 = Game.instance.outside_a4
        _mapSet = GroundSets(ground: oa4.getCell(2, 12, 2, 2), wall: oa4.getCell(2, 14, 2, 2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func createGround() {
        createMap()
    }
    override func hasAction(cell: Int, touchPoint: CGPoint) -> Bool {
        let point = convertPixelToIndex(x: touchPoint.x, y: touchPoint.y)
        if CELL_ITEM == cell {
            return true
        }
        return false
    }
    
    override func moveEndAction() {
        let pos = convertPixelToIndex(x: _role.position.x, y: _role.position.y)
        if pos.x == 10 && pos.y == 11 {
            let cc = CenterCamping()
            let char = _role!
            Game.instance.curStage.switchScene(next: cc, afterCreation: {
                cc.setRole(x: 8, y: 0, char: char)
                //                cc._role.faceWest()
                char.faceSouth()
            }, completion: {})
        }
    }
    override func create() {
        super.create()
        addItem(x: 0, y: 6, item: HouseChurch(), width: 0, z:MyScene.ITEM_LAYER_Z)
        for x in 0...7 {
            if x != 3 {
                addItem(x: x.toFloat(), y: 0, item: Game.instance.outside_b.getNode(6, 9))
            }
            if x != 6 {
                addItem(x: x.toFloat(), y: 1, item: Game.instance.outside_b.getNode(6, 9))
            }
            addItem(x: x.toFloat(), y: 2, item: Game.instance.outside_b.getNode(6, 9))
        }
        let ic = Game.instance.inside_c
        addItem(x: 8, y: 2, item: ic.getNode(8, 15, 1, 3))
        addItem(x: 7, y: 3, item: ic.getNode(8, 12, 2, 1), width:0)
        addItem(x: 9, y: 3, item: ic.getNode(9, 12, 1, 1), width:0)
        addItem(x: 10, y: 3, item: ic.getNode(9, 12, 1, 1), width:0)
        addItem(x: 11, y: 3, item: ic.getNode(9, 12, 2, 1), width:0)
        let treePoint:Array<Array<CGFloat>> = [
            [3, 0],
            [6, 1],
            //            [10, 2],
            [9, 1],
            [10, 0],
            [10, 1],
            [7, 4],
            [7, 5],
            [8, 5],
            [6, 3],
            [6, 4],
            [6, 5],
            [0, 7],
            [3, 6],
            [4, 7],
            [5, 7],
            [6, 8],
            [8, 8],
            [10, 6],
            [10, 5],
            [2, 9],
            [3, 9],
            [5, 10],
            [9, 2],
            [10, 2],
            [11, 2],
            [11, 9],
            [0, 11],
            [1, 11],
            [2, 11],
            [0, 10],
            [11, 10],
            [11, 11],
            [12, 11],
        ]
        for a in treePoint {
            addItem(x: a[0], y: a[1], item: TallTree())
        }
        let oa2 = Game.instance.outside_a2
        let ground = oa2.getCell(2, 5, 2, 2)
        let ms = MapSets(coverGround: ground, thinConnection: oa2.getNode(3, 3))
        addGround(x: 1, y: 7, item: ms.topLeftCover)
        addGround(x: 2, y: 7, item: ms.topConnection)
        addGround(x: 3, y: 7, item: ms.topRightCover)
        addGround(x: 1, y: 8, item: ms.bottomLeftCover)
        addGround(x: 2, y: 8, item: ms.bottomConnection)
        addGround(x: 3, y: 8, item: ms.fullConnection)
        addGround(x: 3, y: 9, item: ms.bottomLeftCover)
        addGround(x: 4, y: 9, item: ground.getNode(0.5, 1, 1, 2))
        addGround(x: 5, y: 8, item: ms.topRightCover)
        addGround(x: 5, y: 9, item: ms.bottomConnection)
        
        addGround(x: 7, y: 6, item: ms.topLeftCover)
        addGround(x: 9, y: 5, item: ms.thinConnectionV)
        addGround(x: 9, y: 4, item: ms.leftConnection)
        addGround(x: 9, y: 3, item: ms.topLeftCover)
        addGround(x: 9, y: 6, item: ms.rightConnection)
        addGround(x: 10, y: 4, item: ground.getNode(0.5, 1, 1, 2))
        addGround(x: 11, y: 4, item: ground.getNode(0.5, 1, 1, 2))
        addGround(x: 12, y: 4, item: ground.getNode(1, 1, 1, 2))
        
        addGround(x: 8, y: 6, item: ms.topConnection)
        addGround(x: 7, y: 7, item: ms.leftConnection)
        addGround(x: 7, y: 8, item: ms.thinBottom)
        addGround(x: 8, y: 7, item: ms.bottomConnection)
        addGround(x: 9, y: 7, item: ms.fullConnection)
        addGround(x: 9, y: 8, item: ms.bottomLeftCover)
        addGround(x: 10, y: 8, item: ms.fullConnection)
        addGround(x: 10, y: 7, item: ms.topConnection)
        addGround(x: 11, y: 7, item: ms.topRightCover)
        addGround(x: 11, y: 8, item: ms.bottomRightCover)
        
        addGround(x: 6, y: 9, item: ms.topConnection)
        addGround(x: 6, y: 10, item: ms.bottomLeftCover)
        addGround(x: 7, y: 10, item: ground.getNode(0.5, 1, 1, 2))
        addGround(x: 8, y: 10, item: ground.getNode(0.5, 1, 1, 2))
        addGround(x: 9, y: 10, item: ground.getNode(0.5, 1, 1, 2))
        addGround(x: 10, y: 10, item: ms.rightConnection)
        addGround(x: 10, y: 11, item: ms.thinConnectionV)
        addGround(x: 10, y: 9, item: ms.rightConnection)
        let itemPoints:Array<Array<CGFloat>> = [
            [1,6],
            [2,6],
            [4,5],
            [5,5],
            [8,3],
            [9,3],
            [10,3],
            [11,3],
            [12,3],
            ]
        let total = treePoint + itemPoints
        for p in total {
            _mapMatrix[p[1].toInt()][p[0].toInt()] = CELL_ITEM
        }
    }
}
