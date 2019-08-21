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
    override func createAI() {
        if _curRole._unit is Boss {
            if seed() < 25 {
                _selectedSpell = BossAttack()
            } else {
                _selectedSpell = getSpell(u: _curRole)
            }
            _selectedSpell._battle = self
            _selectedSpell.findTarget()
            execOrder()
        } else {
            super.createAI()
        }
    }
    
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
    override func specialLoot() -> Array<Prop> {
        var list = Array<Prop>()
        let lucky = _char._lucky * 0.01 + 1
        
        if seedFloat() < lucky * 5 {
            let i = TrueLie()
            i.create()
            list.append(i)
        }
        
        if seedFloat() < lucky * 25 {
            let i = RingOfDeath()
            i.create()
            list.append(i)
        }
        
        if seedFloat() < lucky * 50 {
            let i = SoulPeace()
            i.create()
            list.append(i)
        }
        
        if seedFloat() < lucky * 10 {
            let i = PandoraHearts()
            i.create()
            list.append(i)
        }
        
        let l = Loot()
        l.loot(level: FearGhost.LEVEL)
        return list + l.getList()
    }
}

