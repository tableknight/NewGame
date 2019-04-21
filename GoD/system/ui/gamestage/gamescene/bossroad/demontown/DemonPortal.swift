//
//  DemonPortal.swift
//  GoD
//
//  Created by kai chen on 2019/4/19.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class DemonPortal: Maze {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        //        let oa4 = Game.instance.sf_inside_a4
        let o4 = Game.instance.dungeon_a4
        _mapSet = GroundSets(ground: o4.getCell(4, 2, 2, 2), wall: o4.getCell(4, 4, 2, 2))
        _name = "魔王之城"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
