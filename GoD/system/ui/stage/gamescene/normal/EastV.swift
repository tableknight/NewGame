//
//  EastV.swift
//  GoD
//
//  Created by kai chen on 2020/2/2.
//  Copyright © 2020 Chen. All rights reserved.
//

import SpriteKit
class EastV: StandScene {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _name = "\(Game.VILLAGE_NAME)·东"
        _nameLabel.text = _name
        _vSize = 14
        _soundUrl = "village"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func create() {
        createMapMatrix()
        let t = SKTexture(imageNamed: "east_village")
        let bg = SKSpriteNode(texture: t)
        bg.size = CGSize(width: cellSize * 13, height: cellSize * 14)
        bg.yAxis = cellSize * 0.5
        addChild(bg)
        
        let roof = SKSpriteNode(texture: SKTexture(imageNamed: "east_village_roof"))
        roof.size = CGSize(width: cellSize * 5, height: cellSize * 2)
        addItem(x: 1, y: 6, item: roof, width: 5)
        
        for x in 0...12 {
            _mapMatrix[3][x] = CELL_BLOCK
        }
        addItem(x: 9, y: 4, item: getRoleNode(roleNode: SKTexture(imageNamed: "Jade").getNode(1, 0)))
        _mapMatrix[4][9] = CELL_ROLE
        
        let treePoint:Array<Array<CGFloat>> = [
            [0, 7],
            [0, 8],
            [1, 10],
            [1,11],
            [2,11],
            [7,11],
            [10, 11],
            [6,7],
            [8, 8]
        ]
        for a in treePoint {
            addItem(x: a[0], y: a[1], item: TallTree())
        }
        let blockPoints:Array<Array<CGFloat>> = [
                    [5, 7],
                    [4, 7],
                    [3, 7],
                    [2, 7],
                    [1, 7],
                    [5, 6],
                    [4, 6],
                    [3, 6],
                    [2, 6],
                    [1, 6],
                    [5, 8],
                    [4, 8],
                    [3, 8],
                    [2, 8],
                    [1, 8],
                    [9, 8],
                    [9, 9],
                    [9,5],
                    [9,6],
                    [9,7],
                    [10,9],
                    [11,9],
                    [12,10]
                ]
        let total = treePoint + blockPoints
        for p in total {
            _mapMatrix[p[1].toInt()][p[0].toInt()] = CELL_BLOCK
        }
        
    }
    override func moveEndAction() {
        let pos = convertPixelToIndex(x: _role.position.x, y: _role.position.y)
        if pos.x == 0 && pos.y == 4 {
            let cc = CenterV()
            let char = _role!
            Game.instance.curStage.switchScene(next: cc, completion: {
                cc.setRole(x: 12, y: 5, char: char)
                char.faceNorth()
            })
        } else if pos.x == 3 && pos.y == 9 {
            let cc = ArmorHouse()
            let char = _role!
            Game.instance.curStage.switchScene(next: cc, completion: {
                cc.setRole(x: 6, y: 13, char: char)
                char.faceNorth()
            })
        }
    }
    override func hasAction(cell: Int, touchPoint: CGPoint) -> Bool {
        let point = convertPixelToIndex(x: touchPoint.x, y: touchPoint.y)
        if point.x == 9 && point.y == 4 && cell == CELL_ROLE {
            let stage = Game.instance.curStage!
            stage.showDialog(img: SKTexture(imageNamed: "Jade").getCell(1, 0),
                             text: "需要用船吗？。",
                             name: "船长杰克")
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
        if cell == CELL_ROLE {
            return true
        }
        return false
    }

}


