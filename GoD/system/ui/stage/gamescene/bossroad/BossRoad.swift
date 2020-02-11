//
//  BossRoad.swift
//  GoD
//
//  Created by kai chen on 2019/3/9.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class BossRoad: AcientRoad {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
//        halfSize = seedFloat(min: 3, max: 7)
        hSize = [8,8,10,10,12,12].one()
        vSize = [8,8,10,10,12,12].one()
        _monsterEnum = []
        let oa4 = Game.instance.outside_a4
        _mapSet = GroundSets(ground: oa4.getCell(6, 12, 2, 2), wall: oa4.getCell(6, 14, 2, 2))
        _name = "早宫"
        
        _cellEnum = []
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
        _floorSize = 10
    }
    
    override func create() {
        if _floorSize >= _index {
//            halfSize = 6
            vSize = 12
            hSize = 12
        }
        super.create()
        _bossFloor = _floorSize
        _nameLabel.text = "\(_name) \(_index)"
        
    }
    
    override func createFloorSize() -> Int {
        return _floorSize
    }
    
//    override func createTowers() {
//        
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    override func getItemByIndex(index: Int) -> UIItem {
//        switch index {
//        case 1:
//            return WinterItem1()
//        case 2:
//            return WinterItem2()
//        case 3:
//            return WinterItem3()
//        default:
//            return WinterItem2()
//        }
//    }
    
//    override func getMonsterByIndex(index: Int) -> Creature {
//        switch index {
//        case 1:
//            return SnowLady()
//        case 2:
//            return FrozenSlime()
//        case 3:
//            return IceBeast()
//        case 4:
//            return SnowSpirit()
//        default:
//            return SnowLady()
//        }
//    }
    
    func getSelfScene() -> BossRoad {
        return BossRoad()
    }
    
    func getMonsterByIndex(index: Int) -> Creature {
        if index == 1 {
            return Ayer()
        }
        if index == 2 {
            return Shuran()
        }
        if index == 3 {
            return Lanis()
        }
        if index == 4 {
            return Angela()
        }
        return Ayer()
    }
    
    override func createEnemy() {
        for p in _visiblePoints {
            if Core().d7() && _mapMatrix[p.y.toInt()][p.x.toInt()] == CELL_EMPTY {
                _mapMatrix[p.y.toInt()][p.x.toInt()] = CELL_MONSTER
                addItem(x: p.x, y: p.y, item: getRandomMonterCellItem())
            }
        }
    }
    
    override func getRandomMonterCellItem() -> UIEvil {
        let ue = UIEvil()
        let md = getMonsterByIndex(index: [1,2,3,4,1,2,3,4,1,2,3,4].one())
        ue._thisType = md._type
        ue.setTexture(md._img)
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
    
    override func moveEndAction() {
        let pos = convertPixelToIndex(x: _role.xAxis, y: _role.yAxis)
        let stage = Game.instance.curStage!
        let char = _role!
        if pos.x == _portalNext.x && pos.y == _portalNext.y {
            if _index < _floorSize {
                let nextScene = getSelfScene()
                nextScene._index = self._index + 1
                stage._scenes.append(nextScene)
                stage.switchScene(next: nextScene, completion: {
                    nextScene.setRole(x: nextScene._portalPrev.x, y: nextScene._portalPrev.y, char: char)
                })
            } else {
                debug("_index error _floorSize")
            }
        }
    }
    
    override func hasAction(cell:Int, touchPoint:CGPoint) -> Bool {
        let nextPoint = getNextPoint()
        let nextY = nextPoint.y
        let nextX = nextPoint.x
        
        if nextX == _portalNext.x && nextY == _portalNext.y && cell == CELL_BOSS && _index >= _floorSize {
            finalBattle()
            let boss = getNextCellItem(x: nextX.toInt(), y: nextY.toInt())
            _bossBattle.victoryAction = {
                self._mapMatrix[nextY.toInt()][nextX.toInt()] = self.CELL_EMPTY
                boss.removeFromParent()
            }
            return true

        }
        return false
    }
    
    internal func finalBattle() {
        
    }
    
    func createPortalPoints() {
        var xs = Array<Int>()
        var ys = Array<Int>()
        for i in 0...hSize.toInt() {
            xs.append(i)
            if i != vSize.toInt() {
                ys.append(i)
            }
        }
        _portalPrev = CGPoint(x: xs.one(), y: ys.one())
        _portalNext = CGPoint(x: xs.one(), y: ys.one())
        if _portalNext.x == _portalPrev.x && _portalNext.y == _portalPrev.y {
            debug("same portal position")
            createPortalPoints()
        }
        _specialPoints.append(_portalNext)
        _specialPoints.append(_portalPrev)
    }
    override func addPortalItem() {
        if _index < _floorSize {
            addGround(x: _portalNext.x, y: _portalNext.y, item: PortalNext())
        } else {
            _mapMatrix[_portalNext.y.toInt()][_portalNext.x.toInt()] = CELL_BOSS
            addItem(x: _portalNext.x, y: _portalNext.y, item: getPortalFinal())
        }
//        addGround(x: _portalPrev.x, y: _portalPrev.y, item: PortalPrev())
    }
//    func addPortalItem() {
//        _mapMatrix[_portalNext.y.toInt()][_portalNext.x.toInt()] = CELL_PORTAL
//        let next:UIItem = _index >= _floorSize ? getPortalFinal() : Portal1()
//        addItem(x: _portalNext.x, y: _portalNext.y, item: next)
//        next.zPosition = MyScene.ROLE_LAYER_Z - 1
//        if _floorSize == _index {
//            next.zPosition = MyScene.ITEM_LAYER_Z + 22
//        }
//    }
    
}

class Portal1:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.outside_a5.getCell(7, 5))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
