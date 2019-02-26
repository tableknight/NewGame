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
        let level:CGFloat = 50
        var es = Array<Creature>()
        
        let t = Dius()
        t.create(level: level)
        t._seat = BUnit.TTM
        es.append(t)
        
        super.setEnemyPart(minions: es)
    }
}
class ExposeWeakness: Passive, BossOnly {
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
class BallLighting: Magical {
    override init() {
        super.init()
        _name = "球状闪电"
        _description = "对目标及相邻单位造成精神55%的雷电伤害"
        _rate = 0.55
        _cooldown = 2
        isThunder = true
        _quality = Quality.RARE
    }
    override func cast(completion: @escaping () -> Void) {
        let ts = _battle._selectedTargets
        _battle._curRole.actionCast {
            for t in ts {
                let damage = self.thunderDamage(t)
                if !self.hadSpecialAction(t: t) {
                    t.showValue(value: damage)
                }
            }
            setTimeout(delay: 2.5, completion: completion)
        }
    }
    override func findTarget() {
        findSingleTargetNotBlocked()
        _battle._selectedTargets = getAdajcentUnits(target: _battle._selectedTarget!)
        _battle._selectedTargets.append(_battle._selectedTarget!)
    }
}
class SuperWater:Magical {
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
                    t.showValue(value: damage)
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
                    if self.d7() {
                        t.burning()
                    }
                }
            }
        }
    }
    override func findTarget() {
        findSingleTargetNotBlocked()
    }
}
