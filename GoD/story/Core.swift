//
//  Core.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/1/14.
//  Copyright © 2018年 Chen. All rights reserved.
//
import SpriteKit
class Core:NSObject{
    override init() {
        super.init()
    }
    func seed(min:Int = 0, max:Int = 101) -> Int {
        return Int(arc4random_uniform(UInt32(max - min))) + min
    }
    func seed(to:Int) -> Int {
        return Int(arc4random_uniform(UInt32(to)))
    }
    func yon() -> Bool {
        return seed() < 50
    }
    func lowThan(_ i:Int) -> Bool {
        let sed = seed()
        return sed < i
    }
    
    func aQuarter() -> Bool {
        return seed() < 25
    }
    func d2() -> Bool {
        return arc4random_uniform(2) == 0
    }
    func d3() -> Bool {
        return arc4random_uniform(3) == 0
    }
    func d4() -> Bool {
        return arc4random_uniform(4) == 0
    }
    func d7() -> Bool {
        return arc4random_uniform(7) == 0
    }
    func d20() -> Bool {
        return arc4random_uniform(20) == 0
    }
    func d100() -> Bool {
        return arc4random_uniform(20) == 0
    }
}
