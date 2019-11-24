//
//  IssBattle.swift
//  GoD
//
//  Created by kai chen on 2019/6/4.
//  Copyright © 2019 Chen. All rights reserved.
//


import SpriteKit
class IssBattle: BossBattle {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
//    override func createAI() {
//        debug("\(_round)")
//        if _curRole._unit is IssThePuppet {
//            if _round % 3 == 1 {
//                _selectedSpell = [LowerSummon(), SummonFlower(), WaterCopy(), HighLevelSummon()].one()
//                _selectedSpell._battle = self
//                if !_selectedSpell.selectable() {
//                    _selectedSpell = [ControlWind(), ElementDestory(), SetTimeBack(), BossAttack()].one()
//                }
//            } else {
//                _selectedSpell = [ControlWind(), BossAttack(), BossAttack(), BossAttack(), ControlUndead(), ElementDestory(), SetTimeBack(), BossAttack()].one()
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
        let l:CGFloat = IssThePuppet.LEVEL
        let t = IssThePuppet()
        t.create(level: l)
        t._seat = BUnit.TTM
        es.append(t)
        
        super.setEnemyPart(minions: es)
    }
    override func specialLoot() -> Array<Prop> {
        var list = Array<Prop>()
        let lucky = _char._lucky * 0.01 + 1
        if seedFloat() < lucky * 5 {
            let sb = SpellBook()
            sb.spell = [WaterCopy(), SummonFlower(), LowerSummon(), HighLevelSummon()].one()
            list.append(sb)
        }
        
        if seedFloat() < lucky * 15 {
            let sb = SpellBook()
            sb.spell = [ControlWind(),ControlWind(),ControlWind(), ControlUndead(), ElementDestory(), SetTimeBack()].one()
            list.append(sb)
        }
        
        if seedFloat() < lucky * 35 {
            let mark = IssMark()
            mark.create()
            list.append(mark)
        }
        
        if seedFloat() < lucky * 10 {
            let head = IssHead()
            head.create()
            list.append(head)
        }
        
        let l = Loot()
        l.loot(level: IssThePuppet.LEVEL)
        return list + l.getList()
    }
}



