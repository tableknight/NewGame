//
//  MagicHouse.swift
//  GoD
//
//  Created by kai chen on 2019/1/11.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class MagicHouse: InnerHouse {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
//        self.halfSize = 5
        hSize = 10
        vSize = 10
        _name = "魔法屋"
        _doorX = 5
        let i4 = Game.instance.inside_a4
        let i2 = Game.instance.inside_a2
        _roofSets = RoofSets(texture: i2.getCell(4, 2, 2, 2), corner: i2.getCell(5, 0))
        _wallTexture = i4.getCell(12, 12, 2, 2)
        _bottomWallTexture = Game.instance.inside_a5.getCell(1, 7)
        _mapSet = GroundSets(ground: i2.getCell(6, 2, 2, 2), wall: Game.instance.inside_a5.getCell(5, 7))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func hasAction(cell: Int, touchPoint: CGPoint) -> Bool {
        let point = convertPixelToIndex(x: touchPoint.x, y: touchPoint.y)
        if cell == CELL_ROLE && point.equalTo(CGPoint(x: 1, y: 1)) {
            let role = getNextCellItem(x: 1, y: 1) as! UIRole
            let stage = Game.instance.curStage!
            stage.showDialog(img: role._roleNode.texture!,
                             text: "人们对造物主总是充满了好奇，我愿意与你分享这份秘密，不过需要付出一些代价，你是否能够接受？",
                             name: "大魔法师梅露露", action: {
                                let dlg = stage._curDialog!
                                dlg.addConfirmButton()
                                dlg._confirmAction = {
                                    stage.removeDialog(dlg: dlg)
                                    let sp = SellingPanel()
                                    sp._priceType = 1
                                    sp._goodsList = [RandomSacredSpell()]
                                    sp.create()
                                    sp.hasBuyAction = true
                                    sp.buyAction = {
                                        let l = Loot()
                                        let s = l.getSacredSpell(id: self.seed(max: l.sacredSpellCount))
                                        let sb = SpellBook()
                                        sb.spell = s
                                        Game.instance.char.addProp(p: sb)
                                    }
                                    stage.showPanel(sp)
                                }
            })
            return true
        }
        if cell == CELL_ROLE && point.equalTo(CGPoint(x: 5, y: 4)) {
            let role = getNextCellItem(x: 5, y: 4) as! UIRole
            let stage = Game.instance.curStage!
            
            stage.showDialog(img: role._roleNode.texture!,
                             text: "知识是力量的源泉，书籍是知识的海洋，魔法是遨游于海洋的方舟，我这么说你明白吗？？",
                             name: "大魔法师欧德林", action: {
                                let dlg = stage._curDialog!
                                dlg.addConfirmButton()
                                dlg._confirmAction = {
                                    stage.removeDialog(dlg: dlg)
                                    let sp = SellingPanel()
                                    sp._priceType = 1
                                    sp._goodsList = self._sellingBooks
                                    
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
        if pos.equalTo(CGPoint(x: 9, y: 0)) {
            let i = getNextCellItem(x: 9, y: -1)
            setTimeout(delay: 1, completion: i.triggerEvent)
            return
        }
        if pos.x == _doorX.toFloat() && pos.y == vSize - 1 {
            let cc = EastCamping()
            let char = _role!
            Game.instance.curStage.switchScene(next: cc, completion: {
                cc.setRole(x: 5, y: 2, char: char)
                char.faceSouth()
            })
        }
    }
    override func create() {
        super.create()
        let z = MyScene.ROLE_LAYER_Z - 5
        let ti = Game.instance.tile_innerTown
        let ic = Game.instance.inside_c
        addItem(x: 3, y: 4, item: ti.getNode(0, 5, 8, 1), width: 0, z:z)
        addItem(x: 3, y: 3, item: ti.getNode(0, 4, 8, 2), width: 0)
        
        addItem(x: 0, y: 1, item: ti.getNode(0, 2, 8, 1), width: 0, z:z)
        addItem(x: 0, y: 0, item: ti.getNode(0, 1, 8, 2), width: 0)
        
        addItem(x: 0, y: 7, item: ti.getNode(0, 11, 8, 1), width: 0, z:z)
        addItem(x: 0, y: 6, item: ti.getNode(0, 10, 8, 2), width: 0)
        
        addItem(x: 8, y: 0, item: ic.getNode(4, 14))
        
        let r1 = UIRole()
        r1.create(roleNode: SKTexture(imageNamed: "Mei_lulu").getNode(1, 3))
        addItem(x: 1, y: 1, item: r1)
        
        let r2 = UIRole()
        r2.create(roleNode: SKTexture(imageNamed: "Oldlin").getNode(1, 0))
        addItem(x: 5, y: 4, item: r2)
        addGround(x: 0, y: 3, item: ic.getNode(1, 7))
        addGround(x: 2, y: 4, item: ic.getNode(4, 7))
        addItem(x: 10, y: 4, item: ic.getNode(0, 14))
        addItem(x: 9, y: -1, item: Mirror1())
        
        let itemPoints:Array<Array<Int>> = [
            [8, 0],
            [10, 4],
        ]
        for p in itemPoints {
            _mapMatrix[p[1]][p[0]] = CELL_ITEM
        }
        for x in 0...7 {
            _mapMatrix[0][x] = CELL_ITEM
            _mapMatrix[6][x] = CELL_ITEM
        }
        for x in 3...10 {
            _mapMatrix[3][x] = CELL_ITEM
        }
        let roleoints:Array<Array<Int>> = [[1,1],[5,4]]
        for p in roleoints {
            _mapMatrix[p[1]][p[0]] = CELL_ROLE
        }
        
        let l = Loot()
        var list = Array<SpellBook>()
        for _ in 0...9 {
            let b = SpellBook()
            let s = self.seed(max: 3)
            var spell = l.getRandomNormalSpell()
            if 1 == s {
                spell = l.getRandomGoodSpell()
            } else if 2 == s {
                spell = l.getRandomRareSpell()
            }
            b.spell = spell
            list.append(b)
        }
        _sellingBooks = list
    }
    private let CELL_ROLE = 151
    private var _sellingBooks = Array<SpellBook>()
}

class Table1:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.texture = Game.instance.inside_b.getCell(2, 12)
        self.size = CGSize(width: cellSize * 2, height: cellSize * 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class Mirror1:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.dungeon_c.getCell(9, 13, 1, 2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func triggerEvent() {
        
        self.texture = Game.instance.dungeon_c.getCell(11, 13, 1, 2)
    }
}

