//
//  OutfitStore.swift
//  GoD
//
//  Created by kai chen on 2019/1/7.
//  Copyright © 2019年 Chen. All rights reserved.
//


import SpriteKit
class OutfitStore: InnerHouse {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.halfSize = 5
        _name = "铁匠铺"
        _doorX = 5
//        let oa4 = Game.instance.sf_inside_a4
//        _roofSets = RoofSets(texture: oa4.getCell(14, 7, 2, 2), corner: oa4.getCell(15, 5))
//        let ia4 = Game.instance.inside_a4
//        _wallTexture = oa4.getCell(14, 9, 2, 2)
//        _mapSet = GroundSets(ground: ia4.getCell(0, 2, 2, 2), wall: _wallTexture)
        _roofSets = RoofSets()
        _bottomWallTexture = Game.instance.inside_a5.getCell(1, 3)
        _wallTexture = Game.instance.outside_a4.getCell(0, 9, 2, 2)
        _mapSet = GroundSets(ground: Game.instance.inside_a2.getCell(0, 5, 2, 2), wall: _wallTexture)
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
                             name: "武器大师范铁隆", action: {
                                
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
            })
            return true
        }
        if cell == CELL_ROLE && point.equalTo(CGPoint(x: 4, y: 0)) {
            let role = getNextCellItem(x: 4, y: 0) as! UIRole
            let stage = Game.instance.curStage!
            stage.showDialog(img: role._roleNode.texture!,
                             text: "交易，来一发？",
                             name: "神秘商人", action: {
                                
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
            })
            return true
        }
        if cell == CELL_ROLE && point.equalTo(CGPoint(x: 8, y: 1)) {
            let role = getNextCellItem(x: 8, y: 1) as! UIRole
            let stage = Game.instance.curStage!
            stage.showDialog(img: role._roleNode.texture!,
                             text: "交易，来一发？",
                             name: "防具大师范铁隆", action: {
                                
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
            })
            return true
        }
        if cell == CELL_ROLE && point.equalTo(CGPoint(x: 6, y: 0)) {
            let role = getNextCellItem(x: 6, y: 0) as! UIRole
            let stage = Game.instance.curStage!
            stage.showDialog(img: role._roleNode.texture!,
                             text: "交易，来一发？",
                             name: "神秘商人", action: {
                                
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
            })
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
        addItem(x: 0.5, y: y, item: ic.getNode(11, 2))
        addItem(x: 2, y: y, item: ic.getNode(14, 0))
        addItem(x: 3.5, y: y, item: ic.getNode(15, 0))
        addItem(x: 6.5, y: y, item: ic.getNode(12, 1))
        addItem(x: 8, y: y, item: ic.getNode(15, 1))
        addItem(x: 9.5, y: y, item: ic.getNode(14, 1))
        addItem(x: 3.5, y: 4.25, item: ic.getNode(10, 0), z:z + 1)
        addItem(x: 6.5, y: 4.25, item: ic.getNode(10, 1), z:z + 1)
        addItem(x: 5, y: 5, item: ib.getNode(14, 1, 1, 2), z:z + 1)
        addItem(x: 0, y: 6, item: ti.getNode(9, 6, 1, 2), z:z + 1)
        addItem(x: 10, y: 6, item: ti.getNode(10, 6, 1, 2), z:z + 1)
        addItem(x: 0, y: 0, item: ic.getNode(14, 6, 1, 2))
        addItem(x: 1, y: 0, item: ic.getNode(14, 6, 1, 2))
        addItem(x: 0, y: 1, item: ic.getNode(14, 6, 1, 2))
//        addItem(x: 1, y: -1, item: ib.getNode(10, 3, 1, 2))
//        addItem(x: 9, y: -1, item: ib.getNode(11, 3, 1, 2))
//        addItem(x: 0, y: -1, item: ib.getNode(9, 3, 1, 2))
//        addItem(x: 10, y: -1, item: ib.getNode(9, 3, 1, 2))
//        addItem(x: 3, y: -1.75, item: ic.getNode(10, 0))
//        addItem(x: 5, y: -1.75, item: ic.getNode(10, 1))
//        addItem(x: 7, y: -1.75, item: ic.getNode(11, 0))
//        addItem(x: 0, y: 0, item: ic.getNode(15, 6, 1, 2))
//        addItem(x: 1, y: 0, item: ic.getNode(15, 6, 1, 2))
//        addItem(x: 0, y: 1, item: ic.getNode(15, 6, 1, 2))
//
//        addItem(x: 10, y: 0, item: ic.getNode(15, 6, 1, 2))
//        addItem(x: 9, y: 0, item: ic.getNode(15, 6, 1, 2))
//        addItem(x: 10, y: 1, item: ic.getNode(15, 6, 1, 2))
//
        addItem(x: 9, y: 0, item: OutfitShow1())
        addItem(x: 10, y: 0, item: OutfitShow2())
        addItem(x: 10, y: 1, item: OutfitShow3())
//        addItem(x: 5, y: 1, item: OutfitShow4())
//        addItem(x: 6, y: 1, item: OutfitShow5())
//        addItem(x: 7, y: 1, item: OutfitShow6())
//        addItem(x: 8, y: 1, item: OutfitShow7())
//
//        addItem(x: 1, y: 3, item: OutfitShow7())
//        addItem(x: 2, y: 3, item: OutfitShow8())
//        addItem(x: 3, y: 3, item: OutfitShow9())
//        addItem(x: 4, y: 3, item: OutfitShow10())
//        addItem(x: 5, y: 3, item: OutfitShow11())
//        addItem(x: 6, y: 3, item: OutfitShow12())
//        addItem(x: 7, y: 3, item: OutfitShow7())
//        addItem(x: 8, y: 3, item: OutfitShow8())
//        addItem(x: 9, y: 3, item: OutfitShow9())
//
//        addItem(x: 0, y: 8, item: Game.instance.dungeon_b.getNode(12, 13, 2, 3), width: 0)
//        addItem(x: 2, y: 8, item: Game.instance.dungeon_b.getNode(12, 13, 2, 3), width: 0)
//
//        addItem(x: 7, y: 6, item: ic.getNode(12, 2, 3, 1), width: 0)
//
        let r1 = UIRole()
        r1.create(roleNode: Game.instance.pictureBaldo.getNode(1, 0))
        addItem(x: 2, y: 1, item: r1)

        let r2 = UIRole()
        r2.create(roleNode: Game.instance.pictureBaldo.getNode(7, 4))
        addItem(x: 8, y: 1, item: r2)
        
        let sst = SKTexture(imageNamed: "secret_seller").getCell(1, 0)
        
        let ss1 = UIRole()
        ss1.create(roleNode: SKSpriteNode(texture: sst))
        addItem(x: 4, y: 0, item: ss1)
        let ss2 = UIRole()
        ss2.create(roleNode: SKSpriteNode(texture: sst))
        addItem(x: 6, y: 0, item: ss2)
//
        
        createWall(x: 6, y: 5, width: 2)
        createWall(x: 9, y: 5, width: 2)
        createWall(x: 3, y: 5, width: 2)
        createWall(x: 0, y: 5, width: 2)
        createWall(x: 5, y: 0, height: 6)
        addItem(x: 5, y: 3, item: _roofSets.bottomConnect, z: z)
        addItem(x: 11, y: 3, item: _roofSets.rightConnect)
        addItem(x: -1, y: 3, item: _roofSets.leftConnect)
        addItem(x: 7, y: 3, item: _roofSets.leftEnd, z: z)
        addItem(x: 1, y: 3, item: _roofSets.leftEnd, z: z)
        addItem(x: 9, y: 3, item: _roofSets.rightEnd, z: z)
        addItem(x: 3, y: 3, item: _roofSets.rightEnd, z: z)
        let s = _roofSets.topConnect
        addItem(x: 5, y: -3, item: s, z: z)
        
//        let it = Game.instance.tile_innerTown
//        addItem(x: 3, y: 1, item: it.getNode(0, 5, 8, 3), z: MyScene.ROLE_LAYER_Z - 2)
//        addItem(x: 0, y: 4, item: it.getNode(0, 11, 8, 2), z: MyScene.ROLE_LAYER_Z - 2)
//        addItem(x: 0, y: 2, item: it.getNode(0, 9, 8, 1), width: 0)
//        addItem(x: 0, y: 7, item: it.getNode(10, 15, 5, 2), width: 0)
//        addItem(x: 9, y: -1, item: it.getNode(15, 4, 1, 2))
//        addItem(x: 1, y: -1, item: it.getNode(15, 4, 1, 2))
//        addItem(x: 5, y: -1.5, item: ib.getNode(14, 4, 2, 1), z: MyScene.ROLE_LAYER_Z - 1)
//        addItem(x: 8, y: 8, item: ib.getNode(10, 15, 1, 2))
//        addItem(x: 9, y: 8, item: ib.getNode(10, 15, 1, 2))
//        addItem(x: 10, y: 8, item: ib.getNode(10, 15, 1, 2), z:MyScene.ITEM_LAYER_Z + 8)
//        addItem(x: 10, y: 6, item: ib.getNode(10, 14))
//        addItem(x: 0, y: 9, item: it.getNode(9, 15, 1, 2), z:MyScene.MAP_LAYER_Z + 1)
//        addItem(x: 1, y: 9, item: it.getNode(9, 15, 1, 2), z:MyScene.MAP_LAYER_Z + 1)
//        addItem(x: 0, y: 8, item: it.getNode(9, 15, 1, 2), z:MyScene.ITEM_LAYER_Z + 8)
//        addItem(x: 9, y: 6, item: it.getNode(12, 15, 2, 2), z:MyScene.MAP_LAYER_Z)
//        
//        let r1 = UIRole()
//        r1.create(roleNode: Game.instance.picturePeople4.getNode(1, 3))
//        addItem(x: 1, y: 4, item: r1)
//        
//        let r2 = UIRole()
//        r2.create(roleNode: Game.instance.picturePeople4.getNode(4, 0))
//        addItem(x: 3, y: 5, item: r2)
//        
//        let r3 = UIRole()
//        r3.create(roleNode: Game.instance.picturePeople4.getNode(7, 2))
//        addItem(x: 2, y: 0, item: r3)
//        
        let itemPoints:Array<Array<Int>> = [
            [0, 0],
            [1, 0],
            [0, 1],
            [9, 0],
            [10, 0],
            [10, 1],
            [5, 0],
            [5, 1],
            [5, 2],
            [5, 3],
            [5, 4],
            [5, 5],
            [0, 5],
            [1, 5],
            [3, 5],
            [4, 5],
            [5, 5],
            [6, 5],
            [7, 5],
            [9, 5],
            [10, 5],
            [0, 6],
            [10, 6],
            ]
        for p in itemPoints {
            _mapMatrix[p[1]][p[0]] = CELL_ITEM
        }
        let roleoints:Array<Array<Int>> = [[2,1],[8,1],[4,0],[6,0]]
        for p in roleoints {
            _mapMatrix[p[1]][p[0]] = CELL_ROLE
        }
    }
    private let CELL_ROLE = 151
}

