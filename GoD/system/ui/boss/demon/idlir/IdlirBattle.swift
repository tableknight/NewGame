//
//  IdlirBattle.swift
//  GoD
//
//  Created by kai chen on 2019/2/7.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class IdlirBattle: BossBattle {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
//    override func createAI() {
//        if _curRole._unit is Boss {
//            _selectedSpell = _curRole._unit._spellsInuse.one()
//            _selectedSpell._battle = self
//            _selectedSpell.findTarget()
//            execOrder()
//        } else {
//            super.createAI()
//        }
//    }
    
    override func setEnemyPart(minions: Array<Creature>) {
        let level:CGFloat = Idlir.LEVEL
        var es = Array<Creature>()
        
        let t = Idlir()
        t.create(level: level)
        t._seat = BUnit.TTM
        es.append(t)
        
        super.setEnemyPart(minions: es)
    }
    
    override func specialLoot() -> Array<Item> {
        var list = Array<Item>()
        let lucky = _char._lucky * 0.01 + 1
        
        if seedFloat() < lucky * 95 {
            let i = Outfit(Outfit.Ring)
            i.create(effection: Sacred.IdlirWeddingRing)
            list.append(i)
        }
        
        if seedFloat() < lucky * 35 {
            let i = Outfit(Outfit.Bow)
            i.create(effection: Sacred.Aonena)
            list.append(i)
        }
        
        if seedFloat() < lucky * 30 {
            let i = Outfit(Outfit.EarRing)
            i.create(effection: Sacred.VerdasTear)
            list.append(i)
        }
        
        if seedFloat() < lucky * 25 {
            let i = Outfit(Outfit.Blunt)
            i.create(effection: Sacred.BansMechanArm)
            list.append(i)
        }
        
        if seedFloat() < lucky * 15 {
            let i = Outfit(Outfit.Shield)
            i.create(effection: Sacred.EvilExpel)
            list.append(i)
        }
        
        let l = Loot()
        l.loot(level: Idlir.LEVEL.toInt())
        return list + l.getList()
    }
}
