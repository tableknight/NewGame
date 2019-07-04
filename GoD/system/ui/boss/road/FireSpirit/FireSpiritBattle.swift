//
//  FireSpiritBattle.swift
//  GoD
//
//  Created by kai chen on 2019/7/4.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class FireSpiritBattle: BossBattle {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func createAI() {
        if _curRole._unit is FireSpirit {
            if seed() < 40 {
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
        let l:CGFloat = 25
        let t = FireSpirit()
        t.create(level: l)
        t._seat = BUnit.TTM
        es.append(t)
        
        let fs = FireServant()
        fs.create(level: l)
        fs._seat = BUnit.TBL
        es.append(fs)
        
        let fs2 = FireServant()
        fs2.create(level: l)
        fs2._seat = BUnit.TBR
        es.append(fs2)
        
        super.setEnemyPart(minions: es)
    }
    override func specialLoot() -> Array<Prop> {
        var list = Array<Prop>()
        let lucky = _char._lucky * 0.01 + 1
//        if seedFloat() < lucky * 5 {
//            let sb = SpellBook()
//            sb.spell = [WaterCopy(), SummonFlower(), LowerSummon(), HighLevelSummon()].one()
//            list.append(sb)
//        }
//
//        if seedFloat() < lucky * 15 {
//            let sb = SpellBook()
//            sb.spell = [ControlWind(),ControlWind(),ControlWind(), ControlUndead(), ElementDestory(), SetTimeBack()].one()
//            list.append(sb)
//        }
        
        if seedFloat() < lucky * 35 {
            let mark = FireMark()
            mark.create()
            list.append(mark)
        }
        
        if seedFloat() < lucky * 25 {
            let i = FireCore()
            i.create()
            list.append(i)
        }
        
        let l = Loot()
        l.loot(level: 25)
        return list + l.getList()
    }
}

class FireAngel: Magical, BossOnly {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        isFire = true
        _name = "烈焰天使"
        _description = "对主角造成精神80%的火焰伤害，附加2层燃烧效果"
        _rate = 0.8
        _quality = Quality.NORMAL
        _cooldown = 2
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        let damage = fireDamage(t)
        c.actionCast {
            if !self.hadSpecialAction(t: t, completion: completion) {
                t.flame1(index: 0, line: 1)
                t.actionAttacked {
                    t.showValue(value: damage, criticalFromSpell: false, critical: false, damageType: DamageType.FIRE, textColor: DamageColor.FIRE, completion: completion)
                    t.burning()
                    t.burning()
                }
            }
        }
    }
    
    override func findTarget() {
        findTargetChar()
    }
    
}

