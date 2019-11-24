//
//  NewComersVillage.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/30.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit

class NormalHouse:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let t = HouseSets(roofs: Game.instance.outside_a3.getCell(2, 1, 2, 2), wall: Game.instance.outside_a3.getCell(2, 3, 2, 2))
        let house = SKSpriteNode()
        house.size = CGSize(width: cellSize * 5, height: cellSize * 4)
        let rs = t.roofStart()
        rs.anchorPoint = CGPoint(x: 0.5, y: 0)
        rs.position.x = -cellSize * 2.5
        house.addChild(rs)
        let ws = t.wallStart()
        ws.anchorPoint = CGPoint(x: 0.5, y: 1)
        ws.position.x = -cellSize * 2.5
        house.addChild(ws)
        let rc = t.roofConnect()
        rc.anchorPoint = CGPoint(x: 0.5, y: 0)
        rc.position.x = -cellSize * 1.5
        house.addChild(rc)
        let wc = t.wallConnect()
        wc.anchorPoint = CGPoint(x: 0.5, y: 1)
        wc.position.x = -cellSize * 1.5
        house.addChild(wc)
        
        let rc1 = t.roofConnect()
        rc1.anchorPoint = CGPoint(x: 0.5, y: 0)
        rc1.position.x = -cellSize * 0.5
        house.addChild(rc1)
        let wc1 = t.wallConnect()
        wc1.anchorPoint = CGPoint(x: 0.5, y: 1)
        wc1.position.x = -cellSize * 0.5
        house.addChild(wc1)
        
        let rc2 = t.roofConnect()
        rc2.anchorPoint = CGPoint(x: 0.5, y: 0)
        rc2.position.x = cellSize * 0.5
        house.addChild(rc2)
        let wc2 = t.wallConnect()
        wc2.anchorPoint = CGPoint(x: 0.5, y: 1)
        wc2.position.x = cellSize * 0.5
        house.addChild(wc2)
        
        let re = t.roofEnd()
        re.anchorPoint = CGPoint(x: 0.5, y: 0)
        re.position.x = cellSize * 1.5
        house.addChild(re)
        let we = t.wallEnd()
        we.anchorPoint = CGPoint(x: 0.5, y: 1)
        we.position.x = cellSize * 1.5
        house.addChild(we)
        
        let door = SKSpriteNode(texture: Game.instance.tilee_outsidetown.getCell(6, 15, 1, 2))
        door.anchorPoint = CGPoint(x: 1, y: 1)
        house.addChild(door)
        let b = Game.instance.outside_b
        let wl = SKSpriteNode(texture: b.getCell(0, 9))
        wl.position.y = cellSize
        wl.position.x = -cellSize * 2
        house.addChild(wl)
        let wll = SKSpriteNode(texture: b.getCell(0, 4))
        wll.position.x = -cellSize * 2
        wll.position.y = -cellSize * 0.5
        house.addChild(wll)
        let wr = SKSpriteNode(texture: b.getCell(0, 4))
        wr.position.x = cellSize
        wr.position.y = -cellSize * 0.5
        house.addChild(wr)
        setTexture(house.toTexture())
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class Inn:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let t = Game.instance.tilee_outsidetown
//        let node = SKSpriteNode(texture: t.getCell(0, 14, 6, 4))
//        addChild(node)
        let house = SKSpriteNode()
        house.size = CGSize(width: cellSize * 7, height: cellSize * 4)
        let h = SKSpriteNode(texture: t.getCell(0, 14, 6, 4))
        let sha = SKSpriteNode(texture: Game.instance.sha)
        sha.position.x = cellSize * 3
        sha.position.y = -cellSize * 1.5
//        sha.anchorPoint = CGPoint(x: 0.5, y: 1)
        house.addChild(sha)
        h.position.x = -cellSize * 0.5
//        h.position.y = cellSize * 0.5
        house.addChild(h)
//        let road = SKSpriteNode(texture: Data.instance.outside_b.getCell(4, 9))
//        road.position.x = -cellSize * 2
//        road.position.y = -cellSize * 2.5
//        house.addChild(road)
        setTexture(house.toTexture())
        _xSize = 7
        _ySize = 4
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class DoubleTrees:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let t = Game.instance.outside_b
        let bottom = SKSpriteNode(texture: t.getCell(5, 12))
        let middle = SKSpriteNode(texture: t.getCell(6, 11))
        let top = SKSpriteNode(texture: t.getCell(5, 11))
        let node = SKSpriteNode()
        top.position.y = cellSize
        bottom.position.y = -cellSize
        node.addChild(top)
        node.addChild(middle)
        node.addChild(bottom)
//        let tree = SKSpriteNode(texture: )
        setTexture(node.toTexture())
        _items = [0]
        _xSize = 1
        _ySize = 3
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class MinionsHouse:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let t = Game.instance.tilee_outsidetown
//        let house = SKSpriteNode(texture: t.getCell(1, 4, 4, 4))
//        let l = SKSpriteNode(texture: t.getCell(0, 4, 1, 2))
//        house.addChild(l)
//        let sha = SKSpriteNode(texture: Game.instance.sha)
//        sha.position.x = cellSize * 2
//        sha.position.y = -cellSize * 1.5
//        house.addChild(sha)
//        print("cellsize \(cellSize)")
        setTexture(t.getCell(1, 4, 4, 4))
        self.size = CGSize(width: cellSize * 3, height: cellSize * 3)
//        xAxis = cellSize * 0.5
//        yAxis = -size.height * 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class VillageTrees:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let t = Game.instance.tilee_outsidetown
        setTexture(t.getCell(7, 12, 3, 3))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}



class AdventurersAssociation:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let t = Game.instance.tilee_outsidetown
        let house = SKSpriteNode(texture: t.getCell(8, 4, 6, 4))
        let door = SKSpriteNode(texture: t.getCell(11, 6, 3, 2))
        door.anchorPoint = CGPoint(x: 1, y: 1)
        house.addChild(door)
        let window = SKSpriteNode(texture: t.getCell(11, 8, 3, 2))
        window.anchorPoint = CGPoint(x: 0, y: 0.5)
        house.addChild(window)
        let b = Game.instance.outside_b
        let sha = SKSpriteNode(texture: Game.instance.sha)
        sha.position.x = cellSize * 3.5
//        sha.position.y = -cellSize * 1.5
        sha.anchorPoint = CGPoint(x: 0.5, y: 1)
        house.addChild(sha)
//        let road = SKSpriteNode(texture: b.getCell(4, 9))
//        road.position.x = -cellSize * 1.5
//        road.position.y = -cellSize * 2.5
//        house.addChild(road)
        let bottom = SKSpriteNode(texture: t.getCell(8, 9, 3, 1))
        bottom.anchorPoint = CGPoint(x: 1, y: 0.5)
        bottom.position.y =  -cellSize * 2.5
        house.addChild(bottom)
        
        let c = Game.instance.inside_c
        let mark = SKSpriteNode(texture: b.getCell(2, 0))
        mark.position.x = -cellSize * 1.5
        house.addChild(mark)
        
        let barTop = SKSpriteNode(texture: c.getCell(13, 13))
        let barBottom = SKSpriteNode(texture: c.getCell(13, 15))
        barTop.position.y = -cellSize * 0.5
        barTop.position.x = -cellSize * 3.5
        house.addChild(barTop)
        barBottom.position.y = -cellSize * 1.5
        barBottom.position.x = -cellSize * 3.5
        house.addChild(barBottom)
        setTexture(house.toTexture())
        //        _items = [0]
        _xSize = 6
        _ySize = 4
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
