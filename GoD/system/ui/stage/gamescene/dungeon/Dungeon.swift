//
//  dungeon.swift
//  GoD
//
//  Created by kai chen on 2019/3/22.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class Dungeon: MyScene {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let oa4 = Game.instance.dungeon_a4
//        let so4 = Game.instance.sf_outside_a4
        _mapSet = GroundSets(ground: oa4.getCell(4, 2, 2, 2), wall: oa4.getCell(4, 4, 2, 2))
        _monsterEnum = [1,2,3,4]
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func hasAction(cell: Int, touchPoint: CGPoint) -> Bool {
        let point = convertPixelToIndex(x: touchPoint.x, y: touchPoint.y)
        
        if cell == CELL_BOSS {
            let i = Game.instance
            _bossBattle.setEnemyPart(minions: [])
            _bossBattle.setPlayerPart(roles: [i.char] + i.char.getReadyMinions())
            i.curStage.addBattle(_bossBattle)
            _bossBattle.battleStart()
            return true
            
            
        }
        return false
    }
    override func create() {
        createSize()
//        halfSize = 3
        _nameLabel.text = "恶魔之城"
        createMap()
        createMapMatrix()
        _visiblePoints = findVisiblePoints()
        createTowers()
        if seed() < 7 {
            let tear = TheWitchsTear()
            tear._count = seed(min: 5, max: 11)
            _goodsList = [tear]
            _whichItem = [true]
            _mixedItemMoney = [false]
            let count = seed(min: 1, max: 3)
            let l = Loot()
            for _ in 1...count {
                let sb = SpellBook()
                sb.spell = l.getRandomSacredSpell()
                sb._sellingPrice = 68
                _whichItem.append(false)
                _mixedItemMoney.append(true)
                _goodsList.append(sb)
            }
            createSeller()
        }
        createBoss()
        if self is InnerMaze {
            createWallShadow()
        }
        createPortals()
        createTreasureBoxes()
        createEnemy()
    }
    
    func createSize() {
//        halfSize = seedFloat(min: 3, max: 7)
        hSize = [6,6,6,6,8,8,8,8,10,10,10,10,10,12,12,12,12].one()
        vSize = [6,6,6,6,8,8,8,8,10,10,10,10,10,12,12,12,12].one()
//        hSize = seed(min: 6, max: 13).toFloat()
//        vSize = seed(min: 6, max: 13).toFloat()
    }
    
    override func createMapMatrix() {
//        debug("halfsize \(halfSize)")
        let wallTexture = getWallTexture()
        _mapMatrix = []
        for _ in 0...vSize.toInt() - 1 {
            var row:Array<Int> = []
            for _ in 0...hSize.toInt() {
                row.append(CELL_EMPTY)
            }
            _mapMatrix.append(row)
        }
        for y in 0...vSize.toInt() - 1 {
            var row:Array<Int> = []
//            let xd = y / 3 % 2 == 0 ? 0 : 1
            for x in 0...hSize.toInt() {
                if y % 3 == 0 {
                    if x % 3 == 0 {
                        let landFragment = LandFragment.one()
                        for i in 0...landFragment.count - 1 {
                            if i % 2 == 0 {
                                let x0 = x.toFloat() + landFragment[i]
                                let y0 = y.toFloat() + landFragment[i + 1]
                                if x0 <= hSize && y0 <= vSize - 1 {
                                    let wall = UIItem()
                                    wall.setTexture(wallTexture)
                                    addWall(x: x0, y: y0, item: wall)
                                    _mapMatrix[y0.toInt()][x0.toInt()] = CELL_ITEM
                                }
                            }
                        }
                    }
                }
                row.append(CELL_EMPTY)
            }
            _mapMatrix.append(row)
        }
    }
    internal func createPortals() {
        let fromIndex = seed(max: _visiblePoints.count)
        _portalPrev = _visiblePoints[fromIndex]
        let toIndex = seed(max: _visiblePoints.count)
        _portalNext = _visiblePoints[toIndex]
        if fromIndex == toIndex {
            createPortals()
            return
        }
        let maxx = hSize
        let maxy = vSize - 1
        var connected = false
        var checkedPoints = Array<CGPoint>()
        func isPointPortal(_ x:CGFloat, _ y:CGFloat) {
            var points = Array<CGPoint>()
            if x > 0 {
                let cell = _mapMatrix[y.toInt()][x.toInt() - 1]
                if cell == CELL_EMPTY || cell == CELL_PORTAL {
                    points.append(CGPoint(x: x - 1, y: y))
                }
            }
            if x < maxx {
                let cell = _mapMatrix[y.toInt()][x.toInt() + 1]
                if cell == CELL_EMPTY || cell == CELL_PORTAL {
                    points.append(CGPoint(x: x + 1, y: y))
                }
            }
            if y > 0 {
                let cell = _mapMatrix[y.toInt() - 1][x.toInt()]
                if cell == CELL_EMPTY || cell == CELL_PORTAL {
                    points.append(CGPoint(x: x, y: y - 1))
                }
            }
            if y < maxy {
                let cell = _mapMatrix[y.toInt() + 1][x.toInt()]
                if cell == CELL_EMPTY || cell == CELL_PORTAL {
                    points.append(CGPoint(x: x, y: y + 1))
                }
            }
            for p in points {
                if checkedPoints.index(of: p) == nil {
                    if p.x == _portalNext.x && p.y == _portalNext.y {
                        connected = true
                    } else {
                        checkedPoints.append(p)
                        if !connected {
                            isPointPortal(p.x, p.y)
                        }
                    }
                }
            }
        }
        
        isPointPortal(_portalPrev.x, _portalPrev.y)
        
        if !connected {
            createPortals()
            return
        }
        if fromIndex > toIndex {
            _visiblePoints.remove(at: fromIndex)
            _visiblePoints.remove(at: toIndex)
        } else {
            _visiblePoints.remove(at: toIndex)
            _visiblePoints.remove(at: fromIndex)
        }
        _mapMatrix[_portalNext.y.toInt()][_portalNext.x.toInt()] = CELL_PORTAL
        _mapMatrix[_portalPrev.y.toInt()][_portalPrev.x.toInt()] = CELL_PORTAL
        addPortalItem()
    }
    internal func addPortalItem() {
        let next = PortalPrev()
        addGround(x: _portalNext.x, y: _portalNext.y, item: next)
    }
    internal func createTreasureBoxes() {
        let list = [1,1,1,1,0,0,0,2,2,3]
        let count = list.one()
        if count == 0 {
            return
        }
        for _ in 1...count {
            let index = seed(max: _visiblePoints.count)
            let point = _visiblePoints[index]
            _visiblePoints.remove(at: index)
            let chest = Chest()
            chest.confirmAction = {
//                let fo = SKAction.fadeOut(withDuration: TimeInterval(1))
//                chest.run(fo) {
//                }
                chest.removeFromParent()
                self._mapMatrix[point.y.toInt()][point.x.toInt()] = self.CELL_EMPTY
            }
            addItem(x: point.x, y: point.y, item: chest)
            _mapMatrix[point.y.toInt()][point.x.toInt()] = CELL_BOX
        }
    }
    internal var _visiblePoints = Array<CGPoint>()
    internal var _wallPoints = Array<CGPoint>()
    internal func findVisiblePoints() -> Array<CGPoint> {
        var points = Array<CGPoint>()
        for y in 0...vSize.toInt() - 1 {
            for x in 0...hSize.toInt() {
                let cell = _mapMatrix[y][x]
                if cell == CELL_EMPTY {
                    if y.toFloat() == vSize - 1{
                        points.append(CGPoint(x: x, y: y))
                    } else if y.toFloat() < vSize {
                        if _mapMatrix[y + 1][x] == CELL_EMPTY {
                            points.append(CGPoint(x: x, y: y))
                        }
                    }
                } else {
                    _wallPoints.append(CGPoint(x: x, y: y))
                }
            }
        }
        return points
    }
    internal let _wall_shadow = SKTexture(imageNamed: "wall_shadow_12")
    internal func createWallShadow() {
//        let t = _wall_shadow
        let t2 = Game.instance.inside_a5.getCell(0,0)
        for p in _wallPoints {
            if CELL_TOWER == _mapMatrix[p.y.toInt()][p.x.toInt()] {
                continue
            }
            if p.x < hSize {
                if CELL_EMPTY == _mapMatrix[p.y.toInt()][p.x.toInt() + 1] {
                    addShadow(x: p.x, y: p.y)
                }
            }
            if p.y > 0 {
                if CELL_ITEM == _mapMatrix[p.y.toInt() - 1][p.x.toInt()] {
                    addItem(x: p.x, y: p.y - 1, item: SKSpriteNode(texture: t2), z: 120)
                }
            }
        }
    }
    
    internal func addShadow(x:CGFloat, y:CGFloat) {
        let shadow = SKSpriteNode(texture: _wall_shadow)
        shadow.size = CGSize(width: cellSize * 0.25, height: cellSize)
        addGround(x: x + 1, y: y, item: shadow)
        shadow.xAxis = shadow.xAxis - cellSize / 3 - 1
    }
    
    internal func createTowers() {
        var points = Array<CGPoint>()
        let maxx = hSize.toInt() - 1
        let maxy = vSize.toInt() - 1
        for y in 0...maxy {
            for x in 0...maxx {
                if _mapMatrix[y][x] == CELL_ITEM && _mapMatrix[y + 1][x] == CELL_EMPTY {
                    points.append(CGPoint(x: x, y: y))
                }
            }
        }
        if points.count == 1 {
            let item = getNextCellItem(x: points[0].x.toInt(), y: points[0].y.toInt())
            item.removeFromParent()
            addItem(x: points[0].x, y: points[0].y, item: getRandomTower())
            _mapMatrix[points[0].y.toInt()][points[0].x.toInt()] = CELL_TOWER
        } else if points.count > 1 {
            let c = seed(max: 2)
            for _ in 0...c {
                let index = seed(max: points.count)
                let p = points[index]
                points.remove(at: index)
                let item = getNextCellItem(x: p.x.toInt(), y: p.y.toInt())
                item.removeFromParent()
                addItem(x: p.x, y: p.y, item: getRandomTower())
                _mapMatrix[p.y.toInt()][p.x.toInt()] = CELL_TOWER
            }
        }
    }
    
    internal func createSeller() {
        var points = Array<CGPoint>()
        let maxx = hSize.toInt() - 1
        let maxy = vSize.toInt() - 1
        for y in 0...maxy {
            for x in 0...maxx {
                if _mapMatrix[y][x] == CELL_ITEM && _mapMatrix[y + 1][x] == CELL_EMPTY {
                    points.append(CGPoint(x: x, y: y))
                }
            }
        }
        let seller = UIRole()
        seller.create(roleNode: SKTexture(imageNamed: "seller").getNode(1, 0))
        
        if points.count == 1 {
            let item = getNextCellItem(x: points[0].x.toInt(), y: points[0].y.toInt())
            item.removeFromParent()
            addItem(x: points[0].x, y: points[0].y, item: seller)
            _mapMatrix[points[0].y.toInt()][points[0].x.toInt()] = CELL_SELLER
        } else if points.count > 1 {
            let index = seed(max: points.count)
            let p = points[index]
            points.remove(at: index)
            let item = getNextCellItem(x: p.x.toInt(), y: p.y.toInt())
            item.removeFromParent()
            addItem(x: p.x, y: p.y, item: seller)
            _mapMatrix[p.y.toInt()][p.x.toInt()] = CELL_SELLER
        }
    }
    internal var _bossImg = ""
    internal var _bossBattle:Battle!
    internal func createBoss() {
        
    }
    
    
    internal func createEnemy() {
        for p in _visiblePoints {
            if Core().d7() && _mapMatrix[p.y.toInt()][p.x.toInt()] == CELL_EMPTY {
                _mapMatrix[p.y.toInt()][p.x.toInt()] = CELL_MONSTER
                addItem(x: p.x, y: p.y, item: getRandomMonterCellItem())
            }
        }
    }
    
    override func getMonsterByIndex(index: Int) -> Creature {
        switch index {
        case 1:
            return BoneWitch()
        case 2:
            return RedEyeDemon()
        case 3:
            return DeadSpirit()
        case 4:
            return WasteWalker()
        default:
            return WasteWalker()
        }
    }
    
    internal func m(_ x:Int, _ y:Int) -> Int {
        return _mapMatrix[y][x]
    }
    
    internal func e(_ x:Int, _ y:Int) -> Bool {
        return _mapMatrix[y][x] == CELL_EMPTY
    }
    
    internal func getWallTexture() -> SKTexture {
        let node = SKSpriteNode()
//        let top = Game.instance.inside_a5.getNode(0, 0)
        let top = getRoof()
        top.anchorPoint = CGPoint(x: 0.5, y: 0)
        node.addChild(top)
        let btop = Game.instance.inside_a4.getNode(0, 2.5, 1, 0.5)
        btop.anchorPoint = CGPoint(x: 0.5, y: 1)
        node.addChild(btop)
        let bb = Game.instance.inside_a4.getNode(0, 4, 1, 0.5)
        bb.anchorPoint = CGPoint(x: 0.5, y: 1)
        bb.yAxis = -cellSize * 0.5
        node.addChild(bb)
        return node.toTexture()
    }
    
    internal func getRoof() -> SKSpriteNode {
        return Game.instance.inside_a5.getNode(0,0,1,0.875)
//        return Game.instance.dungeon_a4.getNode(0, 7, 1, 0.75)
    }
    
    internal func addWall(x:CGFloat, y:CGFloat, item:SKSpriteNode) {
        item.anchorPoint = CGPoint(x: 0.5, y: 0)
        item.position.x = (-hSize / 2 + x) * cellSize
        item.position.y = (vSize / 2 - 0.5 - y) * cellSize
        item.zPosition = MyScene.ITEM_LAYER_Z + y
        item.name = getItemName(CGPoint(x: x, y: y))
        _itemLayer.addChild(item)
    }
    
}
class MapWall:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(wallTexture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var wallTexture:SKTexture!
}

protocol InnerMaze {
    
}
