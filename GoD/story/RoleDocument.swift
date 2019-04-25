//
//  RoleDocument.swift
//  GoD
//
//  Created by kai chen on 2019/4/25.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class RoleDocument:NSObject, Codable {
    override init() {
        super.init()
    }
    var _name = ""
    var _level = 0
    var _imgUrl = ""
    var _key = ""
}
