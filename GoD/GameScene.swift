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
    
    func addSacredOutfit() {
        let l = Loot()
        let c = Game.instance.char!
        for i in l._sacredBows {
            let b = l.getSacredBow(id: i)
            b.create()
            c.addProp(p: b)
        }
        for i in l._sacredMarks {
            let b = l.getSacredMark(id: i)
            b.create()
            c.addProp(p: b)
        }
        for i in l._sacredRings {
            let b = l.getSacredRing(id: i)
            b.create()
            c.addProp(p: b)
        }
        
        for i in l._sacredWands {
            let b = l.getSacredWand(id: i)
            b.create()
            c.addProp(p: b)
        }
        
        for i in l._sacredBlunts {
            let b = l.getSacredBlunt(id: i)
            b.create()
            c.addProp(p: b)
        }

        for i in l._sacredSwords {
            let b = l.getSacredSword(id: i)
            b.create()
            c.addProp(p: b)
        }

        for i in l._sacredAmulets {
            let b = l.getSacredAmulet(id: i)
            b.create()
            c.addProp(p: b)
        }
        
        for i in l._sacredDaggers {
            let b = l.getSacredDagger(id: i)
            b.create()
            c.addProp(p: b)
        }
        
        for i in l._sacredShields {
            let b = l.getSacredShield(id: i)
            b.create()
            c.addProp(p: b)
        }

        for i in l._sacredEarrings {
            let b = l.getSacredEarring(id: i)
            b.create()
            c.addProp(p: b)
        }
        
        for i in l._sacredSoulstones {
            let b = l.getSacredSoulstone(id: i)
            b.create()
            c.addProp(p: b)
        }
        
        for i in l._sacredInstruments {
            let b = l.getSacredInstrument(id: i)
            b.create()
            c.addProp(p: b)
        }

    }
    
    func battle() {
        let b = FrancisBattle()
        var es = Array<Creature>()
//        let role = UndeadWarrior()
//        role.create(level: 50)
//        es.append(role)
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
        let char = Game.instance.char!
        let cs:Array<Creature> = [char] + char.getReadyMinions()
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
        let bs = SnowLanding1()
        bs.create()
        let e = Emily()
        e.create(level: e._level)
        
        e.addMoney(num: 1000)
        e._spellsInuse = [LowlevelFlame(), SummonFlower()]
        
        bs.setRole(x: 5, y: 5, role: e)
        stage.loadScene(scene: bs)
        stage.createMenu()
        addChild(stage)
        
        let bs1 = BlastScroll()
        bs1._count = 10
        e.addProp(p: bs1)
        
    }
    
    
    
    override func didMove(to view: SKView) {
        realScene()
//        addSacredOutfit()
//        echoOutfit(item: Game.instance.char._props.one() as! Outfit)
//        for p in Game.instance.char._props {
//            echoOutfit(item: p as! Outfit)
//        }
    }
    func echoSpell(spell:Spell) {
        var str = "{name:\"\(spell._name)\","
        str.append("description:\"\(spell._description)\",")
        str.append("quality:\"\(spell._quality)\",")
        str.append("cooldown:\"\(spell._cooldown)\",")
        str.append("magical:\(spell is Magical ? "true" : "false"),")
        str.append("physical:\(spell is Physical ? "true" : "false"),")
        str.append("passive:\(spell is Passive ? "true" : "false"),")
        str.append("auro:\(spell is Auro ? "true" : "false"),")
        str.append("fire:\(spell.isFire ? "true" : "false"),")
        str.append("water:\(spell.isWater ? "true" : "false"),")
        str.append("thunder:\(spell.isThunder ? "true" : "false"),")
        str.append("handSkill:\(spell is HandSkill ? "true" : "false"),")
        str.append("bowSkill:\(spell is BowSkill ? "true" : "false"),")
        str.append("curse:\(spell is Curse ? "true" : "false"),")
        str.append("summon:\(spell is Summon ? "true" : "false"),")
        str.append("close:\(spell.isClose ? "true" : "false")")
        str.append("},")
        debug(str)
    }
    
    func echoOutfit(item:Outfit) {
        let ai = ArmorInfo()
        ai.create(armor: item)
        
        var spd = "攻速 "
        var spell = ""
        if item is Sword {
            spd += "较快"
        } else if item is Dagger {
            spd += "很快"
        } else if item is Instrument {
            spd += "一般"
            spell = "随机神之技"
        } else if item is Blunt {
            spd += "很慢"
        } else if item is Bow {
            spd += "较快"
        } else if item is Wand {
            spd += "较慢"
        } else {
            spd = ""
        }
        
        if item is MagicMark {
            spell = "随机神之技"
        }
        
        var str = "{fullName:\"\(ai._nameText)\","
        str.append("name:\"\(item._name)\",")
        str.append("speed:\"\(spd)\",")
        str.append("attrs:\(ai._attrTexts),")
        str.append("spell:\"\(spell)\",")
        str.append("description:\"\(ai._desText)\",")
        str.append("price:\"\(ai._priceText)\",")
        str.append("},")
        debug(str)
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
