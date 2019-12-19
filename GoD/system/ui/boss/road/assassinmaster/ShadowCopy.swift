//
//  ShadowCopy.swift
//  GoD
//
//  Created by kai chen on 2019/7/8.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class ShadowCopy:Magical, BossOnly {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _name = "影分身"
        _description = "召唤两个不具有攻击力的影分身，影分身承受200%的额外伤害"
        _quality = Quality.SACRED
        _cooldown = 5
        autoCast = true
    }
    override func cast(completion: @escaping () -> Void) {
//        let b = _battle!
        let c = _battle._curRole
        c.actionCast {
            self.copyCast()
            self.copyCast()
            setTimeout(delay: 1.8, completion: completion)
        }
    }
    private func copyCast() {
        let b = _battle
        let c = _battle._curRole
        let copy = SummonUnit()
        copy._level = c._unit._level
        copy._img = c._unit._img
        
        copy._extensions.health = c.getHealth()
        copy._extensions.hp = c.getHp()
        copy._extensions.defence = c._unit._extensions.defence
        copy._extensions.accuracy = c._unit._extensions.accuracy
        copy._extensions.attack = 0
        copy._extensions.spirit = c._unit._extensions.spirit
        copy._extensions.speed = c._unit._extensions.speed
        copy._extensions.avoid = c._unit._extensions.avoid
        copy._extensions.mind = c._unit._extensions.mind
        copy._revenge = 0
        copy._rhythm = 0
        copy._name = "影分身"
//        copy._spellsInuse = [Disappear(), ThrowWeapon(), Observant(), FlashPowder(), BossAttack()]
        copy._sensitive = 25
        //            copy.hasAction = false
        let seats = b.getEmptySeats(top: !b._curRole.playerPart)
        copy._seat = seats.one()
        let u = b._curRole.playerPart ? b.addPlayerMinion(unit: copy) : b.addEnemy(unit: copy)
        if c._unit is Boss {
            u.setImg(img: c._unit._img)
            u._charNode.size = CGSize(width: u._charSize, height: u._charSize)
        }
        u.actionSummon(completion: {})
    }
    override func selectable() -> Bool {
        if _battle._curRole.playerPart {
            return _battle._playerPart.count < 5
        } else {
            return _battle._enemyPart.count < 5
        }
    }
}


