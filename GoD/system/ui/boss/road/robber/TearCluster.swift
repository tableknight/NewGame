////
////  TearCluster.swift
////  GoD
////
////  Created by kai chen on 2019/7/13.
////  Copyright © 2019 Chen. All rights reserved.
////
//
//import SpriteKit
//class TearCluster: Item {
//    override init() {
//        super.init()
//        usable = true
//        usableInBattle = false
//        _price = 1
//        _storePrice = 1
//        _name = "眼泪精华"
//        _description = "一块大的眼泪晶体。可以获得若干个天使之泪"
//        _quality = Quality.RARE
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//    override func use() {
//        removeFromChar()
//        let char = Game.instance.char!
//        let c = seed(to: 20)
//        for _ in 0...c {
//            char.addProp(p: TheWitchsTear())
//        }
//    }
//}
//
