//
//  Status.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/21.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Status:Core {
    override init() {
        super.init()
    }
    var _timeleft:Int = 0
    var _type:String = ""
    var _name = ""
    var _description = ""
    var _img = SKTexture()
    var _source = BUnit()
    var timeupAction = {}
    var inEndOfRound = {}
    static let TURN_ATTACK = "turn_status"
    static let ATTACK_RETURN_BACK = "attack_return_back"
    static let FREEZING = "freezing"
    static let FRAGILE = "fragile"
    static let TAUNTED = "taunted"
    static let VAMPIRE_BLOOD = "vampire_blood"
    static let CRAZY = "crazy"
    static let DANCING_ON_ICE = "dancing_on_ice"
    static let BARGE_ABOUTR = "barge_about"
    static let BLOOD_THIRSTY = "blood_thirsty"
    static let ARMATURE_PUPPET = "armature_puppet"
    static let MIGHT_OF_OAKS = "might_of_oaks"
    static let BELLICOSE = "bellicose"
    static let CRUEL = "cruel"
    static let REBORN = "reborn"
    static let CONFUSED = "confused"
    static let RACE_SUPERIORITY = "race_superiorty"
    static let PROTECT_FROM_GOD = "protect_from_god"
    static let PROTECTION_FROM_ICE = "protection_from_ice"
    static let FIRE_LORD = "fire_lord"
    static let FOCUS = "focus"
    static let ONE_PUNCH = "one_punch"
    static let MAGIC_SWORD = "magic_sword"
    static let EYE_TO_EYE = "eye_to_eye"
    static let TURN_MAGIC = "turn_magic"
    static let DEATH_STRIKE_UP = "death_strike_up"
    static let DEATH_STRIKE_DOWN = "death_strike_down"
    static let DISAPPEAR = "disappear"
    static let ICE_SHIELD = "ice_shield"
    static let ICE_GUARD = "ice_guard"
    static let LOST_SEPPD = "lost_speed"
    static let IMMUNE = "immune"
    static let DOMINATE = "dominate"
    static let BURNING = "burning"
    
    static let FIRE_ENERGE = "fire_energe"
    static let WATER_ENERGE = "water_energe"
    static let THUNDER_ENERGE = "thunder_energe"
    static let TIME_REDUCE = "time_reduce"
    static let PHYSICAL_POWER = "physical_power"
    static let MAGICAL_POWER = "magical_power"
    static let ATTACK_POWER = "attack_power"
    static let DEFENCE_POWER = "defence_power"
    static let MIND_POWER = "mind_power"
    static let LUCKY_POWER = "lucky_power"
    static let SPEED_POWER = "speed_power"
    
}
class LostSpeed:Status {
    override init() {
        super.init()
        _type = Status.LOST_SEPPD
        let this = self
        timeupAction = {
            this._source._extensions.speed += 10
            debug("速度恢复")
        }
    }
}

class BurningStatus:Status {
    override init() {
        super.init()
        _type = Status.BURNING
//        timeupAction = {}
        _timeleft = 3
    }
    var _level:CGFloat = 1
    func getBurningDamage(unit:BUnit) -> CGFloat {
        let damage = unit.getHealth() * 0.05
        return -damage * _level
    }
}








