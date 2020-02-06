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
        _name = "魔法屋"
        _vSize = 14
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func hasAction(cell: Int, touchPoint: CGPoint) -> Bool {
        let point = convertPixelToIndex(x: touchPoint.x, y: touchPoint.y)
        if cell == CELL_ROLE && point.equalTo(CGPoint(x: 3, y: 4)) {
            let role = getNextCellItem(x: 3, y: 4) as! UIRole
            let stage = Game.instance.curStage!
            stage.showDialog(img: role._roleNode.texture!,
                             text: "人们对造物主总是充满了好奇，我愿意与你分享这份秘密，不过需要付出一些代价，你是否能够接受？",
                             name: "大魔法师梅露露", action: {
                                let dlg = stage._curDialog!
                                dlg.addConfirmButton()
                                dlg._confirmAction = {
                                    stage.removeDialog(dlg: dlg)
                                    let sp = SellingPanel()
                                    let book = Item(Item.RandomSpell)
                                    book._reserveBool = true
                                    book.price = 1
                                    sp._goodsList = [book]
                                    sp.create()
                                    stage.showPanel(sp)
                                }
            })
            return true
        }
        if cell == CELL_ROLE && point.equalTo(CGPoint(x: 4, y: 9)) {
            let role = getNextCellItem(x: 4, y: 9) as! UIRole
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
        if cell == CELL_ROLE && point.equalTo(CGPoint(x: 9, y: 5)) {
            let pp = PharmicPanel()
            pp.create()
            Game.instance.curStage.showPanel(pp)
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
            let cc = NorthV()
            let char = _role!
            Game.instance.curStage.switchScene(next: cc, completion: {
                cc.setRole(x: 5, y: 9, char: char)
                char.faceSouth()
            })
        }
    }
    func notEnough() {
        let role = getNextCellItem(x: 9, y: 5) as! UIRole
        role.speak(text: "材料不足！")
    }
    override func create() {
        createMapMatrix()
        let bg = SKSpriteNode(texture: SKTexture(imageNamed: "magic_house"))
        bg.size = CGSize(width: cellSize * 13, height: cellSize * 13)
//        bg.yAxis = cellSize * 0.5
        addChild(bg)
        
        let roof = SKSpriteNode(texture: SKTexture(imageNamed: "magic_house_roof"))
        addItem(x: 0, y: 13, item: roof, width: 12)
        
        let r1 = UIRole()
        r1.create(roleNode: SKTexture(imageNamed: "Mei_lulu").getNode(1, 0))
        addItem(x: 3, y: 4, item: r1)
        _mapMatrix[4][3] = CELL_ROLE
        
        let r2 = UIRole()
        r2.create(roleNode: SKTexture(imageNamed: "Oldlin").getNode(1, 0))
        addItem(x: 4, y: 9, item: r2)
        _mapMatrix[9][4] = CELL_ROLE
        
        let r3 = UIRole()
        r3.create(roleNode: SKTexture(imageNamed: "Deran").getNode(1, 3))
        addItem(x: 9, y: 5, item: r3)
        _mapMatrix[5][9] = CELL_ROLE
        
        var list = Array<Item>()
        for _ in 0...9 {
            let b = Item(Item.SpellBook)
            b._priceType = Item.PRICE_TYPE_TEAR
            let s = self.seed()
            var spell:Spell!
            if s < 34 {
                spell = Loot.getRandomNormalSpell()
            } else if s < 67 {
                spell = Loot.getRandomGoodSpell()
            } else {
                spell = Loot.getRandomRareSpell()
            }
            debug(spell._name)
            b.spell = spell
            list.append(b)
        }
        _sellingBooks = list
        
        for x in 0...12 {
            _mapMatrix[3][x] = CELL_BLOCK
            _mapMatrix[13][x] = CELL_BLOCK
            _mapMatrix[8][x] = CELL_BLOCK
        }
        _mapMatrix[8][5] = CELL_EMPTY
        _mapMatrix[8][6] = CELL_EMPTY
        _mapMatrix[8][7] = CELL_EMPTY
        
        let blockPoints:Array<Array<CGFloat>> = [
                    [1, 4],
                    [1, 5],
                    [4, 4],
                    [5,4],
                    [7,4],
                    [9,4],
                    [10,5],
                    [10,6],
                    [11,5],
                    [2,9],
                    [3,9],
                    [8,9],
                    [9,10],
                    [10,9],
                    [11,8]
                ]
        for p in blockPoints {
            _mapMatrix[p[1].toInt()][p[0].toInt()] = CELL_BLOCK
        }
        _mapMatrix[13][6] = CELL_EMPTY
//        let pp = PharmicPanel()
//        pp.create()
//        Game.instance.curStage.showPanel(pp)
    }
    private let CELL_ROLE = 151
    private var _sellingBooks = Array<Item>()
}

