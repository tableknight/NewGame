//
//  SnowLanding4.swift
//  GoD
//
//  Created by kai chen on 2019/1/24.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class SnowLanding4: SnowLanding {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        //        _name = "雪之国"
        //        let oa4 = Game.instance.outside_a4
        //        _mapSet = GroundSets(ground: oa4.getCell(6, 12, 2, 2), wall: oa4.getCell(6, 14, 2, 2))
        _name = "\(super._name) 誓言阶梯"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func createGround() {
        
        createMap()
    }
    private let CELL_ROLE = 151
    override func hasAction(cell: Int, touchPoint: CGPoint) -> Bool {
        let point = convertPixelToIndex(x: touchPoint.x, y: touchPoint.y)
        if [CELL_BLOCK,CELL_ROLE].index(of: cell) != nil{
            return true
        }
        return false
    }
    
    override func moveEndAction() {
        
    }
    override func create() {
        super.create()
        let ms = _mapSet!
        let s = Game.instance.outside_a5.getCell(7, 5)
        let oa4 = Game.instance.outside_a4
        let ob = Game.instance.outside_b
        addGround(x: 3, y: 8, item: oa4.getNode(6, 14))
        for x in 4...8 {
            if x == 6 {
                addGround(x: 6, y: 8, item: SKSpriteNode(texture: s))
                continue
            }
            addGround(x: x.toFloat(), y: 8, item: oa4.getNode(6.5, 14))
        }
        addGround(x: 9, y: 8, item: oa4.getNode(7, 14))
        
        for y in 5...7 {
            addGround(x: 3, y: y.toFloat(), item: oa4.getNode(6, 13.5))
            for x in 4...8 {
                if x == 6 {
                    addGround(x: 6, y: y.toFloat(), item: SKSpriteNode(texture: s))
                    continue
                }
                addGround(x: x.toFloat(), y: y.toFloat(), item: oa4.getNode(6.5, 13.5))
            }
            addGround(x: 9, y: y.toFloat(), item: oa4.getNode(7, 13.5))
        }
        
        addGround(x: 3, y: 4, item: oa4.getNode(6, 13))
        for x in 4...8 {
            addGround(x: x.toFloat(), y: 1, item: ms.groundTopConnection)
            if x == 6 {
                addGround(x: 6, y: 4, item: SKSpriteNode(texture: s))
                continue
            }
            addGround(x: x.toFloat(), y: 4, item: oa4.getNode(6.5, 13))
        }
        addGround(x: 9, y: 4, item: oa4.getNode(7, 13))
        addGround(x: 3, y: 3, item: ms.groundBottomLeft)
        addGround(x: 9, y: 3, item: ms.groundBottomRight)
        addGround(x: 3, y: 2, item: ms.groundLeftConnection)
        addGround(x: 9, y: 2, item: ms.groundRightConnection)
        addGround(x: 3, y: 1, item: ms.groundLeftConnection)
        addGround(x: 9, y: 1, item: ms.groundRightConnection)
        addGround(x: 3, y: 1, item: ms.groundTopLeft)
        addGround(x: 9, y: 1, item: ms.groundTopRight)
//        addGround(x: 5.5, y: 2, item: ms.thinLeft)
//        addGround(x: 6.5, y: 2, item: ms.thinRight)
//        addGround(x: 5.5, y: 1, item: ms.groundBottomLeft)
//        addGround(x: 6.5, y: 1, item: ms.groundBottomRight)
        addGround(x: 4, y: 2, item: SKSpriteNode(texture: s), z:MyScene.MAP_LAYER_Z + 15)
        addGround(x: 0, y: 6, item: ms.groundBottomLeft)
        addGround(x: 0, y: 7, item: ms.thinLeft)
        addGround(x: 1, y: 7, item: ms.thinConnection)
        addGround(x: 2, y: 7, item: ms.thinConnection)
        addGround(x: 12, y: 6, item: ms.groundBottomRight)
        addGround(x: 12, y: 7, item: ms.thinRight)
        addGround(x: 11, y: 7, item: ms.thinConnection)
        addGround(x: 10, y: 7, item: ms.thinConnection)
        addItem(x: 6, y: 1, item: RoleLewis())
        addItem(x: 1, y: 5.25, item: ob.getNode(7, 8))
//        addGround(x: 6, y: 1, item: SKSpriteNode(texture: s), z:MyScene.MAP_LAYER_Z + 15)
    }
    override func addGround(x: CGFloat, y: CGFloat, item: SKSpriteNode, z: CGFloat = -1) {
        super.addGround(x: x, y: y + 0.25 - 2, item: item, z:z)
    }
    
}

class RoleLewis: UIRole {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.texture = SKTexture(imageNamed: "Lewis")
        self.size = CGSize(width: cellSize * 3, height: cellSize * 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


