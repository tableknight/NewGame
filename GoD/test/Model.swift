//
//  Model.swift
//  GoD
//
//  Created by kai chen on 2019/10/22.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class Model:NSObject {
    static func getNoActionCreature(level:CGFloat = 25) -> Creature {
        let m = Mummy()
        m.create(level: level)
        m._seat = BUnit.TTM
        m._sensitive = 100
        m._extensions.avoid = 0
        m._rhythm = 0
//        m._spellsInuse = [NoAction()]
        return m
    }
    static func startNoActionBattle(role:Character) {
        let b = Battle()
        let m1 = Model.getNoActionCreature()
        m1._seat = BUnit.TTL
        let m2 = Model.getNoActionCreature()
        m2._seat = BUnit.TTM
        let m3 = Model.getNoActionCreature(level: 25)
        m3._seat = BUnit.TTR
        let m4 = Model.getNoActionCreature()
        m4._seat = BUnit.TBL
        let m5 = Model.getNoActionCreature()
        m5._seat = BUnit.TBM
        let m6 = Model.getNoActionCreature(level: 25)
        m6._race = EvilType.DEMON
//        let m6 = BearWarrior()
//        m6.create(level: 25)
        m6._seat = BUnit.TBR
        b.setEnemyPart(minions: [m1,m2,m3,m4,m5,m6])
//        b.setEnemyPart(minions: [m1])
        b.setPlayerPart(roles: [role])
        Game.instance.curStage.addBattle(b)
        b.battleStart()
    }
    static func getRole(spells:Array<Spell> = []) -> Character {
        let e = Emily()
        e.create()
//        e._spellsInuse = spells
        Game.instance.char = e
        return e
    }
//    static func constructStage() {
//        let stage = MyStage()
//        let bs = CenterCamping()
//        bs.create()
//        stage.loadScene(scene: bs)
//        stage.createMenu()
//        Game.instance.gameScene.addChild(stage)
//    }
}

func debugger(){
    print("debugger")
}
