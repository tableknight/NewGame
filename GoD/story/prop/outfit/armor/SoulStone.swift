//
//  SoulStone.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/28.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class SoulStone: Armor {
    override init() {
        super.init()
        _name = "灵魂石"
        _outfitName = "灵魂石"
    }
    var _race = EvilType.MAN
//    var _backup = EvilType.MAN
    override func create() {
        _quality = Quality.NORMAL
        _race = seed(min: 1, max: 6)
        _description = "将种族转换为\(EvilType.getTypeLabel(type: _race))。"
    }
    override func on() {
        super.on()
//        _backup = Data.instance._char._race
        Game.instance.char._race = _race
    }
    
    override func off() {
        super.off()
        let c = Game.instance.char!
//        c._race = _backup
        if c._leftRing is RingOfDead || c._rightRing is RingOfDead {
            c._race = EvilType.RISEN
        } else {
            c._race = EvilType.MAN
        }
    }
    override func create(level: CGFloat) {
        
    }
    
    private enum CodingKeys: String, CodingKey {
        case _race
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _race = try values.decode(Int.self, forKey: ._race)
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_race, forKey: ._race)
        try super.encode(to: encoder)
    }
    
}

