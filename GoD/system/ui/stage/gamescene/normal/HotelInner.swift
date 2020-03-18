//
//  CenterV.swift
//  GoD
//
//  Created by kai chen on 2019/12/31.
//  Copyright © 2019 Chen. All rights reserved.
//


import SpriteKit
class HotelInner: StandScene {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _name = "旅馆·客房"
        _nameLabel.text = _name
        _vSize = 14
        _soundUrl = "inner_house"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func create() {
        createMapMatrix()
        let bg = SKSpriteNode(texture: SKTexture(imageNamed: "hotel_inner"))
        bg.size = CGSize(width: cellSize * 13, height: cellSize * 13)
//        bg.yAxis = cellSize * 0.5
        addChild(bg)
        
        let r1 = UIRole()
        r1.create(roleNode: SKTexture(imageNamed: "family").getNode(1, 1))
        addItem(x: 9, y: 9, item: r1, z: bg.zPosition)
        _mapMatrix[9][9] = CELL_ROLE
        
        let r2 = UIRole()
        r2.create(roleNode: SKTexture(imageNamed: "priest").getNode(1, 0))
        addItem(x: 6, y: 4, item: r2, z: bg.zPosition)
        _mapMatrix[4][6] = CELL_ROLE
        
        let roof = SKSpriteNode(texture: SKTexture(imageNamed: "hotel_inner_roof"))
        roof.size = CGSize(width: cellSize * 13, height: cellSize * 13)
        addItem(x: 0, y: 13, item: roof, width: 12)
        for x in 0...12 {
            _mapMatrix[0][x] = CELL_BLOCK
            _mapMatrix[1][x] = CELL_BLOCK
            _mapMatrix[2][x] = CELL_BLOCK
            _mapMatrix[3][x] = CELL_BLOCK
            _mapMatrix[13][x] = CELL_BLOCK
        }
        
        for y in 0...13 {
            _mapMatrix[y][0] = CELL_BLOCK
            _mapMatrix[y][12] = CELL_BLOCK
        }
        let blockPoints:Array<Array<CGFloat>> = [
                    [3, 4],
                    [4, 5],
                    [5, 4],
                    [7,4],
                    [8,5],
                    [9,4],
                    [1,8],
                    [2,8],
                    [3,8],
                    [9,8],
                    [10,8],
                    [11,8],
                    [2,9],
                    [4,10],
                    [4,11],
                    [4,12],
                    [10,9],
                    [8,10],
                    [8,11],
                    [8,12],
//                    [11,8],
//                    [2,9],
//                    [3,9],
//                    [4,9],
//                    [5,9],
//                    [9,9],
//                    [10,9]
                ]
        for p in blockPoints {
            _mapMatrix[p[1].toInt()][p[0].toInt()] = CELL_BLOCK
        }
        
        _mapMatrix[13][6] = CELL_EMPTY
        _mapMatrix[4][3] = CELL_BED
        
    }
    override func moveEndAction() {
        let pos = convertPixelToIndex(x: _role.position.x, y: _role.position.y)
        if pos.x == 6 && pos.y == 13 {
            let cc = Hotel()
            let char = _role!
            Game.instance.curStage.switchScene(next: cc, completion: {
                cc.setRole(x: 7, y: 2, char: char)
                char.faceSouth()
            })
        }
    }
    private let CELL_BED = 1991
    override func hasAction(cell: Int, touchPoint: CGPoint) -> Bool {
            let point = convertPixelToIndex(x: touchPoint.x, y: touchPoint.y)
            
            if point.y == 4 && point.x == 6 && cell == CELL_ROLE {
                let p = MinionTradingPanel()
                p.create()
                Game.instance.curStage.showPanel(p)
                return true
            } else if cell == CELL_ROLE && point.equalTo(CGPoint(x: 9, y: 9)) {
//                let role = getNextCellItem(x: 9, y: 9) as! UIRole
//                role.speak(text: "555..")
                let stage = Game.instance.curStage!
                stage.showDialog(img: SKTexture(imageNamed: "Suvya").getCell(1, 0),
                                         text: "受伤好重呀，要我帮你治疗吗？",
                                         name: "护士小埋")
                stage._curDialog?.addConfirmButton()
                stage._curDialog?._confirmAction = {
                    setTimeout(delay: 0.5, completion: {
                        let char = Game.instance.curStage._curScene._role!
                        for m in Game.instance.char._minions {
                            m._extensions.hp = m._extensions.health
                        }
                        
                        Sound.play(node: char, fileName: "heal")
                        char.recovery1f() {
                            char._unit._extensions.hp = char.getHealth()
                            Game.instance.curStage.setBarValue()
                        }
                    })
                    stage.removeDialog(dlg: stage._curDialog!)
                }
                
                return true
            }
            if cell == CELL_ITEM || cell == CELL_ROLE || cell == CELL_BED {
                return true
            }
            return false
        }
    

}

