//
//  Protocals.swift
//  GoD
//
//  Created by kai chen on 2019/12/16.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
protocol Castable {
    func selectable() -> Bool
    func cast(completion: @escaping () -> Void)
    func findTarget()
    var _battle:Battle { get set }
    var _name:String {get set}
    var targetAll:Bool {get set}
    var canBeTargetSelf:Bool {get set}
    var targetEnemy:Bool {get set}
    var isClose:Bool {get set}
    var autoCast:Bool {get set}
    var canBeTargetSummonUnit:Bool {get set}
}
protocol Showable {
    var _name:String { get set }
}
