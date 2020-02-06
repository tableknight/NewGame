//
//  GroceryStore.swift
//  GoD
//
//  Created by kai chen on 2020/1/31.
//  Copyright © 2020 Chen. All rights reserved.
//

import SpriteKit
class GroceryStore: StandScene {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _name = "杂货店"
        _vSize = 14
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func create() {
        createMapMatrix()
        let bg = SKSpriteNode(texture: SKTexture(imageNamed: "grocery_store"))
        bg.size = CGSize(width: cellSize * 13, height: cellSize * 14)
        bg.yAxis = cellSize * 0.5
        addChild(bg)
        for y in 0...2 {
            for x in 0...12 {
                _mapMatrix[y][x] = CELL_BLOCK
            }
        }
        let roof = SKSpriteNode(texture: SKTexture(imageNamed: "grocery_store_roof"))
        addItem(x: 0, y: 13, item: roof, width: 12)
        
        let blockPoints:Array<Array<CGFloat>> = [
                    [2, 4],
                    [1, 5],
                    [10, 4],
                    [11,5],
                    [12,5],
                    [1,7],
                    [2,7],
                    [10,10],
                    [11,10]
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
            _mapMatrix[3][x] = CELL_BLOCK
            _mapMatrix[9][x] = CELL_BLOCK
            _mapMatrix[8][x] = CELL_BLOCK
        }
        for x in 4...12 {
            _mapMatrix[6][x] = CELL_BLOCK
        }
        _mapMatrix[13][6] = CELL_EMPTY
        _mapMatrix[9][7] = CELL_EMPTY
        _mapMatrix[8][7] = CELL_EMPTY
        
        let r1 = UIRole()
        r1.create(roleNode: SKTexture(imageNamed: "boy1").getNode(1, 3))
        addItem(x: 8, y: 7, item: r1)
        
        let r2 = UIRole()
        r2.create(roleNode: SKTexture(imageNamed: "Ranliya").getNode(1, 0))
        addItem(x: 2, y: 5, item: r2)
        
        let r3 = UIRole()
        r3.create(roleNode: SKTexture(imageNamed: "boy2").getNode(1, 2))
        addItem(x: 9, y: 4, item: r3)
        _mapMatrix[7][8] = CELL_ROLE
        _mapMatrix[5][2] = CELL_ROLE
        _mapMatrix[4][9] = CELL_ROLE
    }
    override func moveEndAction() {
        let pos = convertPixelToIndex(x: _role.position.x, y: _role.position.y)
        if pos.x == 6 && pos.y == 13 {
            let cc = CenterV()
            let char = _role!
            Game.instance.curStage.switchScene(next: cc, completion: {
                cc.setRole(x: 10, y: 9, char: char)
                char.faceSouth()
            })
        }
    }
    private let CELL_ROLE = 151
    override func hasAction(cell: Int, touchPoint: CGPoint) -> Bool {
        let point = convertPixelToIndex(x: touchPoint.x, y: touchPoint.y)
        if cell == CELL_ROLE && point.equalTo(CGPoint(x: 2, y: 5)) {
            let role = getNextCellItem(x: 2, y: 5) as! UIRole
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
                        sp._goodsList = [Item(Item.TownScroll), Item(Item.SealScroll), Item(Item.LittlePotion) ,Item(Item.TransportScroll)]
                        for i in sp._goodsList {
                            i._reserveBool = true //没有数量限制
                        }
                        sp.create()
                        stage.showPanel(sp)
                    }
            })
            return true
        }
        if cell == CELL_ROLE && point.equalTo(CGPoint(x: 8, y: 7)) {
            let item = getNextCellItem(x: 8, y: 7)
            item.speak(text: "在哪里啊！")
            return true
        }
        if cell == CELL_ROLE && point.equalTo(CGPoint(x: 9, y: 4)) {
            let item = getNextCellItem(x: 9, y: 4)
            item.speak(text: "你看不见我！")
            return true
        }
        if cell == CELL_ITEM || cell == CELL_ROLE {
            return true
        }
        return false
    }
//    override func hasAction(cell: Int, touchPoint: CGPoint) -> Bool {
//        if cell == CELL_BLOCK {
//            return true
//        }
//        return false
//    }
}

