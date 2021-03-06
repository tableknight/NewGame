//
//  AcientRoad.swift
//  GoD
//
//  Created by kai chen on 2019/1/2.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class AcientRoad: Dungeon {
    static let SECRET_MEADOW = 1
    static let WINTER_LAND = 2
    static let BLOOD_ABYSS = 3
    static let LOST_AREA = 4
    static let FRESH_GRASS = 5
    static let SECRET_VALLEY = 6
    static let HIDDEN_AREA = 101
    static let FIRE_SOURCE = 7
    
    internal var index:Int {
        set {
            _index = newValue
        }
        get {
            return _index
        }
    }
    override func create() {
        let scenes = Game.instance.curStage._scenes
        if _index <= 1 {
            _floorSize = createFloorSize()
            _bossFloor = seed(min: 1, max: _floorSize)
        } else {
            //bossroad用不到
            if scenes.count > 0 {
                _floorSize = scenes[0]._floorSize
                _bossFloor = scenes[0]._bossFloor
            }
        }
        super.create()
        _nameLabel.text = "远古之路\(_level.toInt())层，\(_name)第\(_index)区"
//        _name = "远古之路\(_level.toInt())层"
        _initialized = true
//        debugger()
    }
    func createFloorSize() -> Int {
        let sed = seed(min: 1, max: 7)
        return sed
    }
    internal var _bossFloor = 0
    
    override func createBoss() {
        let c = Core()
        if _level == 10 {
            _bossImg = IssThePuppet.IMG
//            _bossBattle = IssBattle()
            _bossIndex = 1
            addBoss()
        } else if _level == FireSpirit.LEVEL && (c.d2() || Mode.showbossall) {
            _bossImg = FireSpirit.IMG
//            _bossBattle = FireSpiritBattle()
            _bossIndex = 2
            addBoss()
        } else if _level == GiantSpirit.LEVEL && (c.d3() || Mode.showbossall) {
            _bossImg = GiantSpirit.IMG
//            _bossBattle = GiantSpiritBattle()
            _bossIndex = 3
            addBoss()
        } else if _level == AssassinMaster.LEVEL && (c.d4() || Mode.showbossall) {
            _bossImg = AssassinMaster.IMG
//            _bossBattle = AssassinBattle()
            _bossIndex = 4
            addBoss()
        } else if _level == GraveRobber.LEVEL && (c.d3() || Mode.showbossall) {
            _bossImg = GraveRobber.IMG
//            _bossBattle = RobberBattle()
            _bossIndex = 5
            addBoss()
        } else if _level == FearGhost.LEVEL && (c.d5() || Mode.showbossall) {
            _bossImg = FearGhost.IMG
//            _bossBattle = GhostBattle()
            _bossIndex = 6
            addBoss()
        }
        
    }
    
    internal func addBoss() {
        if _index != _bossFloor {
            return
        }
        var points = Array<CGPoint>()
        let maxx = hSize.toInt() - 1
        let maxy = vSize.toInt() - 1
        for y in 0...maxy {
            for x in 1...maxx {
                if _mapMatrix[y][x] == CELL_ITEM && _mapMatrix[y + 1][x] == CELL_EMPTY {
                    points.append(CGPoint(x: x, y: y))
                }
            }
        }
        //        let seller = UIRole()
        //        seller.create(roleNode: SKTexture(imageNamed: "seller").getNode(1, 0))
        
        let boss = UIRole()
//        boss.setTexture(SKTexture(imageNamed: _bossImg))
//        boss.size = CGSize(width: cellSize * 2, height: cellSize * 2)
//        let role = UIRole()
        boss.create(roleNode: SKSpriteNode(imageNamed: _bossImg))
        boss._roleNode.size = CGSize(width: cellSize * 2, height: cellSize * 2)
        boss.zPosition = MyScene.BOSS_LAYER_Z
        
        
        let item = getNextCellItem(x: points[0].x.toInt(), y: points[0].y.toInt())
        item.removeFromParent()
        addItem(x: points[0].x, y: points[0].y, item: boss)
        _mapMatrix[points[0].y.toInt()][points[0].x.toInt()] = CELL_BOSS
    }
