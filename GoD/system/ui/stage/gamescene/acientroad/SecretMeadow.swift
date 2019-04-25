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
        _itemEnum = [11,12,13,14,15,16,17,18,19,110]
        for _ in 0...8 {
//            _itemEnum.append(21)
//            _itemEnum.append(22)
//            _itemEnum.append(23)
            _itemEnum.append(24)
        }
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
        case 11:
            return MI11()
        case 12:
            return MI12()
        case 13:
            return MI13()
        case 14:
            return MI14()
        case 15:
            return MI15()
        case 16:
            return MI16()
        case 17:
            return MI17()
        case 18:
            return MI18()
        case 19:
            return MI19()
        case 110:
            return MI110()
        case 21:
            return MI21()
        case 22:
            return MI22()
        case 23:
            return MI23()
        case 24:
            return MI24()
        default:
            return MI24()
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
    
    override func getWallTexture() -> SKTexture {
        return Game.instance.sf_outside_b.getCell(13, 2, 1, 2)
    }
    
}
class MI24:UIItem {
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
class MI23:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.dungeon_b.getCell(3, 11, 1, 2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class MI110:UIItem {
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

class MI19:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.dungeon_b.getCell(1, 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class MI11:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.outside_b.getCell(14, 5))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class MI12:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.outside_b.getCell(6, 9))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class MI13:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.outside_b.getCell(14, 6))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class MI14:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.outside_b.getCell(0, 13))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class MI15:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.outside_b.getCell(4, 12))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class MI16:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.outside_b.getCell(6, 12))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class MI17:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.outside_b.getCell(3, 10))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class MI18:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.outside_b.getCell(3, 9))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class MI21:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.outside_b.getCell(5, 12, 1, 2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class MI22:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.outside_b.getCell(12, 6, 1, 2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}