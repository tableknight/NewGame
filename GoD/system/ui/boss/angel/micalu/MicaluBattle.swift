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
//            _selectedAction = _curRole._unit._spellsInuse.one()
            _selectedAction._battle = self
            _selectedAction.findTarget()
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
        ms1._createForBattle = true
        es.append(ms1)
        
        let ms2 = MicaluServant2()
        ms2.create(level: level)
        ms2._seat = BUnit.TBR
        ms2._createForBattle = true
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
//    override func specialLoot() -> Array<Prop> {
//        var list = Array<Prop>()
//        let lucky = _char._lucky * 0.01 + 1
//        
//        if seedFloat() < lucky * 50 {
//            let i = MarkOfHeaven()
//            i.create()
//            list.append(i)
//        }
//        
//        if seedFloat() < lucky * 25 {
//            let i = FangOfVampire()
//            i.create()
//            list.append(i)
//        }
//        
//        if seedFloat() < lucky * 45 {
//            let i = VerdasTear()
//            i.create()
//            list.append(i)
//        }
//        
//        if seedFloat() < lucky * 12 {
//            let i = TheExorcist()
//            i.create()
//            list.append(i)
//        }
//        
//        let l = Loot()
//        l.loot(level: Micalu.LEVEL)
//        return list + l.getList()
//    }
}

