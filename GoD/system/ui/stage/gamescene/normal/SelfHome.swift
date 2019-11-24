//
//  SelfHome.swift
//  GoD
//
//  Created by kai chen on 2018/12/31.
//  Copyright © 2018年 Chen. All rights reserved.
//


import SpriteKit
class SelfHome: InnerHouse {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        hSize = 8
        vSize = 8
        _name = "民宅"
        _doorX = 6
        _roofSets = RoofSets()
        _bottomWallTexture = Game.instance.inside_a5.getCell(1, 3)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private let CELL_DOOR = 150
    private let CELL_ROLE = 151
    private let CELL_ROAD = 152
    private let CELL_BOARD = 150
    override func hasAction(cell: Int, touchPoint: CGPoint) -> Bool {
        let point = convertPixelToIndex(x: touchPoint.x, y: touchPoint.y)
        
        if cell == CELL_ITEM {
            if point.x == 4 && point.y == 1 {
                let char = Game.instance.curStage._curScene._role!
                for m in Game.instance.char._minions {
                    m._extensions.hp = m._extensions.health
                }
                char.recovery1f() {
                    char._unit._extensions.hp = char.getHealth()
                    Game.instance.curStage.setBarValue()
                }
                
                let stage = Game.instance.curStage!
                stage.showDialog(img: SKTexture(imageNamed: "family").getCell(1, 0), text: "欢迎回家！", name: "小美")
                let dlg = stage._curDialog!
                let item = getNextCellItem(x: 4, y: 1)
                dlg._battleAction = {
                    stage.removeDialog(dlg: dlg)
                    let battle = MiTyanBattle()
                    battle.setEnemyPart(minions: Array<Creature>())
                    let i = Game.instance
                    battle.setPlayerPart(roles: [i.char] + i.char.getReadyMinions())
                    stage.addBattle(battle)
                    battle.battleStart()
                    battle.defeatAction = {
                        item.speak(text: "你真厉害！")
                    }
                    battle.defeatedAction = {
                        item.speak(text: "下次加油！")
                    }
                }
                
                
                return true
            }
        }
        return false
    }
    
    override func moveEndAction() {
        let pos = convertPixelToIndex(x: _role.position.x, y: _role.position.y)
        if pos.x == 6 && pos.y == vSize - 1 {
            let cc = CenterCamping()
            let char = _role!
            Game.instance.curStage.switchScene(next: cc, completion: {
                cc.setRole(x: 11, y: 2, char: char)
            })
        }
    }
    override func create() {
        let ia4 = Game.instance.inside_a4
        _mapSet = GroundSets(ground: ia4.getCell(0, 7, 2, 2), wall: ia4.getCell(0, 9, 2, 2))
        super.create()
        let ib = Game.instance.inside_b
        let ic = Game.instance.inside_c
        let bed = ib.getNode(1, 11, 2, 2)
        bed.size = CGSize(width: cellSize * 2, height: cellSize * 3)
        addItem(x: 0, y: 1, item: bed, width: 0)
        addItem(x: 4, y: 4, item: ib.getNode(0, 13, 1, 2))
        addItem(x: 5, y: 3, item: ib.getNode(0, 13))
        addItem(x: 2, y: 0, item: ic.getNode(2, 11))
//        addItem(x: 5, y: 0, item: ib.getNode(0, 9, 4, 2), z: MyScene.MAP_LAYER_Z)
//        addItem(x: 5, y: 3, item: ib.getNode(4, 7, 4, 2), z: MyScene.MAP_LAYER_Z)
//        addItem(x: 0, y: 6, item: ib.getNode(9, 15))
//        addItem(x: 1, y: 6, item: ib.getNode(9, 15))
        addItem(x: 7, y: 0, item: ib.getNode(2, 7, 2, 2), width: 0)
        addItem(x: 3.5, y: -1.5, item: ib.getNode(12, 4, 2, 1), width: 0)
        let wife = UIRole()
        wife.create(roleNode: SKTexture(imageNamed: "family").getNode(1, 0))
        addItem(x: 4, y: 1, item: wife)
//        addItem(x: 6, y: -1, item: ib.getNode(1, 3, 1, 2))
        
        let itemPoints:Array<Array<Int>> = [
            [0, 0],
            [1, 0],
            [0, 1],
            [1, 1],
            [2, 0],
            [7, 0],
            [8, 0],
            [4, 1],
            [4, 4],
            [4, 3],
            [5, 3],
        ]
        for p in itemPoints {
            _mapMatrix[p[1]][p[0]] = CELL_ITEM
        }
    }
    
}

