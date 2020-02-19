//
//  GhostBattle.swift
//  GoD
//
//  Created by kai chen on 2019/7/14.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class GhostBattle: BossBattle {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
//    override func createAI() {
//        if _curRole._unit is Boss {
//            if seed() < 25 {
//                _selectedSpell = BossAttack()
//            } else {
//                _selectedSpell = getSpell(u: _curRole)
//            }
//            _selectedSpell._battle = self
//            _selectedSpell.findTarget()
//            execOrder()
//        } else {
//            super.createAI()
//        }
//    }
    
    override func setEnemyPart(minions: Array<Creature>) {
        var es = Array<Creature>()
        let l:CGFloat = FearGhost.LEVEL
        let t = FearGhost()
        t.create(level: l)
        t._seat = BUnit.TTM
        es.append(t)
        
        let fs = Nightmare()
        fs.create(level: l)
        fs._seat = BUnit.TBL
        es.append(fs)
        
        let fs2 = Nightmare()
        fs2.create(level: l)
        fs2._seat = BUnit.TBR
        es.append(fs2)
        
        let fs3 = Nightmare()
        fs3.create(level: l)
        fs3._seat = BUnit.TBM
        es.append(fs3)
        
        super.setEnemyPart(minions: es)
    }
    override func specialLoot() -> Array<Item> {
        var list = Array<Item>()
        let lucky = _char._lucky * 0.01 + 1
        
        if seedFloat() < lucky * 5 {
            let i = Outfit(Outfit.Amulet)
            i.create(effection: Sacred.TrueLie)
            list.append(i)
        }
        
        if seedFloat() < lucky * 25 {
            let i = Outfit(Outfit.Ring)
            i.create(effection: Sacred.RingOfDeath)
            list.append(i)
        }
        
        if seedFloat() < lucky * 50 {
            let i = Outfit(Outfit.SoulStone)
            i.create(effection: Sacred.SoulPeace)
            list.append(i)
        }
        
        if seedFloat() < lucky * 10 {
            let i = Outfit(Outfit.SoulStone)
            i.create(effection: Sacred.PandoraHeart)
            list.append(i)
        }
        
        let l = Loot()
        l.loot(level: FearGhost.LEVEL.toInt())
        return list + l.getList()
    }
}

