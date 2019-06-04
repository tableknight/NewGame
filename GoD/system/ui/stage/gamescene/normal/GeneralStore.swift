//
//  GeneralStore.swift
//  GoD
//
//  Created by kai chen on 2019/1/6.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class GeneralStore: InnerHouse {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
//        self.halfSize = 5
        hSize = 10
        vSize = 10
        _name = "杂货铺"
        _doorX = 5
        _roofSets = RoofSets()
        let ia4 = Game.instance.inside_a4
        _wallTexture = Game.instance.outside_a3.getCell(2, 7, 2, 2)
        _mapSet = GroundSets(ground: ia4.getCell(14, 12, 2, 2), wall: _wallTexture)
        _bottomWallTexture = Game.instance.inside_a5.getCell(1, 7)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func hasAction(cell: Int, touchPoint: CGPoint) -> Bool {
        let point = convertPixelToIndex(x: touchPoint.x, y: touchPoint.y)
        if cell == CELL_ROLE && point.equalTo(CGPoint(x: 3, y: 5)) {
            let role = getNextCellItem(x: 3, y: 5) as! UIRole
            let stage = Game.instance.curStage!
            stage.showDialog(img: role._roleNode.texture!,
                text: "今天需要点什么呢？",
                name: "杂货铺的艾莉娅",
                action: {
                    let dlg = stage._curDialog!
                    dlg.addConfirmButton()
                    dlg._confirmAction = {
                        stage.removeDialog(dlg: dlg)
                        let sp = SellingPanel()
                        sp._goodsList = [TownScroll(), SealScroll(), Potion(), GodTownScroll(), DeathTownScroll()]
                        sp.create()
                        stage.showPanel(sp)
                    }
            })
            return true
        }
        if cell == CELL_ROLE && point.equalTo(CGPoint(x: 1, y: 4)) {
            let item = getNextCellItem(x: 1, y: 4)
            item.speak(text: "在哪里啊！")
            return true
        }
        if cell == CELL_ROLE && point.equalTo(CGPoint(x: 2, y: 0)) {
            let item = getNextCellItem(x: 2, y: 0)
            item.speak(text: "你看不见我！")
            return true
        }
        if cell == CELL_ITEM || cell == CELL_ROLE {
            return true
        }
        return false
    }
    
    override func moveEndAction() {
        let pos = convertPixelToIndex(x: _role.position.x, y: _role.position.y)
        if pos.x == _doorX.toFloat() && pos.y == vSize - 1 {
            let cc = CenterCamping()
            let char = _role!
            Game.instance.curStage.switchScene(next: cc, completion: {
                cc.setRole(x: 3, y: 3, char: char)
                char.faceSouth()
            })
        }
    }
    override func create() {
        super.create()
        let it = Game.instance.tile_innerTown
        let ib = Game.instance.inside_b
        addItem(x: 3, y: 1, item: it.getNode(0, 5, 8, 3), width: 0, z: MyScene.ROLE_LAYER_Z - 2)
        addItem(x: 0, y: 4, item: it.getNode(0, 11, 8, 2), width: 0, z: MyScene.ROLE_LAYER_Z - 2)
        addItem(x: 0, y: 2, item: it.getNode(0, 9, 8, 1), width: 0)
        addItem(x: 0, y: 7, item: it.getNode(10, 15, 5, 2), width: 0)
        addItem(x: 9, y: -1, item: it.getNode(15, 4, 1, 2))
        addItem(x: 1, y: -1, item: it.getNode(15, 4, 1, 2), z:MyScene.ROLE_LAYER_Z - 5)
        addItem(x: 5, y: -1.5, item: ib.getNode(14, 4, 2, 1), width: 0, z: MyScene.ROLE_LAYER_Z - 3)
        addItem(x: 8, y: 8, item: ib.getNode(10, 15, 1, 2))
        addItem(x: 9, y: 8, item: ib.getNode(10, 15, 1, 2))
        addItem(x: 10, y: 8, item: ib.getNode(10, 15, 1, 2), z:MyScene.ITEM_LAYER_Z + 8)
        addItem(x: 10, y: 6, item: ib.getNode(10, 14))
        addItem(x: 0, y: 9, item: it.getNode(9, 15, 1, 2), z:MyScene.MAP_LAYER_Z + 1)
        addItem(x: 1, y: 9, item: it.getNode(9, 15, 1, 2), z:MyScene.MAP_LAYER_Z + 1)
        addItem(x: 0, y: 8, item: it.getNode(9, 15, 1, 2), z:MyScene.ITEM_LAYER_Z + 8)
        addItem(x: 9, y: 6, item: it.getNode(12, 15, 2, 2), width: 0, z:MyScene.MAP_LAYER_Z)
        
        let r1 = UIRole()
        r1.create(roleNode: SKTexture(imageNamed: "boy1").getNode(1, 3))
        addItem(x: 1, y: 4, item: r1)
        
        let r2 = UIRole()
        r2.create(roleNode: SKTexture(imageNamed: "Ranliya").getNode(1, 0))
        addItem(x: 3, y: 5, item: r2)
        
        let r3 = UIRole()
        r3.create(roleNode: SKTexture(imageNamed: "boy2").getNode(1, 2))
        addItem(x: 2, y: 0, item: r3)
        
        let itemPoints:Array<Array<Int>> = [
            [3, 0],
            [4, 0],
            [5, 0],
            [6, 0],
            [7, 0],
            [8, 0],
            [9, 0],
            [10, 0],
            [0, 3],
            [1, 3],
            [2, 3],
            [3, 3],
            [4, 3],
            [5, 3],
            [6, 3],
            [7, 3],
            [0, 7],
            [1, 7],
            [2, 7],
            [3, 7],
            [4, 7],
            [0, 6],
            [1, 6],
            [2, 6],
            [3, 6],
            [4, 6],
            [0, 9],
            [0, 8],
            [1, 8],
            [8, 8],
            [9, 8],
            [10, 8],
            [10, 7],
            [9, 6],
            [10, 6],
            [9, 5],
            [10, 5],
        ]
        for p in itemPoints {
            _mapMatrix[p[1]][p[0]] = CELL_ITEM
        }
        let roleoints:Array<Array<Int>> = [[1,4],[3,5],[2,0]]
        for p in roleoints {
            _mapMatrix[p[1]][p[0]] = CELL_ROLE
        }
    }
    private let CELL_ROLE = 151
}


