//
//  LostForest.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/7.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class LostForest: UIRandomScene {
//    override func getEvilById(_ id: Int) -> Creature {
//        switch id {
//        case 0:
//            return DarkNinja()
//        case 1:
//            return HellNight()
//        case 2:
//            return BloodQueen()
//        case 3:
//            return ManWizard()
//        default:
//            return HellNight()
//        }
//    }
    override func getItem() -> UIItem {
        let n = seed(max:70)
        if n < 20 {
            return ForestItem1()
        } else if  n < 40 {
            return ForestItem2()
        } else if n < 50 {
            return Stump()
        } else if n < 53 {
            return getTower()
        } else if n < 54 {
            return getGate()
        } else if n < 62 {
            return getUIEvil()
        }
        return UIItem()
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        isRandomScene = true
        let oa4 = Game.instance.dungeon_a4
        _groundSets = GroundSets(ground: oa4.getCell(8, 2, 2, 2), wall: oa4.getCell(8, 4, 2, 2))
        _id = 2
        _name = "迷失丛林"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


class ForestItem2:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let chance = seed()
        var x:CGFloat = 6
        var y:CGFloat = 2
        if chance < 20 {
            x = 0
            y = 7
        } else if chance < 40 {
            x = 1
            y = 7
        } else if chance < 50 {
            x = 0
            y = 5
        } else if chance < 60 {
            x = 1
            y = 5
        } else if chance < 70 {
            x = 2
            y = 5
        } else if chance < 75 {
            x = 7
            y = 7
        } else if chance < 80 {
            x = 2
            y = 7
        } else if chance < 85 {
            x = 7
            y = 2
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
class ForestItem1:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let chance = seed(max: 85)
        var x:CGFloat = 6
        var y:CGFloat = 0
        if chance < 20 {
            x = 7
            y = 0
        } else if chance < 40 {
            x = 6
            y = 1
        } else if chance < 50 {
            x = 7
            y = 3
        } else if chance < 60 {
            x = 6
            y = 5
        } else if chance < 70 {
            x = 2
            y = 5
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
