//
//  MinionHouse.swift
//  GoD
//
//  Created by kai chen on 2019/7/1.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class MinionHouse: InnerHouse {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        hSize = 8
        vSize = 8
        _name = "教堂"
        _doorX = 4
        _roofSets = RoofSets()
        _bottomWallTexture = Game.instance.inside_a5.getCell(1, 3)
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
    private let CELL_ROAD = 152
    private let CELL_BOARD = 150
    override func hasAction(cell: Int, touchPoint: CGPoint) -> Bool {
        let point = convertPixelToIndex(x: touchPoint.x, y: touchPoint.y)
        
        if [CELL_BLOCK,CELL_ROAD,CELL_DOOR].firstIndex(of: cell) != nil{
            return true
        }
        if cell == CELL_ROLE && point.x == 4 && point.y == 0 {
            let stage = Game.instance.curStage!
            stage.showDialog(img: Game.instance.pictureActor3.getCell(7, 4),
                             text: "越接近神的地方，灵魂越能得到安息，是否要安置灵魂？",
                             name: "牧师维尔泽")
            stage._curDialog?.addConfirmButton()
            stage._curDialog?._confirmAction = {
                stage.removeDialog(dlg: stage._curDialog!)
                let mhp = MinionTradingPanel()
                mhp.create()
                Game.instance.curStage.showPanel(mhp)
            }
            return true
            
            
        }
        return false
    }
    
    override func moveEndAction() {
        let pos = convertPixelToIndex(x: _role.position.x, y: _role.position.y)
        if pos.x == 4 && pos.y == vSize - 1 {
            let cc = NorthCamping()
            let char = _role!
            Game.instance.curStage.switchScene(next: cc, completion: {
                cc.setRole(x: 1, y: 7, char: char)
            })
        }
        
    }
    override func create() {
        let ia4 = Game.instance.inside_a4
        _mapSet = GroundSets(ground: ia4.getCell(0, 7, 2, 2), wall: ia4.getCell(0, 9, 2, 2))
        super.create()
        let ib = Game.instance.inside_b
        let ti = Game.instance.tile_innerTown
        //        let z = MyScene.ITEM_LAYER_Z + 50
        //        let y:CGFloat = -1.5
        let t = ib.getCell(9, 3, 1, 2)
        let a2 = Game.instance.inside_a2
        addItem(x: 0, y: -1, item: SKSpriteNode(texture: t))
        addItem(x: 1, y: -1, item: SKSpriteNode(texture: t))
        addItem(x: 2, y: -1, item: SKSpriteNode(texture: t))
//        addItem(x: 3, y: -1, item: SKSpriteNode(texture: t))
//        addItem(x: 10, y: -1, item: SKSpriteNode(texture: t))
        addItem(x: 8, y: -1, item: SKSpriteNode(texture: t))
        addItem(x: 7, y: -1, item: SKSpriteNode(texture: t))
        addItem(x: 6, y: -1, item: SKSpriteNode(texture: t))
        addItem(x: 3, y: -1, item: ib.getNode(10, 3, 1, 2))
        addItem(x: 5, y: -1, item: ib.getNode(11, 3, 1, 2))
        for i in 0...7 {
            addItem(x: 4, y: i.toFloat(), item: a2.getNode(4, 10.5, 2, 1), z:MyScene.MAP_LAYER_Z)
        }
        addItem(x: 3, y: 1, item: ti.getNode(8, 10, 3, 2), width: 0)
        //        addItem(x: 1, y: 2.5, item: Table1(), width: 0)
        //        addItem(x: 1, y: 5, item: Table1(), width: 0)
        //        addItem(x: 1, y: 7.5, item: Table1(), width: 0)
        //        addItem(x: 8, y: 2.5, item: Table1(), width: 0)
        //        addItem(x: 8, y: 5, item: Table1(), width: 0)
        //        addItem(x: 8, y: 7.5, item: Table1(), width: 0)
        _mapMatrix[1][3] = CELL_BLOCK
        _mapMatrix[1][4] = CELL_BLOCK
        _mapMatrix[1][5] = CELL_BLOCK
//        _mapMatrix[2][3] = CELL_BLOCK
//        _mapMatrix[2][4] = CELL_BLOCK
//        _mapMatrix[2][5] = CELL_BLOCK
        let r1 = UIRole()
        r1.create(roleNode: SKTexture(imageNamed: "priest").getNode(1, 0))
        addItem(x: 4, y: -0.5, item: r1, z:MyScene.MAP_LAYER_Z)
        
        //        setCell(x: 1, y: 8, width: 2, height: 2)
        //        setCell(x: 1, y: 5, width: 2, height: 2)
        //        setCell(x: 1, y: 3, width: 2, height: 2)
        //        setCell(x: 8, y: 8, width: 2, height: 2)
        //        setCell(x: 8, y: 5, width: 2, height: 2)
        //        setCell(x: 8, y: 3, width: 2, height: 2)
//        setCell(x: 4, y: 1, width: 3, height: 1)
        _mapMatrix[0][4] = CELL_ROLE
        
        
        
        
    }
    
}

