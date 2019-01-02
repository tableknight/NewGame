//
//  StandScene.swift
//  GoD
//
//  Created by kai chen on 2018/12/23.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class StandScene: MyScene {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func create() {
        _nameLabel.text = self._name
        createGround()
        createMapMatrix()
//        setRole()
        _initialized = true
    }
    
    
//    override func setRole() {
//        let e = Emily()
//        Game.instance.char = e
//        e.create()
//        e._level = 20
//        //        for _ in 0...19 {
//        //            e.levelup()
//        //        }
//        let char = BUnit()
//        char._charSize = cellSize
//        char.setUnit(unit: e)
//        char.createForStage()
//        char.faceNorth()
////        char.yAxis = cellSize * 0.25
//        _roleLayer.addChild(char)
//        //        char.anchorPoint = CGPoint(x: 0.5, y: 1)
////        char.position.x = (_portalPrev.x - 4) * cellSize
////        char.position.y = (4 - _portalPrev.y) * cellSize
//        char.zPosition = MyScene.ROLE_LAYER_Z
//        _role = char
//    }
    override func createMapMatrix() {
        _mapMatrix = []
        for _ in 0...halfSize.toInt() * 2 - 1 {
            var row:Array<Int> = []
            for _ in 0...halfSize.toInt() * 2 {
                let cell = CELL_EMPTY
                row.append(cell)
                
                
                
            }
            _mapMatrix.append(row)
        }
    }
}
