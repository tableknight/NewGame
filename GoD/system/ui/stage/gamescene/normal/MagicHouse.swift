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
        _nameLabel.text = _name
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
                             name: "大魔法师瑞德", action: {
                                let dlg = stage._curDialog!
                                dlg.addConfirmButton()
                                dlg._confirmAction = {
                                    stage.removeDialog(dlg: dlg)
                                    let sp = SellingPanel()
                                    let book = Item(Item.RandomSpell)
                                    book._reserveBool = true
//                                    book.price = 1
                                    sp._goodsList = [book]
                                    sp.create()
                                    sp.hasBuyAction = true
                                    sp.buyAction = {
                                        let s = Loot.getRandomSacredSpell()
                                        let sb = Item(Item.SpellBook)
                                        sb.spell = s
                                        Game.instance.char.addItem(sb)
                                    }
                                    stage.showPanel(sp)
                                }
            })
            return true
        } else if cell == CELL_ROLE && point.equalTo(CGPoint(x: 4, y: 9)) {
            let role = getNextCellItem(x: 4, y: 9) as! UIRole
            let stage = Game.instance.curStage!
            
            stage.showDialog(img: role._roleNode.texture!,
                             text: "知识是力量的源泉，书籍是知识的海洋，魔法是遨游于海洋的方舟，我这么说你明白吗？？",
                             name: "大魔法师波普", action: {
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
        } else if cell == CELL_ROLE && point.equalTo(CGPoint(x: 8, y: 10)) {
            let role = getNextCellItem(x: 8, y: 10) as! UIRole
            let stage = Game.instance.curStage!
            
            stage.showDialog(img: role._roleNode.texture!,
                             text: "一颗天使之泪可以转化为一百点法术能量，你愿意让我帮你恢复你和你的伙伴所有的魔法吗？",
                             name: "大魔法师格林", action: {
                                let dlg = stage._curDialog!
                                let c = Game.instance.char!
                                dlg.addConfirmButton()
                                dlg._confirmAction = {
                                    stage.removeDialog(dlg: dlg)
                                    if !self.recoveryMana(unit: c) {
                                        role.speak(text: "你没有那么多眼泪！")
                                        return
                                    } else {
                                        for m in c._minions {
                                            _ = self.recoveryMana(unit: m)
                                        }
                                    }
                                    stage.setBarValue()
                                    var msg = ""
                                    for u in self._recoveriedUnits {
                                        msg.append(contentsOf: "[\(u._name)]，")
                                    }
                                    msg.append(contentsOf: "恢复了法力，消耗眼泪\(self._costedTears)颗")
                                    showMsg(text: msg)
                                }
            })
            return true
        } else if cell == CELL_ROLE && point.equalTo(CGPoint(x: 9, y: 5)) {
            let pp = PharmicPanel()
            pp.create()
            Game.instance.curStage.showPanel(pp)
            return true
        }
        
        if cell == CELL_ITEM || cell == CELL_ROLE {
            return true
        }
        return false
    }
    
    private func createRandomWeapon() {
        
    }
    private var _recoveriedUnits = Array<Unit>()
    private var _costedTears = 0
    private func recoveryMana(unit:Unit) -> Bool {
        let c = Game.instance.char!
        let r = unit._extensions.mpMax - unit._extensions.mp
        let n = ceil(r * 0.01).toInt()
        
        if n == 0 {
            return true
        }
        
        let i = c.searchItem(type: Item.Tear)
        if i != nil {
            if i!._count >= n {
                unit._extensions.mp = unit._extensions.mpMax
                i!._count -= n
                _costedTears += n
                _recoveriedUnits.append(unit)
                return true
            }
        }
        
        return false
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
        roof.size = CGSize(width: cellSize * 13, height: cellSize * 13)
        addItem(x: 0, y: 13, item: roof, width: 12)
        
        let r1 = UIRole()
        r1.create(roleNode: SKTexture(imageNamed: "MRed").getNode(1, 0))
        addItem(x: 3, y: 4, item: r1, z:bg.zPosition)
        _mapMatrix[4][3] = CELL_ROLE
        
        let r2 = UIRole()
        r2.create(roleNode: SKTexture(imageNamed: "MGreen").getNode(1, 0))
        addItem(x: 4, y: 9, item: r2, z:bg.zPosition)
        _mapMatrix[9][4] = CELL_ROLE
        
        let r3 = UIRole()
        r3.create(roleNode: SKTexture(imageNamed: "MBlack").getNode(1, 2))
        addItem(x: 9, y: 5, item: r3, z:bg.zPosition)
        _mapMatrix[5][9] = CELL_ROLE
        
        let r4 = UIRole()
        r4.create(roleNode: SKTexture(imageNamed: "MPurple").getNode(1, 3))
        addItem(x: 8, y: 10, item: r4, z:bg.zPosition)
        _mapMatrix[10][8] = CELL_ROLE
        
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
                    [9,9],
                    [10,10],
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
    
    private var _sellingBooks = Array<Item>()
}

