//
//  WinterPalace.swift
//  GoD
//
//  Created by kai chen on 2019/11/21.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class StarPalace: MorningPalace {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _monsterEnum = []
        _name = "星·宫"
        _floorSize = 5
        _level = Sumahl.LEVEL
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func getPortalFinal() -> UIItem {
        return RoleMicalu()
    }
    override func finalBattle() {
        let b = SumahlBattle()
        let es = Array<Creature>()
        b.setEnemyPart(minions: es)
        let char = Game.instance.char!
        let cs:Array<Unit> = [char] + char.getReadyMinions()
        b.setPlayerPart(roles: cs)
        Game.instance.curStage.addBattle(b)
        b.battleStart()
    }
//    override func getMonsterByIndex(index: Int) -> Creature {
//        switch index {
//            case 1:
//                return SumahlServant1()
//            case 2:
//                return SumahlServant2()
//            default:
//                return SumahlServant1()
//        }
//    }
    override func getSelfScene() -> BossRoad {
        return StarPalace()
    }
}

