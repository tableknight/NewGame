//
//  MoringPalace.swift
//  GoD
//
//  Created by kai chen on 2019/3/10.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class MorningPalace: BossRoad {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _monsterEnum = []
        _name = "早·宫"
        _floorSize = 5
        _level = Toppur.LEVEL // 21
        _soundUrl = "morning_palace"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func getMonsterByIndex(index: Int) -> Creature {
        return ToppurServant()
    }
    override func getSelfScene() -> BossRoad {
        return MorningPalace()
    }
    override func getPortalFinal() -> UIItem {
        let role = UIRole()
        role.create(roleNode: SKSpriteNode(imageNamed: "Toppur"))
        role._roleNode.size = CGSize(width: cellSize * 2, height: cellSize * 2)
        role.zPosition = MyScene.BOSS_LAYER_Z
        return role
    }
    override func finalBattle() {
        let b = ToppurBattle()
        let es = Array<Creature>()
        b.setEnemyPart(minions: es)
        let char = Game.instance.char!
        let cs:Array<Unit> = [char] + char.getReadyMinions()
        b.setPlayerPart(roles: cs)
        Game.instance.curStage.addBattle(b)
        b.battleStart()
        _bossBattle = b
    }
    
    override func getWallTexture() -> SKTexture {
        return Game.instance.outside_b.getCell(13, 4, 1, 2)
    }
}
