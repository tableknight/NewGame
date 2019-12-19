//
//  ControlUndead.swift
//  GoD
//
//  Created by kai chen on 2019/2/20.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class ControlUndead:Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.ControlUndead
        _name = "控制亡灵"
        _description = "有一定几率控制目标亡灵生物"
        _quality = Quality.SACRED
        _cooldown = 1
    }
    override func cast(completion: @escaping () -> Void) {
        let t = _battle._selectedTarget!
        let b = _battle
        _battle._curRole.actionCast {
            if t._unit._race == EvilType.RISEN {
                t.actionDebuff {
                    if self.d4() || Mode.debug {
                        t.actionRecall {
                            t.removeFromBattle()
                            t.removeFromParent()
                            let seats = self._battle.getEmptySeats(top: !b._curRole.playerPart)
                            t._unit._seat = seats.one()
                            if b._curRole.playerPart {
                                b.addPlayerMinion(bUnit: t)
                            } else {
                                b.addEnemy(bUnit: t)
                            }
                            t.actionSummon {}
                            completion()
                        }
                        
                    } else {
                        t.showMiss {
                            completion()
                        }
                    }
                }
            } else {
                t.showMiss {
                    completion()
                }
            }
        }
    }
    override func selectable() -> Bool {
        return _battle._playerPart.count < 6
    }
    override func findTarget() {
        findTargetPartAll()
        let ts = _battle._selectedTargets
        var rs = Array<BUnit>()
        for t in ts {
            if t._unit._race == EvilType.RISEN {
                rs.append(t)
            }
        }
        if rs.count < 1 {
            _battle._selectedTarget = ts.one()
        } else {
            _battle._selectedTarget = rs.one()
        }
    }
}
