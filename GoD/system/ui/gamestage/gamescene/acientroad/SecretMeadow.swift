//
//  SceneMeadow.swift
//  GoD
//
//  Created by kai chen on 2018/12/9.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class SecretMeadow: AcientRoad {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _itemEnum = [1,1,2,2,1,2,3,4]
        _monsterEnum = [1,2,3,4]
        let oa4 = Game.instance.dungeon_a4
        _mapSet = GroundSets(ground: oa4.getCell(8, 2, 2, 2), wall: oa4.getCell(8, 4, 2, 2))
        _name = "秘境沼泽"
        _id = AcientRoad.SECRET_MEADOW
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func getItemByIndex(index: Int) -> UIItem {
        switch index {
        case 1:
            return MeadowItem1()
        case 2:
            return MeadowItem2()
        case 3:
            return MeadowItem3()
        case 4:
            return MeadowItem4()
        default:
            return MeadowItem2()
        }
    }
    
    override func getMonsterByIndex(index: Int) -> Creature {
        switch index {
        case 1:
            return VirulentToad()
        case 2:
            return TreeSpirit()
        case 3:
            return Python()
        case 4:
            return GiantWasp()
        default:
            return TreeSpirit()
        }
    }
}
class MeadowItem2:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
//        let itemPoints:Array<Array<CGFloat>> = [
//            [6, 3],
//            [7, 2],
//            [0, 5],
//            [1, 5],
//            [2, 5],
//            [2, 7],
//            [3, 7],
//        ]
//        let it = itemPoints.one()
//        setTexture(Game.instance.tiled_dungeons.getCell(it[0], it[1], 1, 2))
        setTexture(Game.instance.dungeon_b.getCell(4, 9, 1, 2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class MeadowItem4:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.dungeon_b.getCell(3, 11, 1, 2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class MeadowItem1:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
//        let itemPoints:Array<Array<CGFloat>> = [
//            [6, 1],
//            [7, 0],
//            [7, 3],
//            [6, 5],
//            [2, 5],
//        ]
//        let it = itemPoints.one()
//        setTexture(Game.instance.tiled_dungeons.getCell(it[0], it[1]))
        setTexture(Game.instance.dungeon_b.getCell(4, 7))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class MeadowItem3:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.dungeon_b.getCell(1, 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
