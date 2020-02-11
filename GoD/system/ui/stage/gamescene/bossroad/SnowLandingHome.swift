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
        addItem(x: 3, y: 11, item: roof, width: 3)
        
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
        

    }
    
}

class RoleToppur: UIRole {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.texture = SKTexture(imageNamed: "Toppur")
        self.size = CGSize(width: cellSize * 2, height: cellSize * 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
