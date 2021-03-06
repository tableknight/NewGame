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
                _selectedAction = spell
            } else {
                let sd = seed()
                if sd < 40 {
                    _selectedAction = LewisAttack()
                } else if sd < 65 {
                    _selectedAction = HandOfGod()
                } else if sd < 78 {
                    _selectedAction = PowerUp()
                } else if sd < 90 {
                    _selectedAction = OathBreaker()
                } else {
                    _selectedAction = SoulWatch()
                }
            }
            _selectedAction._battle = self
            _selectedAction.findTarget()
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
        let level:CGFloat = Lewis.LEVEL
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
    
    override func specialLoot() -> Array<Item> {
        var list = Array<Item>()
        let lucky = _char._lucky * 0.01 + 1
        
        if seedFloat() < lucky * 5 {
            let i = Outfit(Outfit.Amulet)
            i.create(effection: Sacred.TrueLie)
            list.append(i)
        }
        
        if seedFloat() < lucky * 25 {
            let i = Outfit(Outfit.Amulet)
            i.create(effection: Sacred.HeartOfJade)
            list.append(i)
        }
        
        if seedFloat() < lucky * 45 {
            let i = Outfit(Outfit.MagicMark)
            i.create(effection: Sacred.MarkOfHeaven)
            list.append(i)
        }
        
        if seedFloat() < lucky * 15 {
            let i = Outfit(Outfit.Bow)
            i.create(effection: Sacred.FollowOn)
            list.append(i)
        }
        
        if seedFloat() < lucky * 15 {
            let i = Outfit(Outfit.Instrument)
            i.create(effection: Sacred.TheFear)
            list.append(i)
        }
        
        let l = Loot()
        l.loot(level: Lewis.LEVEL.toInt())
        return list + l.getList()
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
        _description = "控制一名敌方随从"
        _quality = Quality.SACRED
    }
    var _seat:String = ""
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        c.actionCast {
            t.showText(text: "Controled") {
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
        let b = _battle
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
                            var sa = Array<Spell>()
                            for s in t.spells {
                                if s is Active {
                                    sa.append(s)
                                }
                            }
                            if sa.count > 0 {
                                let s = sa.one()
                                s._timeleft += 3
                                t.showText(text: "Seal")
                            }
                        }
                    }
                    t.darkness4fifth()
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
        _description = "提升目标100%的攻击力和100%的护甲，持续2回合"
        _quality = Quality.GOOD
    }
    override func cast(completion: @escaping () -> Void) {
        let t = _battle._selectedTarget!
        
        _battle._curRole.actionCast {
            t.revival2f() {
                let status = Status()
                status._timeleft = 2
                status._labelText = "E"
                let attack = t.getAttack()
                let def = t.getDefence()
                t._valueUnit._extensions.defence += def
                t._valueUnit._extensions.attack += attack
                status.timeupAction = {
                    t._valueUnit._extensions.defence -= def
                    t._valueUnit._extensions.attack -= attack
                }
                t.addStatus(status: status)
                completion()
            }
        }
    }
    
    override func findTarget() {
//        var ts = Array<BUnit>()
//        for u in _battle._enemyPart {
//            if u != _battle._curRole {
//                ts.append(u)
//            }
//        }
        _battle._selectedTarget = _battle._enemyPart.one()
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
        _description = "对敌方所有单位释放誓言，50%几率降低其50%护甲"
        _quality = Quality.GOOD
        _cooldown = 1
        autoCast = true
    }
    override func cast(completion: @escaping () -> Void) {
        let ts = _battle._selectedTargets
        _battle._curRole.actionCast {
            for t in ts {
                t.stateSleepf() {
                    if self.d2() {
                        let s = Status()
                        s._timeleft = 3
                        s._labelText = "B"
                        let def = t.getDefence() * 0.5
                        t._valueUnit._extensions.defence -= def
                        s.timeupAction = {
                            t._valueUnit._extensions.defence += def
                        }
                        t.addStatus(status: s)
                    }
                }
            }
            setTimeout(delay: 2.3, completion: completion)
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
                    t.darkness5() {
                        t.actionAttacked {
                            let damage = self.magicalDamage(t)
                            t.showValue(value: damage)
                        }
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
