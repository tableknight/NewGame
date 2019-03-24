//
//  HiddenArea.swift
//  GoD
//
//  Created by kai chen on 2019/3/24.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class HiddenArea: AcientRoad {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _id = AcientRoad.HIDDEN_AREA
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func addWall(x: CGFloat, y: CGFloat, item: SKSpriteNode) {
        item.anchorPoint = CGPoint(x: 0.5, y: 0)
        item.position.x = (-halfSize + x) * cellSize
        item.position.y = (halfSize - 0.5 - y) * cellSize
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
        default:
            return HellNight()
        }
    }
}

