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
        _level = Sumahl.LEVEL //40
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func getPortalFinal() -> UIItem {
        let role = UIRole()
        role.create(roleNode: SKSpriteNode(imageNamed: "Sumahl"))
        role._roleNode.size = CGSize(width: cellSize * 2, height: cellSize * 2)
        role.zPosition = MyScene.BOSS_LAYER_Z
        return role
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
    override func getMonsterByIndex(index: Int) -> Creature {
        if index == 1 || index == 2 {
            return SumahlServant1()
        } else {
            return SumahlServant2()
        }
    }
    override func getSelfScene() -> BossRoad {
        return StarPalace()
    }
}

