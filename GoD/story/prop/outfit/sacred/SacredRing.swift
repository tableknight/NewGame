//
//  SacredRing.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/5.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class RingOfDead:Ring {
    override init() {
        super.init()
        _name = "亡灵之戒"
        _description = "种族转换为亡灵。"
        _level = 12
        _chance = 100
        _quality = Quality.SACRED
        price = 108
    }
    override func create() {
        createAttr(attrId: MIND, value: 10, remove: true)
        createAttr(attrId: INTELLECT, value: 10, remove: true)
        createAttr(attrId: WATERRESISTANCE, value: 10, remove: true)
        _attrCount = 2
        createAttrs()
    }
//    private var _backup = 0
    override func on() {
        super.on()
//        _backup = Data.instance._char._race
        Game.instance.char._race = EvilType.RISEN
    }
    
    override func off() {
        super.off()
        if nil != Game.instance.char._soulStone {
            Game.instance.char._race = Game.instance.char._soulStone!._race
        }
        
    }
}
class IdlirWeddingRing:Ring {
    override init() {
        super.init()
        _name = "伊德利尔的婚戒"
        _description = "变形成为伊德利尔的新娘"
        _level = 29
        _chance = 100
        _quality = Quality.SACRED
        price = 199
    }
    override func create() {
        createAttr(attrId: SPIRIT, value: 0, remove: true)
        createAttr(attrId: SPEED, value: 0, remove: true)
        createAttr(attrId: AVOID, value: 0, remove: true)
        _attrCount = seed(min: 2, max: 4)
        createAttrs()
    }
    var _originalImage = SKTexture()
    override func on() {
        super.on()
        _originalImage = Game.instance.char._img
        let t = SKTexture(imageNamed: "idlir_bride.png")
        Game.instance.char._img = t
        Game.instance.curStage._curScene._role._charTexture = t
    }
    override func off() {
        Game.instance.char._img = _originalImage
        Game.instance.curStage._curScene._role._charTexture = _originalImage
    }
}
class ApprenticeRing:Ring {
    override init() {
        super.init()
        _name = "学徒法戒"
        _description = "略微提高玩火的成功几率"
        _level = 2
        _chance = 50
        _quality = Quality.SACRED
        price = 40
    }
    override func create() {
        createAttr(attrId: INTELLECT, value: 2, remove: true)
        createAttr(attrId: SPIRIT, value: 2, remove: true)
        createAttr(attrId: FIREPOWER, value: 0, remove: true)
        _attrCount = 2
        createAttrs()
    }
}
class CopperRing:Ring {
    override init() {
        super.init()
        _name = "铜质戒指"
        _description = "铜的比较耐火"
        _level = 5
        _chance = 100
        _quality = Quality.SACRED
        price = 28
    }
    override func create() {
        createAttr(attrId: FIRERESISTANCE, value: 10, remove: true)
        _attrCount = seed(min: 2, max: 4)
        createAttrs()
    }
}
class SilverRing:Ring {
    override init() {
        super.init()
        _name = "银质戒指"
        _level = 15
        _chance = 100
        _quality = Quality.SACRED
        price = 92
    }
    override func create() {
        createAttr(attrId: STRENGTH, value: 10, remove: true)
        createAttr(attrId: AVOID, value: 10, remove: true)
        createAttr(attrId: FIRERESISTANCE, value: 15, remove: true)
        _attrCount = 2
        createAttrs()
    }
}
class DellarsGoldenRing:Ring {
    override init() {
        super.init()
        _name = "德拉的金戒"
        _description = "真金不怕火炼"
        _level = 25
        _chance = 60
        _quality = Quality.SACRED
        price = 112
    }
    override func create() {
        createAttr(attrId: FIRERESISTANCE, value: 30, remove: true)
        createAttr(attrId: FIREPOWER, value: 30, remove: true)
        _attrCount = seed(min: 2, max: 4)
        createAttrs()
    }
}
class LuckyRing:Ring {
    override init() {
        super.init()
        _name = "幸运指环"
        _level = 15
        _chance = 100
        _quality = Quality.SACRED
        price = 88
    }
    override func create() {
        createAttr(attrId: AVOID, value: 8, remove: true)
        createAttr(attrId: RHYTHM, value: 8, remove: true)
        createAttr(attrId: REVENGE, value: 8, remove: true)
        createAttr(attrId: CRITICAL, value: 10, remove: true)
        createAttr(attrId: LUCKY, value: seedFloat(min: 10, max: 21), remove: true)
    }
}

