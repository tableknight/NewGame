//
//  BlackWaterTown.swift
//  GoD
//
//  Created by kai chen on 2019/4/18.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class BlackWaterTown: StandScene {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _name = "龙德岛"
        let oa4 = Game.instance.dungeon_a4
        _mapSet = GroundSets(ground: oa4.getCell(10, 12, 2, 2), wall: oa4.getCell(10, 14, 2, 2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func createGround() {
        createMap()
    }
    override func hasAction(cell: Int, touchPoint: CGPoint) -> Bool {
        let point = convertPixelToIndex(x: touchPoint.x, y: touchPoint.y)
        if point.x == 3 && point.y == 4 {
            let stage = Game.instance.curStage!
            stage.showDialog(img: Game.instance.picturePeople2.getCell(10, 0),
                             text: "需要用船吗？。",
                             name: "船长杰徳")
            stage._curDialog?.addConfirmButton()
            stage._curDialog?._confirmAction = {
                let rp = EastCamping()
                stage.removeDialog(dlg: stage._curDialog!)
                stage.switchScene(next: rp, afterCreation: {
                    rp.setRole(x: 8, y: 4, char: self._role)
                })
            }
            return true
        }
        if [CELL_BLOCK,CELL_ITEM].index(of: cell) != nil{
            return true
        }
        return false
    }
    
    override func moveEndAction() {
        let pos = convertPixelToIndex(x: _role.position.x, y: _role.position.y)
        if pos.x == 10 && pos.y == 9 {
            let fade = SKAction.fadeIn(withDuration: TimeInterval(1.5))
            _mark.removeFromParent()
            _portalMark.run(fade) {
                let cc = DemonTownPortal()
                let char = self._role!
                Game.instance.curStage.switchScene(next: cc, afterCreation: {
                    cc.setRole(x: 6, y: 5, char: char)
                    char.faceSouth()
                }, completion: {})
            }
        }
    }
    override func create() {
        super.create()
        let oa1 = Game.instance.dungeon_a1
        let river = MapSets(coverGround: oa1.getCell(0, 11, 2, 2), thinConnection: oa1.getNode(1, 9))
        let thinLefts:Array<Array<CGFloat>> = [
            [2,4],
            [2,5],
            [4,11],
            ]
        let bottomLeftCorners:Array<Array<CGFloat>> = [
            [9,0],
            [8,1],
            [5,2],
            [3,3],
            [6,9],
            [5,10]
        ]
        for p in thinLefts {
            addGround(x: p[0], y: p[1], item: river.rightConnection)
        }
        for p in bottomLeftCorners {
            addGround(x: p[0], y: p[1], item: river.bottomRightCover)
        }
        
        
        
        let fcstart = [8,7,4,2,1,1,2,4,5,5,4,3,4]
        for y in 0...fcstart.count - 1 {
            for x in 0...fcstart[y] {
                addGround(x: x.toFloat(), y: y.toFloat(), item: river.fullConnection)
            }
        }
        addGround(x: 6, y: 1, item: river.bottomConnection)
        addGround(x: 7, y: 1, item: river.bottomConnection)
        addGround(x: 4, y: 2, item: river.bottomConnection)
        addGround(x: 3, y: 6, item: river.topConnection)
        addGround(x: 4, y: 6, item: river.topConnection)
        addGround(x: 5, y: 7, item: river.topRightCover)
        addGround(x: 6, y: 8, item: river.topRightCover)
        let p2 = Game.instance.picturePeople2
        addItem(x: 3, y: 4, item: getRoleNode(roleNode: p2.getNode(10, 0)))
        //        let v = Game.instance.pictureVehicle
        addItem(x: 1, y: 4, item: Boat(), width: 0)
        let total:Array<Array<CGFloat>> = [
            [3,4],
            [6,1],
            [7,1],
            [4,2],
            [3,6],
            [4,6],
            [5,7],
            [6,8],
            ] + thinLefts + bottomLeftCorners
        for p in total {
            _mapMatrix[p[1].toInt()][p[0].toInt()] = CELL_BLOCK
        }
        
        _mark.alpha = 0.75
        _mark.size = CGSize(width: cellSize * 5, height: cellSize * 5)
        addGround(x: 10, y: 11, item: _mark)
        _portalMark.alpha = 0.75
        _portalMark.size = CGSize(width: cellSize * 5, height: cellSize * 5)
        addGround(x: 10, y: 11, item: _portalMark)
        _portalMark.alpha = 0
        
        let oc = Game.instance.outside_c
        let paller = oc.getCell(1, 1, 1, 2)
        
        addItem(x: 8.5, y: 7.5, item: oc.getNode(1, 1, 1, 2))
        addItem(x: 8.5, y: 10.5, item: oc.getNode(1, 1, 1, 2))
        addItem(x: 11.5, y: 7.5, item: oc.getNode(1, 1, 1, 2))
        addItem(x: 11.5, y: 10.5, item: oc.getNode(1, 1, 1, 2))
        _mapMatrix[7][8] = CELL_BLOCK
        _mapMatrix[10][8] = CELL_BLOCK
        _mapMatrix[7][11] = CELL_BLOCK
        _mapMatrix[10][11] = CELL_BLOCK

    }
    private var _mark = Game.instance.dungeon_c.getNode(0, 12, 3, 3)
    private var _portalMark = Game.instance.dungeon_c.getNode(3, 12, 3, 3)
}

