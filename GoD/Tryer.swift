//
//  Tryer.swift
//  GoD
//
//  Created by kai chen on 2019/4/20.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class Tryer: NSObject {
    var _name: String = ""
    
    override init() {
        super.init()
        
    }
    
}
class SubTryer:Tryer, Codable {
    override init() {
        super.init()
        sib = SibTryer()
        sib._sibName = "aa"
        _name = "asdsasd"
        _subName = "sub"
    }
    
    private enum CodingKeys: String, CodingKey {
        case _subName
        case sib
    }
    
//    required init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        _subName = try values.decode(String.self, forKey: ._subName)
//        sib = try values.decode(SibTryer.self, forKey: .sib)
////        _attrs = try values.decode(Array.self, forKey: ._attrs)
////        _name = try values.decode(String.self, forKey: ._name)
//        try super.init(from: decoder)
//    }
    
    var _subName = "asd"
    var sib:SibTryer!
//    override func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(_subName, forKey: ._subName)
//        try container.encode(sib, forKey: .sib)
////        try container.encode(_attrs, forKey: ._attrs)
//        try super.encode(to: encoder)
//    }
//    static func getData1() -> SubTryer? {
//        let us = UserDefaults.standard
//        if let data = us.data(forKey: "tryer") {
//            return try? JSONDecoder().decode(self, from: data)
//        }
//        return nil
//    }
}
class SibTryer: Tryer, Codable {
    override init() {
        super.init()
        _sibName = "sib"
    }
    private enum CodingKeys: String, CodingKey {
        case _sibName
    }
    var _sibName = ""
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _sibName = try values.decode(String.self, forKey: ._sibName)
//        try super.init(from: decoder)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_sibName, forKey: ._sibName)
//        try super.encode(to: encoder)
    }
}
//class TTer:NSObject, Codable {
//    override init() {
//        super.init()
//    }
//    private enum CodingKeys: String, CodingKey {
//        case _img
//    }
//    var _img = SKTexture()
//    required init(from decoder: Decoder) throws {
////        let values = try decoder.container(keyedBy: CodingKeys.self)
////        _img = try values.decode(SKTexture.self, forKey: ._img)
//    }
//    func encode(to encoder: Encoder) throws {
//        
//    }
//}