//    override func hasAction(cell:Int, touchPoint:CGPoint) -> Bool {
////        let nextPoint = getNextPoint()
////        let nextY = nextPoint.y.toInt()
////        let nextX = nextPoint.x.toInt()
////        if cell == CELL_TOWER {
////            let tower = getNextCellItem(x: nextX, y: nextY) as! Tower
////            
////        }
//        return false
//    }
    internal var _floorSize:Int = 0
    var _id:Int = 0
    override func moveEndAction() {
        let pos = convertPixelToIndex(x: _role.xAxis, y: _role.yAxis)
        let stage = Game.instance.curStage!
        let char = _role!
        //进入上一个场景
        if pos.x == _portalPrev.x && pos.y == _portalPrev.y {
            //如果是第一个场景，则进入上一层
            if _index == 1 {
                let prevLevel = _level - 1
//                goFloor(floorLevel: prevLevel.toInt())
                stage.enterFloor(floor: prevLevel)
            } else {
                let prevIndex = _index - 1
                let prevScene = stage.getSceneByIndex(index: prevIndex)
                stage.switchScene(next: prevScene!, completion: {
                    prevScene!.setRole(x: prevScene!._portalNext.x, y: prevScene!._portalNext.y, char: char)
                })
            }
        //进入下一个场景
        } else if pos.x == _portalNext.x && pos.y == _portalNext.y {
            let nextIndex = _index + 1
            //如果是本层最后一个场景 则进入战斗
            if _index >= _floorSize {
                triggerEvent()
            //进入本层下一个场景
            } else if _index < _floorSize {
                var nextScene = stage.getSceneByIndex(index: nextIndex)
                if nil == nextScene {
                    nextScene = getSceneById(id: _id)
                    //将下一个新创建的场景加入 舞台场景库
                    stage._scenes.append(nextScene!)
                }
                nextScene?._level = _level
                stage.switchScene(next: nextScene!, completion: {
                    nextScene!.setRole(x: nextScene!._portalPrev.x, y: nextScene!._portalPrev.y, char: char)
                })
            } else {
                debug("_index error _floorSize")
            }
        }
    }
    func triggerEvent() {
        
        let stage = Game.instance.curStage!
        let char = Game.instance.char!
        var enimies = Array<Creature>()
        
        let enemyCount = _level < 10 ? 3 : 5
        for _ in 0...enemyCount {
            let e = Creature(_monsterEnum.one())
            e.create(level: _level)
            enimies.append(e)
        }
//        stage.hideScene()
        let b = Battle()
//        if _level == 10 {
//            b = IssBattle()
//        }
        let roles = [char] + char.getReadyMinions()
        b.setEnemyPart(minions: enimies)
        b.setPlayerPart(roles: roles)
        b.zPosition = MyStage.UI_TOPEST_Z
        b.defeatedAction = {
            self.defeatedAction()
        }
        b.victoryAction = {
            self.victoryAction()
        }
//        b.lootPanelConfirmAction = {
//            self.victoryAction()
//        }
        stage.addBattle(b)
        b.battleStart()
    }
    internal func defeatedAction() {
        let stage = Game.instance.curStage!
        stage.gohome()
    }
    internal func victoryAction() {
        if _level == 40 {
            let c = SnowLandingHome()
            Game.instance.curStage.switchScene(next: c, completion: {
                c.setRole(x: 7, y: 7, char: self._role)
            })
            return
        }
        let nextLevel = _level.toInt() + 1
        let char = Game.instance.char!
        let stage = Game.instance.curStage!
        if char._dungeonLevel < nextLevel {
            char._dungeonLevel = nextLevel
        }
        stage.enterFloor(floor: nextLevel.toFloat())
    }
    internal var _index:Int = 1
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _index = Game.instance.curStage.getSceneIndex()
//        debug("current _floorSize \(_floorSize)")
//        debug("current index \(_index)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    internal func getSceneById(id: Int) -> AcientRoad {
        if AcientRoad.SECRET_MEADOW == id {
            return SecretMeadow()
        }
        if AcientRoad.WINTER_LAND == id {
            return WinterLand()
        }
        if AcientRoad.LOST_AREA == id {
            return LostArea()
        }
        if AcientRoad.BLOOD_ABYSS == id {
            return BloodAbyss()
        }
        if AcientRoad.FRESH_GRASS == id {
            return FreshGrass()
        }
        if AcientRoad.SECRET_VALLEY == id {
            return SecretValley()
        }
        if AcientRoad.FIRE_SOURCE == id {
            return FireSource()
        }
        if AcientRoad.HIDDEN_AREA == id {
            return HiddenArea()
        }
        return SecretMeadow()
    }
    var sceneList:Array<Int> {
        get {
            return [AcientRoad.SECRET_MEADOW,
                    AcientRoad.WINTER_LAND,
                    AcientRoad.BLOOD_ABYSS,
                    AcientRoad.LOST_AREA,
                    AcientRoad.FRESH_GRASS,
                    AcientRoad.SECRET_VALLEY,
                    AcientRoad.HIDDEN_AREA
            ]
        }
    }
