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
        let role = UndeadWarrior()
        role.create(level: 50)
        es.append(role)
//        let r2 = UndeadMinion1()
//        r2.create(level: 50)
//        es.append(r2)
//        for _ in 0...2 {
//            let c = GiantWasp()
//            c.create(level: 45)
////            es.append(c)
//        }
////        es[0]._seat = BUnit.TBL
////        es[1]._seat = BUnit.TBM
////        es[2]._seat = BUnit.TBR
////        es[3]._seat = BUnit.TBM
////        es[4]._seat = BUnit.TBR
//        let t = Lewis()
//        t.create(level: 46)
//        t._seat = BUnit.TTM
//        es.append(t)
//        //        b.setEvils(evils: es)
        b.setEnemyPart(minions: es)
        let cs:Array<Creature> = [Game.instance.char]
//        for u in cs {
//            u._elementalResistance.fire += 70
//        }
        b.setPlayerPart(roles: cs)
        Game.instance.char._spellsInuse = [BearFriend()]
        
        Game.instance.curStage.addBattle(b)
        b.battleStart()
    }
    
    func realScene() {
        let stage = MyStage()
        let bs = SnowLanding4()
        bs._level = 1
        bs.create()
        let e = Emily()
        e.create(level: e._level)
//        e._spellsInuse = [SpiritIntervene(), SoulLash()]
        for m in e._minions + [e] {
            m._spellsInuse = [LowerSummon()]
        }
//        e._minions[0]._spellsInuse.append(Crazy())
        let hm = ThorsHammer()
        hm.create()
        e.addProp(p: hm)
        
        e.addMoney(num: 1000)
        
        bs.setRole(x: 5, y: 5, role: e)
        stage.loadScene(scene: bs)
        stage.createMenu()
        let bow = Bow()
        bow.create(level: 1)
        e.addProp(p: bow)
        let i = Instrument()
        i.create(level: 1)
        e.addProp(p: i)
        addChild(stage)
        let bc = BlastScroll()
        bc._count = 5
        Game.instance.char.addProp(p: bc)
        
        var props = Array<Prop>()
        props.append(bc)
        let swd = Sword()
        swd.create(level: bs._level)
        props.append(swd)
        
        
        let ss = SealScroll()
        ss._count = 5
        Game.instance.char.addProp(p: ss)
        
        let ts = TownScroll()
        ts._count = 5
        Game.instance.char.addProp(p: ts)
        
        let p = Potion()
        p._count = 5
        e.addProp(p: p)
        
        let rw = RandomWeapon()
        e.addProp(p: rw)
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
        battle()
//        let r = RoofSets()
//        addChild(r.rightConnect)
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
