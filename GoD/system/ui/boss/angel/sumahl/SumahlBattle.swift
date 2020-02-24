//
//  MicaluBattle.swift
//  GoD
//
//  Created by kai chen on 2019/1/22.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class SumahlBattle: BossBattle {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func createAI() {
        if _curRole._unit is Sumahl {
            let sd = seed()
            if sd < 35 {
                _selectedAction = MindIntervene()
            } else if sd < 50 {
                _selectedAction = HealAll()
            } else if sd < 70 {
                _selectedAction = SilenceAll()
            } else {
                _selectedAction = BossAttack()
            }
            _selectedAction._battle = self
            _selectedAction.findTarget()
            execOrder()
        } else {
            super.createAI()
        }
    }
    override func setEnemyPart(minions: Array<Creature>) {
        let level:CGFloat = Sumahl.LEVEL
        var es = Array<Creature>()
        
        let mx1 = SumahlServant1()
        mx1._createForBattle = true
        mx1.create(level: level)
        mx1._seat = BUnit.TBL
        
        let mx2 = SumahlServant1()
        mx2._createForBattle = true
        mx2.create(level: level)
        mx2._seat = BUnit.TBM
        
        let mx3 = SumahlServant1()
        mx3._createForBattle = true
        mx3.create(level: level)
        mx3._seat = BUnit.TBR
        
        let lq1 = SumahlServant2()
        lq1._createForBattle = true
        lq1.create(level: level)
        lq1._seat = BUnit.TTL
        
        let lq2 = SumahlServant2()
        lq2._createForBattle = true
        lq2.create(level: level)
        lq2._seat = BUnit.TTR
        
        es.append(mx1)
        es.append(mx2)
        es.append(mx3)
        
        es.append(lq1)
        es.append(lq2)
        
        let t = Sumahl()
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
        
        if seedFloat() < lucky * 5 {
            let i = Outfit(Outfit.Wand)
            i.create(effection: Sacred.FireMaster)
            list.append(i)
        }
        
        if seedFloat() < lucky * 5 {
            let i = Outfit(Outfit.Amulet)
            i.create(effection: Sacred.TrueLie)
            list.append(i)
        }
        
        if seedFloat() < lucky * 10 {
            let i = Outfit(Outfit.Fist)
            i.create(effection: Sacred.NilSeal)
            list.append(i)
        }
        
        if seedFloat() < lucky * 25 {
            let i = Outfit(Outfit.SoulStone)
            i.create(effection: Sacred.PandoraHeart)
            list.append(i)
        }
        
        if seedFloat() < lucky * 15 {
            let i = Outfit(Outfit.Sword)
            i.create(effection: Sacred.DragonSlayer)
            list.append(i)
        }
        
        if seedFloat() < lucky * 5 {
            let i = Outfit(Outfit.Instrument)
            i.create(effection: Sacred.CreationMatrix)
            list.append(i)
        }
        
        let l = Loot()
        l.loot(level: Sumahl.LEVEL.toInt())
        return list + l.getList()
    }
}

class MindIntervene: Physical, Curse {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "精神扰乱"
        _description = "对目标释放诅咒术，有100%几率使其精神产生混乱，随机攻击目标，不分敌友"
        _quality = Quality.SACRED
        _cooldown = 2
        cost(value: 20)
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        c.actionCast {
            if !self.statusMissed(baseline: 100, target: t, completion: completion) {
                t.darkness5() {
                    t.showText(text: Status.CONFUSED) {
                        completion()
                        let s = Status()
                        s._type = Status.CONFUSED
                        s._timeleft = 3
                        s._labelText = "C"
                        t.addStatus(status: s)
                        
                    }
                }
            }
        }
    }
    override func findTarget() {
        findSingleTargetNotBlocked()
    }
}

