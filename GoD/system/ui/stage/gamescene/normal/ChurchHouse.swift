//
//  MagicHouse.swift
//  GoD
//
//  Created by kai chen on 2019/1/11.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class ChurchHouse: InnerHouse {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        hSize = 10
        vSize = 10
        _name = "铁匠铺"
        _doorX = 5
        let i4 = Game.instance.inside_a4
        let i2 = Game.instance.inside_a2
        _roofSets = RoofSets(texture: i2.getCell(6, 5, 2, 2), corner: i2.getCell(7, 3))
        _wallTexture = i4.getCell(12, 12, 2, 2)
        _bottomWallTexture = Game.instance.inside_a5.getCell(3, 7)
        _mapSet = GroundSets(ground: i2.getCell(4, 8, 2, 2), wall: Game.instance.inside_a5.getCell(5, 7))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func hasAction(cell: Int, touchPoint: CGPoint) -> Bool {
        let point = convertPixelToIndex(x: touchPoint.x, y: touchPoint.y)
        let itemPoints:Array<Array<Int>> = [
            [1,2],
            [3,2],
            [1,5],
            [3,5],
            [1,8],
            [3,8],
            [7,2],
            [9,2],
            [7,5],
            [9,5],
            [9,8],
            ]
        for p in itemPoints {
            if cell == CELL_ITEM && point.equalTo(CGPoint(x: p[0].toFloat(), y: p[1].toFloat())) {
                let tower = getNextCellItem(x: p[0], y: p[1]) as! Tower
                tower.showDialog()
                return true
            }
        }
        if cell == CELL_ROLE && point.equalTo(CGPoint(x: 2, y: 1)) {
            let role = getNextCellItem(x: 2, y: 1) as! UIRole
            let stage = Game.instance.curStage!
            stage.showDialog(img: role._roleNode.texture!,
                             text: "交易，来一发？",
                             name: "武器大师范铁隆")
            let dlg = stage._curDialog!
            dlg.addConfirmButton()
            dlg._confirmAction = {
                stage.removeDialog(dlg: dlg)
                let sp = SellingPanel()
                let level = Game.instance.char._level
                let l = Loot()
                
                sp._goodsList = []
                for i in 0...6 {
                    let w = l.getWeaponById(id: i)
                    w.create(level:level.toInt())
                    sp._goodsList.append(w)
                }
                sp.create()
                stage.showPanel(sp)
            }
            return true
        }
        if cell == CELL_ROLE && point.equalTo(CGPoint(x: 5, y: 0)) {
            let role = getNextCellItem(x: 5, y: 0) as! UIRole
            role.speak(text: "愿诸神保佑你。")
            return true
        }
        
        if cell == CELL_ROLE && point.equalTo(CGPoint(x: 6, y: 0)) {
            let role = getNextCellItem(x: 6, y: 0) as! UIRole
            let stage = Game.instance.curStage!
            stage.showDialog(img: role._roleNode.texture!,
                             text: "交易，来一发？",
                             name: "神秘商人")
            let dlg = stage._curDialog!
            dlg.addConfirmButton()
            dlg._confirmAction = {
                stage.removeDialog(dlg: dlg)
                let sp = SellingPanel()
                //                let level = Game.instance.char._level
                let l = Loot()
                sp._goodsList = []
                for i in 0...3 {
                    let a = Item(Item.RandomArmor)
                    if i == 3 {
                        a.price = 50
                    }
                    a._reserveInt = i
                    a._name = "\(l.getArmorById(id: i)._name)?"
                    sp._goodsList.append(a)
                }
                sp.create()
                stage.showPanel(sp)
            }
            return true
        }
        if cell == CELL_ITEM || cell == CELL_ROLE {
            return true
        }
        return false
    }
    
    private func createRandomWeapon() {
        
    }
    
    override func moveEndAction() {
        let pos = convertPixelToIndex(x: _role.position.x, y: _role.position.y)
        if pos.x == _doorX.toFloat() && pos.y == vSize {
            let cc = CenterCamping()
            let char = _role!
            Game.instance.curStage.switchScene(next: cc, completion: {
                cc.setRole(x: 10, y: 9, char: char)
                char.faceSouth()
            })
        }
    }
    override func create() {
        super.create()
//        let ic = Game.instance.inside_c
        let ib = Game.instance.inside_b
        let ti = Game.instance.tile_innerTown
//        let z = MyScene.ITEM_LAYER_Z + 50
//        let y:CGFloat = -1.5
        let t = ib.getCell(9, 3, 1, 2)
        let a2 = Game.instance.inside_a2
        addItem(x: 0, y: -1, item: SKSpriteNode(texture: t))
        addItem(x: 1, y: -1, item: SKSpriteNode(texture: t))
        addItem(x: 2, y: -1, item: SKSpriteNode(texture: t))
        addItem(x: 3, y: -1, item: SKSpriteNode(texture: t))
        addItem(x: 10, y: -1, item: SKSpriteNode(texture: t))
        addItem(x: 9, y: -1, item: SKSpriteNode(texture: t))
        addItem(x: 8, y: -1, item: SKSpriteNode(texture: t))
        addItem(x: 7, y: -1, item: SKSpriteNode(texture: t))
        addItem(x: 4, y: -1, item: ib.getNode(10, 3, 1, 2))
        addItem(x: 6, y: -1, item: ib.getNode(11, 3, 1, 2))
        for i in 0...9 {
            addItem(x: 5, y: i.toFloat(), item: a2.getNode(4, 10.5, 2, 1), z:MyScene.MAP_LAYER_Z)
        }
        addItem(x: 4, y: 1, item: ti.getNode(8, 10, 3, 2), width: 0)
//        addItem(x: 1, y: 2.5, item: Table1(), width: 0)
//        addItem(x: 1, y: 5, item: Table1(), width: 0)
//        addItem(x: 1, y: 7.5, item: Table1(), width: 0)
//        addItem(x: 8, y: 2.5, item: Table1(), width: 0)
//        addItem(x: 8, y: 5, item: Table1(), width: 0)
//        addItem(x: 8, y: 7.5, item: Table1(), width: 0)
        
        let r1 = UIRole()
        r1.create(roleNode: Game.instance.picturePeople2.getNode(7, 0))
        addItem(x: 5, y: 0, item: r1, z:MyScene.MAP_LAYER_Z)
        
//        setCell(x: 1, y: 8, width: 2, height: 2)
//        setCell(x: 1, y: 5, width: 2, height: 2)
//        setCell(x: 1, y: 3, width: 2, height: 2)
//        setCell(x: 8, y: 8, width: 2, height: 2)
//        setCell(x: 8, y: 5, width: 2, height: 2)
//        setCell(x: 8, y: 3, width: 2, height: 2)
        setCell(x: 4, y: 1, width: 3, height: 1)
        _mapMatrix[0][5] = CELL_ROLE

        addItem(x: 1, y: 2, item: FireEnergeTower())
        addItem(x: 3, y: 2, item: WaterEnergeTower())
        addItem(x: 2, y: 2, item: SKSpriteNode(texture: _wallShadow))
        addItem(x: 4, y: 2, item: SKSpriteNode(texture: _wallShadow))
        
        _mapMatrix[2][1] = CELL_ITEM
        _mapMatrix[2][3] = CELL_ITEM
        
        addItem(x: 1, y: 5, item: ThunderEnergeTower())
        addItem(x: 3, y: 5, item: TimeReduceTower())
        addItem(x: 2, y: 5, item: SKSpriteNode(texture: _wallShadow))
        addItem(x: 4, y: 5, item: SKSpriteNode(texture: _wallShadow))
        
        _mapMatrix[5][1] = CELL_ITEM
        _mapMatrix[5][3] = CELL_ITEM
        
        addItem(x: 1, y: 8, item: PhysicalPowerTower())
        addItem(x: 3, y: 8, item: MagicalPowerTower())
        addItem(x: 2, y: 8, item: SKSpriteNode(texture: _wallShadow))
        addItem(x: 4, y: 8, item: SKSpriteNode(texture: _wallShadow))
        
        _mapMatrix[8][1] = CELL_ITEM
        _mapMatrix[8][3] = CELL_ITEM
        
        addItem(x: 7, y: 2, item: AttackPowerTower())
        addItem(x: 9, y: 2, item: DefencePowerTower())
        addItem(x: 8, y: 2, item: SKSpriteNode(texture: _wallShadow))
        addItem(x: 10, y: 2, item: SKSpriteNode(texture: _wallShadow))
        
        _mapMatrix[2][7] = CELL_ITEM
        _mapMatrix[2][9] = CELL_ITEM
        
        addItem(x: 7, y: 5, item: MindPowerTower())
        addItem(x: 9, y: 5, item: LuckyPowerTower())
        addItem(x: 8, y: 5, item: SKSpriteNode(texture: _wallShadow))
        addItem(x: 10, y: 5, item: SKSpriteNode(texture: _wallShadow))
        
        _mapMatrix[5][7] = CELL_ITEM
        _mapMatrix[5][9] = CELL_ITEM
        
//        addItem(x: 7, y: 8, item: MindPowerTower())
        addItem(x: 9, y: 8, item: SpeedPowerTower())
        addItem(x: 10, y: 8, item: SKSpriteNode(texture: _wallShadow))
        
//        _mapMatrix[2][7] = CELL_ITEM
        _mapMatrix[8][10] = CELL_ITEM
        
        
    }
}