//    internal func getBoxCount() -> Int {
//        return seed(max: 3)
//    }
//    override func createMapMatrix() {
//        _mapMatrix = []
//        let towerCountTotal = seed(max: 3)
//        var towerCount = 0
//        let chestCountTotal = getBoxCount()
//        var chestCount = 0
//        for y in 0...halfSize.toInt() * 2 - 1 {
//            var row:Array<Int> = []
//            for x in 0...halfSize.toInt() * 2 {
//                if isSpecialPoint(x: x.toFloat(), y: y.toFloat()) {
//                    row.append(CELL_EMPTY)
//                    continue
//                }
//                var cell = _cellEnum.one()
//                if cell == CELL_TOWER {
//                    if towerCount < towerCountTotal {
//                        let tower = getRandomTower()
//                        addItem(x: x.toFloat(), y: y.toFloat(), item: tower)
//                        tower.zPosition = MyScene.ITEM_LAYER_Z + y.toFloat()
//                        towerCount += 1
//                    } else {
//                        cell = CELL_ITEM
//                    }
//                }
//
//                if cell == CELL_BOX {
//                    if chestCount < chestCountTotal {
//                        let item = Chest()
//                        addItem(x: x.toFloat(), y: y.toFloat(), item: item)
//                        chestCount += 1
//                    } else {
//                        cell = CELL_ITEM
//                    }
//                }
//
//                if cell == CELL_EMPTY {
//
//                } else if cell == CELL_MONSTER {
//                        addItem(x: x.toFloat(), y: y.toFloat(), item: getRandomMonterCellItem())
//                    } else if cell == CELL_ITEM {
//                        let item = getRandomItem()
//                        addItem(x: x.toFloat(), y: y.toFloat(), item: item)
//                        item.zPosition = MyScene.ITEM_LAYER_Z + y.toFloat()
//                }
//                row.append(cell)
//            }
//            _mapMatrix.append(row)
//        }
//    }
    
