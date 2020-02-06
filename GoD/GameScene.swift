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
    var _b = Button()
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor.black
        Game.instance.gameScene = self
        Game.calcCellSize()
        
                homePage()
//        printBoss()
        
        Mode.debug = true
//        Mode.nocd = true
//        Mode.nodefence = true
        Mode.showdungeonall = true
        Mode.showbossall = true
//////
//        realScene()
//
////        let dr = DrangonRoot()
////        dr._count = 5
//
//        let e = Game.instance.char!
////        e.addProp(p: dr)
//        let se = SoulEssence()
//        se.create(soul: DarkNinja())
//        e.addProp(p: se)
//        e.addProp(p: DeathTownScroll())
//        e._spellsInuse = [FireFist(), IceFist(), QiWave(), LightingFist()]
//        let ts = TheSurvive()
//        ts.create()
//        e.addProp(p: ts)
//        let td = TheDeath()
//        td.create()
//        e.addProp(p: td)
//        let tsp = TheSurpass()
//        tsp.create()
//        e.addProp(p: tsp)
//        let ror = RingOfReborn()
//        ror.create()
//        e.addProp(p: ror)
//        let eod = EyeOfDius()
//        eod.create()
//        e.addProp(p: eod)
//
//        let s = IdlirWeddingRing()
//        s.create()
//
//        print(NSStringFromClass(s.classForCoder))
//        print(NSStringFromClass(IdlirWeddingRing.classForCoder()))
//        e.addProp(p: s)
//
//        let s11 = IdlirWeddingRing()
//        s11.create()
//        e.addProp(p: s11)
//
//        let s1 = FingerBone()
//        s1.create()
//        e.addProp(p: s1)
////
//        addItem(outfit: PuppetMaster())
//        addItem(outfit: RingOfDead())
//        addItem(outfit: AssassinsSword())
//        addItem(outfit: VerdasTear())
//        addItem(outfit: DeepCold())
//        addItem(outfit: NilSeal())
//        addItem(outfit: DragonClaw())
//        addItem(outfit: FollowOn())
//        addItem(outfit: BansMechanArm())
//        addItem(outfit: TrueLie())
//        addItem(outfit: PuppetMark())
        
        
//        Model.startNoActionBattle(role: e)
//        battle()

//        playSound("Dungeon1")
    }
    var audioPlayer:AVAudioPlayer = AVAudioPlayer()
    func playSound(_ fileName: String) {
        
        let session = AVAudioSession.sharedInstance()
        do{
            try session.setActive(true)
            try session.setCategory(AVAudioSession.Category.playback)
            UIApplication.shared.beginReceivingRemoteControlEvents()
                    
            let path = Bundle.main.path(forResource: fileName, ofType: "mp3")
            let soudUrl = URL(fileURLWithPath: path!)
            try audioPlayer = AVAudioPlayer(contentsOf: soudUrl)
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 1.0
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
        } catch {
            print("video file \(fileName) play failed!")
            print(error)
        }
    }
    func addItem(outfit:Outfit) {
//        outfit.create()
//        Game.instance.char.addProp(p: outfit)
    }
    var _layer = SKSpriteNode()
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
    func addOutfit() {
//        for _ in 0...30 {
//            let sword = Ring()
//            sword.create(level: 20)
//            Game.instance.char.addProp(p: sword)
//        }
    }
    
    func addSacredOutfit() {
//        let l = Loot()
//        let c = Game.instance.char!
//        for i in l._sacredBows {
//            let b = l.getSacredBow(id: i)
//            b.create()
//            c.addProp(p: b)
//        }
//        for i in l._sacredMarks {
//            let b = l.getSacredMark(id: i)
//            b.create()
//            c.addProp(p: b)
//        }
//        for i in l._sacredRings {
//            let b = l.getSacredRing(id: i)
//            b.create()
//            c.addProp(p: b)
//        }
//
//        for i in l._sacredWands {
//            let b = l.getSacredWand(id: i)
//            b.create()
//            c.addProp(p: b)
//        }
//
//        for i in l._sacredBlunts {
//            let b = l.getSacredBlunt(id: i)
//            b.create()
//            c.addProp(p: b)
//        }
//
//        for i in l._sacredSwords {
//            let b = l.getSacredSword(id: i)
//            b.create()
//            c.addProp(p: b)
//        }
//
//        for i in l._sacredAmulets {
//            let b = l.getSacredAmulet(id: i)
//            b.create()
//            c.addProp(p: b)
//        }
//
//        for i in l._sacredDaggers {
//            let b = l.getSacredDagger(id: i)
//            b.create()
//            c.addProp(p: b)
//        }
//
//        for i in l._sacredShields {
//            let b = l.getSacredShield(id: i)
//            b.create()
//            c.addProp(p: b)
//        }
//
//        for i in l._sacredEarrings {
//            let b = l.getSacredEarring(id: i)
//            b.create()
//            c.addProp(p: b)
//        }
//
//        for i in l._sacredSoulstones {
//            let b = l.getSacredSoulstone(id: i)
//            b.create()
//            c.addProp(p: b)
//        }
//
//        for i in l._sacredInstruments {
//            let b = l.getSacredInstrument(id: i)
//            b.create()
//            c.addProp(p: b)
//        }

    }
    
    func battle() {
        let b = IssBattle()
        let es = Array<Creature>()
        b.setEnemyPart(minions: es)
        let char = Game.instance.char!
        let cs:Array<Unit> = [char] + char.getReadyMinions()
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
        e._level = 1
        e.create()
        e.addMoney(num: 1000)
        
        for _ in 1...e._level.toInt() {
            e.strengthChange(value: 1)
            e.staminaChange(value: 1)
            e.agilityChange(value: 3)
//            e.staminaChange(value: 1)
//            e.intellectChange(value: 4)
        }
        
        
        bs.setRole(x: 5, y: 7, role: e)
        stage.loadScene(scene: bs)
        stage.createMenu()
        addChild(stage)
        
        
//        
//        let aa = HellNight()
//        aa.create(level: e._level)
////        aa._seat = BUnit.BTL
//        e._minions.append(aa)
//        for _ in 0...4 {
//            let sn = HellNight()
//            sn.create(level: e._level)
////            sn._seat = BUnit.BTR
//            e._minions.append(sn)
//        }
//        
        e._dungeonLevel = e._level.toInt()
        e._spellCount = 3
        
        //prop below
        
        e.hasShield = true
        e.hasMark = true
        
//        let w = Sword()
//        w.create(level: e._level)
//        e.addProp(p: w)
//
//        let r = RingOfDeath()
//        r.create()
//        e.addProp(p: r)
        
//        let tss = TransportScroll()
//        tss._count = 10
//        e._props.append(tss)
//
//        for _ in 0...1 {
//
//            let r2 = Ring()
//            r2.create(level: e._level)
//            e.addProp(p: r2)
//        }
        
//        let a = Amulet()
//        a.create(level: e._level)
//        e.addProp(p: a)
//
//        let cm = CreationMatrix()
//        cm.create()
//        e.addProp(p: cm)
//
//        let s = Shield()
//        s.create(level: e._level)
//        e.addProp(p: s)
        
//        e.addProp(p: WordlessBook())
//        e.addProp(p: ThiefPocket())
//        e.addProp(p: TearCluster())
//        e._spellsInuse = [SixShooter(), DancingDragon(), SuperWater(), FireRain()]
//        let eb = ExpBook()
//        eb._count = 26
//        e.addProp(p: eb)
//        let ggg = TownScroll()
//        ggg._count = 10
//        e.addProp(p: ggg)
//////
//        let po = Potion()
//        po._count = 10
//        e.addProp(p: po)
//        let st = GodTownScroll()
//        st._count = 10
//        e.addProp(p: st)
//
////        let bow = Bow()
////        bow.create(level: e._level)
////        e.addProp(p: bow)
//
//        e.addProp(p: LevelUpScroll())
    }
    
    private func startNewGame() {
        
    }
    
