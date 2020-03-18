//
//  IberisBattle.swift
//  GoD
//
//  Created by kai chen on 2019/2/8.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class IberisBattle: BossBattle {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
//    override func createAI() {
//        if _curRole._unit is Boss {
//            _selectedSpell = _curRole._unit._spellsInuse.one()
//            _selectedSpell._battle = self
//            _selectedSpell.findTarget()
//            execOrder()
//        } else {
//            super.createAI()
//        }
//    }
    
    override func setEnemyPart(minions: Array<Creature>) {
        let level:CGFloat = Iberis.LEVEL
        var es = Array<Creature>()
        
        let t = Iberis()
        t.create(level: level)
        t._seat = BUnit.TTM
        es.append(t)
        
        super.setEnemyPart(minions: es)
    }
    
    override func orderUnits() {
        var all = _playerPart
        _roleAll = []
        for i in 0...all.count - 1 {
            if all[i].hasSpell(spell: Vanguard()) {
                _roleAll.append(all[i])
                _roleAll.append(_enemyPart[0])
                all.remove(at: i)
                break
            }
        }
        while all.count > 0 {
            for unit in all {
                if unit._speed >= _speedLine {
                    _roleAll.append(_enemyPart[0])
                    _roleAll.append(unit)
                    all.remove(at: all.firstIndex(of: unit)!)
                } else {
                    if unit._unit is Character {
                        let c = unit._unit as! Character
                        if c._weapon != nil {
                            unit._speed += unit.getSpeed() * c._weapon!._attackSpeed
                        } else {
                            unit._speed += unit.getSpeed()
                        }
                    } else {
                        unit._speed += unit.getSpeed()
                    }
                }
            }
        }
        if _roleAll[0]._unit._name == _roleAll[1]._unit._name {
            debug("出错了")
        }
    }
    
    override func findNextRole(completion: @escaping () -> Void) {
        if hasRhythm {
            hasRhythm = false
            let this = self
            _curRole.showText(text: "律动") {
                this.createCurRole {
                    completion()
                }
            }
            return
        }
        
        createCurRole {
            completion()
        }
    }
    override func specialLoot() -> Array<Item> {
        var list = Array<Item>()
        let lucky = _char._lucky * 0.01 + 1
        
        if seedFloat() < lucky * 35 {
            let i = Outfit(Outfit.Sword)
            i.create(effection: Sacred.IberisHand)
            list.append(i)
        }
        
        if seedFloat() < lucky * 30 {
            let i = Outfit(Outfit.Fist)
            i.create(effection: Sacred.DeepCold)
            list.append(i)
        }
        
        if seedFloat() < lucky * 5 {
            let i = Outfit(Outfit.Amulet)
            i.create(effection: Sacred.TrueLie)
            list.append(i)
        }
        
        if seedFloat() < lucky * 5 {
            let i = Outfit(Outfit.MagicMark)
            i.create(effection: Sacred.FireMark)
            list.append(i)
        }
        
        if seedFloat() < lucky * 15 {
            let i = Outfit(Outfit.EarRing)
            i.create(effection: Sacred.MoltenFire)
            list.append(i)
        }
        
        if seedFloat() < lucky * 15 {
            let i = Outfit(Outfit.EarRing)
            i.create(effection: Sacred.LavaCrystal)
            list.append(i)
        }
        
        let l = Loot()
        l.loot(level: Iberis.LEVEL.toInt())
        return list + l.getList()
    }
}

class FlameAttack: Physical, CloseSkill {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.FlameAttack
        _name = "炙炎一击"
        isFire = true
        _description = "对目标造成攻击60%的火焰伤害，点燃目标，如果目标已被点燃，则造成双倍攻击"
        _rate = 0.6
        _cooldown = 3
        _quality = Quality.GOOD
    }
    override func cast(completion: @escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
//        if t.hasStatus(type: Status.BURNING) {
//            _rate = 0.8
//        }
        if t.hasStatus(type: Status.BURNING) {
            _rate = 1.2
        }
        let damage = self.fireDamage(t)
        c.actionAttack {
            if !self.hadSpecialAction(t: t, completion: completion) {
                if !self.hasMissed(target: t, completion: completion) {
                    t.play("fire")
                    t.actionAttacked {
                        t.showValue(value: damage) {
                            completion()
                        }
                        if !t.hasStatus(type: Status.BURNING) {
                            t.burning()
                        }
                    }
                }
            }
        }
    }
    
    override func selectable() -> Bool {
        return _battle._curRole.isClose()
    }
}

class ChopChop: Physical, BossOnly {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "乱剑挥砍"
        _description = "猛烈的挥舞双键对目标造成2-6次物理攻击，每次造成攻击力35%的伤害"
        _rate = 0.35
    }
    override func cast(completion: @escaping () -> Void) {
        let t = _battle._selectedTarget!
        let times = 1 + seed(max: 5)
        _battle._curRole.actionAttack {
            for i in 0...times {
                if i == 0 {
                    if !self.hadSpecialAction(t: t) {
                        if !self.hasMissed(target: t) {
                            t.actionAttacked {
                                let damage = self.physicalDamage(t)
                                t.showValue(value: damage)
                            }
                        }
                    }
                } else {
                    setTimeout(delay: i.toFloat() * 0.25, completion: {
                        if !self.hasMissed(target: t) {
                            let damage = self.physicalDamage(t)
                            t.showValue(value: damage)
                        }
                    })
                }
            }
            setTimeout(delay: 1.5 + times.toFloat() * 0.25, completion: completion)
        }
    }
}
class ElementPowerUp:Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "元素强化"
        _description = "提升自身50点元素攻击和元素抵抗"
        _cooldown = 3
        _quality = Quality.SACRED
    }
    override func cast(completion: @escaping () -> Void) {
        let c = _battle._curRole
        c.actionCast {
            let s = Status()
            s._timeleft = 5
            s._type = "element_power_up"
            c.addStatus(status: s)
            c._valueUnit._elementalPower.fire += 50
            c._valueUnit._elementalPower.thunder += 50
            c._valueUnit._elementalPower.water += 50
            c._valueUnit._elementalResistance.fire += 50
            c._valueUnit._elementalResistance.water += 50
            c._valueUnit._elementalResistance.thunder += 50
            s.timeupAction = {
                c._valueUnit._elementalPower.fire -= 50
                c._valueUnit._elementalPower.thunder -= 50
                c._valueUnit._elementalPower.water -= 50
                c._valueUnit._elementalResistance.fire -= 50
                c._valueUnit._elementalResistance.water -= 50
                c._valueUnit._elementalResistance.thunder -= 50
            }
            c.cure1f() {
                completion()
            }
        }
    }
}
