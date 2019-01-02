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
    
    func battle() {
        let b = Battle()
        var es = Array<Creature>()
        
        for _ in 0...3 {
            let c = GiantWasp()
            c.create(level: 20)
            es.append(c)
        }
        //        b.setEvils(evils: es)
        b.setEnimyPart(minions: es)
        b.setPlayerPart(roles: [Game.instance.char] + Game.instance.char.getReadyMinions())
        //        b.setRoles(roles: [Game.instance.char] + Game.instance.char._minions)
        
        let potion = Potion()
        potion._count = 1
        Game.instance.char.addProp(p: potion)
        addChild(b)
        b.battleStart()
    }
    
    func realScene() {
        let stage = MyStage()
        let bs = SelfHome()
        bs.create()
        let e = Emily()
        e.create()
        bs.setRole(x: 5, y: 5, role: e)
        stage.loadScene(scene: bs)
        stage.createMenu()
        //        stage.hideUI()
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
        let bc = BlastScroll()
        bc._count = 5
        Game.instance.char.addProp(p: bc)
//        let o = SKShapeNode(rectOf: CGSize(width: 18, height: 18))
//        o.lineWidth = 4
//        o.zPosition = 1200
//        addChild(o)
        
        var props = Array<Prop>()
        props.append(bc)
        let swd = Sword()
        swd.create(level: 20)
        props.append(swd)
        
        
        let ss = SealScroll()
        ss._count = 5
        Game.instance.char.addProp(p: ss)
        
        let ts = TownScroll()
        ts._count = 5
        Game.instance.char.addProp(p: ts)
        
    }
    
    override func didMove(to view: SKView) {
//        let sp = SelecProfession()
//        sp.create()
//        addChild(sp)
//        let rsp = RoleSelectPanel()
//        rsp.create()
//        addChild(rsp)
//        let si = SelectMinion()
//        si.create()
////        let ic = ImageComponent()
////        let p = Game.instance.pictureActor1
////        ic.create(image: p)
//        addChild(si)
//        let cf = CreationFlow()
//        cf.create()
//        addChild(cf)
        realScene()
//        let p = AcientRoadSelection()
//        p.create()
//        addChild(p)
//        let _ = Game.instance.curStage.showDialog(img: Game.instance.pictureActor3.getCell(7, 4),
//                                                  text: "你好，这是远古石碑，是前往无尽深渊的唯一入口！触摸石碑的中心，与石碑产生共鸣。",
//                                                  name: "神官苏维亚")
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
