//
//  WinterPalace.swift
//  GoD
//
//  Created by kai chen on 2019/11/21.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class WinterPalace: MorningPalace {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _monsterEnum = []
        _name = "冬·宫"
        _floorSize = 4
        _level = Lewis.LEVEL //31
        _soundUrl = "winter_palace"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func getPortalFinal() -> UIItem {
        let role = UIRole()
        role.create(roleNode: SKSpriteNode(imageNamed: "Lewis"))
        role._roleNode.size = CGSize(width: cellSize * 2, height: cellSize * 2)
        role.zPosition = MyScene.BOSS_LAYER_Z
        return role
    }
    override func finalBattle() {
        let b = LewisBattle()
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
        switch index {
            case 1:
                return LewisMinion()
            case 2:
                return LewisMinion()
            default:
                return LewisMinion()
        }
    }
    override func getSelfScene() -> BossRoad {
        return WinterPalace()
    }
}

