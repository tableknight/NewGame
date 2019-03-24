//
//  SecretValley.swift
//  GoD
//
//  Created by kai chen on 2019/3/16.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class SecretValley: AcientRoad {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _itemEnum = []
        for i in 1...10 {
            _itemEnum.append(i)
            _itemEnum.append(11)
        }
        _monsterEnum = [1,2,3,4]
        let oa4 = Game.instance.dungeon_a4
        _mapSet = GroundSets(ground: oa4.getCell(8, 12, 2, 2), wall: oa4.getCell(8, 14, 2, 2))
        _name = "神秘小径"
        _id = AcientRoad.SECRET_VALLEY
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func getItemByIndex(index: Int) -> UIItem {
        switch index {
        case 1:
            return getUIItem1(9, 6)
        case 2:
            return getUIItem1(10, 6)
        case 3:
            return getUIItem1(8, 7)
        case 4:
            return getUIItem1(6, 9)
        case 5:
            return getUIItem1(7, 12)
        case 6:
            return getUIItem1(7, 11)
        case 7:
            return getUIItem1(13, 5)
        case 8:
            return getUIItem1(11, 7)
        case 9:
            return getUIItem1(14, 5)
        case 10:
            return getUIItem2(12, 6)
        case 11:
            return getUIItem2(8, 6)
        default:
            return getUIItem2(5, 12)
        }
    }
    
    override func getWallTexture() -> SKTexture {
        return Game.instance.outside_b.getCell(12, 6, 1, 2)
    }
    
    private func getUIItem1(_ x:CGFloat, _ y:CGFloat) -> UIItem {
        let item = UIItem()
        item.setTexture(Game.instance.outside_b.getCell(x, y))
        return item
    }
    private func getUIItem2(_ x:CGFloat, _ y:CGFloat) -> UIItem {
        let item = UIItem()
        item.setTexture(Game.instance.outside_b.getCell(x, y, 1, 2))
        return item
    }
    
    override func getMonsterByIndex(index: Int) -> Creature {
        switch index {
        case 4:
            return DarkNinja()
        case 1:
            return HellNight()
        case 2:
            return BloodQueen()
        case 3:
            return ManWizard()
        default:
            return HellNight()
        }
    }
}
