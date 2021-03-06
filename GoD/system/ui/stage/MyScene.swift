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
    static let UI_LAYER_Z:CGFloat = 108
    static let BOSS_LAYER_Z:CGFloat = 130
    static let WALL_SHADOW_LAYER_Z:CGFloat = 120
    static let ROLE_LAYER_Z:CGFloat = 50
    static let ITEM_LAYER_Z:CGFloat = 100
    static let MASK_LAYER_Z:CGFloat = 1150
    static let CELL_ITEM = 103
    let CELL_EMPTY = 100
    let CELL_TOWER = 101
    let CELL_MONSTER = 102
    let CELL_ITEM = 103
    let CELL_PORTAL = 104
    let CELL_BOX = 105
    let CELL_BLOCK = 106
    let CELL_SELLER = 107
    let CELL_BOSS = 108
    let CELL_HERB = 109
    let CELL_ORE = 110
    let CELL_ROLE = 151
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
    internal var _initialized = false
    var initialized:Bool {
        get {
            return _initialized
        }
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _nameLabel.position.x = 0
        _nameLabel.position.y = cellSize * 12
        _nameLabel.align = "center"
        _nameLabel.fontSize = 24
        _nameLabel.zPosition = MyScene.UI_LAYER_Z
        addChild(_nameLabel)
        _mapLayer.zPosition = MyScene.MAP_LAYER_Z
        _roleLayer.zPosition = MyScene.ROLE_LAYER_Z
        _itemLayer.zPosition = MyScene.ITEM_LAYER_Z
        _maskLayer.zPosition = MyScene.MASK_LAYER_Z
        _direction = SOUTH
        addChild(_mapLayer)
        addChild(_roleLayer)
        addChild(_itemLayer)
        addChild(_maskLayer)
        isUserInteractionEnabled = false
        for _ in 0...25 {
            _cellEnum.append(CELL_EMPTY)
        }
        for _ in 0...10 {
            _cellEnum.append(CELL_ITEM)
        }
        for _ in 0...3 {
            _cellEnum.append(CELL_MONSTER)
        }
        _cellEnum.append(CELL_BOX)
        _cellEnum.append(CELL_TOWER)
        _towerEnum = [TOWER_MIND_POWER, TOWER_FIRE_ENERGE, TOWER_LUCKY_POWER, TOWER_SPEED_POWER, TOWER_TIME_REDUCE, TOWER_ATTACK_POWER, TOWER_DEFENCE_POWER, TOWER_WATER_ENERGE, TOWER_MAGICAL_POWER, TOWER_PHYSICAL_POWER, TOWER_THUNDER_ENERGE]
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touchPoint = touches.first?.location(in: self)
//
//    }
    func touch(touchPoint:CGPoint?) {
        
        if Game.instance.curStage.cancelMove {
            return
        }
        
        if !_isMoving {
            _direction = calDirection(touchPoint: touchPoint!)
            move(touchPoint!)
        } else {
            _nextDirection = calDirection(touchPoint: touchPoint!)
        }
    }
    internal func hasAction(cell:Int, touchPoint:CGPoint) -> Bool {
        
        return false
    }
    internal func moveEndAction() {
        
    }
//    func moveNorth() {
//        if _isMoving {
//            return
//        }
//        _direction = NORTH
//        let nextPoint = getNextPoint()
//        let nextY = nextPoint.y.toInt()
//        let nextX = nextPoint.x.toInt()
//        if nextX < 0 || nextX > hSize.toInt() || nextY < 0 || nextY > vSize.toInt() - 1 {
//            debug("out of matrix")
//            _isMoving = false
//            return
//        }
//        let nextCell = _mapMatrix[nextY][nextX]
//        
//        if CELL_EMPTY == nextCell || CELL_PORTAL == nextCell {
//            let point = CGPoint(x: 0, y: cellSize)
//            _role.moveNorth()
//            let cgv = CGVector(dx: point.x, dy: point.y)
//            let mv = SKAction.move(by: cgv, duration: TimeInterval(0.5))
//            _isMoving = true
//            _role.run(mv, completion: {
//                self._isMoving = false
//                self.moveEndAction()
//            })
//        }
//    }
    func moveTo() {
        if _isMoving {
            moreMoving = true
            return
        }
//        _direction = SOUTH
        let nextPoint = getNextPoint()
        let nextY = nextPoint.y.toInt()
        let nextX = nextPoint.x.toInt()
        if nextX < 0 || nextX > hSize.toInt() || nextY < 0 || nextY > vSize.toInt() - 1 {
            debug("out of matrix")
            _isMoving = false
            return
        }
        let nextCell = _mapMatrix[nextY][nextX]
        
        if CELL_EMPTY == nextCell || CELL_PORTAL == nextCell {
            var point:CGPoint = CGPoint(x: cellSize, y: cellSize)
            switch _direction {
                case NORTH:
                    _role.moveNorth()
                    point = CGPoint(x: 0, y: cellSize)
                    break
                case SOUTH:
                    _role.moveSouth()
                    point = CGPoint(x: 0, y: -cellSize)
                    break
                case WEST:
                    _role.moveWest()
                    point = CGPoint(x: -cellSize, y: 0)
                    break
                case EAST:
                    _role.moveEast()
                    point = CGPoint(x: cellSize, y: 0)
                    break
                default:
                    debug("no face direction in func move")
            }
            let cgv = CGVector(dx: point.x, dy: point.y)
            let mv = SKAction.move(by: cgv, duration: TimeInterval(0.5))
            _isMoving = true
            _role.run(mv, completion: {
                self._isMoving = false
                self.moveEndAction()
                if self.moreMoving {
                    self.moveTo()
                    self.moreMoving = false
                }
            })
            return
        }
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
        }
    }