class OutfitShow1:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let ic = Game.instance.inside_c
        setTexture(ic.getCell(13, 5))
        let node = ic.getNode(8, 3)
        node.yAxis = cellSize * 0.75
        node.zPosition = self.zPosition + 1
        addChild(node)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class OutfitShow2:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let ic = Game.instance.inside_c
        setTexture(ic.getCell(13, 5))
        let node = ic.getNode(9, 3)
        node.yAxis = cellSize * 0.75
        node.zPosition = self.zPosition + 1
        addChild(node)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class OutfitShow3:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let ic = Game.instance.inside_c
        setTexture(ic.getCell(13, 5))
        let node = ic.getNode(10, 3)
        node.yAxis = cellSize * 0.75
        node.zPosition = self.zPosition + 1
        addChild(node)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class OutfitShow4:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let ic = Game.instance.inside_c
        setTexture(ic.getCell(13, 5))
        let node = ic.getNode(11, 3)
        node.yAxis = cellSize * 0.75
        node.zPosition = self.zPosition + 1
        addChild(node)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class OutfitShow5:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let ic = Game.instance.inside_c
        setTexture(ic.getCell(13, 5))
        let node = ic.getNode(12, 3)
        node.yAxis = cellSize * 0.75
        node.zPosition = self.zPosition + 1
        addChild(node)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class OutfitShow6:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let ic = Game.instance.inside_c
        setTexture(ic.getCell(13, 5))
        let node = ic.getNode(13, 3)
        node.yAxis = cellSize * 0.75
        node.zPosition = self.zPosition + 1
        addChild(node)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class OutfitShow7:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let ic = Game.instance.inside_c
        setTexture(ic.getCell(13, 5))
        let node = ic.getNode(14, 3)
        node.yAxis = cellSize
        node.zPosition = self.zPosition + 1
        addChild(node)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class OutfitShow8:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let ic = Game.instance.inside_c
        setTexture(ic.getCell(13, 5))
        let node = ic.getNode(15, 3)
        node.yAxis = cellSize
        node.zPosition = self.zPosition + 1
        addChild(node)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class OutfitShow9:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let ic = Game.instance.inside_c
        setTexture(ic.getCell(13, 5))
        let node = ic.getNode(12, 4)
        node.yAxis = cellSize
        node.zPosition = self.zPosition + 1
        addChild(node)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class OutfitShow10:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let ic = Game.instance.inside_c
        setTexture(ic.getCell(13, 5))
        let node = ic.getNode(13, 4)
        node.yAxis = cellSize
        node.zPosition = self.zPosition + 1
        addChild(node)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class OutfitShow11:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let ic = Game.instance.inside_c
        setTexture(ic.getCell(13, 5))
        let node = ic.getNode(14, 4)
        node.yAxis = cellSize
        node.zPosition = self.zPosition + 1
        addChild(node)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class OutfitShow12:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let ic = Game.instance.inside_c
        setTexture(ic.getCell(13, 5))
        let node = ic.getNode(15, 4)
        node.yAxis = cellSize
        node.zPosition = self.zPosition + 1
        addChild(node)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

