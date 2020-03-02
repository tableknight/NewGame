//
//  CenterV.swift
//  GoD
//
//  Created by kai chen on 2019/12/31.
//  Copyright © 2019 Chen. All rights reserved.
//


import SpriteKit
class ArmorHouse: StandScene {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _name = "铁匠铺"
        _nameLabel.text = _name
        _vSize = 14
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func create() {
        let level = Game.instance.char._level
        let l = Loot()
        for i in 0...6 {
            let w = l.getWeaponById(id: i)
            w.create(level:level.toInt())
            
            _sellingWeapons.append(w)
        }
        for i in 0...4 {
            let w = l.getArmorById(id: i)
            w.create(level:level.toInt())
            _sellingArmors.append(w)
        }
        
        createMapMatrix()
        let bg = SKSpriteNode(texture: SKTexture(imageNamed: "armor_house"))
        bg.size = CGSize(width: cellSize * 13, height: cellSize * 14)
        bg.yAxis = cellSize * 0.5
        addChild(bg)
        let roof = SKSpriteNode(texture: SKTexture(imageNamed: "armor_house_roof"))
        roof.size = CGSize(width: cellSize * 13, height: cellSize * 14)
        addItem(x: 0, y: 13, item: roof, width: 12)
        
        for x in 0...12 {
            _mapMatrix[0][x] = CELL_BLOCK
            _mapMatrix[13][x] = CELL_BLOCK
        }
        
        for x in 0...12 {
            _mapMatrix[3][x] = CELL_BLOCK
        }
        let blockPoints:Array<Array<CGFloat>> = [
                    [1, 7],
                    [2, 7],
                    [10, 7],
                    [11,7],
                    [1,8],
                    [11,8],
                    [5,8],
                    [7,8],
                    [6,8],
                    [5,7],
                    [6,7],
                    [7,7],
                    [5,5],
                    [7,5],
                    [6,5],
                    [6,4]
                ]
        for p in blockPoints {
            _mapMatrix[p[1].toInt()][p[0].toInt()] = CELL_BLOCK
        }
        
        let r1 = UIRole()
        r1.create(roleNode: SKTexture(imageNamed: "Vanteron").getNode(1, 0))
        addItem(x: 3, y: 4, item: r1)
        _mapMatrix[4][3] = CELL_ROLE

        let r2 = UIRole()
        r2.create(roleNode: SKTexture(imageNamed: "Ginly").getNode(1, 0))
        addItem(x: 9, y: 4, item: r2)
        _mapMatrix[4][9] = CELL_ROLE
        
        let ss1 = UIRole()
        ss1.create(roleNode: SKTexture(imageNamed: "seller").getNode(1, 0))
        addItem(x: 2, y: 6, item: ss1)
        _mapMatrix[6][2] = CELL_ROLE
        
        let ss2 = UIRole()
        ss2.create(roleNode: SKTexture(imageNamed: "seller").getNode(1, 0))
        addItem(x: 10, y: 6, item: ss2)
        _mapMatrix[6][10] = CELL_ROLE
        
        _mapMatrix[13][6] = CELL_EMPTY
    }
    override func moveEndAction() {
        let pos = convertPixelToIndex(x: _role.position.x, y: _role.position.y)
        if pos.x == 6 && pos.y == 13 {
            let cc = EastV()
            let char = _role!
            Game.instance.curStage.switchScene(next: cc, completion: {
                cc.setRole(x: 3, y: 9, char: char)
                char.faceSouth()
            })
        }
    }
    private var _sellingWeapons = Array<Outfit>()
    private var _sellingArmors = Array<Outfit>()
    override func hasAction(cell: Int, touchPoint: CGPoint) -> Bool {
            let point = convertPixelToIndex(x: touchPoint.x, y: touchPoint.y)
            if cell == CELL_ROLE && point.equalTo(CGPoint(x: 9, y: 4)) {
                let role = getNextCellItem(x: 9, y: 4) as! UIRole
                let stage = Game.instance.curStage!
                stage.showDialog(img: role._roleNode.texture!,
                                 text: "王国第一铁匠岂是浪得虚名？要不要看看我的货呀？",
                                 name: "武器大师范铁隆", action: {
                                    
                                    let dlg = stage._curDialog!
                                    dlg.addConfirmButton()
                                    dlg._confirmAction = {
                                        stage.removeDialog(dlg: dlg)
                                        let sp = SellingPanel()
                                        sp._goodsList = self._sellingWeapons
                                        sp.create()
                                        stage.showPanel(sp)
                                    }
                })
                return true
            }
            if cell == CELL_ROLE && point.equalTo(CGPoint(x: 10, y: 6)) {
                let role = getNextCellItem(x: 10, y: 6) as! UIRole
                let stage = Game.instance.curStage!
                stage.showDialog(img: role._roleNode.texture!,
                                 text: "你想的，你要的，你追求的，我全都有，看看吗？",
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
                                            let w = Item(Item.RandomWeapon)
                                            w._reserveInt = i //index of weapon type
                                            w._reserveBool = true
                                            w._name = "\(l.getWeaponById(id: i)._name)?"
                                            sp._goodsList.append(w)
                                        }
                                        sp.create()
                                        sp.hasBuyAction = true
                                        sp.buyAction = {
                                            let item = sp._lastSelectedIcon as! SellingItemIcon
                                            let r = item._displayItem as! Item
                                            let i = r._reserveInt
                                            let wp = l.getWeaponById(id: i)
                                            wp.create(level: Game.instance.char._level.toInt())
                                            Game.instance.char.addItem(wp)
                                        }
                                        stage.showPanel(sp)
                                    }
                })
                return true
            }
            if cell == CELL_ROLE && point.equalTo(CGPoint(x: 3, y: 4)) {
                let role = getNextCellItem(x: 3, y: 4) as! UIRole
                let stage = Game.instance.curStage!
                stage.showDialog(img: role._roleNode.texture!,
                                 text: "哼，不买不要碰！",
                                 name: "防具大师金利", action: {
                                    
                                    let dlg = stage._curDialog!
                                    dlg.addConfirmButton()
                                    dlg._confirmAction = {
                                        stage.removeDialog(dlg: dlg)
                                        let sp = SellingPanel()
                                        sp._goodsList = self._sellingArmors
                                        
                                        sp.create()
                                        stage.showPanel(sp)
                                    }
                })
                return true
            }
            if cell == CELL_ROLE && point.equalTo(CGPoint(x: 2, y: 6)) {
                let role = getNextCellItem(x: 2, y: 6) as! UIRole
                let stage = Game.instance.curStage!
                stage.showDialog(img: role._roleNode.texture!,
                                 text: "我喜欢在夜晚交易，你呢？",
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
                                            let a = Item(Item.RandomArmor)
                                            a._reserveInt = i
                                            a._reserveBool = true
                                            a._name = "\(l.getArmorById(id: i)._name)?"
                                            sp._goodsList.append(a)
                                        }
                                        sp.create()
                                        sp.hasBuyAction = true
                                        sp.buyAction = {
                                            let item = sp._lastSelectedIcon as! SellingItemIcon
                                            let r = item._displayItem as! Item
                                            let i = r._reserveInt
                                            let ar = l.getArmorById(id: i)
                                            ar.create(level: Game.instance.char._level.toInt())
                                            Game.instance.char.addItem(ar)
                                        }
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

}

