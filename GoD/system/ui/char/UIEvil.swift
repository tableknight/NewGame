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
        let sc = stage._curScene!
        let char = Game.instance.char!
        var enemies = Array<Creature>()
        
        let thisOne = Creature(_thisType)
        if sc is BossRoad {
            thisOne.create(level: sc._level)
        } else {
            thisOne.create(level: Core().d20() ? 1 : sc._level)
        }
        enemies.append(thisOne)
        
        var nums = [1,1,2,2,3,3,3,3,3,4,4,4,5]
        if sc._level < 10 {
            nums = [1,1,1,2,2,2,2,2,3]
        }
        let enemyCount = nums.one() - 1
        if enemyCount > 0 {
            for _ in 1...enemyCount {
                let e = Creature(sc._monsterEnum.one())
                let l = sc._level
                if sc is BossRoad {
                    e.create(level: sc._level)
                } else {
                    e.create(level: Core().d20() ? 1 : [l > 1 ? l - 1 : 1, l , l + 1].one())
                }
                
                enemies.append(e)
            }
        }
//        stage.hideScene()
        let b = Battle()
        let roles = [char] + char.getReadyMinions()
        b.setEnemyPart(minions: enemies)
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
    var _thisType = "-1"
    var defeatAction = {}
    var defeatedAction = {}
}

