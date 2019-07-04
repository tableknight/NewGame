//
//  FireMark.swift
//  GoD
//
//  Created by kai chen on 2019/7/4.
//  Copyright © 2019 Chen. All rights reserved.
//

class FireMark:MagicMark {
    override init() {
        super.init()
        _name = "火焰纹章"
        _description = "延长燃烧效果一回合"
        _level = 43
        _chance = 27
        _quality = Quality.SACRED
        price = 210
    }
    override func create() {
        _spell = [LavaExplode(), Combustion(), BurnHeart(), BurningOut(), FireRain(), FireBreath()].one()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
