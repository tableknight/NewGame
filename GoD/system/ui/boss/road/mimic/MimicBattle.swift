//
//  MimicBattle.swift
//  GoD
//
//  Created by kai chen on 2019/3/30.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class MimicBattle: BossBattle {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func createAI() {
        if _curRole._unit is Mimic {
            _selectedSpell = _curRole._unit._spellsInuse.one()
            _selectedSpell._battle = self
            _selectedSpell.findTarget()
            execOrder()
        } else {
            super.createAI()
        }
    }
    
    override func setEnemyPart(minions: Array<Creature>) {
        var es = Array<Creature>()
//        _level = 10
        let t = Mimic()
        t.create(level: _level)
        t._seat = BUnit.TTM
        es.append(t)
        
        super.setEnemyPart(minions: es)
    }
    var _level:CGFloat = 1
    
    override func specialLoot() -> Array<Prop> {
        let l = Loot()
        l.loot(level: _level)
        return l.getList()
    }
}

