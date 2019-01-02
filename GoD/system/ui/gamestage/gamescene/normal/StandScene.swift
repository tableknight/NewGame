//
//  StandScene.swift
//  GoD
//
//  Created by kai chen on 2018/12/23.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class SceneTemplate: StandScene {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
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
        
        if [CELL_BLOCK,CELL_ROLE,CELL_ROAD,CELL_DOOR].index(of: cell) != nil{
            return true
        }
        return false
    }
    
    override func moveEndAction() {
        let pos = convertPixelToIndex(x: _role.position.x, y: _role.position.y)
        
    }
    override func create() {
        super.create()
        
    }
    
}
class StandScene: MyScene {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func create() {
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
