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
    var _b = Button()
    override func didMove(to view: SKView) {
        Game.instance.scene = self
        Game.calcCellSize()
        Mode.debug = true
//        let lighting = Game.instance.pictureThunder1.getNode(0, 1, 1, 2)
//        lighting.size = CGSize(width: 70 * 2, height: 70 * 4)
//        lighting.anchorPoint = CGPoint(x: 0.5, y: 0)
////        lighting.zPosition = _charNode.zPosition + 20
//        addChild(lighting)
        
        realScene()
//
//        let b = Button()
//        b.text = "aa"
//        b.zPosition = 1024
//        addChild(b)
//        _b = b
        

//        homePage()
//        for _ in 0...4 {
//            let s = HellBaron()
//            s.create(level: 1)
//            Game.instance.char._minions.append(s)
//        }
//        for _ in 0...9 {
//            let s = HellBaron()
//            s.create(level: 1)
//            Game.instance.char._storedMinions.append(s)
//        }
//        let m = MinionTradingPanel()
//        m.create()
//        Game.instance.curStage.showPanel(m)
    }
//    func getTryer() -> Tryer? {
//        let us = UserDefaults.standard
//        if let data = us.data(forKey: "tryer1") {
//            return try? JSONDecoder().decode(Tryer.self, from: data)
//        }
//        return nil
//    }
    func load() -> Array<RoleDocument>? {
        let us = UserDefaults.standard
        if let data = us.data(forKey: "bow") {
            return try? JSONDecoder().decode(Array.self, from: data)
        }
        return nil
    }
    func save(b:Array<RoleDocument>) {
        if let data = try? JSONEncoder().encode(b) {
            let us = UserDefaults.standard
            us.set(data, forKey: "bow")
            us.synchronize()
        }
    }
    func homePage() {
        let welcome = Welcome()
        welcome.create()
        welcome._gameScene = self
        addChild(welcome)
        
    }
//    func save1(st:Tryer) {
//        
//        if let data = try? JSONEncoder().encode(st) {
//            
//            let us = UserDefaults.standard
//            
//            us.set(data, forKey: "tryer1")
//            us.synchronize()
//        }
//    }

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
        let b = GiantSpiritBattle()
        var es = Array<Creature>()
        
        
//        let p = CowCow()
//        p.create(level: 47)
//        p._sensitive = 100
//
//        p._spellsInuse = [DancingDragon()]
//        es.append(p)
        
//        for _ in 0...4 {
//            let p1 = CowCow()
//            p1.create(level: 1)
//            p1._sensitive = 100
//
//            p1._spellsInuse = [NoAction()]
//            es.append(p1)
//        }
        
        b.setEnemyPart(minions: es)
        
//
//        for s in b._enemyPart {
//            s._unit._extensions.speed = 1
////            let status = Status()
////            status._type = Status.TURN_ATTACK
////            status._timeleft = 5
////            s.addStatus(status: status)
//        }
        
        
        
        let char = Game.instance.char!
//        char._extensions.attack = 300
//        char._extensions.spirit = 300
//        char._spellsInuse = [LowerSummon(), WaterCopy(), HighLevelSummon()]
//        char._spellsInuse = [Zealot(), FireRain(), SuperWater(), SixShooter()]
//        char._revenge = 40
        char._extensions.spirit = 2000
        char._extensions.hp = 10000
        char._extensions.health = 10000
        char._spellsInuse = [LowlevelFlame()]
        
//        let sb = Bow()
//        sb.create(level: 10)
//        char._weapon = sb
        
