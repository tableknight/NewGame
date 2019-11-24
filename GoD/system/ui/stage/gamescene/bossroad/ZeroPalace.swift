//
//  ZeroPalace.swift
//  GoD
//
//  Created by kai chen on 2019/3/13.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class ZeroPalace: MorningPalace {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _itemEnum = [1,2,3,4,5,6,7,8,9,10]
        _monsterEnum = [1,2]
        for _ in 0...10 {
            _itemEnum.append(11)
        }
        _name = "零·宫"
        _floorSize = 8
        _level = Micalu.LEVEL
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func getPortalFinal() -> UIItem {
        return RoleMicalu()
    }
    override func finalBattle() {
        let b = MicaluBattle()
        let es = Array<Creature>()
        b.setEnemyPart(minions: es)
        let char = Game.instance.char!
        let cs:Array<Creature> = [char] + char.getReadyMinions()
        b.setPlayerPart(roles: cs)
        Game.instance.curStage.addBattle(b)
        b.battleStart()
    }
    override func getMonsterByIndex(index: Int) -> Creature {
        switch index {
            case 1:
                return MicaluServant1()
            case 2:
                return MicaluServant2()
            default:
                return MicaluServant1()
        }
    }
    override func getSelfScene() -> BossRoad {
        return ZeroPalace()
    }
}
