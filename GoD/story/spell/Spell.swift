//
//  Spell.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/1/20.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Spell:Core, Showable, Castable {
    var _battle: Battle
    {
        set {
            _curBattle = newValue
        }
        get {
            return _curBattle
        }
    }
    var _curBattle:Battle!
    
    static let CURSED = "CURSED"
    var targetAll: Bool {
        set {
            _targetAll = newValue
        }
        get {
            return _targetAll
        }
    }
    
    var targetEnemy: Bool {
        set {
            _targetEnemy = newValue
        }
        get {
            return _targetEnemy
        }
    }
    
    var canBeTargetPlayer: Bool {
        set {
            _canBeTargetPlayer = newValue
        }
        get {
            return _canBeTargetPlayer
        }
    }
    var canBeTargetSelf: Bool {
        set {
            _canBeTargetSelf = newValue
        }
        get {
            return _canBeTargetSelf
        }
    }
    
    var canBeTargetSummonUnit: Bool {
        set {
            
        }
        get {
            return true
        }
    }
    
    var isClose: Bool {
        set {
            _isClose = newValue
        }
        get {
            return _isClose
        }
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _canBeTargetPlayer = try values.decode(Bool.self, forKey: ._canBeTargetPlayer)
        _canBeTargetSelf = try values.decode(Bool.self, forKey: ._canBeTargetSelf)
        _isClose = try values.decode(Bool.self, forKey: ._isClose)
        _targetEnemy = try values.decode(Bool.self, forKey: ._targetEnemy)
        _targetAll = try values.decode(Bool.self, forKey: ._targetAll)
        isPhysical = try values.decode(Bool.self, forKey: .isPhysical)
        isMagical = try values.decode(Bool.self, forKey: .isMagical)
        isFire = try values.decode(Bool.self, forKey: .isFire)
        isCurse = try values.decode(Bool.self, forKey: .isCurse)
        isWater = try values.decode(Bool.self, forKey: .isWater)
        isThunder = try values.decode(Bool.self, forKey: .isThunder)
        isPassive = try values.decode(Bool.self, forKey: .isPassive)
        isAuro = try values.decode(Bool.self, forKey: .isAuro)
        autoCast = try values.decode(Bool.self, forKey: .autoCast)
        isMultiple = try values.decode(Bool.self, forKey: .isMultiple)
        hasAfterMoveAction = try values.decode(Bool.self, forKey: .hasAfterMoveAction)
        _name = try values.decode(String.self, forKey: ._name)
        _description = try values.decode(String.self, forKey: ._description)
        _rate = try values.decode(CGFloat.self, forKey: ._rate)
        _level = try values.decode(CGFloat.self, forKey: ._level)
        _quality = try values.decode(Int.self, forKey: ._quality)
        //        try super.init(from: decoder)
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_canBeTargetSelf, forKey: ._canBeTargetSelf)
        try container.encode(_canBeTargetPlayer, forKey: ._canBeTargetPlayer)
        try container.encode(_isClose, forKey: ._isClose)
        try container.encode(_targetEnemy, forKey: ._targetEnemy)
        try container.encode(_targetAll, forKey: ._targetAll)
        try container.encode(isPhysical, forKey: .isPhysical)
        try container.encode(isMagical, forKey: .isMagical)
        try container.encode(isFire, forKey: .isFire)
        try container.encode(isCurse, forKey: .isCurse)
        try container.encode(isWater, forKey: .isWater)
        try container.encode(isThunder, forKey: .isThunder)
        try container.encode(isPassive, forKey: .isPassive)
        try container.encode(isAuro, forKey: .isAuro)
        try container.encode(autoCast, forKey: .autoCast)
        try container.encode(isMultiple, forKey: .isMultiple)
        try container.encode(hasAfterMoveAction, forKey: .hasAfterMoveAction)
        try container.encode(_name, forKey: ._name)
        try container.encode(_description, forKey: ._description)
        try container.encode(_rate, forKey: ._rate)
        try container.encode(_level, forKey: ._level)
        try container.encode(_quality, forKey: ._quality)
        try super.encode(to: encoder)
    }
    var  _id = 0
    var _delay:CGFloat = 1.5
    var _canBeTargetPlayer = false
    var _canBeTargetSelf = false
    var _isClose = false
    var _targetEnemy = true
    var _targetAll = false
    var isPhysical = false
    var isMagical = false
    var isFire = false
    var isCurse = false
    var isWater = false
    var isThunder = false
    var isPassive = false
    var isAuro = false
    var hasInitialized = false
    var autoCast = false
    var isMultiple = false
    var hasAfterMoveAction = false
    var hasRevenge = false
    var _costRate:CGFloat = 1
    var _cooldown = 0
    var _timeleft = 0
    var _name:String = ""
    var _description = ""
    var _rate:CGFloat = 1
    var _quality = Quality.NORMAL
    var _level:CGFloat = 1
    var _tear = 0
    var _mpCost:CGFloat = 0
    var _speakings = Array<String>()
    var beCritical = false
    var mpCost:Int {
        get {
            return _mpCost.toInt()
        }
    }
    private enum CodingKeys: String, CodingKey {
        case _canBeTargetPlayer
        case _canBeTargetSelf
        case _isClose
        case _targetEnemy
        case _targetAll
        case isPhysical
        case isMagical
        case isFire
        case isCurse
        case isWater
        case isThunder
        case isPassive
        case isAuro
        case autoCast
        case isMultiple
        case hasAfterMoveAction
        case _cooldown
        case _timeleft
        case _name
        case _description
        case _rate
        case _quality
        case _level
        case _speakings
    }
    override init() {
        super.init()
    }
    
    func beforeMove(completion:@escaping () -> Void) {
        completion()
    }
    func afterMove(completion:@escaping () -> Void) {
        completion()
    }
    func beforeBattle(t:BUnit) {
        
    }
    func cast(completion:@escaping () -> Void) {
        completion()
    }
    func physicalDamage(_ to:BUnit) -> CGFloat {
        if _battle._curRole.getAttack() < 1 {
            _damageValue = 0
            return 0
        }
        if to._unit is Dius {
            let d = to._unit as! Dius
            if d._wwakness != Dius.DEFENCE {
                _damageValue = 0
                return 0
            }
        }
        let from = _battle._curRole
        _damageValue = physicalDamage(from: from, to: to)
        if isPhysical && to.hasSpell(id: Spell.Thorny) {
            if _battle._curRole.isClose() {
                _battle.spellDecision[0] = true
            }
        }
        return _damageValue
    }
    func getDefRate(from: BUnit, to:BUnit) -> CGFloat {
        let level = to._unit._level
        let brk = abs(from.getBreak())
        let odef = to.getDefence() * (1 - brk * 0.01)
//        let base =
//        let r = atan(level * 0.05) + 0.2
//        var def = (odef / atan(odef / level / 2)) / (level * 8) * r
        let rate = level * 0.01 + 1
        var def = odef / (100 * rate + level * 3)
        if def > 0.85 {
            def = 0.85
        }
        if def < 0.15 || def.isNaN{
            def = 0.15
        }
//        debug("\(to._unit._name) odef = \(odef)")
//        debug("def = \(def)")
        if to.hasSpell(id: Spell.OnePunch) || to.hasSpell(id: Spell.DancingOnIce) {
            def = 0
        }
        
        return def
    }
    internal func getAttack(from: BUnit) -> CGFloat {
        return from.getAttack()
    }
    func levelFactor(_ from: BUnit, _ to:BUnit) -> CGFloat {
//        if from._unit is Boss || from._unit is BossMinion {
//            return 1
//        }
//        if to._unit is Boss || to._unit is BossMinion {
//            return 1
//        }
        let m:CGFloat = from._unit._level > to._unit._level ? 1 : -1
        var max = abs(from._unit._level - to._unit._level).toInt()
        if max > 10 {
            max = 10
        }
        var rate:CGFloat = 1
        for _ in 0...max {
            rate = rate * (1 + m * 0.1)
        }
        return rate
    }
    func physicalDamage(from: BUnit, to:BUnit) -> CGFloat {
        let atk = self.getAttack(from: from)
        
        let def = getDefRate(from: from, to:to)
        
//        let msg = "p atk:\(atk.toInt()), def:\(to.getDefence(t: from._unit).toInt()) "
//        debug(msg)
        
        var  damage = atk * (1 - def) * levelFactor(from, to) * raceFactor(to: to, from: from)
        if damage < 5 {
            return -seed(min: 1, max: 5).toFloat()
        }
        if to.isDefend {
            damage = seed(min: 0, max: (damage * 0.6).toInt()).toFloat()
        }
        
//        damage *= 1 + (from.getPhysicalDamage() - to.getPhysicalResistance()) * 0.01
        
        if _battle._curRole._unit is Character && Game.instance.curStage.hasTowerStatus(status: PhysicalPower()) {
            damage *= 1.5
        }
        damage = specialDamage(damage: damage, to: to, from: from)
        chargeCritical(to: to)
        if beCritical {
            damage *= getDestroy(from: from)
        }
        
        if to.hasStatus(type: Status.MIGHT_OF_OAKS) {
            damage *= 0.85
        }
        
        if to.hasStatus(type: "_leading") {
            damage *= 0.5
        }
        
        let percentReduce = abs(to.getPhysicalReducePercent())
        damage *= (100 - percentReduce) * 0.01
        let pointReduce = abs(to.getPhysicalReducePoint())
        damage -= pointReduce
        
        _damageValue = damageControl(damage)
        return -_damageValue
    }
    internal func getDestroy(from: BUnit) -> CGFloat {
        return 1.6 + from.getDestroy() * 0.01
    }
    internal func getSelfSpirit() -> CGFloat {
        return _battle._curRole.getSpirit()
    }
    func magicalDamage(_ to:BUnit) -> CGFloat {
        var def = to.getSpirit()
        if to._unit is Dius {
            let d = to._unit as! Dius
            if d._wwakness != Dius.SPIRIT {
                _damageValue = 0
                return 0
            } else {
                def = 0
            }
            
        }
        let from = _battle._curRole
        let atk = getSelfSpirit()
        
        var damage = atk - def
        damage *= (1 + (from.getMagicalDamage() - to.getMagicalResistance()) * 0.01) * levelFactor(from, to)
        damage *= magicFactor(from: from, to: to)
        
        if _battle._curRole._unit is Character && Game.instance.curStage.hasTowerStatus(status: MagicalPower()) {
            damage *= 1.5
        }
        damage = specialDamage(damage: damage, to: to, from: from)
        _damageValue = -damageControl(damage)
        return _damageValue
    }
    func fireDamage(_ to:BUnit, isPhysical:Bool = false) -> CGFloat {
//        if d2() && to.hasSpell(spell: DragonBlood()) {
//            _damageValue = 0
//            return 0
//        }
        if to._unit is Dius {
            let d = to._unit as! Dius
            if d._wwakness != Dius.FIRE {
                _damageValue = 0
                return 0
            }
        }
        let from = _battle._curRole
        var damage = from.getSpirit()
        if self is Physical {
            damage = from.getAttack()
        }
        damage *= fireFactor(from: from, to: to) * levelFactor(from, to)
        damage *= magicFactor(from: from, to: to)
        if !isMultiple && isFire {
            if from._unit is Character {
                if from.amuletIs(Sacred.LavaCrystal) {
                    damage *= 1.5
                }
            }
        }
        
        damage = specialDamage(damage: damage, to: to, from: from)
        damage = elementalDamage(damage: damage, to: to, from: from)
        _damageValue = -damageControl(damage)
        return _damageValue
    }
    internal func fireFactor(from:BUnit, to:BUnit) -> CGFloat {
        let x = from.getFirePower() - to.getFireResistance()
        return 1 + (x * 0.01)
    }
    internal func waterFactor(from:BUnit, to:BUnit) -> CGFloat {
        let x = from.getWaterPower() - to.getWaterResistance()
        return 1 + (x * 0.01)
    }
    internal func thunderFactor(from:BUnit, to:BUnit) -> CGFloat {
        let x = from.getThunderPower() - to.getThunderResistance()
        return 1 + (x * 0.01)
    }
    func waterDamage(_ to:BUnit, isPhysical:Bool = false) -> CGFloat {
        if to._unit is Dius {
            let d = to._unit as! Dius
            if d._wwakness != Dius.WATER {
                _damageValue = 0
                return 0
            }
        }
        let from = _battle._curRole
        var damage = from.getSpirit()
        if self is Physical {
            damage = from.getAttack()
        }
        if damage < 5 {
            return -seed(min: 0, max: 5).toFloat()
        }
//        let x = from.getWaterPower() - to.getWaterResistance()
        damage *= waterFactor(from: from, to: to) * levelFactor(from, to)
        damage *= magicFactor(from: from, to: to)
        damage = specialDamage(damage: damage, to: to, from: from)
        damage = elementalDamage(damage: damage, to: to, from: from)
        _damageValue = -damageControl(damage)
        return _damageValue
    }
    func thunderDamage(_ to:BUnit, isPhysical:Bool = false) -> CGFloat {
        if to._unit is Dius {
            let d = to._unit as! Dius
            if d._wwakness != Dius.THUNDER {
                _damageValue = 0
                return 0
            }
        }
        let from = _battle._curRole
        var damage = from.getSpirit()
        if self is Physical {
            damage = from.getAttack()
        }
        if damage < 5 {
            return -seed(min: 0, max: 5).toFloat()
        }
//        let x = from.getThunderPower() - to.getThunderResistance()
        damage *= thunderFactor(from: from, to: to) * levelFactor(from, to)
        damage *= magicFactor(from: from, to: to)
        
        damage = specialDamage(damage: damage, to: to, from: from)
        damage = elementalDamage(damage: damage, to: to, from: from)
        _damageValue = -damageControl(damage)
        return _damageValue
    }
    private func damageControl(_ d:CGFloat) -> CGFloat {
        var damage = d * _rate
        if damage < 5 {
            damage = seed(min:1, max: 6).toFloat()
        } else {
            damage = seed(min: (damage * 0.8).toInt(), max: (damage * 1.2).toInt()).toFloat()
        }
        return damage
    }
    private func specialDamage(damage:CGFloat, to:BUnit, from:BUnit) -> CGFloat {
        var d = damage
        if from.weaponIs(Sacred.NightBlade) && to._unit._race == EvilType.RISEN {
            d *= 1.25
        }
        
        return d
    }
    internal func magicFactor(from:BUnit, to:BUnit) -> CGFloat {
//        var f:CGFloat = 1
        return 1 + from.getMagicalDamage() * 0.01 - to.getMagicalResistance() * 0.01
    }
    internal func raceFactor(to:BUnit, from:BUnit) -> CGFloat {
//        if from.soulstoneIs(GiantSoul.EFFECTION) || to.soulstoneIs(GiantSoul.EFFECTION) {
//            return 1
//        }
        var factor:CGFloat = 1
        
//        if from.hasSpell(spell: Dominate()) || from.hasTeamStatus(type: Status.MAKE_EVERYTHING_RIGHT) {
//            return 1.15
//        }
//
//        if to.hasSpell(spell: Dominate()) || to.hasTeamStatus(type: Status.MAKE_EVERYTHING_RIGHT) {
//            return 0.85
//        }
        
        let value:CGFloat = 0.25
        
        if to._unit is Boss {
            factor = 1 - value
        } else if from._unit is Boss {
            factor = 1 + value
        } else if to.getRace() - from.getRace() == 1 {
            factor = 1 - value
        } else if to.getRace() - from.getRace() == -1 {
            factor = 1 + value
        } else if to.getRace() == EvilType.RISEN && from.getRace() == EvilType.NATURE {
            factor = 1 + value
        } else if from.getRace() == EvilType.RISEN && to.getRace() == EvilType.NATURE {
            factor = 1 - value
        }
        
//        if from.weaponIs(HolyPower.EFFECTION) && to.getRace() == EvilType.RISEN {
//            factor *= 2
//        }
        debug("race factor is \(factor)")
        return factor
    }
    internal func elementalDamage(damage:CGFloat, to:BUnit, from:BUnit) -> CGFloat {
//        var damage = damage
//        if _battle._curRole._unit._weapon is ElementalSword {
//            damage *= 1.3
//        }
        
        return damage
    }
    func findPlayerMinion() {
        var arr = Array<BUnit>()
        for u in _battle._playerPart {
            if u._unit is Character {

            } else {
                arr.append(u)
            }
        }
        if arr.count > 0 {
            _battle._selectedTarget = arr.one()
        }
    }
    func findtargetAll() {
        _battle._selectedTargets = _battle._curRole.playerPart ? _battle._enemyPart : _battle._playerPart
    }
    //默认近战 
    func findTarget() {
        var ts = Array<BUnit>()
        let c = _battle._curRole
        if c.isBlocked() {
            if c.playerPart {
                for u in _battle._enemyPart {
                    if !u.isBlocked() {
                        ts.append(u)
                    }
                }
            } else {
                for u in _battle._playerPart {
                    if !u.isBlocked() {
                        ts.append(u)
                    }
                }
            }
        } else {
            if c.playerPart {
                ts = _battle._enemyPart
            } else {
                ts = _battle._playerPart
            }
        }
        if ts.count < 1 {
            debug("--------------------------------findtarget")
        }
        _battle._selectedTarget = ts.one()
    }
    var _damageValue:CGFloat = 0
    func isAttackReturnBack(t:BUnit, completion:@escaping () -> Void) -> Bool {
//        let t = _battle._selectedTarget
        let c = _battle._curRole
        if isClose && self is Physical && c.isClose() {
            let damage = _damageValue
            if t.hasStatus(type: Status.ATTACK_RETURN_BACK) {
                t.removeStatus(type: Status.ATTACK_RETURN_BACK)
                _battle.spellDecision[0] = false
                c.actionAttacked {
//                    c.hpChange(value: damage)
                    c.showValue(value: damage) {
                        completion()
                    }
                }
                return true
            }
        } else if self is Magical {
            let damage = _damageValue
            if t.hasStatus(type: Status.EYE_TO_EYE) {
                t.removeStatus(type: Status.EYE_TO_EYE)
                c.actionAttacked {
//                    c.hpChange(value: damage)
                    c.showValue(value: damage) {
                        completion()
                    }
                }
                return true
            }
        }
        return false
    }
    
    func isAttackTurned(t:BUnit, completion:@escaping () -> Void) -> Bool {
        if self is Physical {
//            let t = _battle._selectedTarget
            let damage = _damageValue
            if t.hasStatus(type: Status.TURN_ATTACK) {
//                let c = _battle._curRole
//                t.hpChange(value: -damage)
                _battle.spellDecision[0] = false
                t.showValue(value: -damage) {
                    completion()
                }
                t.removeStatus(type: Status.TURN_ATTACK)
//                t.actionHealed {
//                }
                return true
            }
        } else if self is Magical {
            let damage = _damageValue
            if t.hasStatus(type: Status.TURN_MAGIC) {
//                t.hpChange(value: -damage)
                t.showValue(value: -damage) {
                    completion()
                }
                t.removeStatus(type: Status.TURN_MAGIC)
                return true
            }
        }
        return false
    }
    func isEmptyHand() -> Bool {
        return false
//        return _battle._curRole._unit._weapon == nil || _battle._curRole._unit._weapon is Fist
    }
    func isWeaponBow() -> Bool {
        return false
//        return _battle._curRole._unit._weapon is Bow
    }
    func getAccuracy() -> CGFloat {
        return _battle._curRole.getAccuracy()
    }
    func hasMissed(target:BUnit, completion:@escaping () -> Void = {}) -> Bool {
        if target.isDefend {
            return false
        }
        if target.hasStatus(type: Status.FREEZING) {
            return false
        }
        let c = _battle._curRole
//        if c.weaponIs(Hawkeye.EFFECTION) {
//            return false
//        }
        let acc = getAccuracy()
        let avd = target.getAvoid()
        let sed = seed().toFloat()
        let this = self
        var value = acc - avd
        if value < 5 {
            value = 5
        }
        if sed > value {
            target.showMiss() {
                //发动复仇
                if self.isClose && target.isClose() && c.isClose() && this.seed() < target.getRevenge().toInt() {
                    self.hasRevenge = true
                    let damage = this.physicalDamage(from: target, to: c)
                    target.showText(text: "复仇") {
                        target.actionAttack {
                            c.actionAttacked {
                                c.showValue(value: damage) {
                                    completion()
                                }
                            }
                            c.attacked1()
                        }
                    }
                } else {
                    completion()
                }
            }
            target.actionAvoid {
            }
            return true
        }
        return false
    }
    internal var CRITICAL:CGFloat = 1.75
    func chargeCritical(to:BUnit) {
//        if _battle._curRole.hasSpell(spell: Cruel()) {
//            if to.getHp() / to.getHealth() <= 0.2 {
//                beCritical = true
//                return
//            }
//        }
        let ctl = _battle._curRole.getCritical() - to.getAgility()
        if seed().toFloat() < ctl {
            beCritical = true
            return
        }
        beCritical = false
    }
    
    func hadSpecialAction(t:BUnit, completion:@escaping () -> Void = {}) -> Bool {
        if isAttackReturnBack(t:t, completion: completion) {
            return true
        } else if isAttackTurned(t:t, completion: completion) {
            return true
        }
        return false
    }
    
    func hasPhysicalEvent(t:BUnit, completion:@escaping () -> Void = {}) -> Bool {
        if !hadSpecialAction(t: t, completion: completion) {
            if !self.hasMissed(target: t, completion: completion) {
                return false
            } else {
                return true
            }
        } else {
            return true
        }
    }
    
    func removeSpecialStatus(t:BUnit) {
//        let t = _battle._selectedTarget
        if t.hasStatus(type: Status.ATTACK_RETURN_BACK) {
            t.removeStatus(type: Status.ATTACK_RETURN_BACK)
        }
        if t.hasStatus(type: Status.TURN_ATTACK) {
            t.removeStatus(type: Status.TURN_ATTACK)
        }
        if t.hasStatus(type: Status.EYE_TO_EYE) {
            t.removeStatus(type: Status.EYE_TO_EYE)
        }
        if t.hasStatus(type: Status.TURN_MAGIC) {
            t.removeStatus(type: Status.TURN_MAGIC)
        }
    }
    
    func getUnitBeyondTarget(seat:String) -> String {
        switch seat {
        case BUnit.TBL:
            return BUnit.TTL
        case BUnit.TBM:
            return "ttm"
        case "tbr":
            return "ttr"
        case "bbl":
            return "btl"
        case "bbm":
            return "btm"
        case "bbr":
            return "btr"
        default:
            return ""
        }
    }
    func getUnitUnderTarget(seat:String) -> String {
        switch seat {
        case "ttl":
            return "tbl"
        case "ttm":
            return "tbm"
        case "ttr":
            return "tbr"
        case "btl":
            return "bbl"
        case "btm":
            return "bbm"
        case "btr":
            return "bbr"
        default:
            return ""
        }
    }
    func getUnitBehindTarget(seat: String) -> String {
        if seat == BUnit.TBL { return BUnit.TTL}
        if seat == BUnit.TBM { return BUnit.TTM}
        if seat == BUnit.TBR { return BUnit.TTR}
        if seat == BUnit.BTL { return BUnit.BBL}
        if seat == BUnit.BTM { return BUnit.BBM}
        if seat == BUnit.BTR { return BUnit.BBR}
        return ""
    }
    func getUnitsInRowOf(seat:String) -> Array<String> {
        var seats = Array<String>()
        switch seat {
        case BUnit.BTL, BUnit.BTM, BUnit.BTR:
            seats = [BUnit.BTL, BUnit.BTM, BUnit.BTR]
            break
        case BUnit.BBL, BUnit.BBM, BUnit.BBR:
            seats = [BUnit.BBL, BUnit.BBM, BUnit.BBR]
            break
        case BUnit.TTL, BUnit.TTM, BUnit.TTR:
            seats = [BUnit.TTL, BUnit.TTM, BUnit.TTR]
            break
        case BUnit.TBL, BUnit.TBM, BUnit.TBR:
            seats = [BUnit.TBL, BUnit.TBM, BUnit.TBR]
            break
        default:
            debug("error of unit seat in getUnitsInRowOf")
            break
        }
        return seats
    }
    func getUnitInTheLeftOfTarget(seat:String) -> String {
        switch seat {
        case "ttm":
            return "ttl"
        case "ttr":
            return "ttm"
        case "tbm":
            return "tbl"
        case "tbr":
            return "tbm"
        case "btm":
            return "btl"
        case "btr":
            return "btm"
        case "bbm":
            return "bbl"
        case "bbr":
            return "bbm"
        default:
            return ""
        }
    }
    func getUnitInTheRightOfTarget(seat:String) -> String {
        switch seat {
        case "ttl":
            return "ttm"
        case "ttm":
            return "ttr"
        case "tbl":
            return "tbm"
        case "tbm":
            return "tbr"
        case "btl":
            return "btm"
        case "btm":
            return "btr"
        case "bbl":
            return "bbm"
        case "bbm":
            return "bbr"
        default:
            return ""
        }
    }
    func getTargetsBySeats(seats:Array<String>) -> Array<BUnit> {
        var ts = Array<BUnit>()
        let all = _battle._playerPart + _battle._enemyPart
        for seat in seats {
            for u in all {
                if seat == u._unit._seat {
                    ts.append(u)
                }
            }
        }
        
        return ts
    }
    func getAdajcentUnits(target:BUnit) -> Array<BUnit> {
//        var ts = Array<BUnit>()
        var seats = Array<String>()
        let seat = target._unit._seat
        seats.append(getUnitBeyondTarget(seat: seat))
        seats.append(getUnitUnderTarget(seat: seat))
        seats.append(getUnitInTheLeftOfTarget(seat: seat))
        seats.append(getUnitInTheRightOfTarget(seat: seat))
        return getTargetsBySeats(seats: seats)
    }
    func setFrozen(target:BUnit, probability:CGFloat = 25) {
        let sed = seed().toFloat()
        let c = _battle._curRole
        let fromMind = c.getMind()
        let toMind = target.getMind()
        let bound = probability * ((fromMind - toMind) * 0.01 + 1)
        if sed < bound {
            debug("feeezing!")
            let status = Status()
            status._type = Status.FREEZING
            status._timeleft = 1
            target.addStatus(status: status)
            target.isDefend = false
            target.actionFrozen(){}
        }
    }
    
    internal func getTimeleft() -> Int {
        return 5
    }
    
    internal func statusMissed(baseline:CGFloat, target:BUnit, bossImmnue:Bool = false, completion:@escaping () -> Void = {}) -> Bool {
        if (target._unit is Boss && bossImmnue) || target.hasStatus(type: Status.IMMUNE) {
            target.showText(text: "IMMUNE") {
                completion()
            }
            return true
        }
        let sed = seed().toFloat()
        let c = _battle._curRole
        let fromMind = c.getMind()
        let toMind = target.getMind()
        let rate:CGFloat = 1 + (fromMind - toMind) * 0.01 + (c._unit._level - target._unit._level) * 0.01
        let bound = baseline * rate
        if sed < bound {
            return false
        }
        target.showText(text: "MISS") {
            completion()
        }
        return true
    }
    //单体无遮挡 目标查找
    internal func findSingleTargetNotBlocked() {
        if targetEnemy {
            if _battle._curRole.playerPart {
                _battle._selectedTarget = _battle._enemyPart.one()
            } else {
                _battle._selectedTarget = _battle._playerPart.one()
            }
        } else {
            if _battle._curRole.playerPart {
                _battle._selectedTarget = _battle._playerPart.one()
            } else {
                _battle._selectedTarget = _battle._enemyPart.one()
            }
        }
    }
    internal func findTargetRandom2() {
        let part = _battle._curRole.playerPart ? _battle._enemyPart : _battle._playerPart
        let index = seed(max: part.count)
        _battle._selectedTargets = [part[index]]
        if part.count > 1 {
            var secondIndex = index
            while(secondIndex == index) {
                secondIndex = seed(max: part.count)
            }
            _battle._selectedTargets.append(part[secondIndex])
        }
    }
    internal func findTargetRandom3() {
        let part = _battle._curRole.playerPart ? _battle._enemyPart : _battle._playerPart
        let index = seed(max: part.count)
        _battle._selectedTargets = [part[index]]
        if part.count > 2 {
            var secondIndex = index
            while(secondIndex == index) {
                secondIndex = seed(max: part.count)
            }
            _battle._selectedTargets.append(part[secondIndex])
        }
    }
    internal func findTargetPartAll() {
        if targetEnemy {
            if _battle._curRole.playerPart {
                _battle._selectedTargets = _battle._enemyPart
            } else {
                _battle._selectedTargets = _battle._playerPart
            }
        } else {
            if _battle._curRole.playerPart {
                _battle._selectedTargets = _battle._playerPart
            } else {
                _battle._selectedTargets = _battle._enemyPart
            }
        }
    }
    internal func findTargetChar() {
        for u in _battle._playerPart {
            if u._unit is Character {
                _battle._selectedTarget = u
            }
        }
    }
    internal func getRandomLeftUnit() -> BUnit {
        return _battle._leftRoles[seed(max: _battle._leftRoles.count)]
    }
    internal func getRandomRightUnit() -> BUnit {
        return _battle._rightRoles[seed(max: _battle._rightRoles.count)]
    }
    internal func findHpLowestUnit() {
        if targetEnemy {
            if !_battle._curRole.playerPart {
                _battle._selectedTarget = findLowesHpUnit(_battle._playerPart)
            } else {
                _battle._selectedTarget = findLowesHpUnit(_battle._enemyPart)
            }
        } else {
            if _battle._curRole.playerPart {
                _battle._selectedTarget = findLowesHpUnit(_battle._playerPart)
            } else {
                _battle._selectedTarget = findLowesHpUnit(_battle._enemyPart)
            }
        }
        
    }
    private func findLowesHpUnit(_ bs: Array<BUnit>) -> BUnit {
        var bu = BUnit()
        var lhp:CGFloat = 0
        for unit in bs {
            if lhp == 0 {
                bu = unit
                lhp = unit.getHp()
            } else {
                if lhp > unit.getHp() && unit.getHp() < unit.getHealth() {
                    bu = unit
                    lhp = unit.getHp()
                }
            }
            
        }
        
        return bu
    }
    
    internal func findRandomTargetInLineFirst() {
        var ts:Array<BUnit> = []
        if _battle._curRole.playerPart {
            let t1 = _battle.getUnitBySeat(seat: BUnit.TBL)
            if nil != t1 {
                ts.append(t1!)
            }
            let t2 = _battle.getUnitBySeat(seat: BUnit.TBM)
            if nil != t2 {
                ts.append(t2!)
            }
            let t3 = _battle.getUnitBySeat(seat: BUnit.TBR)
            if nil != t3 {
                ts.append(t3!)
            }

        } else {
            
            let t1 = _battle.getUnitBySeat(seat: BUnit.BTL)
            if nil != t1 {
                ts.append(t1!)
            }
            let t2 = _battle.getUnitBySeat(seat: BUnit.BTM)
            if nil != t2 {
                ts.append(t2!)
            }
            let t3 = _battle.getUnitBySeat(seat: BUnit.BTR)
            if nil != t3 {
                ts.append(t3!)
            }
        }
        
        if ts.count < 1 {
            findSingleTargetNotBlocked()
        } else {
            _battle._selectedTarget = ts.one()
        }
        
    }
    
    
