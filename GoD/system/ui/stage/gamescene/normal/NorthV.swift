//
//  NorthV.swift
//  GoD
//
//  Created by kai chen on 2020/2/2.
//  Copyright © 2020 Chen. All rights reserved.
//

import SpriteKit
class NorthV: StandScene {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _name = "\(Game.VILLAGE_NAME)·北"
        _nameLabel.text = _name
        _vSize = 14
        _soundUrl = "village"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func create() {
        createMapMatrix()
        let t = SKTexture(imageNamed: "north_village")
        let bg = SKSpriteNode(texture: t)
        bg.size = CGSize(width: cellSize * 13, height: cellSize * 14)
        bg.yAxis = cellSize * 0.5
        addChild(bg)
        
        for x in 0...7 {
            _mapMatrix[8][x] = CELL_BLOCK
        }
        for x in 0...12 {
            _mapMatrix[12][x] = CELL_BLOCK
            _mapMatrix[13][x] = CELL_BLOCK
        }
        let treePoint:Array<Array<CGFloat>> = [
            [0, 9],
            [0,11],
            [11,7]
        ]
        for a in treePoint {
            addItem(x: a[0], y: a[1], item: TallTree())
        }
        let blockPoints:Array<Array<CGFloat>> = [
                    [8, 7],
                    [8,8],
                    [9,6],
                    [8,9],
                    [1,9],
                    [4,9],
                    [6,9],
                    [11,6],
                    [12,8],
                    [10,5]
                ]
        let total = treePoint + blockPoints
        for p in total {
            _mapMatrix[p[1].toInt()][p[0].toInt()] = CELL_BLOCK
        }
        _mapMatrix[12][4] = CELL_EMPTY
    }
    override func moveEndAction() {
        let pos = convertPixelToIndex(x: _role.position.x, y: _role.position.y)
        if pos.x == 4 && pos.y == 12 {
            let cc = CenterV()
            let char = _role!
            Game.instance.curStage.switchScene(next: cc, completion: {
                cc.setRole(x: 10, y: 1, char: char)
                char.faceNorth()
            })
        } else if pos.x == 5 && pos.y == 9 {
            let cc = MagicHouse()
            let char = _role!
            Game.instance.curStage.switchScene(next: cc, completion: {
                cc.setRole(x: 6, y: 13, char: char)
                char.faceNorth()
            })
        }
    }


}


