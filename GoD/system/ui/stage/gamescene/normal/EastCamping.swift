//
//  EastCamping.swift
//  GoD
//
//  Created by kai chen on 2018/12/29.
//  Copyright © 2018年 Chen. All rights reserved.
//


import SpriteKit
class EastCamping: StandScene {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _name = "贝拉姆村·东"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func createGround() {
        let oa4 = Game.instance.outside_a4
        _mapSet = GroundSets(ground: oa4.getCell(2, 12, 2, 2), wall: oa4.getCell(2, 14, 2, 2))
        createMap()
    }
    override func hasAction(cell: Int, touchPoint: CGPoint) -> Bool {
        let point = convertPixelToIndex(x: touchPoint.x, y: touchPoint.y)
        if point.x == 9 && point.y == 4 && cell == CELL_BLOCK {
            let stage = Game.instance.curStage!
            stage.showDialog(img: Game.instance.picturePeople2.getCell(10, 0),
                             text: "需要用船吗？。",
                             name: "船长杰徳")
            stage._curDialog?.addConfirmButton()
            stage._curDialog?._confirmAction = {
                let rp = BlackWaterTown()
                stage.removeDialog(dlg: stage._curDialog!)
                stage.switchScene(next: rp, completion: {
                    rp.setRole(x: 4, y: 4, char: self._role)
                })
            }
            return true
        }
        if [CELL_BLOCK].firstIndex(of: cell) != nil{
            return true
        }
        return false
    }
    
