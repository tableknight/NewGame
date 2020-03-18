//
//  GameScene.swift
//  GoD
//
//  Created by kai chen on 2018/12/8.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor.black
        Game.instance.gameScene = self
        Game.calcCellSize()
        
        let we = Welcome()
        we._gameScene = self
        we.create()
        addChild(we)
        
    }
    
    
}
