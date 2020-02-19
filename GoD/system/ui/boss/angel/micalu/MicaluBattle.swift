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
            if seed() < 33 {
                _selectedAction = Attack()
            } else {
                _selectedAction = _curRole.spells.one()
            }
            _selectedAction._battle = self
            _selectedAction.findTarget()
            execOrder()
        } else {
            super.createAI()
        }
    }
    override func setEnemyPart(minions: Array<Creature>) {
        let level:CGFloat = Micalu.LEVEL
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
    override func specialLoot() -> Array<Item> {
        var list = Array<Item>()
        let lucky = _char._lucky * 0.01 + 1
        
        if seedFloat() < lucky * 50 {
            let i = Outfit(Outfit.MagicMark)
            i.create(effection: Sacred.MarkOfHeaven)
            list.append(i)
        }
        
        if seedFloat() < lucky * 25 {
            let i = Outfit(Outfit.Amulet)
            i.create(effection: Sacred.FangOfVampire)
            list.append(i)
        }
        
        if seedFloat() < lucky * 45 {
            let i = Outfit(Outfit.EarRing)
            i.create(effection: Sacred.VerdasTear)
            list.append(i)
        }
        
        if seedFloat() < lucky * 12 {
            let i = Outfit(Outfit.Sword)
            i.create(effection: Sacred.TheExorcist)
            list.append(i)
        }
        
        let l = Loot()
        l.loot(level: Micalu.LEVEL.toInt())
        return list + l.getList()
    }
}

