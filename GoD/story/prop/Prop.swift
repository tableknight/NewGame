//
//  Prop.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/25.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Prop:Core, IDisplay {
    func getInfosDisplay() -> IPanelSize {
        return ItemInfo()
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _name = try values.decode(String.self, forKey: ._name)
        _description = try values.decode(String.self, forKey: ._description)
        _level = try values.decode(CGFloat.self, forKey: ._level)
        _price = try values.decode(Int.self, forKey: ._price)
        _quality = try values.decode(Int.self, forKey: ._quality)
        _count = try values.decode(Int.self, forKey: ._count)
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_name, forKey: ._name)
        try container.encode(_description, forKey: ._description)
        try container.encode(_level, forKey: ._level)
        try container.encode(_price, forKey: ._price)
        try container.encode(_quality, forKey: ._quality)
        try container.encode(_count, forKey: ._count)
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
    }
    private enum CodingKeys: String, CodingKey {
        case _name
        case _description
        case _level
        case _price
        case _quality
        case _count
    }
    var _showChar = ""
    var _name:String = ""
    var _description:String = ""
    var _level:CGFloat = 1
    var _img = SKTexture()
    var _price = 0
    var _storePrice = 0
    var _priceRate = 0.25
    var _type = ""
    var _count = 1
    var _quality = Quality.NORMAL
    var _priceType = 0
    var countless = true
    var initialized = false
    func create() {}
    func create(level:CGFloat) {}
    var sellingPrice:Int {
        set {
            _storePrice = newValue
            _price = newValue / 2
        }
        get {
            return _storePrice
        }
    }
    var price:Int {
        set {
            if _quality == Quality.SACRED {
                _price = (newValue.toFloat() * 0.4).toInt()
            } else {
                _price = newValue
            }
            _storePrice = _price * 2
        }
        get {
            return _price
        }
    }
}
