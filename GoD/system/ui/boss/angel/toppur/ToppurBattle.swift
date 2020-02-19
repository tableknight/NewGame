//
//  ToppurBattle.swift
//  GoD
//
//  Created by kai chen on 2019/1/17.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class ToppurBattle: BossBattle {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func createAI() {
        if _curRole._unit is Toppur {
            if _round % 3 == 1 {
                _selectedAction = FateDecision()
            } else {
                let sd = seed()
                if sd < 40 {
                    _selectedAction = BossAttack()
                } else if sd < 70 {
                    _selectedAction = LineAttack()
                } else if sd < 90 {
                    _selectedAction = LeeAttack()
                } else {
                    _selectedAction = BossAttack()
                }
            }
            _selectedAction._battle = self
            _selectedAction.findTarget()
            execOrder()
        } else {
            super.createAI()
        }
    }
    override func setEnemyPart(minions: Array<Creature>) {
        let level:CGFloat = Toppur.LEVEL
        var es = Array<Creature>()
        for _ in 0...1 {
            let lm = ToppurServant()
            lm._createForBattle = true
            lm.create(level: level)
            es.append(lm)
        }
        es[0]._seat = BUnit.TBL
        es[1]._seat = BUnit.TBR
        
        let t = Toppur()
        t.create(level: level)
        t._seat = BUnit.TTM
        es.append(t)
        
        super.setEnemyPart(minions: es)
    }
    
    override func specialLoot() -> Array<Item> {
        var list = Array<Item>()
        let lucky = _char._lucky * 0.01 + 1
        
        if seedFloat() < lucky * 15 {
            let i = Outfit(Outfit.Dagger)
            i.create(effection: Sacred.LazesPedicureKnife)
            list.append(i)
        }
        
        if seedFloat() < lucky * 25 {
            let i = Outfit(Outfit.MagicMark)
            i.create(effection: Sacred.MarkOfOaks)
            list.append(i)
        }
        
        if seedFloat() < lucky * 45 {
            let i = Outfit(Outfit.Dagger)
            i.create(effection: Sacred.BloodBlade)
            list.append(i)
        }
        
        if seedFloat() < lucky * 35 {
            let i = Outfit(Outfit.Shield)
            i.create(effection: Sacred.EvilExpel)
            list.append(i)
        }
        
        let l = Loot()
        l.loot(level: Toppur.LEVEL.toInt())
        return list + l.getList()
    }
}
class FateDecision: Magical, BossOnly {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        //        isWater = true
        _name = "命运裁决"
        _description = "对随机随从目标造成当前生命值50%的伤害"
        _rate = 0.8
        _quality = Quality.SACRED
        _cooldown = 2
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        let damage = -t.getHp() * 0.5
        c.actionCast {
            if !self.hadSpecialAction(t: t, completion: completion) {
                t.actionAttacked {
                    t.showValue(value: damage) {
                        completion()
                    }
                }
                t.special3()
            }
        }
    }
    
    override func findTarget() {
        var ts = Array<BUnit>()
        var playerRole:BUnit!
        for u in _battle._playerPart {
            if u._unit is Character {
                playerRole = u
            } else {
                ts.append(u)
            }
        }
        _battle._selectedTarget = ts.count > 0 ? ts.one() : playerRole
    }
    
}


