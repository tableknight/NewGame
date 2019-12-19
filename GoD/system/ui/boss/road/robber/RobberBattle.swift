//
//  RobberBattle.swift
//  GoD
//
//  Created by kai chen on 2019/7/8.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class RobberBattle: BossBattle {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
//    override func createAI() {
//        if _curRole._unit is GraveRobber {
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
//    
    override func setEnemyPart(minions: Array<Creature>) {
        var es = Array<Creature>()
        let l:CGFloat = GraveRobber.LEVEL
        let t = GraveRobber()
        t.create(level: l)
        t._seat = BUnit.TTM
        es.append(t)
        
        let fs = RobberMinion()
        fs.create(level: l)
        fs._seat = BUnit.TBL
        es.append(fs)
        
        let fs2 = RobberMinion()
        fs2.create(level: l)
        fs2._seat = BUnit.TBR
        es.append(fs2)
        
        super.setEnemyPart(minions: es)
    }
//    override func specialLoot() -> Array<Prop> {
//        var list = Array<Prop>()
//        let lucky = _char._lucky * 0.01 + 1
//        
//        if seedFloat() < lucky * 35 {
//            let mark = ThiefPocket()
//            mark.create()
//            list.append(mark)
//        }
//        
//        if seedFloat() < lucky * 25 {
//            let i = TearCluster()
//            i.create()
//            list.append(i)
//        }
//        
//        if seedFloat() < lucky * 15 {
//            let i = WordlessBook()
//            list.append(i)
//        }
//        
//        if seedFloat() < lucky * 8 {
//            let i = CreationMatrix()
//            i.create()
//            list.append(i)
//        }
//        
//        let l = Loot()
//        l.loot(level: GraveRobber.LEVEL)
//        return list + l.getList()
//    }
}

