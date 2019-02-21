//
//  WizardBattle.swift
//  GoD
//
//  Created by kai chen on 2019/2/10.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class WizardBattle: BossBattle {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //    override func createAI() {
    //        if _curRole._unit is Boss {
    //            _selectedSpell._battle = self
    //            _selectedSpell.findTarget()
    //            execOrder()
    //        } else {
    //            super.createAI()
    //        }
    //    }
    
    override func setEnemyPart(minions: Array<Creature>) {
        let level:CGFloat = 50
        var es = Array<Creature>()
        
        for _ in 0...2 {
            let s = MagicStudent()
            s.create(level: level)
            es.append(s)
        }
        es[0]._seat = BUnit.TBL
        es[1]._seat = BUnit.TBM
        es[2]._seat = BUnit.TBR
        
        let t = ElementWizard()
        t.create(level: level)
        t._seat = BUnit.TTM
        es.append(t)
        
        super.setEnemyPart(minions: es)
    }
    override func getSpellAttack() -> Spell {
        return GeorgeAttack()
    }
}

class FireMatrix:Magical {
    override init() {
        super.init()
        _name = "火焰法阵"
        _description = "召唤一个火焰法阵，为己方单位提升20点火焰伤害和抵抗，降低敌方单位20点火焰伤害和抵抗，持续3回合"
        autoCast = true
        _cooldown = 3
    }
    override func cast(completion: @escaping () -> Void) {
        _battle._curRole.actionCast {
            for u in self._battle._playerPart {
                let s = Status()
                s._timeleft = 3
                u._elementalPower.fire -= 20
                u._elementalResistance.fire -= 20
                s.timeupAction = {
                    debugger("time up")
                    u._elementalPower.fire += 20
                    u._elementalResistance.fire += 20
                }
                u.addStatus(status: s)
            }
            for u in self._battle._enemyPart {
                let s = Status()
                s._timeleft = 3
                u._elementalPower.fire += 20
                u._elementalResistance.fire += 20
                s.timeupAction = {
                    u._elementalPower.fire -= 20
                    u._elementalResistance.fire -= 20
                }
                u.addStatus(status: s)
            }
            completion()
        }
    }
    override func findTarget() {
        
    }
}
