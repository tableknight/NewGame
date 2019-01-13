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
        self.halfSize = 5
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
                    w.create(level:level)
                    sp._goodsList.append(w)
                }
                sp.create()
                stage.showPanel(sp)
            }
            return true
        }
        if cell == CELL_ROLE && point.equalTo(CGPoint(x: 4, y: 0)) {
            let role = getNextCellItem(x: 4, y: 0) as! UIRole
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
                for i in 0...6 {
                    let w = RandomWeapon()
                    if i == 6 {
                        w.price = 50
                    }
                    w.weaponId = i
                    w._name = "\(l.getWeaponById(id: i)._name)?"
                    sp._goodsList.append(w)
                }
                sp.create()
                stage.showPanel(sp)
            }
            return true
        }
        if cell == CELL_ROLE && point.equalTo(CGPoint(x: 8, y: 1)) {
            let role = getNextCellItem(x: 8, y: 1) as! UIRole
            let stage = Game.instance.curStage!
            stage.showDialog(img: role._roleNode.texture!,
                             text: "交易，来一发？",
                             name: "防具大师范铁隆")
            let dlg = stage._curDialog!
            dlg.addConfirmButton()
            dlg._confirmAction = {
                stage.removeDialog(dlg: dlg)
                let sp = SellingPanel()
                let level = Game.instance.char._level
                let l = Loot()
                
                sp._goodsList = []
                for i in 0...3 {
                    let w = l.getArmorById(id: i)
                    w.create(level:level)
                    sp._goodsList.append(w)
                }
                sp.create()
                stage.showPanel(sp)
            }
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
                    let a = RandomArmor()
                    if i == 3 {
                        a.price = 50
                    }
                    a.armorId = i
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
        if pos.x == _doorX.toFloat() && pos.y == halfSize * 2 - 1 {
            let cc = CenterCamping()
            let char = _role!
            Game.instance.curStage.switchScene(next: cc, afterCreation: {
                cc.setRole(x: 10, y: 9, char: char)
                char.faceSouth()
            }, completion: {})
        }
    }
    override func create() {
        super.create()
        let ic = Game.instance.inside_c
        let ib = Game.instance.inside_b
        let ti = Game.instance.tile_innerTown
        let z = MyScene.ITEM_LAYER_Z + 50
        let y:CGFloat = -1.5
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
        addItem(x: 1, y: 3, item: Table1(), width: 0)
        //        addItem(x: 0.5, y: y, item: ic.getNode(11, 2))
        //        addItem(x: 2, y: y, item: ic.getNode(14, 0))
        //        addItem(x: 3.5, y: y, item: ic.getNode(15, 0))
        //        addItem(x: 6.5, y: y, item: ic.getNode(12, 1))
        //        addItem(x: 8, y: y, item: ic.getNode(15, 1))
        //        addItem(x: 9.5, y: y, item: ic.getNode(14, 1))
        //        addItem(x: 3.5, y: 4.25, item: ic.getNode(10, 0), z:z + 1)
        //        addItem(x: 6.5, y: 4.25, item: ic.getNode(10, 1), z:z + 1)
        //        addItem(x: 5, y: 5, item: ib.getNode(14, 1, 1, 2), z:z + 1)
        //        addItem(x: 0, y: 6, item: ti.getNode(9, 6, 1, 2), z:z + 1)
        //        addItem(x: 10, y: 6, item: ti.getNode(10, 6, 1, 2), z:z + 1)
        //        addItem(x: 0, y: 0, item: ic.getNode(14, 6, 1, 2))
        //        addItem(x: 1, y: 0, item: ic.getNode(14, 6, 1, 2))
        //        addItem(x: 0, y: 1, item: ic.getNode(14, 6, 1, 2))
        //        addItem(x: 9, y: 0, item: OutfitShow1())
        //        addItem(x: 10, y: 0, item: OutfitShow2())
        //        addItem(x: 10, y: 1, item: OutfitShow3())
        //        let r1 = UIRole()
        //        r1.create(roleNode: Game.instance.pictureBaldo.getNode(1, 0))
        //        addItem(x: 2, y: 1, item: r1)
        //
        //        let r2 = UIRole()
        //        r2.create(roleNode: Game.instance.pictureBaldo.getNode(7, 4))
        //        addItem(x: 8, y: 1, item: r2)
        //
        //        let sst = SKTexture(imageNamed: "secret_seller").getCell(1, 0)
        //
        //        let ss1 = UIRole()
        //        ss1.create(roleNode: SKSpriteNode(texture: sst))
        //        addItem(x: 4, y: 0, item: ss1)
        //        let ss2 = UIRole()
        //        ss2.create(roleNode: SKSpriteNode(texture: sst))
        //        addItem(x: 6, y: 0, item: ss2)
        //
        //        createWall(x: 6, y: 5, width: 2)
        //        createWall(x: 9, y: 5, width: 2)
        //        createWall(x: 3, y: 5, width: 2)
        //        createWall(x: 0, y: 5, width: 2)
        //        createWall(x: 5, y: 0, height: 6)
        //        addItem(x: 5, y: 3, item: _roofSets.bottomConnect, z: z)
        //        addItem(x: 11, y: 3, item: _roofSets.rightConnect)
        //        addItem(x: -1, y: 3, item: _roofSets.leftConnect)
        //        addItem(x: 7, y: 3, item: _roofSets.leftEnd, z: z)
        //        addItem(x: 1, y: 3, item: _roofSets.leftEnd, z: z)
        //        addItem(x: 9, y: 3, item: _roofSets.rightEnd, z: z)
        //        addItem(x: 3, y: 3, item: _roofSets.rightEnd, z: z)
        //        let s = _roofSets.topConnect
        //        addItem(x: 5, y: -3, item: s, z: z)
        //
        //        let itemPoints:Array<Array<Int>> = [
        //            [0, 0],
        //            [1, 0],
        //            [0, 1],
        //            [9, 0],
        //            [10, 0],
        //            [10, 1],
        //            [5, 0],
        //            [5, 1],
        //            [5, 2],
        //            [5, 3],
        //            [5, 4],
        //            [5, 5],
        //            [0, 5],
        //            [1, 5],
        //            [3, 5],
        //            [4, 5],
        //            [5, 5],
        //            [6, 5],
        //            [7, 5],
        //            [9, 5],
        //            [10, 5],
        //            [0, 6],
        //            [10, 6],
        //            ]
        //        for p in itemPoints {
        //            _mapMatrix[p[1]][p[0]] = CELL_ITEM
        //        }
        //        let roleoints:Array<Array<Int>> = [[2,1],[8,1],[4,0],[6,0]]
        //        for p in roleoints {
        //            _mapMatrix[p[1]][p[0]] = CELL_ROLE
        //        }
    }
    private let CELL_ROLE = 151
}
