//
//  LewisBattle.swift
//  GoD
//
//  Created by kai chen on 2019/1/27.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class LewisBattle: BossBattle {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func createAI() {
        if _curRole._unit is Lewis {
            let seat = getDeadPos()
            if seat != "" && _playerPart.count > 1 {
                let spell = SoulControl()
                spell._seat = seat
                _selectedSpell = spell
            } else {
                let sd = seed()
                if sd < 40 {
                    _selectedSpell = LewisAttack()
                } else if sd < 65 {
                    _selectedSpell = HandOfGod()
                } else if sd < 80 {
                    _selectedSpell = PowerUp()
                } else if sd < 90 {
                    _selectedSpell = OathBreaker()
                } else {
                    _selectedSpell = SoulWatch()
                }
            }
            _selectedSpell._battle = self
            _selectedSpell.findTarget()
            execOrder()
        } else {
            super.createAI()
        }
    }
    //阵亡cui song随从位置
    private func getDeadPos() -> String {
        var posArray = Array<String>()
        for u in _enemyPart {
            posArray.append(u._unit._seat)
        }
        if posArray.firstIndex(of: BUnit.TBL) == nil {
            return BUnit.TBL
        }
        if posArray.firstIndex(of: BUnit.TBM) == nil {
            return BUnit.TBM
        }
        if posArray.firstIndex(of: BUnit.TBR) == nil {
            return BUnit.TBR
        }
        return ""
    }
    
    override func setEnemyPart(minions: Array<Creature>) {
        let level:CGFloat = 41
        var es = Array<Creature>()
        for _ in 0...2 {
            let lm = LewisMinion()
            lm.create(level: level)
            es.append(lm)
        }
        es[0]._seat = BUnit.TBL
        es[1]._seat = BUnit.TBM
        es[2]._seat = BUnit.TBR
        
        let t = Lewis()
        t.create(level: level)
        t._seat = BUnit.TTM
        es.append(t)
        
        super.setEnemyPart(minions: es)
    }
}

class SoulControl: Magical, BossOnly {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "精神控制"
        _description = "控制一名敌方随从害"
        _quality = Quality.SACRED
    }
    var _seat:String = ""
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        c.actionCast {
            t.showText(text: "CONTROLED") {
                t.actionRecall {
                    t.removeFromBattle()
                    t.removeFromParent()
                    t._unit._seat = self._seat
                    self._battle.addEnemy(bUnit: t)
                    t.actionSummon {
                        completion()
                    }
                }
            }
        }
    }
    override func findTarget() {
        findPlayerMinion()
    }
}

class LewisAttack: Physical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
    }
    override func cast(completion:@escaping () -> Void) {
        let b = _battle!
        let t = b._selectedTarget!
        let c = b._curRole
        let damage = physicalDamage(t)
        c.actionAttack {
            if !self.hadSpecialAction(t: t, completion: completion) {
                if !self.hasMissed(target: t, completion: completion) {
                    t.actionAttacked {
                        t.showValue(value: damage) {
                            completion()
                        }
                    }
                }
            }
        }
    }
    
    
}

class HandOfGod: Physical, BossOnly {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        isClose = true
        _quality = Quality.RARE
        _cooldown = 1
        _name = "上帝之手"
        _rate = 1
        _description = "对目标造成攻击100%的物理伤害，增加随机主动技能冷却3回合"
    }
    override func cast(completion:@escaping () -> Void) {
        let t = _battle._selectedTarget!
        let c = _battle._curRole
        let damage = physicalDamage(t)
        c.actionAttack {
            if !self.hadSpecialAction(t: t, completion: completion) {
                if !self.hasMissed(target: t, completion: completion) {
                    t.actionAttacked {
                        t.showValue(value: damage) {
                            setTimeout(delay: 2, completion: completion)
                            for s in t._unit._spellsInuse {
                                if s is Active {
                                    s._timeleft += 3
                                    t.showText(text: "DELAYED")
                                    return
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
}
class PowerUp: Magical, BossOnly {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "力量增强"
        _description = "提升目标100%的攻击力和100%的防御，持续2回合"
        _quality = Quality.GOOD
    }
    override func cast(completion: @escaping () -> Void) {
        let t = _battle._selectedTarget!
        let status = Status()
        status._timeleft = 2
        status._labelText = "E"
        let attack = t.getAttack()
        let def = t.getDefence()
        t._extensions.defence += def
        t._extensions.attack += attack
        status.timeupAction = {
            t._extensions.defence -= def
            t._extensions.attack -= attack
        }
        t.addStatus(status: status)
        _battle._curRole.actionCast {
            t.actionBuff {
                t.showText(text: "POWER UP") {
                    completion()
                }
            }
        }
    }
    
    override func findTarget() {
        var ts = Array<BUnit>()
        for u in _battle._enemyPart {
            if u != _battle._curRole {
                ts.append(u)
            }
        }
        _battle._selectedTarget = ts.one()
    }
}

class OathBreaker:Magical, Curse {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "誓言·破"
        _description = "对地方所有目标释放誓言，50%几率降低其50%防御"
        _quality = Quality.GOOD
        _cooldown = 1
        autoCast = true
    }
    override func cast(completion: @escaping () -> Void) {
        let ts = _battle._selectedTargets
        _battle._curRole.actionCast {
            for t in ts {
                t.actionDebuff {
                    if self.d2() {
                        t.showText(text: "BREAK")
                        let s = Status()
                        s._timeleft = 3
                        s._labelText = "B"
                        let def = t.getDefence() * 0.5
                        t._extensions.defence -= def
                        s.timeupAction = {
                            t._extensions.defence += def
                        }
                        t.addStatus(status: s)
                    }
                }
            }
            setTimeout(delay: 2.5, completion: completion)
        }
    }
    override func findTarget() {
        findTargetPartAll()
    }
}
class SoulWatch: Magical, BossOnly {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "灵魂窥探"
        _description = "对敌方所有目标造成精神100%的法术伤害"
        _quality = Quality.SACRED
    }
    override func cast(completion: @escaping () -> Void) {
        let ts = _battle._selectedTargets
        _battle._curRole.actionCast {
            for t in ts {
                if !self.hadSpecialAction(t: t, completion: completion) {
                    t.actionAttacked {
                        let damage = self.magicalDamage(t)
                        t.showValue(value: damage)
                    }
                }
            }
            setTimeout(delay: 2.5, completion: completion)
        }
    }
    override func findTarget() {
        _battle._selectedTargets = _battle._playerPart
    }
}
