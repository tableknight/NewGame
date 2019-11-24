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
    
    override func specialLoot() -> Array<Prop> {
        var list = Array<Prop>()
        let lucky = _char._lucky * 0.01 + 1
        
        if seedFloat() < lucky * 95 {
            let i = IdlirWeddingRing()
            i.create()
            list.append(i)
        }
        
        if seedFloat() < lucky * 35 {
            let i = Aonena()
            i.create()
            list.append(i)
        }
        
        if seedFloat() < lucky * 30 {
            let i = VerdasTear()
            i.create()
            list.append(i)
        }
        
        if seedFloat() < lucky * 25 {
            let i = BansMechanArm()
            i.create()
            list.append(i)
        }
        
        if seedFloat() < lucky * 15 {
            let i = EvilExpel()
            i.create()
            list.append(i)
        }
        
        let l = Loot()
        l.loot(level: Idlir.LEVEL)
        return list + l.getList()
    }
}