//    func moveEast() {
//        if _isMoving {
//            return
//        }
//        _direction = EAST
//        let nextPoint = getNextPoint()
//        let nextY = nextPoint.y.toInt()
//        let nextX = nextPoint.x.toInt()
//        if nextX < 0 || nextX > hSize.toInt() || nextY < 0 || nextY > vSize.toInt() - 1 {
//            debug("out of matrix")
//            _isMoving = false
//            return
//        }
//        let nextCell = _mapMatrix[nextY][nextX]
//
//        if CELL_EMPTY == nextCell || CELL_PORTAL == nextCell {
//            let point = CGPoint(x: cellSize, y: 0)
//            _role.moveEast()
//            let cgv = CGVector(dx: point.x, dy: point.y)
//            let mv = SKAction.move(by: cgv, duration: TimeInterval(0.5))
//            _isMoving = true
//            _role.run(mv, completion: {
//                self._isMoving = false
//                self.moveEndAction()
//            })
//        }
//    }
    func confirmEvent() {
        let nextPoint = getNextPoint()
        let nextY = nextPoint.y.toInt()
        let nextX = nextPoint.x.toInt()
        let nextCell = _mapMatrix[nextY][nextX]
        
        let touchPoint = getNextPixelPoint()
        
        if hasAction(cell: nextCell, touchPoint: touchPoint) {
            
            _isMoving = false
            return
        }
        
        if nextCell == CELL_BOX {
            let box = getNextCellItem(x: nextX, y: nextY) as! Chest
            if box.contains(touchPoint) {
                box.triggerEvent()
            }
            _isMoving = false
            return
        } else
        if nextCell == CELL_TOWER {
            let tower = getNextCellItem(x: nextX, y: nextY) as! Tower
            if tower.contains(touchPoint) {
                if !tower._triggered {
                    Sound.play(node: Game.instance.curStage, fileName: "tower")
//                    _role.play("Sound2")
                    tower.triggerEvent()
                    self._role.stateUp2()
                }
            }
            _isMoving = false
            return
        } else
        if nextCell == CELL_MONSTER {
            meetMonster(nextCell, nextX, nextY, touchPoint)
            _isMoving = false
            return
        }
        
        if nextCell == CELL_ITEM {
            _isMoving = false
            return
        }
        
        if nextCell == CELL_SELLER {
            deal()
            _isMoving = false
            return
        }
    }
    func move(_ touchPoint:CGPoint) {
        let nextPoint = getNextPoint()
        let nextY = nextPoint.y.toInt()
        let nextX = nextPoint.x.toInt()
        if nextX < 0 || nextX > hSize.toInt() || nextY < 0 || nextY > vSize.toInt() - 1 {
            debug("out of matrix")
            _isMoving = false
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
        }
        
        if nextCell == CELL_BLOCK || hasAction(cell: nextCell, touchPoint: touchPoint) || nextCell == CELL_HERB{
            
            _isMoving = false
            return
        }
        
        if nextCell == CELL_BOX {
            let box = getNextCellItem(x: nextX, y: nextY) as! Chest
            if box.contains(touchPoint) {
                box.triggerEvent()
            }
            _isMoving = false
            return
        } else
        if nextCell == CELL_TOWER {
            let tower = getNextCellItem(x: nextX, y: nextY) as! Tower
            if tower.contains(touchPoint) {
                if !tower._triggered {
                    Sound.play(node: Game.instance.curStage, fileName: "tower")
                    tower.triggerEvent()
                    self._role.stateUp2()
                }
            }
            _isMoving = false
            return
        } else
        if nextCell == CELL_MONSTER {
            meetMonster(nextCell, nextX, nextY, touchPoint)
            _isMoving = false
            return
        }
        
        if nextCell == CELL_ITEM {
            _isMoving = false
            return
        }
        
        if nextCell == CELL_SELLER {
            deal()
            _isMoving = false
            return
        }
        
        
        var point:CGPoint = CGPoint(x: cellSize, y: cellSize)
        switch _direction {
            case NORTH:
                _role.moveNorth()
                point = CGPoint(x: 0, y: cellSize)
                break
            case SOUTH:
                _role.moveSouth()
                point = CGPoint(x: 0, y: -cellSize)
                break
            case WEST:
                _role.moveWest()
                point = CGPoint(x: -cellSize, y: 0)
                break
            case EAST:
                _role.moveEast()
                point = CGPoint(x: cellSize, y: 0)
                break
            default:
                debug("no face direction in func move")
        }
        let cgv = CGVector(dx: point.x, dy: point.y)
        let mv = SKAction.move(by: cgv, duration: TimeInterval(0.5))
        let this = self
        _isMoving = true
        _role.run(mv, completion: {
            if this._nextDirection > 0 {
                this._direction = this._nextDirection
                this._nextDirection = 0
                this.move(touchPoint)
            } else {
                this._isMoving = false
            }
            this.moveEndAction()
        })
    }
    internal var _goodsList = Array<Item>()
