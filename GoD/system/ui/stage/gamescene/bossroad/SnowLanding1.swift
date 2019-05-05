//
//  SnowLanding1.swift
//  GoD
//
//  Created by kai chen on 2019/1/14.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class SnowLanding1: SnowLanding {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func createGround() {
        
        createMap()
    }
    private let CELL_DOOR = 150
    private let CELL_ROLE = 151
    private let CELL_ROAD = 152
    private let CELL_BOARD = 150
    override func hasAction(cell: Int, touchPoint: CGPoint) -> Bool {
        let point = convertPixelToIndex(x: touchPoint.x, y: touchPoint.y)
        if [CELL_BLOCK,CELL_ROLE,CELL_ROAD,CELL_DOOR].index(of: cell) != nil{
            return true
        }
        return false
    }
    
    override func moveEndAction() {
        let pos = convertPixelToIndex(x: _role.xAxis, y: _role.yAxis)
        let stage = Game.instance.curStage!
        let char = _role!
        if pos.x == 10 && pos.y == 0 {
            let nextScene = ZeroPalace()
            stage.switchScene(next: nextScene, completion: {
                nextScene.setRole(x: nextScene._portalPrev.x, y: nextScene._portalPrev.y, char: char)
            })
        } else if pos.x == 1 && pos.y == 0 {
            showMsg(text: "go bossroad")
        } else if pos.x == 0 && pos.y == 3 {
            showMsg(text: "go bossroad")
        } else if pos.x == 2 && pos.y == 8 {
            let nextScene = MorningPalace()
            stage.switchScene(next: nextScene, completion: {
                nextScene.setRole(x: nextScene._portalPrev.x, y: nextScene._portalPrev.y, char: char)
            })
        } else if pos.x == 9 && pos.y == 11 {
            let nextScene = CenterCamping()
            stage.switchScene(next: nextScene, completion: {
                nextScene.setRole(x: 5, y: 7, char: char)
            })
        } else if pos.x == 3 && pos.y == 6 {
            showMsg(text: "go bossroad")
        } else if pos.x == 2 && pos.y == 10 {
            showMsg(text: "go bossroad")
        }
    }
    override func create() {
        super.create()
        let ms = _mapSet!
        let s = Game.instance.outside_a5.getCell(7, 5)
        let x:CGFloat = 2
        let y:CGFloat = -1
        addGround(x: 4 + x, y: 5 + y, item: ms.thinLeft)
        addGround(x: 5 + x, y: 5 + y, item: ms.thinConnection)
        addGround(x: 6 + x, y: 5 + y, item: ms.thinConnection)
        addGround(x: 7 + x, y: 5 + y, item: SKSpriteNode(texture: s))
        addGround(x: 7 + x, y: 3 + y, item: SKSpriteNode(texture: s))
        addGround(x: 8 + x, y: 5 + y, item: ms.thinConnection)
        addGround(x: 9 + x, y: 5 + y, item: ms.thinConnection)
        addGround(x: 10 + x, y: 5 + y, item: ms.thinRight)
        
        addGround(x: 4 + x, y: 4 + y, item: ms.groundBottomLeft)
        addGround(x: 3 + x, y: 4 + y, item: ms.thinLeft)
        addGround(x: 3 + x, y: 3 + y, item: ms.groundLeftConnection)
        addGround(x: 2 + x, y: 1 + y, item: ms.groundLeftConnection)
        addGround(x: 2 + x, y: 2 + y, item: ms.thinLeft)
        addGround(x: 3 + x, y: 0, item: ms.fullConnection)
        addGround(x: 4 + x, y: 0, item: ms.fullConnection)
        
//        addGround(x: 3, y: 2, item: ms.groundTopLeft)
        addGround(x: 5 + x, y: 1 + y, item: ms.groundLeftConnection)
        addGround(x: 5 + x, y: 2 + y, item: ms.groundLeftConnection)
        addGround(x: 5 + x, y: 3 + y, item: ms.thinLeft)
        addGround(x: 6 + x, y: 3 + y, item: ms.thinConnection)
        
        addGround(x: 8 + x, y: 3 + y, item: ms.thinConnection)
        addGround(x: 9 + x, y: 3 + y, item: ms.thinRight)
        addGround(x: 9 + x, y: 2 + y, item: ms.groundBottomRight)
//        addGround(x: 9 + x, y: 1 + y, item: ms.groundRightConnection)
        addGround(x: 10 + x, y: 2 + y, item: ms.groundRightConnection)
        addGround(x: 0, y: 4, item: ms.thinLeft)
        addGround(x: 1, y: 5, item: ms.groundBottomLeft)
        addGround(x: 1, y: 6, item: ms.thinLeft)
        addGround(x: 2, y: 6, item: ms.thinConnection)
        addGround(x: 3, y: 6, item: ms.thinConnection)
        addGround(x: 4, y: 6, item: ms.thinRight)
        addGround(x: 4, y: 5, item: ms.groundBottomRight)
        addGround(x: 1, y: 10, item: ms.thinLeft)
        addGround(x: 2, y: 10, item: ms.thinConnection)
        addGround(x: 3, y: 10, item: ms.thinRight)
        addGround(x: 3, y: 9, item: ms.groundBottomRight)
//        addGround(x: 8, y: 0, item: ms.fullConnection)
//        addGround(x: 9, y: 0, item: ms.fullConnection)
//        addGround(x: 10, y: 0, item: ms.fullConnection)
        let ob = Game.instance.outside_b
        
        addItem(x: 5, y: 1, item: ob.getNode(8, 4))
//        addItem(x: 9, y: 0, item: ms.fullConnection)
        addItem(x: 8, y: 9, item: ob.getNode(15, 4))
        
        addGround(x: 8, y: 6, item: ob.getNode(11, 4))
        
        addGround(x: 3, y: 6, item: ob.getNode(7, 8))
        addGround(x: 3, y: 7, item: ob.getNode(11, 4))
        
//        addGround(x: 5, y: 3, item: ob.getNode(7, 8))
        addGround(x: 5, y: 4, item: ob.getNode(11, 4))
        
        addGround(x: 2, y: 10, item: ob.getNode(7, 8))
        addGround(x: 2, y: 11, item: ob.getNode(11, 4))
        
        let dy:CGFloat = 0
        addGround(x: 10, y: 0 - dy, item: SKSpriteNode(texture: s))
        addGround(x: 1, y: 0 - dy, item: SKSpriteNode(texture: s))
        addGround(x: 0, y: 3 - dy, item: SKSpriteNode(texture: s))
        addGround(x: 2, y: 8 - dy, item: SKSpriteNode(texture: s))
        addGround(x: 5, y: 0 - dy, item: SKSpriteNode(texture: s), z:MyScene.MAP_LAYER_Z + 12)
        
        
        
        addGround(x: 9, y: 12, item: SKSpriteNode(texture: s))
//        let treePoints:Array<Int> = [
//            7,0,
//            0,0,
//            0,1,
//            2,4,
//            5,1,
//            0,2,
//            2,0,
//        ]
//        var i = 0
//        for _ in 0...treePoints.count / 2 - 1 {
//            let x = treePoints[i]
//            let y = treePoints[i + 1]
//            addItem(x: x.toFloat(), y: y.toFloat(), item: ob.getNode(8, 1, 2, 2), width: 0)
//            i += 2
//        }
        let treePoints1:Array<Int> = [
            0,0,
            3,0,
            3,5,
            1,2,
            4,3,
            0,5,
            4,10,
            7,11,
            4,2,
            10,3,
            1,8,
            0,10,
            11,9,
            9,8,
            12,0,
            12,1,
            12,6,
        ]
        var i = 0
        for _ in 0...treePoints1.count / 2 - 1 {
            let x = treePoints1[i]
            let y = treePoints1[i + 1]
            addItem(x: x.toFloat(), y: y.toFloat(), item: ob.getNode(13, 4, 1, 2))
            i += 2
        }
//        addItem(x: 9, y: 1, item: RoleToppur())
//        let oa2 = Game.instance.outside_a2
//        addGround(x: 3, y: 10, item: oa2.getNode(10, 5, 2, 0.5))
//        addItem(x: 2, y: 10, item: oa4.getNode(10, 9, 1, 2.5))
//        addItem(x: 3, y: 10, item: oa4.getNode(10.5, 9, 1, 2.5))
//        addItem(x: 4, y: 10, item: oa4.getNode(10.5, 9, 1, 2.5))
//        addItem(x: 5, y: 10, item: oa4.getNode(10.5, 9, 1, 2.5))
//        addItem(x: 6, y: 10, item: oa4.getNode(11, 9, 1, 2.5))
//        addGround(x: 8, y: 0, item: ms.thinLeft)
//        addGround(x: 9, y: 0, item: ms.thinConnection)
//        addGround(x: 10, y: 0, item: ms.thinRight)
//        addGround(x: 8, y: -1, item: ms.groundTopLeft)
//        addGround(x: 9, y: -1, item: ms.groundTopConnection)
//        addGround(x: 10, y: -1, item: ms.groundTopRight)
//        addItem(x: 9, y: 0, item: ob.getNode(7, 8))
    }
    
}

class RoleToppur: UIRole {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.texture = SKTexture(imageNamed: "Toppur")
        self.size = CGSize(width: cellSize * 2, height: cellSize * 2)
        _xSize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