//    func findTargetInALine() {
//        var list = Array<String>()
//        let rs = _battle._curRole.playerPart ? _battle._enemyPart : _battle._playerPart
//        let t = rs.one()
//        for seats in [[BUnit.TTL, BUnit.TTM, BUnit.TTR],[BUnit.TBL, BUnit.TBM, BUnit.TBR],[BUnit.BTL, BUnit.BTM, BUnit.BTR],[BUnit.BBL, BUnit.BBM, BUnit.BBR]] {
//            if seats.index(of: t._unit._seat) != nil {
//                list = seats
//                break
//            }
//        }
//        
//        _battle._selectedTargets = []
//        for u in rs {
//            if list.index(of: u._unit._seat) != nil {
//                _battle._selectedTargets.append(u)
//            }
//        }
//    }
    internal func cost(value:CGFloat) {
        _mpCost = value * _costRate
    }
    func selectable() -> Bool {
        return true
    }
    static let Cruel = 1001
    static let Bellicose = 1002
    static let BargeAbout = 1003
    static let FeignAttack = 1004
    static let FireBreath = 1005
    static let ToughHeart = 1006
    static let Focus = 1007
    static let Strong = 1008
    static let Energetic = 1009
    static let ThunderAttack = 1010
    static let LowlevelFlame = 1011
    static let BreakDefence = 1012
    static let AttackHard = 1013
    static let ScreamLoud = 1014
    static let Burn = 1015
    static let ControlWind = 1016
    static let SharpStone = 1017
    static let SkyAndLand = 1018
    static let Powerful = 1019
    static let ChaosCore = 1020
    static let PoisonCurse = 1021
    static let ColdWind = 1022
    static let Heal = 1023


    static let BloodThirsty = 2001
    static let LineAttack = 2002
    static let FireFist = 2003
    static let FrozenShoot = 2004
    static let Disappear = 2005
    static let IceFist = 2006
    static let QuickHeal = 2007
    static let Sacrifice = 2008
    static let Bitslap = 2009
    static let LastChance = 2010
    static let PriceOfBlood = 2011
    static let MightOfOaks = 2012
    static let ChaosAttack = 2013
    static let Vanguard = 2014
    static let TrueSight = 2015
    static let LowerSummon = 2016
    static let IceSpear = 2017
    static let DragonBlood = 2018
    static let FlameAttack = 2019
    static let OathBreaker = 2020
    static let WindAttack = 2021
    static let WindPunish = 2022
    static let BurningAll = 2023
    static let ElementDestory = 2024
    static let SetTimeBack = 2025
    static let AsShadow = 2026
    static let Predict = 2027
    static let Combustion = 2028

    
    static let Lighting = 3001
    static let LeeAttack = 3002
    static let ProtectFromGod = 3003
    static let OneShootDoubleKill = 3004
    static let FireRain = 3005
    static let ThunderArray = 3006
    static let FragileCurse = 3007
    static let FireOrFired = 3008
    static let Firelord = 3009
    static let DeathStrike = 3010
    static let Taunt = 3011
    static let Interchange = 3012
    static let ProtectionFromIce = 3013
    static let IceGuard = 3014
    static let TruePower = 3015
    static let Dominate = 3016
    static let ShootAll = 3017
    static let QiWave = 3018
    static let SongOfElement = 3019
    static let DancingDragon = 3020
    static let BallLighting = 3021
    static let SuperWater = 3022
    static let FireExplode = 3023
    static let Reinforce = 3024
    static let AttackPowerUp = 3025
    static let HolySacrifice = 3026
    static let LifeFlow = 3027
    static let Ignite = 3028
    static let Blizzard = 3029
    static let ShootTwo = 3030
    static let LavaExplosion = 3031
    
    static let VampireBlood = 4001
    static let RaceSuperiority = 4002
    static let DancingOnIce = 4003
    static let OnePunch = 4004
    static let TurnAttack = 4005
    static let MagicConvert = 4006
    static let AttackReturnBack = 4007
    static let MagicReflect = 4008
    static let LifeDraw = 4009
    static let MagicSword = 4010
    static let Refresh = 4011
    static let SummonFlower = 4012
    static let SwapHealth = 4013
    static let Steal = 4014
    static let DeathGaze = 4015
    static let SpiritIntervene = 4016
    static let Immune = 4017
    static let Reborn = 4018
    static let SoulLash = 4019
    static let LightingFist = 4020
    static let IceBomb = 4021
    static let ElementMaster = 4022
    static let SpringIsComing = 4023
    static let ControlUndead = 4024
    static let WaterCopy = 4025
    static let HighLevelSummon = 4026
    static let BearFriend = 4027
    static let ElementPowerUp = 4028
    static let SoulExtract = 4029
    static let MindIntervene = 4030
    static let HealAll = 4031
    static let SilenceAll = 4032
    static let SixShooter = 4033
    static let Zealot = 4034
    static let VeryEcperienced = 4035
    static let BurnHeart = 4036
    
    static let ReduceLife = 5001
    static let HorribleImage = 5002
    static let HealOfFlower = 5003
    static let FacelessSpell = 5004
    static let DarkFall = 5005
    static let MessGhost = 5006
    static let SoulReaping = 5007
    static let SoulSlay = 5008
    static let RobberHasMoral = 5009
    static let SummonMummy = 5010
    static let CutThroat = 5011
    static let MakeEverythingRight = 5012
    static let NervousPoison = 5013
    static let KickAss = 5014
    static let Scare = 5015
    static let ThrowWeapon = 5016
    static let ShadowCopy = 5017
    static let Observant = 5018
    static let FlashPowder = 5019
    static let Escape = 5020
    static let Thorny = 5021
    static let TreadEarth = 5022
    static let TakeRest = 5023
    static let ThrowRock = 5024
    static let BeingTired = 5025
    static let Disintegrate = 5026
    static let FireAngel = 5027
    static let BurningOut = 5028
    static let Infection = 5029
    static let DrawBlood = 5030
    static let Screaming = 5031
    static let CriticalBite = 5032
    static let SummonCopy = 5033
    static let ExposeWeakness = 5034
    static let SummonServant = 5035
    static let Nova = 5036
    static let DeathAttack = 5037
    static let NoAction = 5038
    static let HandOfGod = 5039
    static let BlowMana = 5040
}
