//
//  SnowLanding3.swift
//  GoD
//
//  Created by kai chen on 2019/1/23.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class SnowLanding3: SnowLanding {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        //        _name = "雪之国"
        //        let oa4 = Game.instance.outside_a4
        //        _mapSet = GroundSets(ground: oa4.getCell(6, 12, 2, 2), wall: oa4.getCell(6, 14, 2, 2))
        _name = "\(super._name) 零之阶梯"
        let oa4 = Game.instance.outside_a4
        _mapSet = GroundSets(ground: oa4.getCell(6, 12, 2, 2), wall: oa4.getCell(10, 9, 2, 2))
        
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
//        let ms = _mapSet!
        let oa4 = Game.instance.outside_a4
        let ob = Game.instance.outside_b
        let yd:CGFloat = 0.5
        let ys:Array<CGFloat> = [10, 7, 4, 1]
        for y in ys {
            addGround(x: 0, y: y + yd, item: oa4.getNode(10, 9))
            addItem(x: 0, y: y + yd - 1, item: oa4.getNode(10, 8))
            for x in 0...12 {
                if y == 7 && x == 9 {
                    continue
                }
                if y == 4 && x == 2 {
                    continue
                }
                if y == 1 && (x == 6 || x == 5 || x == 7) {
                    continue
                }
                if x != 0 && x != 12 {
                    addGround(x: x.toFloat(), y: y + yd, item: oa4.getNode(10.5, 9))
                    addItem(x: x.toFloat(), y: y + yd - 1, item: oa4.getNode(10.5, 8))
                }
                addItem(x: x.toFloat(), y: y + yd - 2, item: oa4.getNode(11, 5))
            }
            addGround(x: 12, y: y + yd, item: oa4.getNode(11, 9))
            addItem(x: 12, y: y + yd - 1, item: oa4.getNode(11, 8))
        }
        for x in 0...12 {
            addItem(x: x.toFloat(), y: 11, item: ob.getNode(14, 4))
        }
        addItem(x: 6, y: 1, item: RoleSumahl())
        addItem(x: 6, y: 0, item: Game.instance.outside_a5.getNode(5, 5))
//        var y:CGFloat = 5
//        addGround(x: 1, y: y, item: oa4.getNode(10, 9, 1, 2.5))
//        for x in 1...11 {
//            if x != 15 && x != 6 {
//                if x != 1 && x != 11 {
//                    addGround(x: x.toFloat(), y: y, item: oa4.getNode(10.5, 9, 1, 2))
//                }
//                addGround(x: x.toFloat(), y: y - 2, item: oa4.getNode(11, 5))
//            }
//        }
//        addGround(x: 11, y: y, item: oa4.getNode(11, 9, 1, 2.5))
//
//        y = 1
////        addGround(x: 1, y: y, item: oa4.getNode(10, 9, 1, 2.5))
//        for x in 2...10 {
//            if x != 5 && x != 6 && x != 7 {
//                if x != 1 && x != 11 {
//                    addGround(x: x.toFloat(), y: y, item: oa4.getNode(10.5, 9, 1, 2))
//                }
//                addGround(x: x.toFloat(), y: y - 2, item: oa4.getNode(11, 5))
//            }
//        }
////        addGround(x: 11, y: y, item: oa4.getNode(11, 9, 1, 2.5))
//
//        for y in -1...3 {
//            addGround(x: 1, y: y.toFloat(), item: oa4.getNode(11, 5))
//            addGround(x: 5, y: y.toFloat(), item: oa4.getNode(11, 5))
//            addGround(x: 7, y: y.toFloat(), item: oa4.getNode(11, 5))
//            addGround(x: 11, y: y.toFloat(), item: oa4.getNode(11, 5))
//        }
    }
    
}

class RoleSumahl: UIRole {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.texture = SKTexture(imageNamed: "Sumahl")
        self.size = CGSize(width: cellSize * 3, height: cellSize * 3)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

