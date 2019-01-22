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
                _selectedSpell = FateDecision()
            } else {
                _selectedSpell = ThunderArray()
            }
            _selectedSpell._battle = self
            _selectedSpell.findTarget()
            execOrder()
        } else {
            super.createAI()
        }
    }
}
class FateDecision: Magical {
    override init() {
        super.init()
        //        isWater = true
        _name = "命运之轮"
        _description = "对随机随从目标造成最大生命75%的伤害"
        _rate = 0.8
        _quality = Quality.SACRED
        _cooldown = 2
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        let damage = -t.getHealth() * 0.75
        c.actionCast {
            if !self.hadSpecialAction(t: t, completion: completion) {
                t.actionAttacked {
                    t.showValue(value: damage) {
                        completion()
                    }
                }
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
