//
//  TruePower.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/21.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class TruePower: Passive {
    
    override init() {
        super.init()
        _id = Spell.TruePower
        _name = "天神下凡"
        _description = "提升10%基础力量"
        _quality = Quality.RARE
        
    }
//    private enum CodingKeys: String, CodingKey {
//        case _value
//    }
    required init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        _value = try values.decode(CGFloat.self, forKey: ._value)
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(_value, forKey: ._value)
        try super.encode(to: encoder)
    }
//    private var _value:CGFloat = 0
//    override func on() {
//        _value = Game.instance.char._mains.strength * 0.1
//        Game.instance.char.strengthChange(value: _value)
//    }
//    override func off() {
//        Game.instance.char.strengthChange(value: -_value)
//    }
}
