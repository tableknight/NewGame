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
        _monsterEnum = []
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func hasAction(cell: Int, touchPoint: CGPoint) -> Bool {
        let point = convertPixelToIndex(x: touchPoint.x, y: touchPoint.y)
        let nextPoint = getNextPoint()
        let nextY = nextPoint.y.toInt()
        let nextX = nextPoint.x.toInt()
        
        if cell == CELL_BOSS && nextPoint.x == point.x && nextPoint.y == point.y {
            let i = Game.instance
            _bossBattle = getBossByIndex()
            _bossBattle.setEnemyPart(minions: [])
            _bossBattle.setPlayerPart(roles: [i.char] + i.char.getReadyMinions())
            i.curStage.addBattle(_bossBattle)
            _bossBattle.battleStart()
            
            let boss = getNextCellItem(x: nextX, y: nextY)
            _bossBattle.victoryAction = {
                self._mapMatrix[nextY][nextX] = self.CELL_EMPTY
                boss.removeFromParent()
            }
            return true
        } else if cell == CELL_HERB && nextPoint.x == point.x && nextPoint.y == point.y {
            let item = getNextCellItem(x: nextX, y: nextY)
            self._mapMatrix[nextY][nextX] = self.CELL_EMPTY
            takeHerb(item)
            return true
        }
        if cell == CELL_BOSS {
            return true
        }
        return false
    }
    override func create() {
        createSize()
//        halfSize = 3
        _nameLabel.text = "黄昏之城"
        _maxHerbCount = seed(min: 1, max: 6)
        _maxChestCount = seed(min: 0, max: 3)
        createMap()
        createMapMatrix()
        _visiblePoints = findVisiblePoints()
        if seed() < 10 {
            let tear = Item(Item.Tear)
            tear._count = seed(min: 5, max: 11)
            _goodsList = [tear]
            let spellBookCount = seed(min: 1, max: 3)
            for _ in 1...spellBookCount {
                let sb = Item(Item.SpellBook)
                sb.spell = Loot.getRandomSacredSpell()
//                sb._price = 48
                sb._priceType = Item.PRICE_TYPE_TEAR
                _goodsList.append(sb)
            }
            if seed() < 50 {
                let expBook = Item(Item.ExpBook)
                expBook._count = seed(min: 1, max: 4)
                _goodsList.append(expBook)
            }
            if seed() < 75 {
                let gp = Item(Item.GiantPotion)
                gp._count = seed(min: 1, max: 5)
                _goodsList.append(gp)
            }
            if seed() < 25 {
                let ps = Item(Item.PsychicScroll)
                ps._count = 1
                _goodsList.append(ps)
            }
            if seed() < 35 {
                let ps = Item(Item.GodTownScroll)
                ps._count = seed(min: 1, max: 3)
                _goodsList.append(ps)
            }
            if seed() < 35 {
                let ps = Item(Item.DeathTownScroll)
                ps._count = seed(min: 1, max: 3)
                _goodsList.append(ps)
            }
            createSeller()
        }
        createBoss()
        if self is InnerMaze {
            createWallShadow()
        }
        createPortals()
        createEnemy()
    }
    
    func createSize() {
//        halfSize = seedFloat(min: 3, max: 7)
//        hSize = [6,6,6,6,8,8,8,8,10,10,10,10,10,12,12,12,12].one()
//        vSize = [6,6,6,6,8,8,8,8,10,10,10,10,10,12,12,12,12].one()
//        hSize = seed(min: 6, max: 13).toFloat()
//        vSize = seed(min: 6, max: 13).toFloat()
        hSize = 12
        vSize = 12
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
                                    addWallCell(x: x0, y: y0, texture: wallTexture)
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
    internal var _herbCount = 0
    internal var _maxHerbCount = 5
    internal var _chestCount = 0
    internal var _maxChestCount = 3
    internal var _towerCount = 0
    internal func addWallCell(x:CGFloat, y:CGFloat, texture:SKTexture) {
        let sd = seed()
        let item = UIItem()
        if sd < 6 && _herbCount < _maxHerbCount && !(self is InnerMaze) {
            let herb = _herbs.one()
            item._key = herb
            let data = ItemData.data[herb]!
            let t = Game.instance.outside_b.getCell(data.imgX, data.imgY)
            item.setTexture(t)
            addWall(x: x, y: y, item: item)
            _mapMatrix[y.toInt()][x.toInt()] = CELL_HERB
            _herbCount += 1
        } else if sd < 10 && _chestCount < _maxChestCount {
            let chest = Chest()
            addWall(x: x, y: y, item: chest)
            _mapMatrix[y.toInt()][x.toInt()] = CELL_BOX
            _chestCount += 1
        } else if sd < 15 && _towerCount < 2 {
            let tower = getRandomTower()
            addWall(x: x, y: y, item: tower)
            _mapMatrix[y.toInt()][x.toInt()] = CELL_TOWER
            _towerCount += 1
        } else {
            item.setTexture(texture)
            addWall(x: x, y: y, item: item)
            _mapMatrix[y.toInt()][x.toInt()] = CELL_ITEM
        }
    }
    var _herbs = [Item.Caesalpinia, Item.Curium, Item.DragonRoot, Item.SkyAroma, Item.PanGrass]
    internal func takeHerb(_ item:UIItem) {
        Game.instance.curStage.cancelMove = true
        _role.recovery1f()
        Sound.play(node: Game.instance.curStage, fileName: "herb")
        setTimeout(delay: 2, completion: {
            Sound.play(node: Game.instance.curStage, fileName: "Save")
            let herb = Item(item._key)
            let count = ceil(self._level * 0.1)
            herb._count = self.seed(min: 1, max: count.toInt() + 1)
            Game.instance.char.addItem(herb)
            showMsg(text: "你获得了[\(herb._name)]x\(herb._count)")
            item.removeFromParent()
            Game.instance.curStage.cancelMove = false
        })
        
        
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
                if checkedPoints.firstIndex(of: p) == nil {
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
//    internal func createTreasureBoxes() {
//        let list = [1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,2,2,3]
//        let count = list.one()
//        if count == 0 {
//            return
//        }
//        for _ in 1...count {
//            let index = seed(max: _visiblePoints.count)
//            let point = _visiblePoints[index]
//            _visiblePoints.remove(at: index)
//            let chest = Chest()
//            chest.confirmAction = {
////                let fo = SKAction.fadeOut(withDuration: TimeInterval(1))
////                chest.run(fo) {
////                }
//                chest.removeFromParent()
//                self._mapMatrix[point.y.toInt()][point.x.toInt()] = self.CELL_EMPTY
//            }
//            addItem(x: point.x, y: point.y, item: chest)
//            _mapMatrix[point.y.toInt()][point.x.toInt()] = CELL_BOX
//        }
//    }
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
        let t2 = SKTexture(imageNamed: "roof_black")
        for p in _wallPoints {
            if [CELL_TOWER, CELL_SELLER, CELL_BOX, CELL_HERB, CELL_ORE].firstIndex(of: _mapMatrix[p.y.toInt()][p.x.toInt()]) != nil{
                continue
            }
            if p.x < hSize {
                if CELL_EMPTY == _mapMatrix[p.y.toInt()][p.x.toInt() + 1] {
                    addShadow(x: p.x, y: p.y)
                }
            }
            if p.y > 0 {
                if CELL_ITEM == _mapMatrix[p.y.toInt() - 1][p.x.toInt()] {
                    let n = SKSpriteNode(texture: t2)
                    n.size = CGSize(width: cellSize, height: cellSize)
                    addItem(x: p.x, y: p.y - 1, item: n, z: MyScene.WALL_SHADOW_LAYER_Z)
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
    
//    internal func createTowers() {
//        var points = Array<CGPoint>()
//        let maxx = hSize.toInt() - 1
//        let maxy = vSize.toInt() - 1
//        for y in 0...maxy {
//            for x in 0...maxx {
//                if _mapMatrix[y][x] == CELL_ITEM && _mapMatrix[y + 1][x] == CELL_EMPTY {
//                    points.append(CGPoint(x: x, y: y))
//                }
//            }
//        }
//        if points.count == 1 {
//            let item = getNextCellItem(x: points[0].x.toInt(), y: points[0].y.toInt())
//            item.removeFromParent()
//            addItem(x: points[0].x, y: points[0].y, item: getRandomTower())
//            _mapMatrix[points[0].y.toInt()][points[0].x.toInt()] = CELL_TOWER
//        } else if points.count > 1 {
//            let c = seed(max: 2)
//            for _ in 0...c {
//                let index = seed(max: points.count)
//                let p = points[index]
//                points.remove(at: index)
//                let item = getNextCellItem(x: p.x.toInt(), y: p.y.toInt())
//                item.removeFromParent()
//                addItem(x: p.x, y: p.y, item: getRandomTower())
//                _mapMatrix[p.y.toInt()][p.x.toInt()] = CELL_TOWER
//            }
//        }
//    }
    
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
//                debug("monster x = \(p.x), y = \(p.y)")
                addItem(x: p.x, y: p.y, item: getRandomMonterCellItem())
            }
        }
    }
    
//    override func getMonsterByIndex(index: Int) -> Creature {
//        switch index {
//        case 1:
//            return BoneWitch()
//        case 2:
//            return RedEyeDemon()
//        case 3:
//            return DeadSpirit()
//        case 4:
//            return WasteWalker()
//        default:
//            return WasteWalker()
//        }
//    }
    internal var _bossIndex = 0
    internal func getBossByIndex() -> Battle {
        if 1 == _bossIndex {
            return IssBattle()
        }
        if 2 == _bossIndex {
            return FireSpiritBattle()
        }
        if 3 == _bossIndex {
            return GiantSpiritBattle()
        }
        if 4 == _bossIndex {
            return AssassinBattle()
        }
        if 5 == _bossIndex {
            return RobberBattle()
        }
        if 6 == _bossIndex {
            return GhostBattle()
        }
        return IssBattle()
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
        let n = SKSpriteNode(imageNamed: "roof_black")
        n.size = CGSize(width: cellSize, height: cellSize * 0.875)
        return n
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