    override func moveEndAction() {
        let pos = convertPixelToIndex(x: _role.position.x, y: _role.position.y)
        if pos.x == 0 && pos.y == 5 {
            let cc = CenterCamping()
            let char = _role!
            Game.instance.curStage.switchScene(next: cc, completion: {
                cc.setRole(x: 12, y: 3, char: char)
//                cc._role.faceWest()
            })
        }
        if pos.x == 5 && pos.y == 2 {
            let cc = MagicHouse()
            let char = _role!
            Game.instance.curStage.switchScene(next: cc, completion: {
                cc.setRole(x: 5, y: 9, char: char)
                //                cc._role.faceWest()
            })
        }
    }
    override func create() {
        super.create()
        let oa1 = Game.instance.outside_a1
        let river = MapSets(coverGround: oa1.getCell(0, 8, 2, 2), thinConnection: oa1.getNode(1, 6))
        let thinLefts:Array<Array<CGFloat>> = [
            [8, 0],
            [8, 1],
            [10, 4],
            [9, 6],
            [11, 9],
        ]
        let bottomLeftCorners:Array<Array<CGFloat>> = [
            [8, 2],
            [9, 3],
            [9, 7],
            [10, 8],
            [11, 10],
            [12, 11]
        ]
        for p in thinLefts {
            addGround(x: p[0], y: p[1], item: river.leftConnection)
        }
        for p in bottomLeftCorners {
            addGround(x: p[0], y: p[1], item: river.bottomLeftCover)
        }

        let fcstart = [9,9,9,10,11,10,10,10,11,12,12]
        for y in 0...fcstart.count - 1 {
            for x in fcstart[y]...12 {
                addGround(x: x.toFloat(), y: y.toFloat(), item: river.fullConnection)
            }
        }
        addGround(x: 9, y: 5, item: river.topLeftCover)
        
//        let p2 = Game.instance.picturePeople2
        addItem(x: 9, y: 4, item: getRoleNode(roleNode: SKTexture(imageNamed: "Jade").getNode(1, 0)))
//        let v = Game.instance.pictureVehicle
        addItem(x: 10, y: 5, item: Boat(), width: 0)
        addItem(x: 0, y: 2, item: House4(), width:0, z: MyScene.MAP_LAYER_Z)
        addItem(x: 1, y: 10, item: MyHouse(), width:0, z: MyScene.MAP_LAYER_Z)
        addItem(x: 6, y: 10, item: MyHouse(), width:0, z: MyScene.MAP_LAYER_Z)
        let oa2 = Game.instance.outside_a2
        let ms = MapSets(coverGround: oa2.getCell(2, 5, 2, 2), thinConnection: oa2.getNode(3, 3))
        
        addGround(x: 0, y: 5, item: ms.thinConnectionH)
        addGround(x: 1, y: 5, item: ms.thinConnectionH)
        addGround(x: 2, y: 5, item: ms.topConnection)
        addGround(x: 3, y: 5, item: ms.fullConnection)
        addGround(x: 4, y: 5, item: ms.fullConnection)
        addGround(x: 4, y: 4, item: ms.topConnection)
        addGround(x: 5, y: 4, item: ms.fullConnection)
        addGround(x: 5, y: 5, item: ms.fullConnection)
        addGround(x: 5, y: 6, item: ms.fullConnection)
        addGround(x: 6, y: 6, item: ms.bottomRightCover)
        addGround(x: 4, y: 6, item: ms.fullConnection)
        addGround(x: 4, y: 7, item: ms.leftConnection)
        addGround(x: 4, y: 8, item: ms.leftConnection)
        addGround(x: 4, y: 9, item: ms.leftConnection)
        addGround(x: 4, y: 10, item: ms.leftConnection)
        addGround(x: 4, y: 11, item: ms.bottomConnection)
        addGround(x: 3, y: 11, item: ms.thinConnectionH)
        addGround(x: 2, y: 11, item: ms.thinLeft)
        addGround(x: 5, y: 11, item: ms.bottomConnection)
        addGround(x: 6, y: 11, item: ms.thinConnectionH)
        addGround(x: 7, y: 11, item: ms.thinConnectionH)
        addGround(x: 8, y: 11, item: ms.thinConnectionH)
        addGround(x: 9, y: 11, item: ms.thinRight)
        addGround(x: 5, y: 7, item: ms.rightConnection)
        addGround(x: 5, y: 8, item: ms.rightConnection)
        addGround(x: 5, y: 9, item: ms.rightConnection)
        addGround(x: 5, y: 10, item: ms.rightConnection)
        addGround(x: 3, y: 6, item: ms.bottomConnection)
        addGround(x: 6, y: 4, item: ms.topRightCover)
        addGround(x: 6, y: 5, item: ms.rightConnection)
        addGround(x: 5, y: 3, item: ms.thinConnectionV)
        addGround(x: 5, y: 2, item: ms.thinTop)
        addGround(x: 3, y: 4, item: ms.topLeftCover)
        addGround(x: 2, y: 6, item: ms.bottomLeftCover)
        
        addItem(x: 2, y: 6, item: TreeTop())
        addItem(x: 3, y: 6, item: TreeTop())
        addItem(x: 6, y: 6, item: TreeTop())
        let house:Array<Array<CGFloat>> = [
            [0, 1],
            [1, 1],
            [2, 1],
            [3, 1],
            [4, 1],
            [5, 1],
            [6, 1],
            [1, 8],
            [2, 8],
            [3, 8],
            [1, 9],
            [2, 9],
            [3, 9],
            [6, 8],
            [7, 8],
            [8, 8],
            [6, 9],
            [7, 9],
            [8, 9],
            [3, 7],
            [6, 7]
        ]
        let treePoint:Array<Array<CGFloat>> = [
            [0, 3],
            [0, 4],
            [3, 4],
            [2, 4],
            [4, 3],
            [0, 10],
//            [4, 5],
            [6, 4],
            [7, 5],
            [7, 6],
            [8, 6],
            [0, 6],
            [1, 6],
            [0, 7],
            [0, 9],
            [4, 8],
            [9, 9],
            [10, 9],
            [9, 8],
            [9 ,11],
            [10, 11],
            [7, 0],
            [8, 0],
            [7, 1],
            [7, 2],
            [1, 11],
        ]
        for a in treePoint {
            addItem(x: a[0], y: a[1], item: TallTree())
        }
        let riverPoint:Array<Array<CGFloat>> = [
            [9,4],
            [9,3],
            [9,5],
            [8,2],
        ]
        let total = house + treePoint + riverPoint
        for p in total {
            _mapMatrix[p[1].toInt()][p[0].toInt()] = CELL_BLOCK
        }
    }
    
}
class Boat:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let t = SKTexture(imageNamed: "boat")
        setTexture(t.getCell(1, 0))
        self.size = CGSize(width: cellSize * 2, height: cellSize * 2.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class TreeTop:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.outside_b.getCell(5, 11))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

