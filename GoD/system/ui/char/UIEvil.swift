//
//  UIEvil.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/8.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class UIEvil: UIUnit {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)

    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func triggerEvent() {
        let stage = Game.instance.curStage!
        let sc = stage._curScene as! AcientRoad
        let char = Game.instance.char!
        var enimies = Array<Creature>()
        
        let enemyCount = seed(min: 1, max: sc._level < 10 ? 2 : 4)
        for _ in 0...enemyCount {
            let e = sc.getMonsterByIndex(index: sc._monsterEnum.one())
            e.create(level: sc._level)
            enimies.append(e)
        }
        stage.hideScene()
        let b = Battle()
        let roles = [char] + char.getReadyMinions()
        b.setEnemyPart(minions: enimies)
        b.setPlayerPart(roles: roles)
        b.zPosition = MyStage.UI_TOPEST_Z
        let this = self
        b.defeatedAction = {
            this.defeatedAction()
        }
        b.defeatAction = {
            this.defeatAction()
        }
        stage.addBattle(b)
        b.battleStart()
    }
    var _evils = Array<Creature>()
    var _thisType = -1
    var defeatAction = {}
    var defeatedAction = {}
}

