//
//  Structure.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/1/14.
//  Copyright © 2018年 Chen. All rights reserved.
//
import SpriteKit
struct Mains:Codable {
    var stamina:CGFloat = 0
    var strength:CGFloat = 0
    var agility:CGFloat = 0
    var intellect:CGFloat = 0
}
struct Extensions:Codable {
    var attack:CGFloat
    var defence:CGFloat
    var speed:CGFloat
    var accuracy:CGFloat
    var critical:CGFloat
    var destroy:CGFloat
    var avoid:CGFloat
    var spirit:CGFloat
    var hp:CGFloat
    var health:CGFloat
    var mp:CGFloat
    var mpMax:CGFloat
    var mind:CGFloat
}
struct Elemental:Codable {
    var fire:CGFloat
    var water:CGFloat
    var thunder:CGFloat
}
struct Magic:Codable {
    var damage:CGFloat
    var resistance:CGFloat
}
