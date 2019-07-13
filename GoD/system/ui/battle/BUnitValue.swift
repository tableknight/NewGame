//
//  BUnitValue.swift
//  GoD
//
//  Created by kai chen on 2019/7/5.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
extension BUnit {
    func getSpirit() -> CGFloat {
        var spirit = _unit._extensions.spirit + _extensions.spirit
        
        if hasSpell(spell: Energetic()) {
            if spirit > 0 {
                spirit *= 1.2
            } else {
                spirit *= 0.8
            }
        }
        
        for s in _status.values {
            if s._type == Status.DEATH_STRIKE_UP {
                spirit += 10
            } else if s._type == Status.DEATH_STRIKE_DOWN {
                spirit -= 10
            }
        }
        return spirit
    }
    func getFirePower() -> CGFloat {
        var val = _unit._elementalPower.fire
        //        if hasStatus(type: Status.FIRE_LORD) {
        //            val += 20
        //        }
        if hasAuro(auro: Firelord()) {
            val += 20
        }
        
        if _unit is Character && _stage.hasTowerStatus(status: FireEnerge()) {
            val += 50
        }
        
        return val + _elementalPower.fire + _elemental.damage
    }
    func getWaterPower() -> CGFloat {
        var val = _unit._elementalPower.water
        if _unit is Character && _stage.hasTowerStatus(status: WaterEnerge()) {
            val += 50
        }
        return val + _elementalPower.water + _elemental.damage
    }
    func getThunderPower() -> CGFloat {
        var val = _unit._elementalPower.thunder
        if _unit is Character && _stage.hasTowerStatus(status: ThunderEnerge()) {
            val += 50
        }
        return val + _elementalPower.thunder + _elemental.damage
    }
    func getFireResistance() -> CGFloat {
        var val = _unit._elementalResistance.fire
        //        if hasStatus(type: Status.FIRE_LORD) {
        //            val += 20
        //        }
        if hasAuro(auro: Firelord()) {
            val += 20
        }
        
        if _unit is Character && _stage.hasTowerStatus(status: FireEnerge()) {
            val += 50
        }
        
        return val + _elementalResistance.fire + _elemental.resistance
    }
    func getWaterResistance() -> CGFloat {
        var val = _unit._elementalResistance.water
        if _unit is Character && _stage.hasTowerStatus(status: WaterEnerge()) {
            val += 50
        }
        return val + _elementalResistance.water + _elemental.resistance
    }
    func getThunderResistance() -> CGFloat {
        var val = _unit._elementalResistance.thunder
        if _unit is Character && _stage.hasTowerStatus(status: ThunderEnerge()) {
            val += 50
        }
        return val + _elementalResistance.thunder + _elemental.resistance
    }
    
    func getMagicalDamage() -> CGFloat {
        let val = _unit._magical.damage
        
        return val + _magical.damage
    }
    
    func getMagicalResistance() -> CGFloat {
        let val = _unit._magical.resistance
        
        return val + _magical.resistance
    }
    
    func getPhysicalDamage() -> CGFloat {
        let val = _unit._physical.damage
        
        return val + _physical.damage
    }
    
    func getPhysicalResistance() -> CGFloat {
        let val = _unit._physical.resistance
        
        return val + _physical.resistance
    }
    
