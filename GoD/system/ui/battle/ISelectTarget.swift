//
//  ISelectTarget.swift
//  GoD
//
//  Created by kai chen on 2019/1/3.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
protocol ISelectTarget {
    var targetAll:Bool{get}
    var targetEnemy:Bool{get}
    var canBeTargetPlayer:Bool{get}
    var canBeTargetSelf:Bool{get}
    var isClose:Bool{get}
}
