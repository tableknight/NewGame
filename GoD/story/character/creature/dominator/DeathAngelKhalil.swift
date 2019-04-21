//
//  DeathAngelKhalil.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/23.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class DeathAngelKhalil:PowerLord {
    override init() {
        super.init()
        _name = "哈利勒"
        _img = SKTexture(imageNamed: "death_angel.png")
    }
    override func create(level: CGFloat) {
        _quality = Quality.SACRED
        _growth.stamina = 1.8
        _growth.strength = 3.2
        _growth.agility = 1.2
        _growth.intellect = 2.6
        levelTo(level: 42)
        _extensions.health *= 3
        _extensions.hp = _extensions.health
        _spellsInuse = [KhalilsGaze(), KhalilsSong(), KhalilsSob()]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class KhalilsGaze:Magical {
    override init() {
        super.init()
        _name = "哈利勒的凝视"
        _speakings = ["感受死亡的凝视"]
        _quality = Quality.SACRED
    }
    override func cast(completion: @escaping () -> Void) {
        let b = _battle!
        let t = b._selectedTarget!
        let c = b._curRole
        let this = self
        c.actionCast {
            if !this.statusMissed(baseline: 25, target: t, completion: completion) {
                t.showText(text: "KILLED") {
                    t.actionDead {
                        t.die()
                        completion()
                    }
                }
            }
        }
    }
    override func findTarget() {
        let b = _battle!
        if b._playerPart.count > 1 {
            var ar = Array<BUnit>()
            for u in b._playerPart {
                if !(u._unit is Character) {
                    ar.append(u)
                }
            }
            b._selectedTarget = ar.one()
        } else if b._playerPart.count == 1 {
            b._selectedTarget = b._playerPart[0]
        } else {
            debug("gase has no target!")
        }
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class KhalilsSong:Magical {
    override init() {
        super.init()
        _name = "哈利勒的歌声"
        _speakings = ["让我的歌声陪伴着你"]
        _quality = Quality.SACRED
    }
    override func cast(completion: @escaping () -> Void) {
        let b = _battle!
        let t = b._selectedTarget!
        let c = b._curRole
        let this = self
        c.actionCast {
            if !this.statusMissed(baseline: 50, target: t, completion: completion) {
                t.silenced(completion: completion)
            }
        }
    }
    override func findTarget() {
        let b = _battle!
        b._selectedTarget = b._playerPart.one()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class KhalilsSob:Magical {
    override init() {
        super.init()
        _name = "哈利勒的哭泣"
        _speakings = ["眼泪是最真实的存在"]
        _quality = Quality.SACRED
        _rate = 0.5
    }
    override func cast(completion: @escaping () -> Void) {
        let b = _battle!
        let c = b._curRole
        let this = self
        c.actionCast {
            
            for t in b._selectedTargets {
                let damage = this.magicalDamage(t)
                t.showValue(value: damage) {
                    t.showText(text: "SPIRIT -10")
                    t._extensions.spirit -= 10
                }
//                t.hpChange(value: damage)
                
            }
            setTimeout(delay: 1.5, completion: completion)
        }
        
    }
    override func findTarget() {
        _battle._selectedTargets = getTargetsBySeats(seats: getUnitsInRowOf(seat: _battle._playerPart.one()._unit._seat))
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class NecPriest: Rizen {
    override init() {
        super.init()
        _stars.stamina = 1.7
        _stars.strength = 1.9
        _stars.agility = 1.0
        _stars.intellect = 1.3
        _name = "死灵牧师"
        _img = SKTexture(imageNamed: "nec_priest.png")
        _spellsInuse = [SpiritIntervene(), QuickHeal()]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class LoiteringBanshee: Rizen {
    override init() {
        super.init()
        _stars.stamina = 1.1
        _stars.strength = 1.0
        _stars.agility = 1.8
        _stars.intellect = 1.8
        _name = "游荡女鬼"
        _img = SKTexture(imageNamed: "loitering_banshee.png")
        _spellsInuse = [DeathScream(), Addict()]
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class DeathScream:Magical {
    override init() {
        super.init()
        _name = "死亡尖啸"
        _rate = 1.25
    }
    override func cast(completion: @escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        let damage = magicalDamage(t)
        c.actionCast {
            t.actionAttacked {
//                t.hpChange(value: damage)
                t.showValue(value: damage) {
                    completion()
                }
            }
        }
    }
    override func findTarget() {
        _battle._selectedTarget = _battle._playerPart.one()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class Addict:Magical {
    override init() {
        super.init()
        _name = "魅惑"
    }
    override func cast(completion: @escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget!
        let this = self
        c.actionCast {
            if !this.statusMissed(baseline: 50, target: t, completion: completion) {
                t.showText(text: "ADDICTED") {
                    let status = Status()
                    t.addStatus(status: status)
                    status._timeleft = 5
                    t._extensions.accuracy -= 50
                    status.timeupAction = {
                        t._extensions.accuracy += 50
                        debug("魅惑命中已恢复")
                    }
                    completion()
                }
            }
        }
    }
    override func findTarget() {
        _battle._selectedTarget = _battle._playerPart.one()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
