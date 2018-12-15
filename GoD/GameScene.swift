//
//  GameScene.swift
//  GoD
//
//  Created by kai chen on 2018/12/8.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
//    private var label : SKLabelNode?
//    private var spinnyNode : SKShapeNode?
    
    func addOutfit() {
        for _ in 0...30 {
            let sword = Ring()
            sword.create(level: 20)
            Game.instance.char.addProp(p: sword)
        }
    }
    
    override func didMove(to view: SKView) {
        let bs = SceneMeadow()
        bs.create()
        let stage = MyStage()
//        stage.loadScene(scene: bs)
        stage.createMenu()
        addChild(stage)
//        let panel = RolePanel()
//        panel.create(unit: Game.instance.char)
//        stage.showPanel(panel)
//        let panel = SpellPanel()
//        panel.create(role: Game.instance.char)
//        stage.addChild(panel)
//        let panel = MinionsList()
//        panel.create(minions: Game.instance.char._minions)
//        stage.showPanel(panel)
        
//        let mc = MinionComponent()
//        mc.create(minion: Game.instance.char._minions[0])
//        addChild(mc)
        
        let o = SKShapeNode(rectOf: CGSize(width: 18, height: 18))
        o.lineWidth = 4
        o.zPosition = 1200
        addChild(o)
        
//        addOutfit()
        
        let potion = Potion()
        potion._count = 1
        Game.instance.char.addProp(p: potion)
        
//        let ii = ItemInfo()
//        ii.create(item: potion)
//        addChild(ii)
//        
//        Game.instance.char._extensions.hp = 1
        
//        let rl = RoleList()
//        rl.create(list: Game.instance.char._minions + [Game.instance.char] + [Game.instance.char])
//        addChild(rl)
        
//        let ai = ArmorInfo()
//        ai.create(armor: Game.instance.char._props[0] as! Outfit)
//        addChild(ai)
        
//        let op = OutfitPanel()
//        op.create()
//        addChild(op)
//        let spell = AttackReturnBack()
//        let p = SpellInfo()
//        p.zPosition = 100
//        p.create(spell: spell)
//        addChild(p)
//        addChild(spell.getInfosDisplay() as! SKSpriteNode)
        
//        // Get label node from scene and store it for use later
//        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
//        if let label = self.label {
//            label.alpha = 0.0
//            label.run(SKAction.fadeIn(withDuration: 2.0))
//        }
//
//        // Create shape node to use during mouse interaction
//        let w = (self.size.width + self.size.height) * 0.05
//        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
//
//        if let spinnyNode = self.spinnyNode {
//            spinnyNode.lineWidth = 2.5
//
//            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
//            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
//                                              SKAction.fadeOut(withDuration: 0.5),
//                                              SKAction.removeFromParent()]))
//        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.green
//            self.addChild(n)
//        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.blue
//            self.addChild(n)
//        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.red
//            self.addChild(n)
//        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
//
//        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
