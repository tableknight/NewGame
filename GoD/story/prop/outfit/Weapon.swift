//
//  Weapon.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/25.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Weapon:Outfit {
    private enum CodingKeys: String, CodingKey {
        case _attackSpeed
        case isClose
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _attackSpeed = try values.decode(CGFloat.self, forKey: ._attackSpeed)
        isClose = try values.decode(Bool.self, forKey: .isClose)
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_attackSpeed, forKey: ._attackSpeed)
        try container.encode(isClose, forKey: .isClose)
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
    }
    var isClose = true
    var _attackSpeed:CGFloat = 1
    func getAttack() -> CGFloat {
        for a in _attrs {
            if a is AttackAttribute {
                return a._value
            }
        }
        return 0
    }
}
