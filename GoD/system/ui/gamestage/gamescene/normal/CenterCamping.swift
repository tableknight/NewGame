//
//  CenterCamping.swift
//  GoD
//
//  Created by kai chen on 2018/12/23.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class CenterCamping: StandScene {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _name = "贝拉姆村·南"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func createGround() {
        let oa4 = Game.instance.outside_a4
        _mapSet = GroundSets(ground: oa4.getCell(2, 12, 2, 2), wall: oa4.getCell(2, 14, 2, 2))
        createMap()
    }
    private let CELL_DOOR = 150
    private let CELL_ROLE = 151
    private let CELL_ROAD = 152
    private let CELL_BOARD = 150
    override func hasAction(cell: Int, touchPoint: CGPoint) -> Bool {
        let point = convertPixelToIndex(x: touchPoint.x, y: touchPoint.y)
        
        if point.x == 3 && point.y == 2 && cell == CELL_DOOR {
            showMsg(text: "house1")
            return true
        }
        if point.x == 10 && point.y == 8 && cell == CELL_DOOR {
            showMsg(text: "house1")
            return true
        }
        if (point.x == 4 || point.x == 5) && point.y == 6 && cell == CELL_ROAD {
//            showMsg(text: "road")
            let rp = AcientRoadSelection()
            rp.create()
            Game.instance.curStage.showPanel(rp)
            return true
        }
        if point.x == 4 && point.y == 7 && cell == CELL_ROLE {
            let stage = Game.instance.curStage!
            stage.showDialog(img: Game.instance.pictureActor3.getCell(7, 4),
                                     text: "这里是前往神域的唯一入口，通过100层远古试炼，就可以进去神域，升入神格.........不过，我建议你放弃。",
                                     name: "神官苏维亚")
            stage._curDialog?.addConfirmButton()
            stage._curDialog?._confirmAction = {
                let rp = AcientRoadSelection()
                rp.create()
                stage.removeDialog(dlg: stage._curDialog!)
                stage.showPanel(rp)
            }
            return true
        }
        let hb1 = getNextCellItem(x: 4, y: 3)
        if hb1.contains(touchPoint) && cell == CELL_BOARD {
            hb1.triggerEvent()
            return true
        }
        let hb2 = getNextCellItem(x: 11, y: 9)
        if hb2.contains(touchPoint) && cell == CELL_BOARD {
            hb2.triggerEvent()
            return true
        }
        if [CELL_BLOCK,CELL_ROLE,CELL_ROAD,CELL_DOOR].index(of: cell) != nil{
            return true
        }
        return false
    }
    
    override func moveEndAction() {
        let pos = convertPixelToIndex(x: _role.position.x, y: _role.position.y)
        if pos.x == 8 && pos.y == 0 {
            let ec = NorthCamping()
            //            let char = Game.instance.curStage._curScene._role!
            let char = self._role!
            Game.instance.curStage.switchScene(next: ec, afterCreation: {
                ec.setRole(x: 10, y: 11, char: char)
            }, completion: {})
        } else
        if pos.x == 0 && pos.y == 5 {
            showMsg(text: "west")
        } else
        if pos.x == 12 && pos.y == 3 {
            let ec = EastCamping()
//            let char = Game.instance.curStage._curScene._role!
            let char = self._role!
            Game.instance.curStage.switchScene(next: ec, afterCreation: {
                ec.setRole(x: 0, y: 5, char: char)
            }, completion: {})
        } else
        if pos.x == 11 && pos.y == 2 {
            let ec = SelfHome()
            //            let char = Game.instance.curStage._curScene._role!
            let char = self._role!
            Game.instance.curStage.switchScene(next: ec, afterCreation: {
                ec.setRole(x: 6, y: 7, char: char)
            }, completion: {})
        } else
        if pos.x == 3 && pos.y == 3 {
            let store = GeneralStore()
            let char = self._role!
            Game.instance.curStage.switchScene(next: store, afterCreation: {
                store.setRole(x: store._doorX.toFloat(), y: self.halfSize * 2 - 3, char: char)
            })
        } else
        if pos.x == 10 && pos.y == 9 {
            let store = OutfitStore()
            let char = self._role!
            Game.instance.curStage.switchScene(next: store, afterCreation: {
                store.setRole(x: store._doorX.toFloat(), y: self.halfSize * 2 - 3, char: char)
            })
        }
    }
    
    override func create() {
        super.create()
        let oa2 = Game.instance.outside_a2
        let ms = MapSets(coverGround: oa2.getCell(2, 5, 2, 2), thinConnection: oa2.getNode(3, 3))
//        createCoord()
        addItem(x: 1, y: 2, item: House2(), width: 0, height: 0)
        addItem(x: 8, y: 8, item: House1(), width: 0, height: 0)
        addItem(x: 10, y: 2, item: MyHouse(), width:0, z: MyScene.MAP_LAYER_Z)
//        addItem(x: 0, y: 9, item: Stump())
//        addItem(x: 3, y: 11, item: Stump())
//        addItem(x: 7, y: 11, item: Stump())
//        addItem(x: 9, y: 11, item: Stump())
        
//        var treePoint = Array<Array<CGFloat>>()
//        treePoint.append([6, 3])
//        treePoint.append([7, 2])
        
        let item:Array<Array<CGFloat>> = [
            [8, 7],
            [4, 7],
            [12, 11],
//            [11, 10],
            [12, 10],
            [11, 9],
            [12, 9],
            [4, 6],
            [5, 6],
        ]
        let house1:Array<Array<CGFloat>> = [
            [1, 0],
            [2, 0],
            [3, 0],
            [4, 0],
            [5, 0],
            [6, 0],
            [1, 1],
            [2, 1],
            [3, 1],
            [4, 1],
            [5, 1],
            [6, 1],
            [1, 2],
            [2, 2],
            [3, 2],
            [4, 2],
            [5, 2],
        ]
        let house2:Array<Array<CGFloat>> = [
            [9, 8],
            [10, 8],
            [11, 8],
            [9, 7],
            [10, 7],
            [11, 7],
            [9, 6],
            [10, 6],
            [11, 6],
            [10, 1],
            [11, 1],
            [12, 1],
        ]
        let ob = Game.instance.outside_b
        let treePoint:Array<Array<CGFloat>> = [
            [9, 0],
            [9, 1],
            [9, 2],
//            [10, 2],
            [8, 4],
            [0, 7],
            [0, 8],
            [0, 11],
            [8, 11],
            [8, 6],
            [8, 5],
            [2, 6],
            [6, 3],
            [7, 1],
            [9, 9],
            [7, 0],
            [10, 4],
            [11, 4],
            [11, 5],
            [6, 9],
            [0, 0],
            [0, 1],
            [12, 5],
            [0, 6],
            [1, 11],
            [4, 11],
            [6, 10],
            [7, 10],
            [6, 4],
            [2, 4],
            [5, 4],
        ]
        let p1:Array<Array<CGFloat>> = [
            [0, 2],
            [0, 3],
            [1, 3],
            [2, 3],
            [0, 4],
            [1, 4],
        ]
        let p2:Array<Array<CGFloat>> = [
            [0, 9],
            [3, 11],
            [7, 11],
            [9, 11],
            [9, 4],
        ]
        for a in p2 {
            addItem(x: a[0], y: a[1], item: ob.getNode(4, 11))
        }
        for a in p1 {
            addItem(x: a[0], y: a[1], item: ob.getNode(8, 7))
        }
        for a in treePoint {
            addItem(x: a[0], y: a[1], item: TallTree())
        }
        
        let ac3 = Game.instance.pictureActor3
        addItem(x: 4, y: 7, item: getRoleNode(roleNode: ac3.getNode(7, 4)))
        
        let db = Game.instance.dungeon_b
        
        addItem(x: 12, y: 9, item: db.getNode(12, 11))
        addItem(x: 12, y: 10, item: db.getNode(12, 12))
        addItem(x: 12, y: 11, item: db.getNode(13, 11))
        addItem(x: 8, y: 7, item: ob.getNode(5, 9))
        addItem(x: 5, y: 2, item: ob.getNode(5, 9))
        addItem(x: 5, y: 0, item: ob.getNode(6, 15, 2, 1), width: 0)
        addItem(x: 5, y: 1, item: ob.getNode(6, 14, 2, 1), width: 0)
        
        for x in 1...5 {
            for y in 8...10 {
                addGround(x: x.toFloat(), y: y.toFloat(), item: ob.getNode(6, 13))
            }
        }
        
//        for x in 9...12 {
//            for y in 0...2 {
//                addGround(x: x.toFloat(), y: y.toFloat(), item: ob.getNode(5, 13))
//            }
//        }
//        for x in 6...12 {
//            for y in 0...2 {
//                if x != 8 {
//                    addItem(x: x.toFloat(), y: y.toFloat(), item: ob.getNode(5, 13))
//                }
//            }
//        }
        for x in 1...3 {
            addGround(x: x.toFloat(), y: 7, item: ob.getNode(6, 13))
        }
        
        let wb = Game.instance.world_b
        addItem(x: 4, y: 6.25, item: wb.getNode(10, 15, 2, 1), width: 0)
        let land = wb.getNode(12, 14, 2, 2)
        addItem(x: 4, y: 5.25, item: land, width: 0)
        
//        let down = SKAction.move(by: CGVector(dx: 0, dy: -cellSize * 0.25), duration: TimeInterval(2))
//        let up = SKAction.move(by: CGVector(dx: 0, dy: cellSize * 0.25), duration: TimeInterval(2))
//        let anm = SKAction.repeatForever(SKAction.sequence([down, up]))
//        land.run(anm)
        
        addGround(x: 10, y: 9, item: ms.thinTop)
        addGround(x: 10, y: 10, item: ms.bottomRightCover)
        addGround(x: 9, y: 10, item: ms.thinConnectionH)
        addGround(x: 7, y: 10, item: ms.bottomConnection)
        addGround(x: 6, y: 10, item: ms.bottomLeftCover)
        addGround(x: 8, y: 10, item: ms.bottomConnection)
        addGround(x: 8, y: 9, item: ms.topRightCover)
        addGround(x: 7, y: 9, item: ms.fullConnection)
        addGround(x: 7, y: 8, item: ms.rightConnection)
        addGround(x: 7, y: 7, item: ms.rightConnection)
        addGround(x: 7, y: 6, item: ms.rightConnection)
        addGround(x: 7, y: 5, item: ms.rightConnection)
        addGround(x: 7, y: 4, item: ms.fullConnection)
        addGround(x: 7, y: 3, item: ms.topLeftCover)
        addGround(x: 8, y: 3, item: ms.fullConnection)
        addGround(x: 8, y: 4, item: ms.bottomRightCover)
        addGround(x: 8, y: 2, item: ms.thinConnectionV)
        addGround(x: 8, y: 1, item: ms.thinConnectionV)
        addGround(x: 8, y: 0, item: ms.thinConnectionV)
        
        
        addGround(x: 9, y: 3, item: ms.thinConnectionH)
        addGround(x: 10, y: 3, item: ms.thinConnectionH)
        addGround(x: 11, y: 3, item: ms.thinConnectionH)
        addGround(x: 12, y: 3, item: ms.thinConnectionH)
        
        addGround(x: 6, y: 5, item: ms.fullConnection)
        addGround(x: 6, y: 4, item: ms.topLeftCover)
        
        
        addGround(x: 6, y: 9, item: ms.leftConnection)
        addGround(x: 6, y: 8, item: ms.leftConnection)
        addGround(x: 7, y: 7, item: ms.rightConnection)
        addGround(x: 6, y: 7, item: ms.fullConnection)
        addGround(x: 6, y: 6, item: ms.fullConnection)
        addGround(x: 5, y: 7, item: ms.bottomConnection)
        addGround(x: 5, y: 6, item: ms.fullConnection)
        addGround(x: 5, y: 5, item: ms.topConnection)
        addGround(x: 4, y: 5, item: ms.topConnection)
        addGround(x: 4, y: 6, item: ms.fullConnection)
        addGround(x: 4, y: 7, item: ms.bottomLeftCover)
        addGround(x: 3, y: 6, item: ms.bottomLeftCover)
        addGround(x: 3, y: 5, item: ms.fullConnection)
        addGround(x: 3, y: 4, item: ms.thinConnectionV)
        addGround(x: 3, y: 3, item: ms.thinTop)
        addGround(x: 2, y: 5, item: ms.thinConnectionH)
        addGround(x: 1, y: 5, item: ms.thinConnectionH)
        addGround(x: 0, y: 5, item: ms.thinLeft)
        
        let total = house1 + house2 + treePoint + p1 + p2 + item
        for p in total {
            _mapMatrix[p[1].toInt()][p[0].toInt()] = CELL_BLOCK
        }
        _mapMatrix[2][3] = CELL_DOOR
        _mapMatrix[8][10] = CELL_DOOR
        _mapMatrix[7][4] = CELL_ROLE
        _mapMatrix[6][4] = CELL_ROAD
        _mapMatrix[6][5] = CELL_ROAD
        
        let hb1 = HouseBoard()
        hb1._text = "杂货铺"
        addItem(x: 4, y: 3, item: hb1)
        _mapMatrix[3][4] = CELL_BOARD
        let hb2 = HouseBoard()
        hb2._text = "铁匠铺"
        addItem(x: 11, y: 9, item: hb2)
        _mapMatrix[9][11] = CELL_BOARD
        
//        addItem(x: 1, y: 10, item: House3(), width: 0, height: 0)
        
//        addGround(x: 4, y: 1, item: VillageTrees(), width: 0, height: 0)
//        addGround(x: 1, y: 0, item: ms.topLeftCover)
//        addGround(x: 3, y: 3, item: ms.topRightCover)
//        addGround(x: 4, y: 4, item: ms.bottomRightCover)
//        addGround(x: 5, y: 5, item: ms.bottomLeftCover)
//        addGround(x: 1, y: 0, item: ms.thinTop)
//        addGround(x: 1, y: 1, item: ms.thinConnectionH)
//        addGround(x: 1, y: 2, item: ms.bottomLeftCover)
//        addGround(x: 1, y: 3, item: ms.thinBottom)
//        addGround(x: 2, y: 2, item: ms.thinConnectionV)
//        addGround(x: 3, y: 2, item: ms.thinRight)
//        addGround(x: 0, y: 2, item: ms.thinLeft)
        
//        addGround(x: 4, y: 4, item: ms.topLeftCover)
//        addGround(x: 5, y: 4, item: ms.topConnection)
//        addGround(x: 6, y: 4, item: ms.topRightCover)
//        addGround(x: 4, y: 5, item: ms.leftConnection)
//        addGround(x: 5, y: 5, item: ms.fullConnection)
//        addGround(x: 6, y: 5, item: ms.rightConnection)
//        addGround(x: 4, y: 6, item: ms.bottomLeftCover)
//        addGround(x: 5, y: 6, item: ms.bottomConnection)
//        addGround(x: 6, y: 6, item: ms.bottomRightCover)
    }
    
}
class House1:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let t = Game.instance.tilee_outsidetown
        //        let house = SKSpriteNode(texture: t.getCell(1, 4, 4, 4))
        //        let l = SKSpriteNode(texture: t.getCell(0, 4, 1, 2))
        //        house.addChild(l)
        //        let sha = SKSpriteNode(texture: Game.instance.sha)
        //        sha.position.x = cellSize * 2
        //        sha.position.y = -cellSize * 1.5
        //        house.addChild(sha)
        //        print("cellsize \(cellSize)")
        setTexture(t.getCell(0, 4, 5, 5))
        self.size = CGSize(width: cellSize * 5, height: cellSize * 4)
        //        xAxis = cellSize * 0.5
        //        yAxis = -size.height * 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class House2:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let t = Game.instance.tilee_outsidetown
        //        let house = SKSpriteNode(texture: t.getCell(1, 4, 4, 4))
        //        let l = SKSpriteNode(texture: t.getCell(0, 4, 1, 2))
        //        house.addChild(l)
        //        let sha = SKSpriteNode(texture: Game.instance.sha)
        //        sha.position.x = cellSize * 2
        //        sha.position.y = -cellSize * 1.5
        //        house.addChild(sha)
        //        print("cellsize \(cellSize)")
        setTexture(t.getCell(0, 9, 5, 5))
        self.size = CGSize(width: cellSize * 5, height: cellSize * 4)
        //        xAxis = cellSize * 0.5
        //        yAxis = -size.height * 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class House3:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let t = Game.instance.tilee_outsidetown
        //        let house = SKSpriteNode(texture: t.getCell(1, 4, 4, 4))
        //        let l = SKSpriteNode(texture: t.getCell(0, 4, 1, 2))
        //        house.addChild(l)
        //        let sha = SKSpriteNode(texture: Game.instance.sha)
        //        sha.position.x = cellSize * 2
        //        sha.position.y = -cellSize * 1.5
        //        house.addChild(sha)
        //        print("cellsize \(cellSize)")
        setTexture(t.getCell(8, 4, 6, 5))
        self.size = CGSize(width: cellSize * 6, height: cellSize * 4)
        //        xAxis = cellSize * 0.5
        //        yAxis = -size.height * 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class House4:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let t = Game.instance.tilee_outsidetown
        //        let house = SKSpriteNode(texture: t.getCell(1, 4, 4, 4))
        //        let l = SKSpriteNode(texture: t.getCell(0, 4, 1, 2))
        //        house.addChild(l)
        //        let sha = SKSpriteNode(texture: Game.instance.sha)
        //        sha.position.x = cellSize * 2
        //        sha.position.y = -cellSize * 1.5
        //        house.addChild(sha)
        //        print("cellsize \(cellSize)")
        setTexture(t.getCell(9, 15, 7, 6))
        self.size = CGSize(width: cellSize * 7, height: cellSize * 5)
        //        xAxis = cellSize * 0.5
        //        yAxis = -size.height * 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class HouseChurch:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let t = Game.instance.tilee_outsidetown
        setTexture(t.getCell(8, 4, 6, 5))
        self.size = CGSize(width: cellSize * 6, height: cellSize * 4)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class HouseBoard:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let t = Game.instance.outside_b
        setTexture(t.getCell(1, 9))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var _text:String = ""
    override func triggerEvent() {
        speak(text: _text)
    }
}

class MyHouse:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let t = Game.instance.tilee_outsidetown
        //        let house = SKSpriteNode(texture: t.getCell(1, 4, 4, 4))
        //        let l = SKSpriteNode(texture: t.getCell(0, 4, 1, 2))
        //        house.addChild(l)
        //        let sha = SKSpriteNode(texture: Game.instance.sha)
        //        sha.position.x = cellSize * 2
        //        sha.position.y = -cellSize * 1.5
        //        house.addChild(sha)
        //        print("cellsize \(cellSize)")
        setTexture(t.getCell(5, 4, 3, 5))
        self.size = CGSize(width: cellSize * 3, height: cellSize * 4)
        //        xAxis = cellSize * 0.5
        //        yAxis = -size.height * 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
