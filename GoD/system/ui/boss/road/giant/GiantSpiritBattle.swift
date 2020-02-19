//
//  GiantSpiritBattle.swift
//  GoD
//
//  Created by kai chen on 2019/7/6.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class GiantSpiritBattle: BossBattle {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func createAI() {
        if _curRole._unit is GiantSpirit {
            if _curRole.getHp() / _curRole.getHealth() < 0.2 {
                _selectedAction = Disintegrate()
            } else {
                if seed() < 25 {
                    _selectedAction = BossAttack()
                } else {
                    _selectedAction = getSpell(u: _curRole)
                }
            }
//            _selectedSpell = TreadEarth()
            _selectedAction._battle = self
            _selectedAction.findTarget()
            execOrder()
        } else {
            super.createAI()
        }
    }
    
    override func setEnemyPart(minions: Array<Creature>) {
        var es = Array<Creature>()
        let l:CGFloat = GiantSpirit.LEVEL
        let t = GiantSpirit()
        t.create(level: l)
        t._seat = BUnit.TTM
        es.append(t)
        
        super.setEnemyPart(minions: es)
    }
    override func specialLoot() -> Array<Item> {
        var list = Array<Item>()
        let lucky = _char._lucky * 0.01 + 1
        
        if seedFloat() < lucky * 40 {
            let i = Outfit(Outfit.SoulStone)
            i.create(effection: Sacred.GiantSoul)
            list.append(i)
        }
        if seedFloat() < lucky * 25 {
            let i = Outfit(Outfit.EarRing)
            i.create(effection: Sacred.VerdasTear)
            list.append(i)
        }
        
        if seedFloat() < lucky * 30 {
            let i = Outfit(Outfit.Ring)
            i.create(effection: Sacred.DellarsGoldenRing)
            list.append(i)
        }


        
        let l = Loot()
        l.loot(level: GiantSpirit.LEVEL.toInt())
        return list + l.getList()
    }
}

