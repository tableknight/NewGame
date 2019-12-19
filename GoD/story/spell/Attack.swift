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
        _id = -1
    }
    override func findTarget() {
        super.findTarget()
//        if _battle._playerUnit.weaponIs(FollowOn.EFFECTION) && _battle._curRole.playerPart && !_battle._curRole.isBlocked() {
//            _battle._selectedTarget = _battle._lockedTarget
//        }
    }
    override func cast(completion:@escaping () -> Void) {
        let b = _battle
        let t = b._selectedTarget!
        let c = b._curRole
        setTimeout(delay: 0.25, completion: {
            c.actionAttack {
                self.attack {
//                    if !t.isDead() && c.weaponIs(IdyllssHand.EFFECTION) && self.d7() {
//                        self.attack {
//                            completion()
//                        }
//                    } else {
//                        completion()
//                    }
                }
            }
        })
    }
    
    private func attack(completion:@escaping () -> Void) {
        let b = _battle
        let t = b._selectedTarget!
        let c = b._curRole
        
        _damageValue = physicalDamage(t)
        
//        if c.hasSpell(spell: TruePower()) {
//            _damageValue *= 1.3
//        }
//        let this = self
        let damage = _damageValue
        if !hadSpecialAction(t:t, completion: completion) {
            if !hasMissed(target: t, completion: completion) {
                if c.isClose() {
                    t.attacked1()
//                    t.hit1()
                } else {
                    t.hit2()
                }
                t.actionAttacked {
                    t.showValue(value: damage) {
                        completion()
                        
                    }
//                    t.hpChange(value: damage)
//                    if c.weaponIs(BansMechanArm.EFFECTION) {
//                        if self.d4() {
//                            let s = Status()
//                            s._timeleft = 2
//                            s._labelText = "R"
//                            s._type = BansMechanArm.EFFECTION
//                            t.addStatus(status: s)
//                        }
//                    } else if c.weaponIs(DragonSaliva.EFFECTION) {
//                        setTimeout(delay: 0.5, completion: {
//                            let rate = self.fireFactor(from: c, to: t)
//                            let fireDamage = damage * 0.3 * rate
//                            
//                            t.showValue(value: fireDamage, damageType: DamageType.FIRE, textColor: ElementColor.FIRE)
//                        })
//                    } else
//                        if c.weaponIs(LazesPedicureKnife.EFFECTION)  {
//                        if self.d7() {
//                            setTimeout(delay: 0.5, completion: {
//                                c.showText(text: "AGILITY +1")
//                                c.agilityChange(value: 1)
//                            })
//                        }
//                    } else if c.weaponIs(DeepCold.EFFECTION) {
//                        if self.d3() {
//                            t.freezing()
//                        }
//                    } else if c.weaponIs(FollowOn.EFFECTION) {
//                        self._battle._lockedTarget = t
//                    }
//                    
//                    var isGiantFang = false
//                    if c.weaponIs(GiantFang.EFFECTION) {
//                        isGiantFang = true
//                    }
//                    
//                    if c.hasSpell(spell: VampireBlood()) || isGiantFang {
//                        var recoveryFactor:CGFloat = isGiantFang ? 0.2 : 0.3
//                        if c.amuletIs(FangOfVampire.EFFECTION) {
//                            recoveryFactor *= 2
//                        }
//                        let d = abs(damage * recoveryFactor)
//                        setTimeout(delay: 0.5, completion: {
//                            c.showValue(value: d)
//                        })
////                        c.hpChange(value: d)
//                    }
                    
                }
            }
        }
    }
    
//    func attackMore(completion:@escaping () -> Void) {
//        let b = _battle!
//        let t = b._selectedTarget!
//        let c = b._curRole
//
//        if !(c._unit._weapon is IdyllssHand) {
//            completion()
//            return
//        }
//
//        if t.isDead() {
//            completion()
//            return
//        }
//
//        if seed() < 15 {
//            let this = self
//            c.showText(text:"IDYLLS POWER")
//            c.actionAttack {
//                this.attack {
//                    completion()
//                }
//            }
//            return
//        }
//
//        completion()
//    }
    
}
