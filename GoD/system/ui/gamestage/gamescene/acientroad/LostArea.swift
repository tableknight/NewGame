//
//  LostArea.swift
//  GoD
//
//  Created by kai chen on 2019/1/2.
//  Copyright © 2019年 Chen. All rights reserved.
//

import SpriteKit
class LostArea: AcientRoad {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _itemEnum = [1,1,1,1,2,2,2,2,12,21,21,3,4,5,6,7,8,9]
        _monsterEnum = [1,2,3,4]
        let oa4 = Game.instance.dungeon_a4
        _mapSet = GroundSets(ground: oa4.getCell(4, 2, 2, 2), wall: oa4.getCell(4, 4, 2, 2))
        _name = "失落荒地"
        _id = AcientRoad.LOST_AREA
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func getItemByIndex(index: Int) -> UIItem {
        switch index {
        case 1:
            return LostItem1()
        case 2:
            return LostItem2()
        case 3:
            return getUIItem1(11, 7)
        case 4:
            return getUIItem1(14, 6)
        case 5:
            return getUIItem1(8, 7)
        case 6:
            return getUIItem1(3, 9)
        case 7:
            return getUIItem1(6, 12)
        case 8:
            return getUIItem1(4, 12)
        case 9:
            return getUIItem1(4, 11)
        case 21:
            return LostItem21()
        case 12:
            return LostItem12()
        default:
            return LostItem2()
        }
    }
    
    private func getUIItem1(_ x:CGFloat, _ y:CGFloat) -> UIItem {
        let item = UIItem()
        item.setTexture(Game.instance.outside_b.getCell(x, y))
        return item
    }
    
    override func getWallTexture() -> SKTexture {
        return Game.instance.outside_b.getCell(5, 12, 1, 2)
    }
    override func addWall(x: CGFloat, y: CGFloat, item: SKSpriteNode) {
        if Core().d4() {
            super.addWall(x: x, y: y, item: item)
        } else {
            addItem(x: x, y: y, item: getItemByIndex(index: _itemEnum.one()))
        }
    }
    
    override func getMonsterByIndex(index: Int) -> Creature {
        switch index {
        case 1:
            return BoneWitch()
        case 2:
            return RedEyeDemon()
        case 3:
            return DeadSpirit()
        case 4:
            return WasteWalker()
        default:
            return WasteWalker()
        }
    }
}
class LostItem2:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.outside_b.getCell(8, 6, 1, 2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class LostItem21:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.outside_b.getCell(5, 12, 1, 2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class LostItem1:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.outside_b.getCell(9, 6))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class LostItem12:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.outside_b.getCell(4, 12))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class LostItem13:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.outside_b.getCell(1, 13))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class BoneWitch: Rizen {
    override init() {
        super.init()
        _stars.strength = 1.0
        _stars.stamina = 1.0
        _stars.agility = 1.0
        _stars.intellect = 2.8
        _name = "白骨巫师"
        _spellSlot = SpellSlot(max: 2, min: 1)
        _spellsInuse = [FireBreath()]
        _img = Game.instance.pictureMonster.getCell(3, 7, 3, 4)
    }
}
class RedEyeDemon: Demon {
    override init() {
        super.init()
        _stars.strength = 1.0
        _stars.stamina = 2.1
        _stars.agility = 2.1
        _stars.intellect = 0.6
        _name = "红眼恶魔"
        _spellSlot = SpellSlot(max: 1, min: 0)
        _img = Game.instance.pictureMonster.getCell(0, 7, 3, 4)
    }
    override func create(level: CGFloat) {
        super.create(level: level)
        if _spellCount > 0 && aQuarter() {
            _spellsInuse = [Strong()]
        }
    }
}
class DeadSpirit: Rizen {
    override init() {
        super.init()
        _stars.strength = 0.8
        _stars.stamina = 1.0
        _stars.agility = 2.2
        _stars.intellect = 2.4
        _name = "死灵"
        _spellSlot = SpellSlot(max: 3, min: 1)
        _img = Game.instance.pictureMonster.getCell(6, 7, 3, 4)
    }
    override func create(level: CGFloat) {
        super.create(level: level)
        if _spellCount > 0 && aQuarter() {
            _spellsInuse = [DeathStrike()]
        }
        if _spellCount > 1 && aQuarter() {
            _spellsInuse.append(Energetic())
        }
    }
    
}
class WasteWalker: Rizen {
    override init() {
        super.init()
        _stars.strength = 2.2
        _stars.stamina = 2.2
        _stars.agility = 1
        _stars.intellect = 0.4
        _name = "荒地行者"
        _spellSlot = SpellSlot(max: 1, min: 0)
        _img = Game.instance.pictureMonster.getCell(9, 7, 3, 4)
    }
    override func create(level: CGFloat) {
        super.create(level: level)
        if _spellCount > 0 && aQuarter() {
            _spellsInuse = [Cruel()]
        }
    }
    
}
