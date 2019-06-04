//
//  attack.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/18.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Attack: Physical {
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
        let c = b._curRole
        setTimeout(delay: 0.25, completion: {
            c.actionAttack {
                self.attack {
                    completion()
                }
            }
        })
//        if c._unit is Character {
//        } else {
//            c.actionAttack {
//                self.attack {
//                    completion()
//                }
//            }
//        }
    }
    
    private func attack(completion:@escaping () -> Void) {
        let b = _battle!
        let t = b._selectedTarget!
        let c = b._curRole
        
        _damageValue = physicalDamage(t)
        
        if c.hasSpell(spell: TruePower()) {
            _damageValue *= 1.3
        }
//        let this = self
        let damage = _damageValue
        if !hadSpecialAction(t:t, completion: completion) {
            if !hasMissed(target: t, completion: completion) {
                t.attacked1()
                t.actionAttacked {
                    t.showValue(value: damage) {
                        completion()
                    }
//                    t.hpChange(value: damage)
                    if c._unit._weapon is DragonSaliva {
                        setTimeout(delay: 0.5, completion: {
                            let rate = self.fireFactor(from: c, to: t)
                            let fireDamage = damage * 0.3 * rate
                            
                            t.showValue(value: fireDamage, damageType: DamageType.FIRE, textColor: ElementColor.FIRE)
                        })
                    }
                    
                    var isGiantFang = false
                    if c._unit._weapon is GiantFang {
                        isGiantFang = true
                    }
                    
                    if c.hasSpell(spell: VampireBlood()) || isGiantFang {
                        var recoveryFactor:CGFloat = isGiantFang ? 0.2 : 0.3
                        if c._unit is Character {
                            let char = c._unit as! Character
                            if char._amulet is FangOfVampire {
                                recoveryFactor *= 2
                            }
                        }
                        let d = abs(damage * recoveryFactor)
                        setTimeout(delay: 0.5, completion: {
                            c.showValue(value: d)
                        })
//                        c.hpChange(value: d)
                    }
                    
                    if c._unit._weapon is LazesPedicureKnife {
                        if self.d7() {
                            setTimeout(delay: 0.5, completion: {
                                c.showText(text: "AGILITY +1")
                                c.agilityChange(value: 1)
                            })
                        }
                    }
                }
            }
        }
    }
    
    func attackMore(completion:@escaping () -> Void) {
        let b = _battle!
        let t = b._selectedTarget!
        let c = b._curRole
        
        if !(c._unit._weapon is IdyllssHand) {
            completion()
            return
        }
        
        if t.isDead() {
            completion()
            return
        }
        
        if seed() < 15 {
            let this = self
            c.showText(text:"IDYLLS POWER")
            c.actionAttack {
                this.attack {
                    completion()
                }
            }
            return
        }
        
        completion()
    }
    
}
