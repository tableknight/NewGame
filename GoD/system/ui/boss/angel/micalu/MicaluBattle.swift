//
//  MicaluBattle.swift
//  GoD
//
//  Created by kai chen on 2019/1/22.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class MicaluBattle: BossBattle {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func createAI() {
        if _curRole._unit is Micalu {
            _selectedSpell = _curRole._unit._spellsInuse.one()
            _selectedSpell._battle = self
            _selectedSpell.findTarget()
            execOrder()
        } else {
            super.createAI()
        }
    }
}