//    private func welcome() {
//        let flow = CreationFlow()
//        flow.create()
//        flow.gameScene = self
//        flow.actionCreate = {
//            flow.removeFromParent()
////            self.realScene()
//        }
//        addChild(flow)
//    }
    
    func printSpell(spell:Spell) -> String {
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
        return str
    }
    
    func printBossSpell(spell:Spell) -> String {
        var str = "{name:\"\(spell._name)\","
        str.append("description:\"\(spell._description)\",")
        str.append("quality:\"\(spell._quality)\",")
        str.append("cooldown:\"\(spell._cooldown)\"")
        str.append("},")
        return str
    }
    
    func printBoss(boss:Boss) {
        var str = "{name:\"\(boss._name)\","
        str.append("level:\(boss._level),")
        str.append("image:\"\(boss._imgUrl)\",")
        str.append("race:\"\(EvilType.getTypeLabel(type: boss._race))\",")
        str.append("stars:\"\(boss._growth.strength),\(boss._growth.stamina),\(boss._growth.agility),\(boss._growth.intellect)\",")
        str.append("spells:[")
        for s in boss._spellsInuse {
            str.append(printBossSpell(spell: Loot.getSpellById(s)))
        }
        str.append("]},")
        debug(str)
    }
    
    
    func echoOutfit(item:Outfit) {
        let ai = ArmorInfo()
        ai.create(armor: item)
        
//        var spd = "攻速 "
////        var spell = ""
//        if item is Sword {
//            spd += "较快"
//        } else if item is Dagger {
//            spd += "很快"
//        } else if item is Instrument {
//            spd += "一般"
////            spell = "随机神之技"
//        } else if item is Blunt {
//            spd += "很慢"
//        } else if item is Bow {
//            spd += "较快"
//        } else if item is Wand {
//            spd += "较慢"
//        } else {
//            spd = ""
//        }
//        
//        if item is MagicMark {
////            spell = "随机神之技"
//        }
        
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
    
    func printBoss() {
        let road = [FearGhost(), GraveRobber(), AssassinMaster(), GiantSpirit(), FireSpirit(), IssThePuppet(), Mimic()]
//        let demon = [Idlir(), George(), Umisa(), Iberis(), Pitheron(), Dius(), Francis()]
//        let angel = [Lewis(), Sumahl(), Micalu(), Toppur()]
//        let npc = [Suvya()]
        
//        for b in npc {
//            printBoss(boss: b)
//        }
        for b in road {
            printBoss(boss: b)
        }
//        for b in demon {
//            printBoss(boss: b)
//        }
//        for b in road {
//            printBoss(boss: b)
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
