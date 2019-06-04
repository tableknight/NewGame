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
    override func createAI() {
        if _curRole._unit is IssThePuppet {
            if _round % 3 == 1 {
                _selectedSpell = [LowerSummon(), SummonFlower(), WaterCopy(), HighLevelSummon()].one()
                _selectedSpell._battle = self
                if !_selectedSpell.selectable() {
                    _selectedSpell = [ControlWind(), BossAttack(), BossAttack(), BossAttack(), ControlUndead(), ElementDestory(), SetTimeBack(), BossAttack()].one()
                }
            } else {
                _selectedSpell = [ControlWind(), BossAttack(), BossAttack(), BossAttack(), ControlUndead(), ElementDestory(), SetTimeBack(), BossAttack()].one()
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
        let l:CGFloat = 10
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
        
        return list
    }
}

class IssMark:MagicMark {
    override init() {
        super.init()
        _name = "艾斯斯之印"
        _description = "获得一个召唤系技能"
        _level = 10
        _chance = 75
        _quality = Quality.SACRED
        price = 190
    }
    override func create() {
        _spell = [LowerSummon(), HighLevelSummon(), SummonFlower(), WaterCopy()].one()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class IssHead:Instrument {
    override init() {
        super.init()
        _name = "艾斯斯之颅"
        _description = "傀儡师的头也是木头做的"
        _level = 10
        _chance = 10
        _quality = Quality.SACRED
        price = 181
    }
    override func create() {
        createSelfAttrs()
        _spell = [LowerSummon(), HighLevelSummon(), SummonFlower(), WaterCopy()].one()
        createAttr(attrId: INTELLECT, value: 12, remove: true)
        _attrCount = 3
        createAttrs()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
