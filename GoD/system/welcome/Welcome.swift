//
//  Welcome.swift
//  GoD
//
//  Created by kai chen on 2019/4/25.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class Welcome: SKSpriteNode {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        if _enterLabel.contains(touchPoint!) {
            self.removeFromParent()
            let sd = SelectDocument()
            sd.create()
            _gameScene.addChild(sd)
            sd._gameScene = _gameScene
            return
        }
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        isUserInteractionEnabled = true
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func create() {
        
        _layer1.size = CGSize(width: cellSize * 3, height: cellSize * 3)
        _layer1.position.y = cellSize * 2
        _layer1.zPosition = 20
        let bu = BUnit()
        let ao = AnimationOption()
        ao.frameSize = 5
        ao.duration = 100
        ao.startX = 1
        ao.startY = 3
        ao.imgUrl = "Darkness2.png"
        ao.single = true
        ao.repeatForever = true
        ao.targetLayer = _layer1
        bu.animate(ao: ao)
        addChild(_layer1)
        
//        _enterLabel.fontSize = 24
//        _enterLabel.text = "进入游戏"
//        addChild(_enterLabel)
        
        let bg = SKSpriteNode(texture: SKTexture(imageNamed: "welbg"))
        bg.size = CGSize(width: cellSize * 14, height: cellSize * 25)
        bg.zPosition = 1
        bg.xAxis = cellSize * 0.5
//        bg.alpha = 0.25
        addChild(bg)
        
        _enterLabel.texture = SKTexture(imageNamed: "enter")
        _enterLabel.size = CGSize(width: cellSize * 3, height: cellSize)
        addChild(_enterLabel)
        
        let title = SKSpriteNode(texture: SKTexture(imageNamed: "title"))
        title.size = CGSize(width: cellSize * 10, height: cellSize * 4)
        title.position.y = cellSize * 8
        title.zPosition = 50
        addChild(title)
        
        let imgs = [
                    "role_1",
                    "role_2",
                    "role_3",
                    "role_4",
                    "role_5",
                    "role_6",
                    "role_7",
                    "role_8",
                    "role_9",
                    "role_10",
                    "role_11",
                    "role_12",
                    "Vanteron",
                    "seller",
                    "Suvya",
                    "Ranliya",
                    "priest",
                    "Oldlin",
                    "Mei_lulu","Jade","Ginly","family","boy2","boy1",
        ]
        let angels = ["aiki","death_angel","miki","son_of_micalu1","son_of_micalu2"]
        let demons = ["blood_bat","blood_queen","crawler","death_god","dream_sucker",
                      "evil_curse","evil_spirit","george_servant1",
                      "george_servant2","angela","ayer","gerute",
                      "hell_baron","idlir_bride","Kodagu","lanis",
                      "shuran","slime","underworld_rider"]
        let men = ["critical_joker","dark_ninja","dark_wizard","flower_fairy",
                   "forest_guard","lost_elf","luki","niro",
                   "robber_minion","the_fallen","wander_wizard"]
        let rizen = ["bone_wizard","dead_spirit","hell_rider","HellBaron",
                     "mummy","nec_priest","nightmare","red_eye_demon","soul_seaker","waste_walker"]
        let nature = ["bear_warrior","child_lizard","cow_cow",
                      "crazy_plant","fire_servant","green_spirit",
                      "ice_beast","snow_spirit","tree_spirit"]
        let all = imgs + angels + demons + men + rizen + nature
        _imgs = all
        execAnima(i: 0)
        
//        createMovingRole(img: "role_1")
    }
    var _gameScene:GameScene!
    private var _imgs:Array<String>!
    private var _layer1 = SKSpriteNode()
    private var _enterLabel = SKSpriteNode()
    private var _delay:CGFloat = 2.5
    private func execAnima(i:Int) {
        setTimeout(delay: _delay, completion: {
            self.createMovingRole(img: self._imgs[i])
            if i >= self._imgs.count - 1 {
                return
            } else {
                let next = i + 1
                self.execAnima(i: next)
            }
        })
    }
    
    internal var _wait = SKAction.wait(forDuration: TimeInterval(0.5))
    
    private func createMovingRole(img:String) {
        let role = SKSpriteNode()
        let t = SKTexture(imageNamed: img)
        role.texture = t.getCell(1, 1)
        let size = cellSize * 1.5
        role.size = CGSize(width: size, height: size)
        
        let move1 = SKAction.setTexture(t.getCell(0, 1))
        let move2 = SKAction.setTexture(t.getCell(2, 1))
        let go = SKAction.repeatForever(SKAction.sequence([move1, _wait, move2, _wait, move1]))
        role.run(go)
        
        let movingLayer = SKSpriteNode()
        movingLayer.position.y = cellSize * -10
        movingLayer.size = CGSize(width: size, height: size)
        movingLayer.zPosition = 100
        movingLayer.addChild(role)
        
        movingLayer.xAxis = cellSize * 10
        
        let movingAction = SKAction.move(by: CGVector(dx: -cellSize * 20, dy: 0), duration: TimeInterval(20))
        movingLayer.run(movingAction) {
            movingLayer.removeFromParent()
        }
        
        addChild(movingLayer)
    }
}
