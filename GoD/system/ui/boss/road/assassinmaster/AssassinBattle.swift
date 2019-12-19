//
//  AssassinBattle.swift
//  GoD
//
//  Created by kai chen on 2019/7/8.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class AssassinBattle: BossBattle {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func createAI() {
        if _curRole._unit is AssassinMaster {
            if _curRole.getHp() / _curRole.getHealth() < 0.1 {
                _selectedAction = Escape()
            } else {
                if seed() < 55 {
                    _selectedAction = AssassinAttack()
                } else {
                    _selectedAction = getSpell(u: _curRole)
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
        var es = Array<Creature>()
        let l:CGFloat = AssassinMaster.LEVEL
        let t = AssassinMaster()
        t.create(level: l)
        t._seat = BUnit.TTM
        es.append(t)
        
        super.setEnemyPart(minions: es)
    }
//    override func specialLoot() -> Array<Prop> {
//        var list = Array<Prop>()
//        let lucky = _char._lucky * 0.01 + 1
//        
//        if seedFloat() < lucky * 5 {
//            let i = AssassinsSword()
//            i.create()
//            list.append(i)
//        }
//        
//        if seedFloat() < lucky * 15 {
//            let i = ElementalSword()
//            i.create()
//            list.append(i)
//        }
//        
//        if seedFloat() < lucky * 35 {
//            let i = BloodBlade()
//            i.create()
//            list.append(i)
//        }
//        
//        if seedFloat() < lucky * 20 {
//            let i = EternityNight()
//            i.create()
//            list.append(i)
//        }
//        
//        if seedFloat() < lucky * 20 {
//            let i = Hawkeye()
//            i.create()
//            list.append(i)
//        }
//        
//        if seedFloat() < lucky * 10 {
//            let i = Accident()
//            i.create()
//            list.append(i)
//        }
//        
//        let l = Loot()
//        l.loot(level: AssassinMaster.LEVEL)
//        return list + l.getList()
//    }
    override func addEnemy(bUnit: BUnit) {
        bUnit._battle = self
        bUnit.playerPart = false
        bUnit.faceSouth()
        bUnit.position = _enemySeats[bUnit._unit._seat]!
        _enemyPart.append(bUnit)
        addChild(bUnit)
    }
    
    override func addEnemy(unit: Creature) -> BUnit {
        let bUnit = CopyUnit()
        bUnit.setUnit(unit: unit)
        bUnit.create()
        addEnemy(bUnit: bUnit)
        
        return bUnit
    }
}

class CopyUnit:BUnit {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func showValue(value: CGFloat, source:BUnit? = nil, criticalFromSpell: Bool, critical: Bool, damageType: Int, textColor: UIColor, completion: @escaping () -> Void) {
        super.showValue(value: value * 3, source: source, damageType: damageType, textColor: textColor, completion: completion)
    }
}
