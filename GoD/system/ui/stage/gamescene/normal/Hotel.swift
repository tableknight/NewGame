//
//  Hotel.swift
//  GoD
//
//  Created by kai chen on 2019/12/30.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class Hotel: StandScene {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _name = "旅馆·餐厅"
        _nameLabel.text = _name
        _vSize = 14
        _soundUrl = "inner_house"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func create() {
        createMapMatrix()
        let bg = SKSpriteNode(texture: SKTexture(imageNamed: "hotel_out"))
        bg.size = CGSize(width: cellSize * 13, height: cellSize * 14)
        bg.yAxis = cellSize * 0.5
        addChild(bg)
        for y in 0...2 {
            for x in 0...12 {
                _mapMatrix[y][x] = CELL_BLOCK
            }
        }
        let roof = SKTexture(imageNamed: "hotel_out_roof")
        let top1 = roof.getNode(4, 8, 1, 3)
        addItem(x: 3, y: 6, item: top1)
        
        let top2 = roof.getNode(0, 8, 4, 3)
        addItem(x: 2, y: 9, item: top2, width: 4)
        
        let top3 = roof.getNode(0, 11, 2, 3)
        addItem(x: 9, y: 9, item: top3, width: 2)
        
        let top4 = roof.getNode(2, 11, 2, 3)
        addItem(x: 9, y: 5, item: top4, width: 2)
        
        let top5 = roof.getNode(0, 2, 5, 3)
        addItem(x: 1, y: 13, item: top5, width: 5)
        let top6 = roof.getNode(0, 5, 5, 3)
        addItem(x: 7, y: 13, item: top6, width: 5)
        
        let r1 = UIRole()
        r1.create(roleNode: SKTexture(imageNamed: "chef").getNode(1, 3))
        addItem(x: 4, y: 3, item: r1)
        _mapMatrix[3][4] = CELL_ROLE
        let r2 = UIRole()
        r2.create(roleNode: SKTexture(imageNamed: "Catherine").getNode(1, 0))
        addItem(x: 6, y: 6, item: r2)
        _mapMatrix[6][6] = CELL_ROLE
        
        
//        for x in 0...12 {
//            _mapMatrix[6][x] = CELL_BLOCK
//            _mapMatrix[8][x] = CELL_BLOCK
//            _mapMatrix[9][x] = CELL_BLOCK
//            _mapMatrix[13][x] = CELL_BLOCK
//        }
        for y in 0...5 {
            _mapMatrix[y][6] = CELL_BLOCK
        }
        
        let blockPoints:Array<Array<CGFloat>> = [
                    [2, 3],
                    [2, 4],
                    [2, 5],
                    [8,4],
                    [9,4],
                    [10,4],
                    [11,4],
                    [9,5],
                    [10,5],
                    [1,7],
                    [2,6],
                    [3,6],
                    [2,8],
                    [3,8],
                    [4,8],
                    [5,8],
                    [6,8],
                    [8,8],
                    [9,8],
                    [10,8],
                    [11,8],
                    [2,9],
                    [3,9],
                    [4,9],
                    [5,9],
                    [9,9],
                    [10,9]
                ]
        for p in blockPoints {
            _mapMatrix[p[1].toInt()][p[0].toInt()] = CELL_BLOCK
        }
        
        for y in 0...13 {
            _mapMatrix[y][0] = CELL_BLOCK
            _mapMatrix[y][12] = CELL_BLOCK
        }
        for x in 0...12 {
            _mapMatrix[13][x] = CELL_BLOCK
        }
        _mapMatrix[13][6] = CELL_EMPTY
        _mapMatrix[2][7] = CELL_EMPTY
    }
    override func moveEndAction() {
        let pos = convertPixelToIndex(x: _role.position.x, y: _role.position.y)
        if pos.x == 6 && pos.y == 13 {
            let cc = CenterV()
            let char = _role!
            Game.instance.curStage.switchScene(next: cc, completion: {
                cc.setRole(x: 2, y: 3, char: char)
                char.faceSouth()
            })
        } else if pos.x == 7 && pos.y == 2 {
            let cc = HotelInner()
            let char = _role!
            Game.instance.curStage.switchScene(next: cc, completion: {
                cc.setRole(x: 6, y: 13, char: char)
                char.faceNorth()
            })
        }
    }
    override func hasAction(cell: Int, touchPoint: CGPoint) -> Bool {
        let point = convertPixelToIndex(x: touchPoint.x, y: touchPoint.y)
        if cell == CELL_ROLE && point.equalTo(CGPoint(x: 4, y: 3)) {
            let role = getNextCellItem(x: 4, y: 3) as! UIRole
            role.speak(text: "蛋炒饭，嘿！")
            return true
        } else if cell == CELL_ROLE && point.equalTo(CGPoint(x: 6, y: 6)) {
            let role = getNextCellItem(x: 6, y: 6) as! UIRole
            role.speak(text: "你好呀！")
            return true
        }
        
        if cell == CELL_ITEM || cell == CELL_ROLE {
            return true
        }
        return false
    }
}

