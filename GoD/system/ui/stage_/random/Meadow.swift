//
//  Meadow.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/2/24.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Meadow: UIRandomScene {
    static var GIANTWASP = 0
    static var TREESPIRIT = 1
    static var VIRULENTTOAD = 2
    static var PYTHON = 3
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        isRandomScene = true
        let oa4 = Game.instance.outside_a4
        _groundSets = GroundSets(ground: oa4.getCell(12, 2, 2, 2), wall: oa4.getCell(12, 4, 2, 2))
        _id = 0
        _name = "林间小径"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func getItem() -> UIItem {
        let sd = seed(max: 75)
        if sd < 8 {
            return DeadTree()
        } else if sd < 16 {
            return Stump()
        } else if sd < 18 {
            return getGate()
        } else if sd < 30 {
            return BigTree()
        } else if sd < 50 {
            return TallTree()
        } else if sd < 62 {
            return getUIEvil()
        } else if sd < 65 {
            return getTower()
        }
        
        return UIItem()
    }
    
    override func getEvilById(_ id: Int) -> Creature {
        switch id {
        case 0:
            return GiantWasp()
        case 1:
            return TreeSpirit()
        case 2:
            return Python()
        case 3:
            return VirulentToad()
        default:
            return GiantWasp()
        }
    }
}

class TallTree:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let tree = Game.instance.outside_b.getCell(5, 12, 1, 2)
        setTexture(tree)
        _items = [0]
        _xSize = 1
        _ySize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class DeadTree:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let item = Game.instance.outside_b.getCell(4, 12)
        setTexture(item)
        _items = [0]
        _xSize = 1
        _ySize = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class Stump:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let item = Game.instance.outside_b.getCell(4, 11)
        setTexture(item)
        _items = [0]
        _xSize = 1
        _ySize = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class BigTree:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let item = Game.instance.outside_b.getCell(0, 15, 2, 2)
        setTexture(item)
        _items = [0, 0]
        _xSize = 2
        _ySize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

