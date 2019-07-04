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
    private let spells = [LineAttack(), BallLighting(), SuperWater(), FireExplode()]
    override func createAI() {
        if _curRole._unit is Dius {
            _selectedSpell = spells.one()
//            _selectedSpell = BallLighting()
            _selectedSpell._battle = self
            _selectedSpell.findTarget()
            execOrder()
        } else {
            super.createAI()
        }
    }
    
    override func setEnemyPart(minions: Array<Creature>) {
        let level:CGFloat = 33
        var es = Array<Creature>()
        
        let t = Dius()
        t.create(level: level)
        t._seat = BUnit.TTM
        es.append(t)
        
        super.setEnemyPart(minions: es)
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
            text = "防御弱化"
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
        _battle._curRole.showText(text: text) {
            completion()
        }
    }
}

class SuperWater:Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "超级洪流"
        _description = "对所有敌方目标造成精神45%的寒冰伤害"
        _rate = 0.45
        _cooldown = 3
        isWater = true
        _quality = Quality.RARE
        autoCast = true
    }
    override func cast(completion: @escaping () -> Void) {
        _battle._curRole.actionCast {
            for t in self._battle._selectedTargets {
                let damage = self.waterDamage(t)
                if !self.hadSpecialAction(t: t) {
                    t.actionAttacked {
                        t.showValue(value: damage, criticalFromSpell: false, critical: false, damageType: DamageType.WATER, textColor: DamageColor.WATER)
                    }
                    t.water1(index: 4)
                }
            }
            setTimeout(delay: 2.5, completion: completion)
        }
    }
    override func findTarget() {
        findtargetAll()
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
                    if t.ifRingIs(FireCore()) {
                        t.burning()
                    } else {
                        if self.d7() {
                            t.burning()
                        }
                    }
                }
                t.flame3()
                
            }
        }
    }
    override func findTarget() {
        findSingleTargetNotBlocked()
    }
}
