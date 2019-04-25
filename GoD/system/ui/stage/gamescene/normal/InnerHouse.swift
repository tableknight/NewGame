//
//  InnerHouse.swift
//  GoD
//
//  Created by kai chen on 2019/1/1.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class InnerHouse: StandScene {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    internal var _wallTexture = Game.instance.outside_a3.getCell(2, 7, 2, 2)
    internal var _doorX = 6
    override func create() {
        _nameLabel.text = self._name
        createMapMatrix()
        createInnerGround()
        createWall(wallTexture: _wallTexture)
        createRoof()
        //        setRole()
        _initialized = true
        
    }
    internal func createWall(wallTexture:SKTexture) {
//        let ws = wallTexture.getCell(0, 1, 1, 2)
        let wc = wallTexture.getCell(0.5, 1, 1, 2)
//        let we = wallTexture.getCell(1, 1, 1, 2)
        let start = -halfSize
        let end = halfSize
//        let wallStart = SKSpriteNode(texture: ws)
//        wallStart.position.x = cellSize * start
//        wallStart.position.y = cellSize * (halfSize + 1.5)
//        _mapLayer.addChild(wallStart)
        for i in start.toInt()...end.toInt(){
            let wallConnect = SKSpriteNode(texture: wc)
            wallConnect.position.x = cellSize * i.toFloat()
            wallConnect.position.y = cellSize * (halfSize + 1.5)
            _mapLayer.addChild(wallConnect)
        }
//        let wallEnd = SKSpriteNode(texture: we)
//        wallEnd.position.x = cellSize * end
//        wallEnd.position.y = wallStart.yAxis
//        _mapLayer.addChild(wallEnd)
    }
    internal func createInnerGround() {
        _mapSet.groundHeight = halfSize
        let start = -halfSize
        let end = halfSize
        
        //        let yOffset:CGFloat = cellSize
        //        let mapStart = _mapSet.getMapPart(part: "start")
        //        mapStart.position.x = cellSize * start
        //        mapStart.position.y = yOffset
        //        _mapLayer.addChild(mapStart)
        //        let mapEnd = _mapSet.getMapPart(part: "end")
        //        mapEnd.position.x = cellSize * end
        //        mapEnd.position.y = yOffset
        //        _mapLayer.addChild(mapEnd)
//        let wallStart = _mapSet.getWallPart(part: "start")
//        wallStart.position.x = cellSize * start - cellSize
//        wallStart.position.y = -cellSize * (halfSize + 1) + cellSize
//        _mapLayer.addChild(wallStart)
        
        
        
        for i in start.toInt()...end.toInt() {
            let mapConnect = _mapSet.getMapPart(part: "connect")
            mapConnect.position.x = cellSize * i.toFloat()
            mapConnect.position.y = cellSize
            _mapLayer.addChild(mapConnect)
//            let wallConnect = _mapSet.getWallPart(part: "connect")
//            wallConnect.position.x = mapConnect.position.x
//            wallConnect.position.y = wallStart.position.y
//            wallConnect.zPosition = MyScene.ROLE_LAYER_Z + 100
//            _mapLayer.addChild(wallConnect)
        }
//        let wallEnd = _mapSet.getWallPart(part: "end")
//        wallEnd.position.x = cellSize * end + cellSize
//        wallEnd.position.y = wallStart.position.y
//        _mapLayer.addChild(wallEnd)
        
        //        for i in startX.toInt()...endX.toInt() {
        //            let wallDeep = SKSpriteNode(texture: wallShadow)
        //            wallDeep.position.x = cellSize * i.toFloat()
        //            wallDeep.position.y = wallStart.position.y
        //            wallDeep.size = CGSize(width: cellSize, height: cellSize * 2)
        //            _mapLayer.addChild(wallDeep)
        //        }
//        createTopWall()
    }
    //not used
    internal func createTopWall() {
        let start = -halfSize
        let end = halfSize
        
        //        let yOffset:CGFloat = cellSize
        //        let mapStart = _mapSet.getMapPart(part: "start")
        //        mapStart.position.x = cellSize * start
        //        mapStart.position.y = yOffset
        //        _mapLayer.addChild(mapStart)
        //        let mapEnd = _mapSet.getMapPart(part: "end")
        //        mapEnd.position.x = cellSize * end
        //        mapEnd.position.y = yOffset
        //        _mapLayer.addChild(mapEnd)
        //        let wallStart = _mapSet.getWallPart(part: "start")
        //        wallStart.position.x = cellSize * start
        //        wallStart.position.y = -cellSize * (halfSize + 1) + cellSize
        //        _mapLayer.addChild(wallStart)
        
        
        let y = -cellSize * (halfSize + 1) + cellSize
        for i in start.toInt()...end.toInt() {
            //            let mapConnect = _mapSet.getMapPart(part: "connect")
            //            mapConnect.position.x = cellSize * i.toFloat()
            //            mapConnect.position.y = yOffset
            //            _mapLayer.addChild(mapConnect)
            let wallConnect = _mapSet.getWallPart(part: "connect")
            wallConnect.position.x = cellSize * i.toFloat()
            wallConnect.position.y = y
            _mapLayer.addChild(wallConnect)
        }
        //        let wallEnd = _mapSet.getWallPart(part: "end")
        //        wallEnd.position.x = cellSize * end
        //        wallEnd.position.y = wallStart.position.y
        //        _mapLayer.addChild(wallEnd)
        
        //        for i in startX.toInt()...endX.toInt() {
        //            let wallDeep = SKSpriteNode(texture: wallShadow)
        //            wallDeep.position.x = cellSize * i.toFloat()
        //            wallDeep.position.y = wallStart.position.y
        //            wallDeep.size = CGSize(width: cellSize, height: cellSize * 2)
        //            _mapLayer.addChild(wallDeep)
        //        }
    }
    internal var _roofSets:RoofSets!
    internal var _bottomWallTexture:SKTexture!
    internal func createRoof() {
        let rs = _roofSets!
        let start = -halfSize
        let end = halfSize
        let doorX = _doorX - halfSize.toInt()
        let z = MyScene.ROLE_LAYER_Z + 100
        // top bottom
        for i in start.toInt()...end.toInt() {
            let rh = rs.roofConnectH
            rh.position.x = cellSize * i.toFloat()
            rh.position.y = cellSize * (halfSize + 2.5)
            _mapLayer.addChild(rh)
            if [doorX - 1, doorX, doorX + 1].index(of: i) == nil {
                let rh1 = rs.roofConnectH
                rh1.zPosition = z
                rh1.position.x = cellSize * i.toFloat()
                rh1.position.y = -cellSize * (halfSize - 0.5)
                _mapLayer.addChild(rh1)
            }
        }
        // left right
        for i in start.toInt()...end.toInt() {
            let y = -cellSize * i.toFloat() + cellSize * 1.5
            let rv1 = rs.roofConnectV
            rv1.position.x = (start - 1) * cellSize
            rv1.position.y = y
            rv1.zPosition = _mapLayer.zPosition + 2
            _mapLayer.addChild(rv1)
            let rv2 = rs.roofConnectV
            rv2.position.x = (end + 1) * cellSize
            rv2.position.y = y
            rv2.zPosition = _mapLayer.zPosition + 2
            _mapLayer.addChild(rv2)
        }
        let tlc = rs.topLeftCorner
        //        tlc.zPosition = _mapLayer.zPosition + 3
        tlc.xAxis = (start - 1) * cellSize
        tlc.yAxis = (halfSize + 3) * cellSize
        _mapLayer.addChild(tlc)
        
        let trc = rs.topRightCorner
        //        trc.zPosition = _mapLayer.zPosition + 3
        trc.xAxis = -tlc.xAxis
        trc.yAxis = tlc.yAxis
        _mapLayer.addChild(trc)
        
        let blc = rs.bottomLeftCorner
        //        blc.zPosition
        blc.xAxis = tlc.xAxis
        blc.yAxis = (-halfSize + 1) * cellSize
        _mapLayer.addChild(blc)
        
        let brc = rs.bottomRightCorner
        brc.xAxis = trc.xAxis
        brc.yAxis = blc.yAxis
        _mapLayer.addChild(brc)
        
//        let wallStart = _mapSet.getWallPart(part: "start")
//        wallStart.position.x = cellSize * start - cellSize
//        wallStart.position.y = -cellSize * (halfSize + 1) + cellSize
//        _mapLayer.addChild(wallStart)
        for i in start.toInt() - 1...end.toInt() + 1 {
            if i != doorX {
                let wallConnect = SKSpriteNode(texture: _bottomWallTexture)
                wallConnect.position.x = cellSize * i.toFloat()
                wallConnect.position.y = cellSize * start
                wallConnect.zPosition = z
                _mapLayer.addChild(wallConnect)
            }
        }
//        let wallEnd = _mapSet.getWallPart(part: "end")
//        wallEnd.position.x = cellSize * end + cellSize
//        wallEnd.position.y = wallStart.position.y
//        _mapLayer.addChild(wallEnd)
        
        let le = rs.leftEnd
        le.zPosition = z
        le.yAxis = -cellSize * (halfSize - 0.5)
        le.xAxis = (doorX - 1).toFloat() * cellSize
        _mapLayer.addChild(le)
        let re = rs.rightEnd
        re.zPosition = z
        re.yAxis = le.yAxis
        re.xAxis = (doorX + 1).toFloat() * cellSize
        _mapLayer.addChild(re)
    }
    func createWall(x:CGFloat, y:CGFloat, width:CGFloat) {
        let rs = _roofSets!
        let z = MyScene.ITEM_LAYER_Z + 30
        let wc = _wallTexture.getCell(0.5, 1, 1, 2)
        for i in x.toInt()...(x + width - 1).toInt() {
            let rh = rs.roofConnectH
            rh.position.x = cellSize * (i.toFloat() - halfSize)
            rh.position.y = cellSize * (halfSize - y + 1.5)
            rh.anchorPoint = CGPoint(x: 0.5, y: 0)
            rh.zPosition = z
            _itemLayer.addChild(rh)
            let wallConnect = SKSpriteNode(texture: wc)
            wallConnect.position.x = cellSize * (i.toFloat() - halfSize)
            wallConnect.position.y = cellSize * (halfSize - y - 0.5)
            wallConnect.anchorPoint = CGPoint(x: 0.5, y: 0)
            wallConnect.zPosition = z
            _itemLayer.addChild(wallConnect)
        }
    }
    func createWall(x:CGFloat, y:CGFloat, height:CGFloat) {
        let rs = _roofSets!
        let z = MyScene.ITEM_LAYER_Z + 30
        let wc = _wallTexture.getCell(0.5, 1, 1, 2)
        for i in y.toInt()...(y + height - 1).toInt() {
            let rh = rs.roofConnectV
            rh.position.x = cellSize * (x - halfSize)
            rh.position.y = cellSize * (halfSize - i.toFloat() + 1.5)
            rh.anchorPoint = CGPoint(x: 0.5, y: 0)
            rh.zPosition = z
            _itemLayer.addChild(rh)
        }
        let wallConnect = SKSpriteNode(texture: wc)
        wallConnect.position.x = cellSize * (x - halfSize)
        wallConnect.position.y = cellSize * (halfSize - y + 0.5 - height)
        wallConnect.anchorPoint = CGPoint(x: 0.5, y: 0)
        wallConnect.zPosition = z
        _itemLayer.addChild(wallConnect)
    }
}
