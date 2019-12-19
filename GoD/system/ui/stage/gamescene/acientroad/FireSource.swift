//
//  FireSource.swift
//  GoD
//
//  Created by kai chen on 2019/3/16.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class FireSource: AcientRoad {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _monsterEnum = []
        let oa4 = Game.instance.dungeon_a4
        _mapSet = GroundSets(ground: oa4.getCell(12, 12, 2, 2), wall: oa4.getCell(12, 14, 2, 2))
        _name = "火源之地"
        _id = AcientRoad.FIRE_SOURCE
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func getItemByIndex(index: Int) -> UIItem {
        switch index {
        case 1:
            return getUIItem1(2, 7)
        case 2:
            return getUIItem3(11, 5)
        case 3:
            return getUIItem3(10, 6)
        case 10:
            return getUIItem2(2, 9)
        default:
            return getUIItem2(2, 9)
        }
    }
    
    private func getUIItem1(_ x:CGFloat, _ y:CGFloat) -> UIItem {
        let item = UIItem()
        item.setTexture(Game.instance.dungeon_b.getCell(x, y))
        return item
    }
    private func getUIItem3(_ x:CGFloat, _ y:CGFloat) -> UIItem {
        let item = UIItem()
        item.setTexture(Game.instance.outside_b.getCell(x, y))
        return item
    }
    private func getUIItem2(_ x:CGFloat, _ y:CGFloat) -> UIItem {
        let item = UIItem()
        item.setTexture(Game.instance.dungeon_b.getCell(x, y, 1, 2))
        return item
    }
    
//    override func getMonsterByIndex(index: Int) -> Creature {
//        switch index {
//        case 1:
//            return VirulentToad()
//        case 2:
//            return TreeSpirit()
//        case 3:
//            return Python()
//        case 4:
//            return GiantWasp()
//        default:
//            return TreeSpirit()
//        }
//    }
}

