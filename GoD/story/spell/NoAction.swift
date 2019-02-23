//
//  NoAction.swift
//  GoD
//
//  Created by kai chen on 2019/2/21.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class NoAction: Spell {
    override init() {
        super.init()
    }
    override func cast(completion: @escaping () -> Void) {
        completion()
    }
}
