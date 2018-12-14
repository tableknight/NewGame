//
//  BaseScene.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/12/8.
//  Copyright © 2018年 Chen. All rights reserved.
//
//
import Foundation
import SpriteKit
class MyScene: SKSpriteNode {
    static let MAP_LAYER_Z:CGFloat = 10
    static let ROLE_LAYER_Z:CGFloat = 50
    static let ITEM_LAYER_Z:CGFloat = 100
    static let MASK_LAYER_Z:CGFloat = 150
    let CELL_EMPTY = 100
    let CELL_TOWER = 101
    let CELL_MONSTER = 102
    let CELL_ITEM = 103
    let CELL_PORTAL = 104
    let TOWER_FIRE_ENERGE = 200
    let TOWER_WATER_ENERGE = 201
    let TOWER_THUNDER_ENERGE = 202
    let TOWER_TIME_REDUCE = 203
    let TOWER_PHYSICAL_POWER = 204
    let TOWER_MAGICAL_POWER = 205
    let TOWER_ATTACK_POWER = 206
    let TOWER_DEFENCE_POWER = 207
    let TOWER_MIND_POWER = 208
    let TOWER_LUCKY_POWER = 209
    let TOWER_SPEED_POWER = 210
    let NORTH = 1
    let SOUTH = 2
    let WEST = 3
    let EAST = 4
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _mapLayer.zPosition = MyScene.MAP_LAYER_Z
        _roleLayer.zPosition = MyScene.ROLE_LAYER_Z
        _itemLayer.zPosition = MyScene.ITEM_LAYER_Z
        _maskLayer.zPosition = MyScene.MASK_LAYER_Z
        addChild(_mapLayer)
        addChild(_roleLayer)
        addChild(_itemLayer)
        addChild(_maskLayer)
        isUserInteractionEnabled = true
        for _ in 0...20 {
            _cellEnum.append(CELL_EMPTY)
        }
        for _ in 0...12 {
            _cellEnum.append(CELL_ITEM)
        }
        for _ in 0...3 {
            _cellEnum.append(CELL_MONSTER)
        }
        _cellEnum.append(CELL_TOWER)
        _towerEnum = [TOWER_MIND_POWER, TOWER_FIRE_ENERGE, TOWER_LUCKY_POWER, TOWER_SPEED_POWER, TOWER_TIME_REDUCE, TOWER_ATTACK_POWER, TOWER_DEFENCE_POWER, TOWER_WATER_ENERGE, TOWER_MAGICAL_POWER, TOWER_PHYSICAL_POWER, TOWER_THUNDER_ENERGE]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        
        if !_isMoving {
            _direction = calDirection(touchPoint: touchPoint!)
            move()
        } else {
            _nextDirection = calDirection(touchPoint: touchPoint!)
        }
    }
    func move() {
        let nextPoint = getNextPoint()
        let nextY = nextPoint.y.toInt()
        let nextX = nextPoint.x.toInt()
        if nextX < 0 || nextX > 8 || nextY < 0 || nextY > 7 {
            debug("out of matrix")
            return
        }
        let nextCell = _mapMatrix[nextY][nextX]
        if CELL_EMPTY != nextCell && CELL_PORTAL != nextCell {
            switch _direction {
                case NORTH:
                    _role.faceNorth()
                    break
                case SOUTH:
                    _role.faceSouth()
                    break
                case WEST:
                    _role.faceWest()
                    break
                case EAST:
                    _role.faceEast()
                    break
                default:
                    debug("no face direction in func move")
            }
            let cell = getNextCellItem(x:nextX, y:nextY)
//            cell.triggerEvent()
            
            return
        }
        
        var point:CGPoint = CGPoint(x: cellSize, y: cellSize)
        switch _direction {
            case NORTH:
//                _role.faceNorth()
                _role.moveNorth()
                point = CGPoint(x: 0, y: cellSize)
                break
            case SOUTH:
//                _role.faceSouth()
                _role.moveSouth()
                point = CGPoint(x: 0, y: -cellSize)
                break
            case WEST:
//                _role.faceWest()
                _role.moveWest()
                point = CGPoint(x: -cellSize, y: 0)
                break
            case EAST:
//                _role.faceEast()
                _role.moveEast()
                point = CGPoint(x: cellSize, y: 0)
                break
            default:
                debug("no face direction in func move")
        }
        let cgv = CGVector(dx: point.x, dy: point.y)
        let mv = SKAction.move(by: cgv, duration: TimeInterval(Game.FRAME_SIZE * 2))
        let this = self
        _isMoving = true
        _role.run(mv, completion: {
            if this._nextDirection > 0 {
                this._direction = this._nextDirection
                this._nextDirection = 0
                this.move()
            } else {
                this._isMoving = false
                
            }
        })
    }
    func getNextCellItem(x:Int, y:Int) -> UIItem {
        return _itemLayer.childNode(withName: "cell\(x)\(y)") as! UIItem
    }
    func convertPixelToIndex(x:CGFloat, y:CGFloat) -> CGPoint {
        return CGPoint(x: round(x / cellSize) + 4, y: 4 - round(y / cellSize))
    }
    func getNextPoint() -> CGPoint {
        let position = convertPixelToIndex(x: _role.position.x, y: _role.position.y)
        switch _direction {
        case NORTH:
            return CGPoint(x: position.x, y: position.y - 1)
        case SOUTH:
            return CGPoint(x: position.x, y: position.y + 1)
        case WEST:
            return CGPoint(x: position.x - 1, y: position.y)
        case EAST:
            return CGPoint(x: position.x + 1, y: position.y)
        default:
            return position
        }
    }
    func isPointValid(point:CGPoint) -> Bool {
        if point.x < 0 || point.y < 0 || point.x > 8 || point.y > 7 {
            return false
        }
        return true
    }
    func calDirection(touchPoint:CGPoint) -> Int {
        let xOffset = abs(touchPoint.x - _role.position.x)
        let yOffset = abs(touchPoint.y - _role.position.y)
        var direction = 0
        if xOffset > yOffset {
            if touchPoint.x > _role.position.x {
                direction = EAST
            } else {
                direction = WEST
            }
        } else {
            if touchPoint.y > _role.position.y {
                direction = NORTH
            } else {
                direction = SOUTH
            }
        }
        
        return direction
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func create() -> Void {
        let oa4 = Game.instance.outside_a4
        _mapSet = GroundSets(ground: oa4.getCell(12, 2, 2, 2), wall: oa4.getCell(12, 4, 2, 2))
//        createMap()
//        let map = _mapLayer
        let map = SKSpriteNode(imageNamed: "meadow")
        map.size = CGSize(width: cellSize * 9, height: cellSize * 10)
        map.position.y = -cellSize * 0.5
        _mapLayer.addChild(map)
//        createItems()
        createPortalPoints()
        createMapMatrix()
        addPortalItem()
        setRole()
//        createMask()
//        let point = convertPixelToIndex(x: _role.position.x, y: _role.position.y)
//        removeCellMask(x: point.x, y: point.y)
//        let points = getAcentPoints(point: point)
//        for p in points {
//            removeCellMask(x: p.x, y: p.y)
//        }
    }
    internal func createMask() {
        for y in 0...7 {
            for x in 0...8 {
                addMask(x: x.toFloat(), y: y.toFloat())
            }
        }
    }
    internal func removeCellMask(x:CGFloat, y:CGFloat) {
        let mask = _maskLayer.childNode(withName: "mask\(x.toInt())\(y.toInt())")
        if nil != mask {
            mask?.removeFromParent()
        }
    }
    internal func getAcentPoints(point:CGPoint) -> Array<CGPoint> {
        var points = Array<CGPoint>()
        let northPoint = CGPoint(x: point.x, y: point.y - 1)
        if isPointValid(point: northPoint) {
            points.append(northPoint)
        }
        let southPoint = CGPoint(x: point.x, y: point.y + 1)
        if isPointValid(point: southPoint) {
            points.append(southPoint)
        }
        let westPoint = CGPoint(x: point.x - 1, y: point.y)
        if isPointValid(point: westPoint) {
            points.append(westPoint)
        }
        let eastPoint = CGPoint(x: point.x + 1, y: point.y)
        if isPointValid(point: eastPoint) {
            points.append(eastPoint)
        }
        return points
    }
    internal func createMap() {
        let yOffset:CGFloat = cellSize
        let mapStart = _mapSet.getMapPart(part: "start")
        mapStart.position.x = cellSize * startX
        mapStart.position.y = yOffset
        _mapLayer.addChild(mapStart)
        let mapEnd = _mapSet.getMapPart(part: "end")
        mapEnd.position.x = cellSize * endX
        mapEnd.position.y = yOffset
        _mapLayer.addChild(mapEnd)
        let wallStart = _mapSet.getWallPart(part: "start")
        wallStart.position.x = mapStart.position.x
        wallStart.position.y = -cellSize * 5.5 + yOffset
        _mapLayer.addChild(wallStart)
        for i in startX.toInt() + 1...endX.toInt() - 1 {
            let mapConnect = _mapSet.getMapPart(part: "connect")
            mapConnect.position.x = cellSize * i.toFloat()
            mapConnect.position.y = yOffset
            _mapLayer.addChild(mapConnect)
            let wallConnect = _mapSet.getWallPart(part: "connect")
            wallConnect.position.x = mapConnect.position.x
            wallConnect.position.y = wallStart.position.y
            _mapLayer.addChild(wallConnect)
        }
        let wallEnd = _mapSet.getWallPart(part: "end")
        wallEnd.position.x = mapEnd.position.x
        wallEnd.position.y = wallStart.position.y
        _mapLayer.addChild(wallEnd)
        
        for i in startX.toInt()...endX.toInt() {
            let wallDeep = SKSpriteNode(texture: wallShadow)
            wallDeep.position.x = cellSize * i.toFloat()
            wallDeep.position.y = wallStart.position.y
            wallDeep.size = CGSize(width: cellSize, height: cellSize * 2)
            _mapLayer.addChild(wallDeep)
        }
        
    }
//    internal func createItems() {
//        let ob = Game.instance.outside_b
//        addItem(x: 0, y: 0, item: ob.getNode(4, 12))
//        addItem(x: 1, y: 0, item: ob.getNode(4, 12))
//        addItem(x: 0, y: 1, item: ob.getNode(4, 12))
//        for i in 3...8 {
//
////            addItem(x: i.toFloat(), y: 7, item: ob.getNode(4, 12))
//            addItem(x: i.toFloat(), y: 6, item: ob.getNode(5, 12, 1, 2))
//        }
//    }
    internal func addItem(x:CGFloat, y:CGFloat, item:SKSpriteNode) {
        item.anchorPoint = CGPoint(x: 0.5, y: 0)
        item.position.x = (startX + x) * cellSize
        item.position.y = (3.5 - y) * cellSize
        item.zPosition = MyScene.ITEM_LAYER_Z
        item.name = "cell\(x.toInt())\(y.toInt())"
        _itemLayer.addChild(item)
    }
    internal func addMask(x:CGFloat, y:CGFloat) {
        let item = SKShapeNode(rect: CGRect(x: (startX + x - 0.5) * cellSize, y: (4 - y - 0.5) * cellSize, width: cellSize, height: cellSize))
//        item.anchorPoint = CGPoint(x: 0.5, y: 0)
//        item.position.x = (startX + x) * cellSize
//        item.position.y = (3.5 - y) * cellSize
        item.lineWidth = 0
        item.fillColor = UIColor.black
        item.zPosition = MyScene.MASK_LAYER_Z
        item.name = "mask\(x.toInt())\(y.toInt())"
        _maskLayer.addChild(item)
    }
    internal func createMapMatrix() {
        _mapMatrix = []
        for y in 0...7 {
            var row:Array<Int> = []
            for x in 0...8 {
                if isSpecialPoint(x: x.toFloat(), y: y.toFloat()) {
                    row.append(CELL_EMPTY)
                    continue
                }
                let cell = _cellEnum.one()
                row.append(cell)
                if cell == CELL_EMPTY {
                    
                } else
                if cell == CELL_MONSTER {
                    addItem(x: x.toFloat(), y: y.toFloat(), item: getRandomMonterCellItem())
                } else
                if cell == CELL_TOWER {
                    let tower = getRandomTower()
                    addItem(x: x.toFloat(), y: y.toFloat(), item: tower)
                    tower.zPosition = MyScene.ITEM_LAYER_Z + y.toFloat()
                } else
                if cell == CELL_ITEM {
                    let item = getRandomItem()
                    addItem(x: x.toFloat(), y: y.toFloat(), item: item)
                    item.zPosition = MyScene.ITEM_LAYER_Z + y.toFloat()
                }
                
            }
            _mapMatrix.append(row)
        }
    }
    func getTowerByIndex(index:Int) -> Tower {
        switch index {
        case TOWER_MIND_POWER:
            return MindPowerTower()
        case TOWER_FIRE_ENERGE:
            return FireEnergeTower()
        case TOWER_LUCKY_POWER:
            return LuckyPowerTower()
        case TOWER_SPEED_POWER:
            return SpeedPowerTower()
        case TOWER_TIME_REDUCE:
            return TimeReduceTower()
        case TOWER_ATTACK_POWER:
            return AttackPowerTower()
        case TOWER_WATER_ENERGE:
            return WaterEnergeTower()
        case TOWER_DEFENCE_POWER:
            return DefencePowerTower()
        case TOWER_MAGICAL_POWER:
            return MagicalPowerTower()
        case TOWER_PHYSICAL_POWER:
            return PhysicalPowerTower()
        case TOWER_THUNDER_ENERGE:
            return ThunderEnergeTower()
        default:
            return FireEnergeTower()
        }
    }
    func isSpecialPoint(x: CGFloat, y:CGFloat) -> Bool {
        for p in _specialPoints {
            if p.x == x && p.y == y {
                return true
            }
        }
        
        return false
    }
    func createPortalPoints() {
        let xs = [0,1,2,3,4,5,6,7,8]
        let ys = [0,1,2,3,4,5,6,7]
        _portalPrev = CGPoint(x: xs.one(), y: ys.one())
        _portalNext = CGPoint(x: xs.one(), y: ys.one())
//        let prevPortalPoint = CGPoint(x: xs.one(), y: ys.one())
//        var currentPoint = prevPortalPoint
//        var lastPoint = CGPoint(x: 0, y: 0)
//        _portalPoints.append(prevPortalPoint)
//        let steps = seed(min: 0, max: 16)
//        for _ in 0...steps {
//            let acentPoints = getAcentPoints(point: currentPoint)
//            let nextPoint = acentPoints.one()
//            if nextPoint.x != lastPoint.x || nextPoint.y != lastPoint.y {
//                _portalPoints.append(nextPoint)
//                lastPoint = currentPoint
//                currentPoint = nextPoint
//            }
//        }
//        _portalPrev = prevPortalPoint
//        _portalNext = lastPoint
        if _portalNext.x == _portalPrev.x && _portalNext.y == _portalPrev.y {
            debug("same portal position")
            createPortalPoints()
        }
        _specialPoints.append(_portalNext)
        _specialPoints.append(_portalPrev)
    }
    func addPortalItem() {
        _mapMatrix[_portalPrev.y.toInt()][_portalPrev.x.toInt()] = CELL_PORTAL
        _mapMatrix[_portalNext.y.toInt()][_portalNext.x.toInt()] = CELL_PORTAL
        let prev = PortalPrev()
        let next = PortalNext()
        addItem(x: _portalPrev.x, y: _portalPrev.y, item: prev)
        addItem(x: _portalNext.x, y: _portalNext.y, item: next)
        prev.zPosition = MyScene.ROLE_LAYER_Z - 1
        next.zPosition = prev.zPosition
    }
    func getMonsterByIndex(index:Int) -> Creature {
        return Creature()
    }
    func getItemByIndex(index:Int) -> UIItem {
        return UIItem()
    }
    func getRandomMonterCellItem() -> UIEvil {
        let ue = UIEvil()
        let ranMon = getMonsterByIndex(index: _monsterEnum.one())
        ue.setTexture(ranMon._img)
        let face = [NORTH,SOUTH,EAST,WEST].one()
        if face == NORTH {
            ue.faceNorth()
        } else
        if face == SOUTH {
            ue.faceSouth()
        } else
        if face == WEST {
            ue.faceWest()
        } else
        if face == EAST {
            ue.faceEast()
        }
        
        return ue
    }
    func getRandomTower() -> Tower {
        return getTowerByIndex(index: _towerEnum.one())
    }
    func getRandomItem() -> UIItem {
        let ui = getItemByIndex(index: _itemEnum.one())
        return ui
    }
    func blastItem() -> Bool {
        let point = getNextPoint()
        if isPointValid(point: point) {
            let item = _itemLayer.childNode(withName: getItemName(point))
            if nil != item {
                item!.removeFromParent()
                return true
            }
        }
        return false
    }
    func getItemName(_ point:CGPoint) -> String {
        return "item\(point.x)\(point.y)"
    }
    func setRole() {
        let e = Emily()
        Game.instance.char = e
        e.create(level: 1)
        e._level = 100
        e._leftPoint = 5
        e._dungeonLevel = 100
        let char = BUnit()
        char.setUnit(unit: e)
        char.createForStage()
        char.faceNorth()
        _roleLayer.addChild(char)
//        char.anchorPoint = CGPoint(x: 0.5, y: 1)
        char.position.x = (_portalPrev.x - 4) * cellSize
        char.position.y = (4 - _portalPrev.y) * cellSize
        char.zPosition = MyScene.ROLE_LAYER_Z
        _role = char
//        Game.instance.role = _role
        Game.instance.role = _role
    }
    internal var wallShadow = SKTexture(imageNamed: "wall_deep.png")
    internal var _mapSet:GroundSets!
    internal var _mapLayer = SKSpriteNode()
    internal var _roleLayer = SKSpriteNode()
    internal var _itemLayer = SKSpriteNode()
    internal var _maskLayer = SKSpriteNode()
    internal var startX:CGFloat = -4
    internal var endX:CGFloat = 4
    internal var _direction = 0
    internal var _isMoving = false
    internal var _nextDirection = 0
    internal var _portalPrev:CGPoint!
    internal var _portalNext:CGPoint!
    var _role:BUnit!
    var _mapMatrix:Array<Array<Int>> = []
    var _itemEnum:Array<Int> = []
    var _towerEnum:Array<Int> = []
    var _monsterEnum:Array<Int> = []
    var _cellEnum:Array<Int> = []
    var _specialPoints:Array<CGPoint> = []
    var _status = Array<Status>()
}

