//
//  CenterV.swift
//  GoD
//
//  Created by kai chen on 2019/12/31.
//  Copyright © 2019 Chen. All rights reserved.
//


import SpriteKit
class CenterV: StandScene {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _name = "\(Game.VILLAGE_NAME)·南"
        _nameLabel.text = _name
        _vSize = 14
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func create() {
        createMapMatrix()
        let t = SKTexture(imageNamed: "center_v")
        let bg = SKSpriteNode(texture: t)
        bg.size = CGSize(width: cellSize * 13, height: cellSize * 14)
        bg.yAxis = cellSize * 0.5
        addChild(bg)
        for x in 0...12 {
            _mapMatrix[0][x] = CELL_BLOCK
        }
        addItem(x: 4, y: 7, item: getRoleNode(roleNode: SKTexture(imageNamed: "Suvya").getNode(1, 0)))
        let wb = Game.instance.world_b
        addItem(x: 4, y: 6.25, item: wb.getNode(10, 15, 2, 1), width: 0)
        let land = wb.getNode(12, 14, 2, 2)
        addItem(x: 4, y: 5.25, item: land, width: 0)
        _mapMatrix[7][4] = CELL_ROLE
        _mapMatrix[6][4] = CELL_ROAD
        _mapMatrix[6][5] = CELL_ROAD
//        let roof = t.getNode(7, 9)
//        for y in 0...3 {
//            for x in 0...12 {
//                _mapMatrix[y][x] = CELL_BLOCK
//            }
//        }
//        _mapMatrix[3][6] = CELL_EMPTY
        let treePoint:Array<Array<CGFloat>> = [
            [0, 7],
            [1, 5],
            [1,7],
            [2,7],
            [0,8],
            [0,11],
            [1,11],
            [2,11],
            [4,11],
            [5,11],
            [12,11],
            [11,11],
            [8,11],
//            [7,11],
            [6,11],
            [8,6],
//            [11,7],
//            [12,8],
            [7,7],
            [7,8],
            [8,7],
//            [8,8]
//            [5,6]
        ]
        for a in treePoint {
            addItem(x: a[0], y: a[1], item: TallTree())
        }
        let blockPoints:Array<Array<CGFloat>> = [
                    [3, 8],
                    [4,8],
                    [4,9],
                    [4,10],
                    [5,13],
                    [11,7],
                    [7,9],
                    [8,9],
                    [9,9],
                    [11,9],
                    [12,9],
                    [3,3],
                    [4,3],
                    [5,3],
                    [6,3],
                    [7,3],
                    [8,3],
                    [9,4],
                    [9,1],
                    [9,2],
                    [11,1],
                    [11,2],
                    [11,3],
                    [11,4],
                    [12,4],
                    [9,7],
                    [10,7],
                    [10,8],
                    [11,7],
                    [12,7]
                    
        //            [5,6]
                ]
        let total = treePoint + blockPoints
        for p in total {
            _mapMatrix[p[1].toInt()][p[0].toInt()] = CELL_BLOCK
        }
        
        let roof = SKSpriteNode(texture: SKTexture(imageNamed: "shop_roof"))
        roof.size = CGSize(width: cellSize * 3, height: cellSize * 2)
        addItem(x: 10, y: 7, item: roof)
        
    }
    override func moveEndAction() {
        let pos = convertPixelToIndex(x: _role.position.x, y: _role.position.y)
        if pos.x == 2 && pos.y == 3 {
            let cc = Hotel()
            let char = _role!
            Game.instance.curStage.switchScene(next: cc, completion: {
                cc.setRole(x: 6, y: 13, char: char)
                char.faceNorth()
            })
        } else if pos.x == 10 && pos.y == 9 {
            let cc = GroceryStore()
            let char = _role!
            Game.instance.curStage.switchScene(next: cc, completion: {
                cc.setRole(x: 6, y: 13, char: char)
                char.faceNorth()
            })
        } else if pos.x == 12 && pos.y == 5 {
           let cc = EastV()
           let char = _role!
           Game.instance.curStage.switchScene(next: cc, completion: {
               cc.setRole(x: 0, y: 4, char: char)
               char.faceEast()
           })
       } else if pos.x == 10 && pos.y == 1 {
             let cc = NorthV()
             let char = _role!
             Game.instance.curStage.switchScene(next: cc, completion: {
                 cc.setRole(x: 4, y: 12, char: char)
                 char.faceNorth()
             })
         }
    }
    private let CELL_DOOR = 150
    private let CELL_ROAD = 152
    private let CELL_BOARD = 150
    override func hasAction(cell: Int, touchPoint: CGPoint) -> Bool {
        let point = convertPixelToIndex(x: touchPoint.x, y: touchPoint.y)
        
        if point.x == 3 && point.y == 2 && cell == CELL_DOOR {
//            showMsg(text: "house1")
            return true
        }
        if point.x == 10 && point.y == 8 && cell == CELL_DOOR {
//            showMsg(text: "house1")
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
                                     text: "这里是前往神域的唯一入口，攀登远古之巅，即可进入神域，升入神格。。。不过，我建议你放弃。",
                                     name: "神官苏维亚")
            stage._curDialog?.addConfirmButton()
            stage._curDialog?._confirmAction = {
                let rp = AcientRoadSelection()
                rp.create()
                stage.removeDialog(dlg: stage._curDialog!)
                stage.showPanel(rp)
            }
            
            let dlg = stage._curDialog!
//            let item = getNextCellItem(x: 4, y: 1)
            dlg._battleAction = {
                stage.removeDialog(dlg: dlg)
                let battle = SuvyaBattle()
                battle.setEnemyPart(minions: Array<Creature>())
                let i = Game.instance
                battle.setPlayerPart(roles: [i.char] + i.char.getReadyMinions())
                stage.addBattle(battle)
                battle.battleStart()
                battle.victoryAction = {
//                    item.speak(text: "你真厉害！")
                }
                battle.defeatedAction = {
//                    item.speak(text: "下次加油！")
                }
            }
            return true
        }
//        let hb1 = getNextCellItem(x: 4, y: 3)
//        if hb1.contains(touchPoint) && cell == CELL_BOARD {
//            hb1.triggerEvent()
//            return true
//        }
//        let hb2 = getNextCellItem(x: 11, y: 9)
//        if hb2.contains(touchPoint) && cell == CELL_BOARD {
//            hb2.triggerEvent()
//            return true
//        }
        if [CELL_BLOCK,CELL_ROLE,CELL_ROAD,CELL_DOOR].firstIndex(of: cell) != nil{
            return true
        }
        return false
    }

}

