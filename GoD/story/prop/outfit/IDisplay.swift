//
//  IDisplay.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/9/26.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
protocol IDisplay {
    func getInfosDisplay() -> IPanelSize
}
protocol IPanelSize {
    func getDisplayWidth() -> CGFloat
    func getDisplayHeight() -> CGFloat
}