//        let cs:Array<Creature> = [char]
        let cs:Array<Creature> = [char] + char.getReadyMinions()
        b.setPlayerPart(roles: cs)
        
        Game.instance.curStage.addBattle(b)
        b.battleStart()
    }
    
    func realScene() {
        let stage = MyStage()
        let bs = CenterCamping()
        bs.create()
        
        
//        let e = Game.load(key: "char")!
        
        
        let e = Emily()
        e.create(level: e._level)
        e.addMoney(num: 1000)
//        e._spells = [TruePower()]
//        let bow = Bow()
//        bow.create(level: 1)
//        e.addProp(p: bow)
        
        
        bs.setRole(x: 5, y: 7, role: e)
//        bs.setRole(x: bs._portalPrev.x, y: bs._portalPrev.y, role: e)
        stage.loadScene(scene: bs)
        stage.createMenu()
        addChild(stage)
        
        e._level = 1
        
        let aa = HellNight()
        aa.create(level: e._level)
//        aa._seat = BUnit.BTL
        e._minions.append(aa)
        for _ in 0...4 {
            let sn = SnowLady()
            sn.create(level: e._level)
//            sn._seat = BUnit.BTR
            e._minions.append(sn)
        }
        
//        e.strengthChange(value: 100)
//        e.agilityChange(value: 70)
//        e.staminaChange(value: 60)
//        e.intellectChange(value: 0)
        
        e._dungeonLevel = e._level.toInt()
        e._spellCount = 3
        
        e.hasShield = true
        e.hasMark = true
        
        let w = Sword()
        w.create(level: e._level)
        e.addProp(p: w)
        
        let r = RingOfDeath()
        r.create()
        e.addProp(p: r)
        
        let tss = TransportScroll()
        tss._count = 10
        e._props.append(tss)
        
        for _ in 0...1 {
            
            let r2 = Ring()
            r2.create(level: e._level)
            e.addProp(p: r2)
        }
        
        let a = Amulet()
        a.create(level: e._level)
        e.addProp(p: a)
        
        let cm = CreationMatrix()
        cm.create()
        e.addProp(p: cm)
        
        let s = Shield()
        s.create(level: e._level)
        e.addProp(p: s)
        e.addProp(p: WordlessBook())
        e.addProp(p: ThiefPocket())
        e.addProp(p: TearCluster())
        e._spellsInuse = [SummonFlower()]
//
        
//        let gt = SealScroll()
//        gt._count = 10
//        e.addProp(p: gt)
////
        let ggg = TownScroll()
        ggg._count = 10
        e.addProp(p: ggg)
////
        let po = Potion()
        po._count = 10
        e.addProp(p: po)
//        e._minionsCount = 1
//        e._dungeonLevel = 99
//
        
        let bow = Bow()
        bow.create(level: e._level)
        e.addProp(p: bow)
        
        let t = TheWitchsTear()
        t._count = 1000
        e._props.append(t)
        e.addProp(p: Loot().getSpellBook())
//        let r1 = HellBaron()
//        r1.create(level: 1)
//        e._minions.append(r1)
//
//        let r2 = DarkNinja()
//        r2.create(level: 1)
//        e._minions.append(r2)
//
//        let r3 = HellNight()
//        r3.create(level: 1)
//        e._minions.append(r3)
//
//        let r4 = ForestGuard()
//        r4.create(level: 1)
//        e._minions.append(r4)
        
        
        e.addProp(p: LevelUpScroll())
//        e._spellsInuse = [BallLighting(), Refresh()]
//        let rs = [e] + e._minions
//        for r in rs {
////            r._extensions.spirit = 300
////            r._spellsInuse = [FireRain(), Refresh()]
//        }
        
    }
    
    private func startNewGame() {
        
    }
    
    private func welcome() {
        let flow = CreationFlow()
        flow.create()
        flow.gameScene = self
        flow.actionCreate = {
            flow.removeFromParent()
//            self.realScene()
        }
        addChild(flow)
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
        str.append("summon:\(spell is SummonSkill ? "true" : "false"),")
        str.append("close:\(spell.isClose ? "true" : "false")")
        str.append("},")
        debug(str)
    }
    
    func echoOutfit(item:Outfit) {
        let ai = ArmorInfo()
        ai.create(armor: item)
        
        var spd = "攻速 "
//        var spell = ""
        if item is Sword {
            spd += "较快"
        } else if item is Dagger {
            spd += "很快"
        } else if item is Instrument {
            spd += "一般"
//            spell = "随机神之技"
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
//            spell = "随机神之技"
        }
        
        var str = "{fullName:\"\(ai._nameText)\","
        str.append("name:\"\(item._name)\",")
//        str.append("speed:\"\(spd)\",")
//        str.append("attrs:\(ai._attrTexts),")
//        str.append("spell:\"\(spell)\",")
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
        let touchPoint = touches.first?.location(in: self)
        if _b.contains(touchPoint!) {
            battle()
        }
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