    func getAccuracy() -> CGFloat {
        var acc = _unit._extensions.accuracy + _extensions.accuracy
        if hasSpell(spell: BargeAbout()) {
            acc -= 100
        }
        if hasSpell(spell: Sacrifice()) {
            acc += 50
        }
        if hasAuro(auro: Focus()) {
            acc += 20
        }
        if _unit is Character && _stage.hasTowerStatus(status: SpeedPower()) {
            acc += 25
        }
        return acc
    }
    func getAvoid() -> CGFloat {
        var avd = _unit._extensions.avoid + _extensions.avoid
        if hasSpell(spell: DancingOnIce()) {
            avd += 100
        }
        if _unit is Character && _stage.hasTowerStatus(status: DefencePower()) {
            avd += 25
        }
        
        return avd
    }
    func getSpeed() -> CGFloat {
        var speed = _unit._extensions.speed + _extensions.speed
        if _unit.isMainChar && _stage.hasTowerStatus(status: SpeedPower()) {
            speed += 50
        }
        return speed
    }
    func getAttack() -> CGFloat {
        //        let atk = sqrt(_unit._extensions.attack) * 12
        if hasSpell(spell: MagicSword()) {
            return getSpirit()
        }
        var atk = _unit._extensions.attack + _extensions.attack
        if hasSpell(spell: OnePunch()) {
            atk += getDefence()
        }
        
        if hasSpell(spell: Bellicose()) {
            atk *= 1.3
        }
        if _unit is Character && _stage.hasTowerStatus(status: AttackPower()) {
            atk += 50
        }
        if _unit is Character {
            let char = _unit as! Character
            if char._weapon is BloodBlade {
                let rate = getHp() / getHealth()
                let plus = char._weapon!.getAttack() * (1 - rate)
                atk += plus
            }
        }
        return atk
    }
    func getDefence() -> CGFloat {
        var def = _unit._extensions.defence + _extensions.defence
        if hasSpell(spell: DancingOnIce()) {
            return 0
        }
        if hasSpell(spell: Sacrifice()) {
            def *= 0.5
        }
        var rate:CGFloat = 1
        //        if hasStatus(type: Status.FRAGILE) {
        //            rate = 0.5
        //        }
        if hasSpell(spell: Strong()) {
            rate += 0.2
        }
        if hasStatus(type: Status.ICE_GUARD) {
            rate += 0.1
        }
        def *= rate
        if _unit is Character && _stage.hasTowerStatus(status: DefencePower()) {
            def += 50
        }
        return def
    }
    func getCritical() -> CGFloat {
        var ctl = _unit._extensions.critical + _extensions.critical
        if hasSpell(spell: BloodThirsty()) {
            ctl += _unit._level
        }
        if hasSpell(spell: BargeAbout()) {
            ctl += 100
        }
        if _unit is Character && _stage.hasTowerStatus(status: AttackPower()) {
            ctl += 25
        }
        return ctl
    }
    
    func getCriticalForShow() -> CGFloat {
        var ctl = _unit._extensions.critical
        if hasSpell(spell: BloodThirsty()) {
            ctl += _unit._level
        }
        if hasSpell(spell: BargeAbout()) {
            ctl += 100
        }
        if _unit is Character && _stage.hasTowerStatus(status: AttackPower()) {
            ctl += 25
        }
        return ctl
    }
    func getStrength() -> CGFloat {
        let val = _unit._mains.strength + _mains.strength
        return val
    }
    func getStamina() -> CGFloat {
        let val = _unit._mains.stamina + _mains.stamina
        return val
    }
    func getAgility() -> CGFloat {
        let val = _unit._mains.agility + _mains.agility
        return val
    }
    func getIntellect() -> CGFloat {
        let val = _unit._mains.intellect + _mains.intellect
        return val
    }
    
    func getMind() -> CGFloat {
        var mind = _unit._extensions.mind + _extensions.mind
        if _unit is Character && _stage.hasTowerStatus(status: MindPower()) {
            mind += 25
        }
        return mind
    }
    
    func getDestroy() -> CGFloat {
        return _unit._extensions.destroy + _extensions.destroy
    }
    
    func getBreak() -> CGFloat {
        let val = _unit._break
        return val + _break
    }
    
    func getHp() -> CGFloat {
        return _unit._extensions.hp
    }
    func getHealth() -> CGFloat {
        return _unit._extensions.health + _extensions.health
    }
    func getRevenge() -> CGFloat {
        let val = _unit._revenge + _revenge
        return val + _revenge
    }
    func getLucky() -> CGFloat {
        var val = _unit._lucky
        if _unit is Character && _stage.hasTowerStatus(status: LuckyPower()) {
            val += 25
        }
        
        return val
    }
    
    func getRace() -> Int {
        if _race != -1 {
            return _race
        }
        
        return _unit._race
    }
    
    func getRhythm() -> CGFloat {
        let val = _unit._rhythm
        return val + _rhythm
    }
    func getChaos() -> CGFloat {
        let val = _unit._chaos
        return val + _chaos
    }
    func getSensitive() -> Int {
        let val = _unit._sensitive
        return val + _sensitive
    }
}

