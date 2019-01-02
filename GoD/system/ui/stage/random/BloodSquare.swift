//
//  LostForest.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/7.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class BloodSquare: UIRandomScene {
//    override func getEvilById(_ id: Int) -> Creature {
//        switch id {
//        case 0:
//            return BloodyBat()
//        case 1:
//            return Kodagu()
//        case 2:
//            return EvilSpirit()
//        case 3:
//            return HellBaron()
//        default:
//            return BloodyBat()
//        }
//    }
    override func getItem() -> UIItem {
        let n = seed(max:90)
        if n < 25 {
            return BloodItem1()
        } else if  n < 50 {
            return BloodItem2()
        } else if n < 53 {
            return getTower()
        } else if n < 54 {
            return getGate()
        } else if n < 62 {
            return getUIEvil()
        } else if n < 70 {
            return BloodPillar()
        } else if n < 75 {
            return BloodPillarSmall()
        } else if n < 80 {
            return BloodPillarShard()
        }
        return UIItem()
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        isRandomScene = true
        let oa4 = Game.instance.dungeon_a4
        _groundSets = GroundSets(ground: oa4.getCell(12, 2, 2, 2), wall: oa4.getCell(12, 4, 2, 2))
        _id = 4
        _name = "鲜血平原"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}



class BloodPillar:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let tree = Game.instance.dungeon_b.getCell(6, 9, 1, 2)
        setTexture(tree)
        _xSize = 1
        _ySize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class BloodPillarSmall:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let tree = Game.instance.dungeon_b.getCell(6, 7)
        setTexture(tree)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class BloodPillarShard:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let tree = Game.instance.dungeon_b.getCell(6, 6)
        setTexture(tree)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

