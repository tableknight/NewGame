//
//  SceneTemplate.swift
//  GoD
//
//  Created by kai chen on 2019/1/2.
//  Copyright © 2019年 Chen. All rights reserved.
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
//        let point = convertPixelToIndex(x: touchPoint.x, y: touchPoint.y)
        
        if [CELL_BLOCK,CELL_ROLE,CELL_ROAD,CELL_DOOR].firstIndex(of: cell) != nil{
            return true
        }
        return false
    }
    
    override func moveEndAction() {
//        let pos = convertPixelToIndex(x: _role.position.x, y: _role.position.y)
        
    }
    override func create() {
        super.create()
    }
    
}