//    internal var _whichItem = Array<Bool>()
//    internal var _mixedItemMoney = Array<Bool>()
    internal func deal() {
        let sp = SellingPanel()
        sp._goodsList = _goodsList
//        sp.showItemCount = true
//        sp._whichItem = _whichItem
//        sp.isMixedItems = true
//        sp._mixedItemMoney = _mixedItemMoney
        sp.create()
//        sp.buyAction
//        sp.hasBuyAction = true
//        sp.buyAction = {
//            sp.createGoodsList()
//        }
        Game.instance.curStage.showPanel(sp)
    }
    
    internal func meetMonster(_ cell:Int, _ nextX:Int, _ nextY:Int, _ touchPoint:CGPoint) {
        let item = getNextCellItem(x: nextX, y: nextY)
        if item is UIEvil {
            let mon = item as! UIEvil
            if mon.contains(touchPoint) {
                mon.triggerEvent()
                mon.defeatedAction = {
                    
                }
                mon.victoryAction = {
                    self._mapMatrix[nextY][nextX] = self.CELL_EMPTY
                    mon.removeFromParent()
                }
            }
        } else {
            //异常处理，不知道什原因这个模块不是uievil
            if cell == CELL_MONSTER {
                let mon = UIEvil()
                if _monsterEnum.count > 0 {
                    mon._thisType = _monsterEnum.one()
                }
                if item.contains(touchPoint) {
                    mon.triggerEvent()
                    mon.defeatedAction = {
                        
                    }
                    mon.victoryAction = {
                        self._mapMatrix[nextY][nextX] = self.CELL_EMPTY
                        item.removeFromParent()
                    }
                }
            } else {
                debug("----------------异常处理，不知道什原因这个模块不是uievil")
            }
        }
    }
    
    func getNextCellItem(x:Int, y:Int) -> UIItem {
        return _itemLayer.childNode(withName: getItemName(CGPoint(x: x, y: y))) as! UIItem
    }
    func convertPixelToIndex(x:CGFloat, y:CGFloat) -> CGPoint {
        return CGPoint(x: round(x / cellSize) + hSize / 2, y: vSize / 2 - round(y / cellSize))
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
    func getNextPixelPoint() -> CGPoint {
        let position = convertPixelToIndex(x: _role.position.x, y: _role.position.y)
        let x = _role.position.x
        let y = _role.position.y
        let gap = cellSize * 1
        switch _direction {
        case NORTH:
            return CGPoint(x: x, y: y + gap)
        case SOUTH:
            return CGPoint(x: x, y: y - gap)
        case WEST:
            return CGPoint(x: x - gap, y: y)
        case EAST:
            return CGPoint(x: x + gap, y: y)
        default:
            return position
        }
    }
    func isPointValid(point:CGPoint) -> Bool {
        if point.x < 0 || point.y < 0 || point.x > hSize || point.y >= vSize {
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
        createGround()
//        createItems()
//        createPortalPoints()
        createMapMatrix()
//        addPortalItem()
//        setRole()
//        createMask()
//        let point = convertPixelToIndex(x: _role.position.x, y: _role.position.y)
//        removeCellMask(x: point.x, y: point.y)
//        let points = getAcentPoints(point: point)
//        for p in points {
//            removeCellMask(x: p.x, y: p.y)
//        }
        _initialized = true
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
    internal func createGround() {
//        let map = SKSpriteNode(imageNamed: "meadow")
//        map.size = CGSize(width: cellSize * 9, height: cellSize * 10)
//        map.position.y = -cellSize * 0.5
//        _mapLayer.addChild(map)
        createMap()
    }
    internal func createMap() {
        
        _mapSet.groundHeight = vSize / 2
        let start = -hSize / 2
        let end = hSize / 2
        
        let yOffset:CGFloat = cellSize
        let mapStart = _mapSet.getMapPart(part: "start")
        mapStart.position.x = cellSize * start
        mapStart.position.y = yOffset
        _mapLayer.addChild(mapStart)
        let mapEnd = _mapSet.getMapPart(part: "end")
        mapEnd.position.x = cellSize * end
        mapEnd.position.y = yOffset
        _mapLayer.addChild(mapEnd)
        let wallStart = _mapSet.getWallPart(part: "start")
        wallStart.position.x = mapStart.position.x
        wallStart.position.y = -cellSize * (vSize / 2 + 0.5)
        _mapLayer.addChild(wallStart)
        
        
        
        for i in start.toInt() + 1...end.toInt() - 1 {
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
    }
    
    
    internal func addItem(x:CGFloat, y:CGFloat, item:SKSpriteNode) {
        item.anchorPoint = CGPoint(x: 0.5, y: 0)
        item.position.x = (-hSize / 2 + x) * cellSize
        item.position.y = (vSize / 2 - 0.5 - y) * cellSize
        item.zPosition = MyScene.ITEM_LAYER_Z + y
        item.name = getItemName(CGPoint(x: x, y: y))
        _itemLayer.addChild(item)
    }
    internal func addItem(x:CGFloat, y:CGFloat, item:SKSpriteNode, z:CGFloat = -1) {
        item.anchorPoint = CGPoint(x: 0.5, y: 0)
        item.position.x = (-hSize / 2 + x) * cellSize
        item.position.y = (vSize / 2 - 0.5 - y) * cellSize
        if z == -1 {
            item.zPosition = MyScene.ITEM_LAYER_Z + y
        } else {
            item.zPosition = z
        }
        item.name = getItemName(CGPoint(x: x, y: y))
        _itemLayer.addChild(item)
    }
    internal func addGround(x:CGFloat, y:CGFloat, item:SKSpriteNode, z:CGFloat = -1) {
        item.anchorPoint = CGPoint(x: 0.5, y: 0)
        item.position.x = (-hSize / 2 + x) * cellSize
        item.position.y = (vSize / 2 - 0.5 - y) * cellSize
        if z > -1 {
            item.zPosition = z
        } else {
            item.zPosition = MyScene.MAP_LAYER_Z + y
        }
//        item.name = getItemName(CGPoint(x: x, y: y))
        _mapLayer.addChild(item)
    }
    internal func setCell(x:Int, y:Int, width: Int, height: Int, cell: Int = MyScene.CELL_ITEM) {
        for x in x...(x + width - 1) {
            for y in (y - height + 1)...y {
                _mapMatrix[y][x] = cell
            }
        }
    }
    internal func addItem(x:CGFloat, y:CGFloat, item:SKSpriteNode, width: CGFloat = 0, height: CGFloat = 0, cell: Int = MyScene.CELL_ITEM, z:CGFloat = -1) {
        item.anchorPoint = CGPoint(x: 0, y: 0)
        item.position.x = (-hSize / 2 - 0.5 + x) * cellSize
        item.position.y = (vSize / 2 - 0.5 - y) * cellSize
        if z == -1 {
            item.zPosition = MyScene.ITEM_LAYER_Z + y
        } else {
            item.zPosition = z
        }
        item.name = getItemName(CGPoint(x: x, y: y))
        _itemLayer.addChild(item)
        
//        let ySize = (item.size.height / cellSize).toInt()
//        let xSize = (item.size.width / cellSize).toInt()
//        
//        for _y in 0...ySize - 1 {
//            for _x in 0...xSize - 1 {
//                _mapMatrix[y.toInt() - _y][x.toInt() + _x] = cell
//            }
//        }
    }
    internal func createCoord() {
        for y in 0...vSize.toInt() {
            for x in 0...hSize.toInt() {
                let l = Label()
                l.fontSize = 18
                l.text = "\(x),\(y)"
                l.position.x = (-hSize / 2 - 0.5 + x.toFloat()) * cellSize
                l.position.y = (vSize / 2 + 0.5 - y.toFloat()) * cellSize
                l.align = "center"
                l.zPosition = MyScene.ITEM_LAYER_Z
                _itemLayer.addChild(l)
            }
        }
    }
    internal func addMask(x:CGFloat, y:CGFloat) {
        let item = SKShapeNode(rect: CGRect(x: (-hSize / 2 + x - 0.5) * cellSize, y: (4 - y - 0.5) * cellSize, width: cellSize, height: cellSize))
//        item.anchorPoint = CGPoint(x: 0.5, y: 0)
//        item.position.x = (startX + x) * cellSize
//        item.position.y = (3.5 - y) * cellSize
        item.lineWidth = 0
        item.fillColor = UIColor.black
        item.zPosition = MyScene.MASK_LAYER_Z
        item.name = "mask\(x.toInt())\(y.toInt())"
        _maskLayer.addChild(item)
    }
    internal func createMapMatrix() {}
    func getItemName(_ point:CGPoint) -> String {
        return "item\(point.x.toInt())\(point.y.toInt())"
    }
    func setRole(x:CGFloat, y:CGFloat, role:Character) {
        
        Game.instance.char = role
//        for _ in 0...19 {
//            e.levelup()
//        }
        let char = BUnit()
        char._charSize = cellSize
        char.setUnit(unit: role)
        char.createForStage()
        char.faceSouth()
        _roleLayer.addChild(char)
//        char.anchorPoint = CGPoint(x: 0.5, y: 1)
        char.position.x = (x - hSize / 2) * cellSize
        char.position.y = (vSize / 2 - y) * cellSize
        char.zPosition = MyScene.ROLE_LAYER_Z
        _role = char
//        Game.instance.role = _role
//        Game.instance.role = _role
    }
    
    func setRole(x:CGFloat, y:CGFloat, char:BUnit) {
        _roleLayer.addChild(char)
        char.position.x = (x - hSize / 2) * cellSize
        char.position.y = (vSize / 2 - y) * cellSize
        char.zPosition = MyScene.ROLE_LAYER_Z
        _role = char
    }
    func getRoleNode(roleNode:SKSpriteNode) -> SKSpriteNode {
        let shadow = SKSpriteNode(texture: _shadow)
        shadow.yAxis = -cellSize * 0.25
        shadow.anchorPoint = CGPoint(x: 0.5, y: 0)
        roleNode.anchorPoint = CGPoint(x: 0.5, y: 0)
        roleNode.zPosition = shadow.zPosition + 1
        let node = SKSpriteNode()
        node.addChild(shadow)
        node.addChild(roleNode)
        return node
    }
    func getRandomMonterCellItem() -> UIEvil {
        let ue = UIEvil()
        let type = _monsterEnum.one()
        let md = Minions.data[type]!
        ue._thisType = type
        ue.setTexture(SKTexture(imageNamed: md.imgUrl))
        let face = [NORTH,SOUTH,EAST,WEST].one()
        if face == NORTH {
            ue.faceNorth()
        } else if face == SOUTH {
            ue.faceSouth()
        } else if face == WEST {
            ue.faceWest()
        } else if face == EAST {
            ue.faceEast()
        }
        
        return ue
    }
    
    func getRandomTower() -> Tower {
        return getTowerByIndex(index: _towerEnum.one())
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
    internal var hSize:CGFloat {
        set {
            _hSize = newValue
        }
        get {
            return _hSize
        }
    }
    internal var vSize:CGFloat {
        set {
            _vSize = newValue
        }
        get {
            return _vSize
        }
    }
//    internal var wallShadow = SKTexture(imageNamed: "wall_deep.png")
    internal var _mapSet:GroundSets!
    internal var _mapLayer = SKSpriteNode()
    internal var _roleLayer = SKSpriteNode()
    internal var _itemLayer = SKSpriteNode()
    internal var _maskLayer = SKSpriteNode()
//    internal var halfSize:CGFloat = 6
    internal var _hSize:CGFloat = 12
    internal var _vSize:CGFloat = 12
    internal var _direction = 0
    internal var _isMoving = false
    var moreMoving = false
    internal var _nextDirection = 0
    internal var _portalPrev:CGPoint!
    internal var _portalNext:CGPoint!
    internal var xSzie = 13
    internal var ySzie = 12
    internal var _shadow = SKTexture(imageNamed: "select.png").getCell(3, 0)
    var _role:BUnit!
    var _mapMatrix:Array<Array<Int>> = []
//    var _itemEnum:Array<Int> = []
    var _towerEnum:Array<Int> = []
    var _monsterEnum:Array<String> = []
    var _cellEnum:Array<Int> = []
    var _specialPoints:Array<CGPoint> = []
    var _status = Array<Status>()
    var _level:CGFloat = 1
    var _name = ""
    var _nameLabel = Label()
    var _soundUrl = ""
    internal let _wallShadow = SKTexture(imageNamed: "wall_shadow2")
}

class Chest:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
//        _x = seed(max: 12)
        let item = Game.instance.pictureChest.getCell(_x.toFloat(), 0)
        setTexture(item)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func triggerEvent() {
        if _triggered {
            return
        }
        _triggered = true
        let item = Game.instance.pictureChest.getCell(_x.toFloat(), 3)
        setTexture(item)
        Sound.play(node: Game.instance.curStage, fileName: "chest")
        if Core().d4() {
            let b = MimicBattle()
            b._level = Game.instance.curStage._curScene._level
            b.setEnemyPart(minions: Array<Creature>())
            let char = Game.instance.char!
            let cs:Array<Unit> = [char] + char.getReadyMinions()
            b.setPlayerPart(roles: cs)
            Game.instance.curStage.addBattle(b)
            b.battleStart()
            
            b.victoryAction = {
                let l = Loot()
                let roles = b._playerPart
                for c in roles {
                    let exp = l.getExp(selfUnit: c, enemyLevel: Game.instance.curStage._curScene._level) * 10
                    c._unit.expUp(up: exp)
                }
            }
            return
        }
        
        loot()
        
    }
    private func loot() {
        let l = Loot()
        l.loot(level: Game.instance.curStage._curScene!._level.toInt())
        var list = l.getList()
        if list.count == 0 {
            list.append(Item(Item.Tear))
        }
        Loot.showLootItems(list)
    }
    private var _x = 0
    var _triggered = false
    
}
class UIRole:UIItem {
    internal var _shadow = SKTexture(imageNamed: "select.png").getCell(3, 0)
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    func create(roleNode:SKSpriteNode) {
        let shadow = SKSpriteNode(texture: _shadow)
        shadow.yAxis = -cellSize * 0.25
        shadow.anchorPoint = CGPoint(x: 0.5, y: 0)
        roleNode.anchorPoint = CGPoint(x: 0.5, y: 0)
        roleNode.zPosition = shadow.zPosition + 1
        addChild(shadow)
        addChild(roleNode)
        _roleNode = roleNode
    }
    var _roleNode:SKSpriteNode!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
