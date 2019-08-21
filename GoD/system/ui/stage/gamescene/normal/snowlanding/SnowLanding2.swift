//
//  SnowLanding2.swift
//  GoD
//
//  Created by kai chen on 2019/1/22.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class SnowLanding2: SnowLanding {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        //        _name = "雪之国"
        //        let oa4 = Game.instance.outside_a4
        //        _mapSet = GroundSets(ground: oa4.getCell(6, 12, 2, 2), wall: oa4.getCell(6, 14, 2, 2))
        _name = "\(super._name) 零之阶梯"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func createGround() {
        
        createMap()
    }
    private let CELL_ROLE = 151
    override func hasAction(cell: Int, touchPoint: CGPoint) -> Bool {
//        let point = convertPixelToIndex(x: touchPoint.x, y: touchPoint.y)
        if [CELL_BLOCK,CELL_ROLE].firstIndex(of: cell) != nil{
            return true
        }
        return false
    }
    
    override func moveEndAction() {
        
    }
    override func create() {
        super.create()
        let ms = _mapSet!
//        let s = Game.instance.outside_a5.getCell(7, 5)
        let oa4 = Game.instance.outside_a4
        let ob = Game.instance.outside_b
        addGround(x: 2, y: 7.25, item: oa4.getNode(6, 14, 1, 2))
        addGround(x: 2, y: 5.25, item: ms.groundBottomLeft)
        for x in 3...8 {
            addGround(x: x.toFloat(), y: 7.25, item: oa4.getNode(6.5, 14, 1, 2))
        }
        addGround(x: 9, y: 7.25, item: oa4.getNode(7, 14, 1, 2))
        addGround(x: 9, y: 5.25, item: ms.groundBottomRight)
        
        addGround(x: 4, y: 3.25, item: oa4.getNode(6, 14, 1, 2))
        addGround(x: 4, y: 1.25, item: ms.groundBottomLeft)
        for x in 5...7 {
            addGround(x: x.toFloat(), y: 3.25, item: oa4.getNode(6.5, 14, 1, 2))
        }
        addGround(x: 8, y: 3.25, item: oa4.getNode(7, 14, 1, 2))
        addGround(x: 8, y: 1.25, item: ms.groundBottomRight)
        addGround(x: 6, y: 3.25, item: Game.instance.dungeon_b.getNode(9, 1, 1, 2),z :MyScene.MAP_LAYER_Z + 10)
        let treePoints1:Array<Int> = [
            9,5,
            9,4,
            8,5,
            10,2,
            11,4,
            10,7,
            4,8,
            7,9,
            11,9,
            1,1,
            2,2
        ]
        var i = 0
        for _ in 0...treePoints1.count / 2 - 1 {
            let x = treePoints1[i]
            let y = treePoints1[i + 1]
            addItem(x: x.toFloat(), y: y.toFloat(), item: ob.getNode(13, 4, 1, 2))
            i += 2
        }
        let trackPoints:Array<Int> = [
            2,4,
            2,5,
            3,5,
            4,6,
            5,6,
            6,5,
        ]
        i = 0
        for _ in 0...trackPoints.count / 2 - 1 {
            let x = trackPoints[i]
            let y = trackPoints[i + 1]
            addGround(x: x.toFloat(), y: y.toFloat() - 1, item: ob.getNode(11, 4))
            i += 2
        }
        for x in 1...11 {
            addItem(x: x.toFloat(), y: 0, item: ob.getNode(13, 4, 1, 2))
            addItem(x: x.toFloat(), y: 11, item: ob.getNode(13, 4, 1, 2))
        }
        for y in 0...11 {
            addItem(x: 0, y: y.toFloat(), item: ob.getNode(13, 4, 1, 2))
            addItem(x: 12, y: y.toFloat(), item: ob.getNode(13, 4, 1, 2))
        }
        addItem(x: 6, y: 4, item: RoleMicalu())
    }
    
}

class RoleMicalu: UIRole {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.texture = SKTexture(imageNamed: "Micalu")
        self.size = CGSize(width: cellSize * 2, height: cellSize * 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

