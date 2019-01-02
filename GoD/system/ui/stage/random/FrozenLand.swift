//
//  LostForest.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/7.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class FrozenLand: UIRandomScene {
//    override func getEvilById(_ id: Int) -> Creature {
//        switch id {
//        case 0:
//            return SnowLady()
//        case 1:
//            return SnowGod()
//        case 2:
//            return IceBeast()
//        case 3:
//            return SnowSpirit()
//        default:
//            return SnowSpirit()
//        }
//    }
    override func getItem() -> UIItem {
        let n = seed(max:90)
        if n < 25 {
            return FrozenItem2()
        } else if  n < 50 {
            return FrozenItem1()
        } else if n < 53 {
            return getTower()
        } else if n < 54 {
            return getGate()
        } else if n < 62 {
            return getUIEvil()
        } else if n < 70 {
            return IcePillar()
        } else if n < 75 {
            return IcePillarSmall()
        } else if n < 80 {
            return IcePillarShard()
        }
        return UIItem()
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        isRandomScene = true
        let oa4 = Game.instance.dungeon_a4
        _groundSets = GroundSets(ground: oa4.getCell(6, 2, 2, 2), wall: oa4.getCell(6, 4, 2, 2))
        _id = 3
        _name = "冰雪栈道"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


class FrozenItem2:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let chance = seed(max: 80)
        var x:CGFloat = 14
        var y:CGFloat = 3
        if chance < 20 {
            x = 8
            y = 5
        } else if chance < 40 {
            x = 9
            y = 5
        } else if chance < 50 {
            x = 10
            y = 5
        } else if chance < 60 {
            x = 15
            y = 7
        }
        let tree = Game.instance.tiled_dungeons.getCell(x, y, 1, 2)
        setTexture(tree)
        _xSize = 1
        _ySize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class FrozenItem1:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let chance = seed(max: 60)
        var x:CGFloat = 14
        var y:CGFloat = 0
        if chance < 20 {
            x = 14
            y = 1
        } else if chance < 40 {
            x = 15
            y = 3
        }
        let tree = Game.instance.tiled_dungeons.getCell(x, y)
        setTexture(tree)
        _xSize = 1
        _ySize = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class IcePillar:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let tree = Game.instance.dungeon_b.getCell(3, 9, 1, 2)
        setTexture(tree)
        _xSize = 1
        _ySize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class IcePillarSmall:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let tree = Game.instance.dungeon_b.getCell(3, 7)
        setTexture(tree)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class IcePillarShard:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let tree = Game.instance.dungeon_b.getCell(3, 6)
        setTexture(tree)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