//    func isSpecialPoint(x: CGFloat, y:CGFloat) -> Bool {
//        for p in _specialPoints {
//            if p.x == x && p.y == y {
//                return true
//            }
//        }
//
//        return false
//    }
//    func createPortalPoints() {
//        var xs = Array<Int>()
//        var ys = Array<Int>()
//        for i in 0...halfSize.toInt() * 2 {
//            xs.append(i)
//            if i != halfSize.toInt() * 2 {
//                ys.append(i)
//            }
//        }
//        _portalPrev = CGPoint(x: xs.one(), y: ys.one())
//        _portalNext = CGPoint(x: xs.one(), y: ys.one())
//        //        let prevPortalPoint = CGPoint(x: xs.one(), y: ys.one())
//        //        var currentPoint = prevPortalPoint
//        //        var lastPoint = CGPoint(x: 0, y: 0)
//        //        _portalPoints.append(prevPortalPoint)
//        //        let steps = seed(min: 0, max: 16)
//        //        for _ in 0...steps {
//        //            let acentPoints = getAcentPoints(point: currentPoint)
//        //            let nextPoint = acentPoints.one()
//        //            if nextPoint.x != lastPoint.x || nextPoint.y != lastPoint.y {
//        //                _portalPoints.append(nextPoint)
//        //                lastPoint = currentPoint
//        //                currentPoint = nextPoint
//        //            }
//        //        }
//        //        _portalPrev = prevPortalPoint
//        //        _portalNext = lastPoint
//        if _portalNext.x == _portalPrev.x && _portalNext.y == _portalPrev.y {
//            debug("same portal position")
//            createPortalPoints()
//        }
//        _specialPoints.append(_portalNext)
//        _specialPoints.append(_portalPrev)
//    }
//    func addPortalItem() {
//        _mapMatrix[_portalPrev.y.toInt()][_portalPrev.x.toInt()] = CELL_PORTAL
//        _mapMatrix[_portalNext.y.toInt()][_portalNext.x.toInt()] = CELL_PORTAL
//        let prev = PortalPrev()
//        let next:UIItem = _index >= _floorSize ? PortalFinal() : PortalNext()
//        addItem(x: _portalPrev.x, y: _portalPrev.y, item: prev)
//        addItem(x: _portalNext.x, y: _portalNext.y, item: next)
//        prev.zPosition = MyScene.ROLE_LAYER_Z - 1
//        next.zPosition = prev.zPosition
//        if next is PortalFinal {
//            next.zPosition = MyScene.ITEM_LAYER_Z + 20
//        }
//    }
//
//    func getItemByIndex(index:Int) -> UIItem {
//        return UIItem()
//    }
    
    override func addWall(x: CGFloat, y: CGFloat, item: SKSpriteNode) {
        super.addWall(x: x, y: y, item: item)
//        if Core().d2() {
//        } else {
//            addItem(x: x, y: y, item: getItemByIndex(index: _itemEnum.one()))
//        }
    }
    
    override func addPortalItem() {
        if _index < _floorSize {
            addGround(x: _portalNext.x, y: _portalNext.y, item: PortalNext())
        } else {
            addItem(x: _portalNext.x, y: _portalNext.y, item: getPortalFinal())
        }
        addGround(x: _portalPrev.x, y: _portalPrev.y, item: PortalPrev())
    }
    
    func getPortalFinal() -> UIItem {
        return PortalFinal()
    }
    
//    func blastItem() -> Bool {
//        let point = getNextPoint()
//        if isPointValid(point: point) {
//            let item = _itemLayer.childNode(withName: getItemName(point))
//            if nil != item && removable(point) {
//                item!.removeFromParent()
//                _mapMatrix[point.y.toInt()][point.x.toInt()] = CELL_EMPTY
//                return true
//            }
//        }
//        return false
//    }
    func transport() -> Bool {
        var point:CGPoint!
        let position = convertPixelToIndex(x: _role.position.x, y: _role.position.y)
        switch _direction {
            case NORTH:
                point = CGPoint(x: position.x, y: position.y - 2)
            case SOUTH:
                point = CGPoint(x: position.x, y: position.y + 2)
            case WEST:
                point = CGPoint(x: position.x - 2, y: position.y)
            case EAST:
                point = CGPoint(x: position.x + 2, y: position.y)
            default:
                return false
        }
        let dx = point.x.toInt()
        let dy = point.y.toInt()
        if isPointValid(point: point) && _mapMatrix[dy][dx] == CELL_EMPTY {
            let fo = SKAction.fadeOut(withDuration: TimeInterval(0.5))
            let fi = SKAction.fadeIn(withDuration: TimeInterval(0.5))
            _role.run(fo) {
                self._role.position.x = (point.x - self.hSize / 2) * self.cellSize
                self._role.position.y = (self.vSize / 2 - point.y) * self.cellSize
                self._role.run(fi)
            }
            
            return true
        }
        return false
    }
    private func removable(_ point:CGPoint) -> Bool {
        let cell = _mapMatrix[point.y.toInt()][point.x.toInt()]
        
        return cell == CELL_ITEM || cell == CELL_TOWER
    }
}
