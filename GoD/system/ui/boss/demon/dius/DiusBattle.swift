//
//  DiusBattle.swift
//  GoD
//
//  Created by kai chen on 2019/2/7.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class DiusBattle: BossBattle {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
//    private let spells = [LineAttack(), BallLighting(), SuperWater(), FireExplode()]
//    override func createAI() {
//        if _curRole._unit is Dius {
//            _selectedAction = spells.one()
////            _selectedSpell = BallLighting()
//            _selectedAction._battle = self
//            _selectedAction.findTarget()
//            execOrder()
//        } else {
//            super.createAI()
//        }
//    }
//    
    override func setEnemyPart(minions: Array<Creature>) {
        let level:CGFloat = Dius.LEVEL
        var es = Array<Creature>()
        
        let t = Dius()
        t.create(level: level)
        t._seat = BUnit.TTM
        es.append(t)
        
        super.setEnemyPart(minions: es)
    }
    override func specialLoot() -> Array<Item> {
        var list = Array<Item>()
        let lucky = _char._lucky * 0.01 + 1
        
        if seedFloat() < lucky * 55 {
            let i = Outfit(Outfit.EarRing)
            i.create(effection: Sacred.VerdasTear)
            list.append(i)
        }
        
        if seedFloat() < lucky * 30 {
            let i = Outfit(Outfit.Amulet)
            i.create(effection: Sacred.EyeOfDius)
            list.append(i)
        }

        if seedFloat() < lucky * 25 {
            let i = Outfit(Outfit.Bow)
            i.create(effection: Sacred.Hawkeye)
            list.append(i)
        }

        if seedFloat() < lucky * 15 {
            let i = Outfit(Outfit.Bow)
            i.create(effection: Sacred.FollowOn)
            list.append(i)
        }

        if seedFloat() < lucky * 15 {
            let i = Outfit(Outfit.Instrument)
            i.create(effection: Sacred.TheSurvive)
            list.append(i)
        }

        if seedFloat() < lucky * 15 {
            let i = Outfit(Outfit.Instrument)
            i.create(effection: Sacred.TheDeath)
            list.append(i)
        }

        if seedFloat() < lucky * 15 {
            let i = Outfit(Outfit.Instrument)
            i.create(effection: Sacred.TheAbandon)
            list.append(i)
        }
        
        let l = Loot()
        l.loot(level: Dius.LEVEL.toInt())
        return list + l.getList()
    }
}
class ExposeWeakness: Passive, BossOnly {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.ExposeWeakness
        _name = ""
        _description = "每回合行动结束暴露一个自己的弱点"
        _quality = Quality.SACRED
        hasAfterMoveAction = true
    }
    private var _weakness = 0
    override func cast(completion: @escaping () -> Void) {
        var text = ""
        _weakness = seed(max: 5)
        if Dius.DEFENCE == _weakness {
            text = "护甲弱化"
        } else if Dius.SPIRIT == _weakness {
            text = "精神弱化"
        } else if Dius.FIRE == _weakness {
            text = "火焰弱化"
        } else if Dius.WATER == _weakness {
            text = "寒冰弱化"
        } else if Dius.THUNDER == _weakness {
            text = "雷电弱化"
        } else {
            text = ""
        }
        let d = _battle._curRole._unit as! Dius
        d._wwakness = _weakness
//        _weakness += 1
//        if _weakness > 4 {
//            _weakness = 0
//        }
        _battle._curRole.sonic()
        _battle._curRole.showText(text: text) {
            completion()
        }
    }
}


class FireExplode:Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "烈焰爆轰"
        _description = "对目标造成精神100%的火焰伤害,有小概率点燃目标"
        _cooldown = 3
        isFire = true
        _quality = Quality.RARE
    }
    override func cast(completion: @escaping () -> Void) {
        let t = _battle._selectedTarget!
        let damage = self.fireDamage(t)
        _battle._curRole.actionCast {
            if !self.hadSpecialAction(t: t, completion: completion) {
                t.actionAttacked {
                    t.showValue(value: damage) {
                        completion()
                    }
//                    if t.ringIs(FireCore.EFFECTION) {
//                        t.burning()
//                    } else {
//                        if self.d7() {
//                            t.burning()
//                        }
//                    }
                }
                t.fire3f()
                
            }
        }
    }
    override func findTarget() {
        findSingleTargetNotBlocked()
    }
}
