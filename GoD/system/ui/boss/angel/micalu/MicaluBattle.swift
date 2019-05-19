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
    override func setEnemyPart(minions: Array<Creature>) {
        let level:CGFloat = 36
        var es = Array<Creature>()
//        for _ in 0...1 {
//            let lm = ToppurServant()
//            lm.create(level: level)
//            es.append(lm)
//        }
//        es[0]._seat = BUnit.TBL
//        es[1]._seat = BUnit.TBR
        let ms1 = MicaluServant1()
        ms1.create(level: level)
        ms1._seat = BUnit.TBL
        es.append(ms1)
        
        let ms2 = MicaluServant2()
        ms2.create(level: level)
        ms2._seat = BUnit.TBR
        es.append(ms2)
        
        let t = Micalu()
        t.create(level: level)
        t._seat = BUnit.TTM
        es.append(t)
        
        super.setEnemyPart(minions: es)
    }
    override func getBossYAxis() -> CGFloat {
        return cellSize * 4.25
    }
}

