//
//  UmisaBattle.swift
//  GoD
//
//  Created by kai chen on 2019/2/9.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class UmisaBattle: BossBattle {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private var p75 = false
    private var p50 = false
    private var p25 = false
    override func createAI() {
        if _curRole._unit is Umisa {
            let umisa = _curRole._unit as! Umisa
            let per = _curRole.getHp() / _curRole.getHealth()
            if !p75 && !umisa.isCopy && per <= 0.75 {
                let spell = SummonCopy()
                spell._seat = BUnit.TBL
                _selectedAction = spell
                p75 = true
            } else if !p50 && !umisa.isCopy && per <= 0.5 {
                let spell = SummonCopy()
                spell._seat = BUnit.TBM
                _selectedAction = spell
                p50 = true
            } else if !p25 && !umisa.isCopy && per <= 0.25 {
                let spell = SummonCopy()
                spell._seat = BUnit.TBR
                _selectedAction = spell
                p25 = true
            } else {
//                _selectedAction = _curRole._unit._spellsInuse.one()
            }
            _selectedAction._battle = self
            _selectedAction.findTarget()
            execOrder()
        } else {
            super.createAI()
        }
    }
    
    override func setEnemyPart(minions: Array<Creature>) {
        let level:CGFloat = Umisa.LEVEL
        var es = Array<Creature>()
        
        let t = Umisa()
        t.create(level: level)
        t._seat = BUnit.TTM
        es.append(t)
        
        super.setEnemyPart(minions: es)
    }
//    override func specialLoot() -> Array<Item> {
//        var list = Array<Item>()
//        let lucky = _char._lucky * 0.01 + 1
//        
////        if seedFloat() < lucky * 35 {
////            let i = RingOfDeath()
////            i.create()
////            list.append(i)
////        }
////
////        if seedFloat() < lucky * 10 {
////            let i = Accident()
////            i.create()
////            list.append(i)
////        }
////
////        if seedFloat() < lucky * 5 {
////            let i = CreationMatrix()
////            i.create()
////            list.append(i)
////        }
////
////        if seedFloat() < lucky * 5 {
////            let i = HolyPower()
////            i.create()
////            list.append(i)
////        }
////
////        if seedFloat() < lucky * 15 {
////            let i = Boreas()
////            i.create()
////            list.append(i)
////        }
////
////        let l = Loot()
////        l.loot(level: Umisa.LEVEL)
//        return list + l.getList()
//    }
}
class SummonCopy:Magical, BossOnly {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.SummonCopy
        _name = "分身之术"
        _description = "召唤一个真实的分身"
    }
    var _seat:String = ""
    override func cast(completion: @escaping () -> Void) {
        let c = _battle._curRole
        c.actionCast {
            let copy = Umisa()
            copy.create(level: c._unit._level)
            copy._extensions.hp = c.getHp()
            copy.isCopy = true
            copy._seat = self._seat
            let unit = self._battle.addEnemy(unit: copy)
            unit.actionSummon {
                completion()
            }
        }
    }
}

class CriticalBite:Physical, BossOnly {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.CriticalBite
        _name = "致命撕咬"
        _description = "对目标造成攻击力85%的物理伤害，并且有一定几率召唤一个分身协助攻击"
        _rate = 0.85
    }
    override func cast(completion: @escaping () -> Void) {
        let b = _battle
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        c.actionAttack {
            let assistant = self.d3()
            if !self.hadSpecialAction(t: t, completion: completion) {
                if !self.hasMissed(target: t, completion: completion) {
                    let damage = self.physicalDamage(t)
                    t.actionAttacked {
                        t.showValue(value: damage) {
                            if !assistant {
                                completion()
                            }
                        }
                    }
                    t.blow()
                    if assistant {
                        if b._enemyPart.count > 1 && !t.isDead() {
                            var es = Array<BUnit>()
                            for u in b._enemyPart {
                                if b._curRole != u {
                                    es.append(u)
                                }
                            }
                            let ast = es.one()
                            setTimeout(delay: 0.5, completion: {
                                ast.showText(text: "ASSIST")
                                ast.actionAttack {
                                    if !self.hasMissed(target: t, completion: completion) {
                                        self._rate = 1
                                        let dmg = self.physicalDamage(t)
                                        t.showValue(value: dmg) {
                                            completion()
                                        }
                                    }
                                }
                            })
                        } else {
                            setTimeout(delay: 1.5, completion: completion)
                        }
                    }
                }
            }
            
        }
    }
}
