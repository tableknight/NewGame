//
//  MiTyan.swift
//  GoD
//
//  Created by kai chen on 2019/8/26.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class MiTyan:NPCBoss {
    static let LEVEL:CGFloat = 1
    static let IMG = "family"
    override init() {
        super.init()
        _name = "小美"
        _img = SKTexture(imageNamed: "family").getCell(1, 0)
        _level = 1
        _race = EvilType.MAN
    }
    override func create(level: CGFloat) {
        _quality = Quality.SACRED
        _growth.stamina = 3
        _growth.strength = 3
        _growth.agility = 3
        _growth.intellect = 3
        levelTo(level: level)
//        _extensions.health *= 1
        _extensions.hp = _extensions.health
        _spellsInuse = []
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

class MiTyanBattle: NPCBattle {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func createAI() {
        if _curRole._unit is Boss {
            _selectedSpell = BossAttack()
            _selectedSpell._battle = self
            _selectedSpell.findTarget()
            execOrder()
        } else {
            super.createAI()
        }
    }
    
    override func setEnemyPart(minions: Array<Creature>) {
        var es = Array<Creature>()
        let l:CGFloat = _level
        let t = MiTyan()
        t.create(level: l)
        t._seat = BUnit.TTM
        es.append(t)
        super.setEnemyPart(minions: es)
    }
    override func specialLoot() -> Array<Prop> {
        return []
    }
}

