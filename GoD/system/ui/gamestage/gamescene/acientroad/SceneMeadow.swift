//
//  SceneMeadow.swift
//  GoD
//
//  Created by kai chen on 2018/12/9.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class SceneMeadow: MyScene {
    var MONSTER_BEE = 1001
    var MONSTER_TREE_SPIRIT = 1002
    var MONSTER_TOAD = 1003
    var MONSTER_PYTHON = 1004
    var ITEM_STUMP = 2001
    var ITEM_TREE_TALL = 2002
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _itemEnum = [ITEM_TREE_TALL, ITEM_TREE_TALL,ITEM_TREE_TALL,ITEM_TREE_TALL,ITEM_TREE_TALL,ITEM_TREE_TALL,ITEM_TREE_TALL,ITEM_TREE_TALL, ITEM_STUMP]
        _monsterEnum = [MONSTER_BEE, MONSTER_TREE_SPIRIT, MONSTER_TOAD, MONSTER_PYTHON]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func getItemByIndex(index: Int) -> UIItem {
        switch index {
        case ITEM_STUMP:
            return Stump()
        case ITEM_TREE_TALL:
            return TallTree()
        default:
            return TallTree()
        }
    }
    
    override func getMonsterByIndex(index: Int) -> Creature {
        switch index {
        case MONSTER_TOAD:
            return VirulentToad()
        case MONSTER_TREE_SPIRIT:
            return TreeSpirit()
        case MONSTER_PYTHON:
            return Python()
        case MONSTER_BEE:
            return GiantWasp()
        default:
            return TreeSpirit()
        }
    }
}
