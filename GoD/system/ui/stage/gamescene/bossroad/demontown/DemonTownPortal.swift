//
//  DemonPortal.swift
//  GoD
//
//  Created by kai chen on 2019/4/19.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class DemonTownPortal: Maze {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        //        let oa4 = Game.instance.sf_inside_a4
        let o4 = Game.instance.dungeon_a4
        _mapSet = GroundSets(ground: o4.getCell(4, 2, 2, 2), wall: o4.getCell(4, 4, 2, 2))
        _name = "魔王之城"
        _nameLabel.text = _name
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func create() {
        //1
        _fragment.append([])
        _fragment.append([0,1,0,2])
        _fragment.append([])
        _fragment.append([0,1,0,2])
        _fragment.append([])
        
        //2
        _fragment.append([0,0,1,0,2,0])
        _fragment.append([0,2,2,0])
        _fragment.append([0,0,1,0])
        _fragment.append([0,2,2,0,1,0])
        _fragment.append([0,0])
        
        //3
        _fragment.append([0,2,1,2,2,2])
        _fragment.append([2,2,0,1,0,0])
        _fragment.append([0,2,1,2])
        _fragment.append([0,0,0,1,1,2,2,2])
        _fragment.append([0,2])
        //4
        _fragment.append([])
        _fragment.append([0,2,0,1])
        _fragment.append([])
        _fragment.append([0,2,0,1])
        _fragment.append([])
        _fragment.append([])
        
        super.create()
        let mark = Game.instance.dungeon_c.getNode(0, 12, 3, 3)
        mark.alpha = 0.5
        mark.size = CGSize(width: cellSize * 5, height: cellSize * 5)
        addGround(x: 6, y: 7.5, item: mark)
        //        let t = SKTexture(imageNamed: "wall_shadow_12")
        //        addItem(x: 3, y: 6, item: Game.instance.dungeon_c.getNode(6, 8, 1, 2))
        //        addGround(x: 5, y: 6, item: SKSpriteNode(texture: t))
        //        addShadow(x: 4, y: 7)
        _portalNext = CGPoint(x: 5, y: 5)
        _portalPrev = CGPoint(x: 6, y: 7)
        
        let b = Game.instance.dungeon_b
//        let ptl = Game.instance.dungeon_b.getCell(2, 1)
//        let ptr = Game.instance.dungeon_b.getCell(3, 1)
        
        addGround(x: 1, y: 1, item: b.getNode(2, 1))
        addGround(x: 1, y: 5, item: b.getNode(2, 1))
        addGround(x: 1, y: 10, item: b.getNode(2, 1))
        
        addGround(x: 11, y: 1, item: b.getNode(3, 1))
        addGround(x: 11, y: 5, item: b.getNode(3, 1))
        addGround(x: 11, y: 10, item: b.getNode(3, 1))
    }
    
    override func moveEndAction() {
        let pos = convertPixelToIndex(x: _role.xAxis, y: _role.yAxis)
        let stage = Game.instance.curStage!
        let char = _role!
        stage.clearScene()
        if pos.x == 1 && pos.y == 1 { //13
            let nextScene = CityOfDesire()
            stage.saveScene(scene: nextScene)
            stage.switchScene(next: nextScene, completion: {
                nextScene.setRole(x: nextScene._portalPrev.x, y: nextScene._portalPrev.y, char: char)
            })
        } else if pos.x == 1 && pos.y == 5 { //19
            let nextScene = CityOfSorrow()
            stage.saveScene(scene: nextScene)
            stage.switchScene(next: nextScene, completion: {
                nextScene.setRole(x: nextScene._portalPrev.x, y: nextScene._portalPrev.y, char: char)
            })
        } else if pos.x == 1 && pos.y == 10 { //24
            let nextScene = CityOfFail()
            stage.saveScene(scene: nextScene)
            stage.switchScene(next: nextScene, completion: {
                nextScene.setRole(x: nextScene._portalPrev.x, y: nextScene._portalPrev.y, char: char)
            })
        } else if pos.x == 11 && pos.y == 1 { //30
            let nextScene = CityOfSin()
            stage.saveScene(scene: nextScene)
            stage.switchScene(next: nextScene, completion: {
                nextScene.setRole(x: nextScene._portalPrev.x, y: nextScene._portalPrev.y, char: char)
            })
        } else if pos.x == 11 && pos.y == 5 { // 34
            let nextScene = CityOfDeath()
            stage.saveScene(scene: nextScene)
            stage.switchScene(next: nextScene, completion: {
                nextScene.setRole(x: nextScene._portalPrev.x, y: nextScene._portalPrev.y, char: char)
            })
        } else if pos.x == 11 && pos.y == 10 { // 39
            let nextScene = CityOfLethe()
            stage.saveScene(scene: nextScene)
            stage.switchScene(next: nextScene, completion: {
                nextScene.setRole(x: nextScene._portalPrev.x, y: nextScene._portalPrev.y, char: char)
            })
        }
    }
}
