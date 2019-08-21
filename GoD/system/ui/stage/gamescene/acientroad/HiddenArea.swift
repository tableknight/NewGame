//
//  HiddenArea.swift
//  GoD
//
//  Created by kai chen on 2019/3/24.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class HiddenArea: AcientRoad, InnerMaze {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _id = AcientRoad.HIDDEN_AREA
        _monsterEnum = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func createFloorSize() -> Int {
        return 6
    }
    override func addWall(x: CGFloat, y: CGFloat, item: SKSpriteNode) {
        item.anchorPoint = CGPoint(x: 0.5, y: 0)
        item.position.x = (-hSize / 2 + x) * cellSize
        item.position.y = (vSize / 2 - 0.5 - y) * cellSize
        item.zPosition = MyScene.ITEM_LAYER_Z + y
        item.name = getItemName(CGPoint(x: x, y: y))
        _itemLayer.addChild(item)
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
        case 5:
            return VirulentToad()
        case 6:
            return TreeSpirit()
        case 7:
            return Python()
        case 8:
            return GiantWasp()
        case 9:
            return BoneWitch()
        case 10:
            return RedEyeDemon()
        case 11:
            return DeadSpirit()
        case 12:
            return WasteWalker()
        case 13:
            return SnowLady()
        case 14:
            return FrozenSlime()
        case 15:
            return IceBeast()
        case 16:
            return SnowSpirit()
        case 17:
            return BloodBat()
        case 18:
            return Kodagu()
        case 19:
            return EvilSpirit()
        case 20:
            return HellBaron()
        case 21:
            return CrazyPlant()
        case 22:
            return ForestGuard()
        case 23:
            return ChildLizard()
        case 24:
            return CowCow()
        default:
            return CowCow()
        }
    }
}

