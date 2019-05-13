//
//  Spell.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/1/20.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Spell:Core, IDisplay, ISelectTarget {
    func getInfosDisplay() -> IPanelSize {
        return ItemInfo()
    }
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
    var _cooldown = 0
    var _timeleft = 0
    var _battle:Battle!
    var _name:String = ""
    var _description = ""
    var _rate:CGFloat = 1
    var _quality = Quality.NORMAL
    var _level:CGFloat = 1
    var _tear = 0
    var _speakings = Array<String>()
    var beCritical = false
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
        if to._unit is Dius {
            let d = to._unit as! Dius
            if d._wwakness != Dius.DEFENCE {
                return 0
            }
        }
        let from = _battle._curRole
        _damageValue = physicalDamage(from: from, to: to)
        return _damageValue
    }
    func getDefRate(from: BUnit, to:BUnit) -> CGFloat {
        let level = to._unit._level
        let brk = from.getBreak()
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
        if to.hasSpell(spell: OnePunch()) || to.hasSpell(spell: DancingOnIce()) {
            def = 0
        }
        
        return def
    }
    internal func getAttack(from: BUnit) -> CGFloat {
        return from.getAttack()
    }
    func levelFactor(_ from: BUnit, _ to:BUnit) -> CGFloat {
        return 1 + (from._unit._level / to._unit._level) * 0.05
    }
    func physicalDamage(from: BUnit, to:BUnit) -> CGFloat {
        let atk = self.getAttack(from: from)
        
        let def = getDefRate(from: from, to:to)
        
//        let msg = "p atk:\(atk.toInt()), def:\(to.getDefence(t: from._unit).toInt()) "
//        debug(msg)
        
        var  damage = atk * (1 - def) * levelFactor(from, to)
        if damage < 5 {
            return -seed(min: 0, max: 5).toFloat()
        }
        if to.isDefend {
            damage = seed(min: 0, max: (damage * 0.6).toInt()).toFloat()
        }
        
        damage *= 1 + (from.getPhysicalDamage() - to.getPhysicalResistance()) * 0.01
        
        if _battle._curRole._unit is Character && Game.instance.curStage.hasTowerStatus(status: PhysicalPower()) {
            damage *= 1.5
        }
        damage = specialDamage(damage: damage, to: to, from: from)
        chargeCritical(to: to)
        if beCritical {
            damage *= CRITICAL
        }
        
        if to.hasStatus(type: Status.MIGHT_OF_OAKS) {
            damage *= 0.85
        }
        
        _damageValue = damageControl(damage)
        return -_damageValue
    }
    internal func getSelfSpirit() -> CGFloat {
        return _battle._curRole.getSpirit()
    }
    func magicalDamage(_ to:BUnit) -> CGFloat {
        var def = to.getSpirit()
        if to._unit is Dius {
            let d = to._unit as! Dius
            if d._wwakness != Dius.SPIRIT {
                return 0
            } else {
                def = 0
            }
            
        }
        let from = _battle._curRole
        let atk = getSelfSpirit()
        
        var damage = atk - def
        damage *= (1 + (from.getMagicalDamage() - to.getMagicalResistance()) * 0.01) * levelFactor(from, to)
        
        if _battle._curRole._unit is Character && Game.instance.curStage.hasTowerStatus(status: MagicalPower()) {
            damage *= 1.5
        }
        damage = specialDamage(damage: damage, to: to, from: from)
        _damageValue = -damageControl(damage)
        return _damageValue
    }
    func fireDamage(_ to:BUnit, isPhysical:Bool = false) -> CGFloat {
        if d2() && to.hasSpell(spell: DragonBlood()) {
            _damageValue = 0
            return 0
        }
        if to._unit is Dius {
            let d = to._unit as! Dius
            if d._wwakness != Dius.FIRE {
                return 0
            }
        }
        let from = _battle._curRole
        var damage = from.getSpirit()
        if self is Physical {
            damage = from.getAttack()
        }
        damage *= fireFactor(from: from, to: to) * levelFactor(from, to)
        
        if !isMultiple && isFire {
            if from._unit is Character {
                let char = from._unit as! Character
                if char._earRing is LavaCrystal {
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
        damage = specialDamage(damage: damage, to: to, from: from)
        damage = elementalDamage(damage: damage, to: to, from: from)
        _damageValue = -damageControl(damage)
        return _damageValue
    }
    func thunderDamage(_ to:BUnit, isPhysical:Bool = false) -> CGFloat {
        if to._unit is Dius {
            let d = to._unit as! Dius
            if d._wwakness != Dius.THUNDER {
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
        if from._unit._weapon is NightBlade && to._unit._race == EvilType.RISEN {
            d *= 1.25
        }
        
        return d
    }
    internal func raceFactor(to:BUnit, from:BUnit) -> CGFloat {
        var factor:CGFloat = 1
        
        if from.hasSpell(spell: Dominate()) {
            return 1.15
        }
        
        if to.hasSpell(spell: Dominate()) {
            return 0.85
        }
        
        if to.getRace() == EvilType.FINAL {
            factor = 0.85
        }
        if from.getRace() == EvilType.FINAL {
            factor =  1.15
        }
        
        if to.getRace() - from.getRace() == 1 {
            factor =  0.85
        }
        
        if to.getRace() - from.getRace() == -1 {
            factor =  1.15
        }
        
        if to.getRace() == EvilType.RISEN && from.getRace() == EvilType.NATURE {
            factor =  1.15
        }
        
        if from.getRace() == EvilType.RISEN && to.getRace() == EvilType.NATURE {
            factor =  0.85
        }
        
        if from._unit._weapon is HolyPower && to.getRace() == EvilType.RISEN {
            factor *= 2
        }
        
        return factor
    }
    internal func elementalDamage(damage:CGFloat, to:BUnit, from:BUnit) -> CGFloat {
        var damage = damage
        if _battle._curRole._unit._weapon is ElementalSword {
            damage *= 1.3
        }
        
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
        if isClose && self is Physical && c._unit.isClose() {
            let damage = _damageValue
            if t.hasStatus(type: Status.ATTACK_RETURN_BACK) {
                t.removeStatus(type: Status.ATTACK_RETURN_BACK)
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
        return _battle._curRole._unit._weapon == nil
    }
    func isWeaponBow() -> Bool {
        return _battle._curRole._unit._weapon is Bow
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
        if c._unit is Character {
            let char = c._unit as! Character
            if char._weapon is Hawkeye {
                return false
            }
        }
        let acc = getAccuracy()
        let avd = target.getAvoid()
        let sed = seed().toFloat()
        let this = self
        var value = acc - avd
        if value < 5 {
            value = 5
        }
        if sed > value {
            target.showText(text: "Miss") {
                //发动复仇
                if this.isClose && target._unit.isClose() && this.seed() < target.getRevenge().toInt() {
                    let damage = this.physicalDamage(from: target, to: c)
                    target.showText(text: "复仇") {
                        target.actionAttack {
                            c.actionAttacked {
                                c.showValue(value: damage) {
                                    completion()
                                }
                            }
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
        if _battle._curRole.hasSpell(spell: Cruel()) {
            if to.getHp() / to.getHealth() <= 0.2 {
                beCritical = true
                return
            }
        }
        let ctl = _battle._curRole.getCritical() - to._unit._level
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
            print("feeezing!")
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
        if bossImmnue || target.hasStatus(type: Status.IMMUNE) {
            target.showText(text: "IMMUNE") {
                completion()
            }
            return true
        }
        let sed = seed().toFloat()
        let c = _battle._curRole
        let fromMind = c.getMind()
        let toMind = target.getMind()
        let rate:CGFloat = 1 + (fromMind - toMind) * 0.01
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
    internal func getRandomLeftUnit() -> BUnit {
        return _battle._leftRoles[seed(max: _battle._leftRoles.count)]
    }
    internal func getRandomRightUnit() -> BUnit {
        return _battle._rightRoles[seed(max: _battle._rightRoles.count)]
    }
    internal func findHpLowestUnit() {
        if _battle._curRole.playerPart {
            _battle._selectedTarget = findLowesHpUnit(_battle._playerPart)
        } else {
            _battle._selectedTarget = findLowesHpUnit(_battle._enemyPart)
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
    
    func burningOne(t: BUnit) {
        
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
    
    func selectable() -> Bool {
        return true
    }
}
