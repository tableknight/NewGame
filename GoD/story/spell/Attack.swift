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
        if _battle._playerUnit.weaponIs(Sacred.FollowOn) && _battle._curRole.playerPart && !_battle._curRole.isBlocked() {
            _battle._selectedTarget = _battle._lockedTarget
        }
    }
    override func cast(completion:@escaping () -> Void) {
        let b = _battle
        let t = b._selectedTarget!
        let c = b._curRole
        setTimeout(delay: 0.25, completion: {
            c.actionAttack {
                self.attack {
                    if !t.isDead() && c.weaponIs(Sacred.IdyllssHand) && self.d7() {
                        self.attack {
                            completion()
                        }
                    } else {
                        completion()
                    }
                }
            }
        })
    }
    
    private func attack(completion:@escaping () -> Void) {
        let b = _battle
        let t = b._selectedTarget!
        let c = b._curRole
        
        _damageValue = physicalDamage(t)
        
        if c.hasSpell(id: Spell.TruePower) {
            _damageValue *= 1.3
        }
        let damage = _damageValue
        if !hadSpecialAction(t:t, completion: completion) {
            if !hasMissed(target: t, completion: completion) {
                if c.isClose() {
                    t.attacked1()
                } else {
                    t.hit2()
                }
                t.actionAttacked {
                    t.showValue(value: damage) {
                        completion()
                        
                    }
                    if c.weaponIs(Sacred.BansMechanArm) {
                        if self.d4() {
                            let s = Status()
                            s._timeleft = 2
                            s._labelText = "R"
                            s._type = Sacred.BansMechanArm
                            t.addStatus(status: s)
                        }
                    } else if c.weaponIs(Sacred.DragonSaliva) {
                        setTimeout(delay: 0.5, completion: {
                            let rate = self.fireFactor(from: c, to: t)
                            let fireDamage = damage * 0.3 * rate
                            
                            t.showValue(value: fireDamage, damageType: DamageType.FIRE, textColor: ElementColor.FIRE)
                        })
                    } else
                        if c.weaponIs(Sacred.LazesPedicureKnife)  {
                        if self.d7() {
                            setTimeout(delay: 0.5, completion: {
                                c.showText(text: "+1")
                                c._valueUnit.agilityChange(value: 1)
                            })
                        }
                        } else if c.weaponIs(Sacred.DeepCold) {
                        if self.d3() {
                            t.freezing()
                        }
                        } else if c.weaponIs(Sacred.FollowOn) {
                        self._battle._lockedTarget = t
                    }
                    
                    var isGiantFang = false
                    if c.weaponIs(Sacred.GiantFang) {
                        isGiantFang = true
                    }
                    
                    if c.hasSpell(id: Spell.VampireBlood) || isGiantFang {
                        var recoveryFactor:CGFloat = isGiantFang ? 0.2 : 0.3
                        if c.amuletIs(Sacred.FangOfVampire) {
                            recoveryFactor *= 2
                        }
                        let d = abs(damage * recoveryFactor)
                        setTimeout(delay: 0.5, completion: {
                            c.showValue(value: d)
                        })
                    }
                    
                }
            }
        }
    }
    
}
