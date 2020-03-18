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
        _monsterEnum = []
        _name = "零·宫"
        _floorSize = 8
        _level = Micalu.LEVEL //26
        _soundUrl = "zero_palace"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func getPortalFinal() -> UIItem {
        let role = UIRole()
        role.create(roleNode: SKSpriteNode(imageNamed: "Micalu"))
        role._roleNode.size = CGSize(width: cellSize * 2, height: cellSize * 2)
        role.zPosition = MyScene.BOSS_LAYER_Z
        return role
    }
    override func finalBattle() {
        let b = MicaluBattle()
        let es = Array<Creature>()
        b.setEnemyPart(minions: es)
        let char = Game.instance.char!
        let cs:Array<Unit> = [char] + char.getReadyMinions()
        b.setPlayerPart(roles: cs)
        Game.instance.curStage.addBattle(b)
        b.battleStart()
        _bossBattle = b
    }
    override func getMonsterByIndex(index: Int) -> Creature {
        if index == 1 || index == 2 {
            return MicaluServant1()
        } else {
            return MicaluServant2()
        }
    }
    override func getSelfScene() -> BossRoad {
        return ZeroPalace()
    }
}
