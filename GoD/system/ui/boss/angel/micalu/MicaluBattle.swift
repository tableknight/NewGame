//
//  MicaluBattle.swift
//  GoD
//
//  Created by kai chen on 2019/1/22.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class MicaluBattle: BossBattle {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func createAI() {
        if _curRole._unit is Micalu {
            _selectedSpell = _curRole._unit._spellsInuse.one()
            _selectedSpell._battle = self
            _selectedSpell.findTarget()
            execOrder()
        } else {
            super.createAI()
        }
    }
    override func setEnemyPart(minions: Array<Creature>) {
        let level:CGFloat = 36
        var es = Array<Creature>()
//        for _ in 0...1 {
//            let lm = ToppurServant()
//            lm.create(level: level)
//            es.append(lm)
//        }
//        es[0]._seat = BUnit.TBL
//        es[1]._seat = BUnit.TBR
        let ms1 = MicaluServant1()
        ms1.create(level: level)
        ms1._seat = BUnit.TBL
        es.append(ms1)
        
        let ms2 = MicaluServant2()
        ms2.create(level: level)
        ms2._seat = BUnit.TBR
        es.append(ms2)
        
        let t = Micalu()
        t.create(level: level)
        t._seat = BUnit.TTM
        es.append(t)
        
        super.setEnemyPart(minions: es)
    }
    override func getBossYAxis() -> CGFloat {
        return cellSize * 4.25
    }
}

class SixShooter: Physical, BowSkill {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "乱射"
        _description = "进行六次快速射击，每次伤害递减38%"
        _rate = 0.38
        _quality = Quality.SACRED
        _cooldown = 2
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        c.actionShoot {
            for i in 0...5 {
                setTimeout(delay: i.toFloat() * 0.5, completion: {
                    let t = self._battle._playerPart.one()
                    let damage = self.physicalDamage(t) * pow(0.82, i.toFloat())
                    if !self.hadSpecialAction(t: t) {
                        if !self.hasMissed(target: t) {
                            t.actionAttacked {
                                t.showValue(value: damage)
                            }
                        }
                    }
                })
            }
            setTimeout(delay: 5, completion: completion)
        }
    }
    override func selectable() -> Bool {
        return isWeaponBow()
    }
}
