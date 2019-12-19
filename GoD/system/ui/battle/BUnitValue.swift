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
        var spirit = _unit._extensions.spirit + _valueUnit._extensions.spirit
        
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
        
        return val + _valueUnit._elementalPower.fire + _valueUnit._elemental.damage
    }
    func getWaterPower() -> CGFloat {
        var val = _unit._elementalPower.water
        if _unit is Character && _stage.hasTowerStatus(status: WaterEnerge()) {
            val += 50
        }
        return val + _valueUnit._elementalPower.water + _valueUnit._elemental.damage
    }
    func getThunderPower() -> CGFloat {
        var val = _unit._elementalPower.thunder
        if _unit is Character && _stage.hasTowerStatus(status: ThunderEnerge()) {
            val += 50
        }
        return val + _valueUnit._elementalPower.thunder + _valueUnit._elemental.damage
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
        
        return val + _valueUnit._elementalResistance.fire + _valueUnit._elemental.resistance
    }
    func getWaterResistance() -> CGFloat {
        var val = _unit._elementalResistance.water
        if _unit is Character && _stage.hasTowerStatus(status: WaterEnerge()) {
            val += 50
        }
        return val + _valueUnit._elementalResistance.water + _valueUnit._elemental.resistance
    }
    func getThunderResistance() -> CGFloat {
        var val = _unit._elementalResistance.thunder
        if _unit is Character && _stage.hasTowerStatus(status: ThunderEnerge()) {
            val += 50
        }
        return val + _valueUnit._elementalResistance.thunder + _valueUnit._elemental.resistance
    }
    
    func getMagicalDamage() -> CGFloat {
        let val = _unit._magical.damage
        
        return val + _valueUnit._magical.damage
    }
    
    func getMagicalResistance() -> CGFloat {
        let val = _unit._magical.resistance
        
        return val + _valueUnit._magical.resistance
    }
    
    func getPhysicalDamage() -> CGFloat {
        let val = _unit._physical.damage
        
        return val + _valueUnit._physical.damage
    }
    
    func getPhysicalResistance() -> CGFloat {
        let val = _unit._physical.resistance
        
        return val + _valueUnit._physical.resistance
    }
    
    func getAccuracy() -> CGFloat {
        var acc = _unit._extensions.accuracy + _valueUnit._extensions.accuracy
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
        var avd = _unit._extensions.avoid + _valueUnit._extensions.avoid
        if hasSpell(spell: DancingOnIce()) {
            avd += 100
        }
        if _unit is Character && _stage.hasTowerStatus(status: DefencePower()) {
            avd += 25
        }
        
        return avd
    }
    func getSpeed() -> CGFloat {
        var speed = _unit._extensions.speed + _valueUnit._extensions.speed
//        if _unit.isMainChar && _stage.hasTowerStatus(status: SpeedPower()) {
//            speed += 50
//        }
        return speed
    }
    func getAttack() -> CGFloat {
        //        let atk = sqrt(_unit._extensions.attack) * 12
        if hasSpell(spell: MagicSword()) {
            return getSpirit()
        }
        var atk = _unit._extensions.attack + _valueUnit._extensions.attack
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
//            if char._weapon is BloodBlade {
//                let rate = getHp() / getHealth()
//                let plus = char._weapon!.getAttack() * (1 - rate)
//                atk += plus
//            }
        }
        return atk
    }
    func getDefence() -> CGFloat {
        var def = _unit._extensions.defence + _valueUnit._extensions.defence
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
        var ctl = _unit._extensions.critical + _valueUnit._extensions.critical
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
        let val = _unit._mains.strength + _valueUnit._mains.strength
        return val
    }
    func getStamina() -> CGFloat {
        let val = _unit._mains.stamina + _valueUnit._mains.stamina
        return val
    }
    func getAgility() -> CGFloat {
        let val = _unit._mains.agility + _valueUnit._mains.agility
        return val
    }
    func getIntellect() -> CGFloat {
        let val = _unit._mains.intellect + _valueUnit._mains.intellect
        return val
    }
    
    func getMind() -> CGFloat {
        var mind = _unit._extensions.mind + _valueUnit._extensions.mind
        if _unit is Character && _stage.hasTowerStatus(status: MindPower()) {
            mind += 25
        }
        return mind
    }
    
    func getMpMax() -> CGFloat {
        return _unit._extensions.mpMax
    }
    
    func getDestroy() -> CGFloat {
        return _unit._extensions.destroy + _valueUnit._extensions.destroy
    }
    
    func getBreak() -> CGFloat {
        let val = _unit._break
        return val + _valueUnit._break
    }
    
    func getHp() -> CGFloat {
        return _unit._extensions.hp
    }
    func getHealth() -> CGFloat {
        return _unit._extensions.health + _valueUnit._extensions.health
    }
    func getRevenge() -> CGFloat {
        var val = _unit._revenge
//        if hasSpell(spell: ChaosCore()) {
//            val += ChaosCore.VALUE
//        }
        return val + _valueUnit._revenge
    }
    func getLucky() -> CGFloat {
        var val = _unit._lucky
        if _unit is Character && _stage.hasTowerStatus(status: LuckyPower()) {
            val += 25
        }
        
        if hasSpell(spell: ToughHeart()) {
            val += ToughHeart.VALUE
        }
        
        return val
    }
    
    func getRace() -> Int {
        if _valueUnit._race != -1 {
            return _valueUnit._race
        }
        
        return _unit._race
    }
    
    func getRhythm() -> CGFloat {
        var val = _unit._rhythm
        if hasSpell(spell: AsShadow()) {
            val += 10
        }
        return val + _valueUnit._rhythm
    }
    func getChaos() -> CGFloat {
        let val = _unit._chaos
        return val + _valueUnit._chaos
    }
    func getSensitive() -> Int {
        let val = (_unit as! Creature)._sensitive
        return val
    }
}

