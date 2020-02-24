//
//  SnowLanding1.swift
//  GoD
//
//  Created by kai chen on 2019/1/14.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class SnowLandingHome: SnowLanding {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _name = "神域·雪之国"
        _vSize = 14
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func moveEndAction() {
        let pos = convertPixelToIndex(x: _role.xAxis, y: _role.yAxis)
        let stage = Game.instance.curStage!
        let char = _role!
        stage.clearScene()
        if pos.x == 4 && pos.y == 1 {
            let nextScene = ZeroPalace()
            stage.saveScene(scene: nextScene)
            stage.switchScene(next: nextScene, completion: {
                nextScene.setRole(x: nextScene._portalPrev.x, y: nextScene._portalPrev.y, char: char)
            })
        } else if pos.x == 6 && pos.y == 1 {
            let nextScene = WinterPalace()
            stage.saveScene(scene: nextScene)
            stage.switchScene(next: nextScene, completion: {
                nextScene.setRole(x: nextScene._portalPrev.x, y: nextScene._portalPrev.y, char: char)
            })
        } else if pos.x == 8 && pos.y == 1 {
            let nextScene = StarPalace()
            stage.saveScene(scene: nextScene)
            stage.switchScene(next: nextScene, completion: {
                nextScene.setRole(x: nextScene._portalPrev.x, y: nextScene._portalPrev.y, char: char)
            })
        } else if pos.x == 2 && pos.y == 1 {
            let nextScene = MorningPalace()
            stage.saveScene(scene: nextScene)
            stage.switchScene(next: nextScene, completion: {
                nextScene.setRole(x: nextScene._portalPrev.x, y: nextScene._portalPrev.y, char: char)
            })
        } else if pos.x == 4 && pos.y == 13 {
            let nextScene = CenterV()
            stage.switchScene(next: nextScene, completion: {
                nextScene.setRole(x: 5, y: 7, char: char)
            })
        } else if pos.x == 3 && pos.y == 6 {
//            showMsg(text: "go bossroad")
        } else if pos.x == 2 && pos.y == 10 {
//            showMsg(text: "go bossroad")
        }
    }
    override func create() {
        createMapMatrix()
        let t = SKTexture(imageNamed: "snowlanding")
        let bg = SKSpriteNode(texture: t)
        bg.size = CGSize(width: cellSize * 13, height: cellSize * 14)
        bg.yAxis = cellSize * 0.5
        addChild(bg)
        
        let roof = SKSpriteNode(texture: SKTexture(imageNamed: "angel_stone"))
        roof.size = CGSize(width: cellSize * 3, height: cellSize * 2)
        addItem(x: 3, y: 11, item: roof, width: 3)
        
        for x in 0...12 {
            _mapMatrix[0][x] = CELL_BLOCK
            _mapMatrix[1][x] = CELL_BLOCK
            _mapMatrix[8][x] = CELL_BLOCK
            _mapMatrix[12][x] = CELL_BLOCK
            _mapMatrix[13][x] = CELL_BLOCK
        }
        for x in 7...12 {
            _mapMatrix[2][x] = CELL_BLOCK
        }
        for x in 5...12 {
            _mapMatrix[4][x] = CELL_BLOCK
        }
        for x in 3...12 {
            _mapMatrix[6][x] = CELL_BLOCK
        }
        for x in 1...12 {
            _mapMatrix[8][x] = CELL_BLOCK
        }
        for y in 1...8 {
            _mapMatrix[y][1] = CELL_BLOCK
            _mapMatrix[y][10] = CELL_EMPTY
            _mapMatrix[y][11] = CELL_BLOCK
            _mapMatrix[y][12] = CELL_BLOCK
        }
        for y in 1...6 {
            _mapMatrix[y][3] = CELL_BLOCK
        }
        for y in 1...4 {
            _mapMatrix[y][5] = CELL_BLOCK
        }
        
        
        
//        let treePoints:Array<Int> = [
//            0,0,
//            3,0,
//            3,5,
//            1,2,
//            4,3,
//            0,5,
//            4,10,
//            7,11,
//            4,2,
//            10,3,
//            1,8,
//            0,10,
//            11,9,
//            9,8,
//            12,0,
//            12,1,
//            12,6,
//        ]
        _mapMatrix[5][11] = CELL_EMPTY
        _mapMatrix[1][10] = CELL_EMPTY
        _mapMatrix[8][10] = CELL_EMPTY
        _mapMatrix[1][9] = CELL_EMPTY
        _mapMatrix[12][4] = CELL_EMPTY
        _mapMatrix[13][4] = CELL_EMPTY
        _mapMatrix[9][0] = CELL_BLOCK
        _mapMatrix[9][6] = CELL_BLOCK
        _mapMatrix[11][3] = CELL_BLOCK
        _mapMatrix[11][5] = CELL_BLOCK
        _mapMatrix[11][12] = CELL_BLOCK
        
        _mapMatrix[1][2] = CELL_PORTAL
        _mapMatrix[1][4] = CELL_PORTAL
        _mapMatrix[1][6] = CELL_PORTAL
        _mapMatrix[1][8] = CELL_PORTAL
    }
    
}
