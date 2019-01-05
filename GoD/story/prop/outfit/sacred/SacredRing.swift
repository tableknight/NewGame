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
    }
    override func create() {
        _quality = Quality.SACRED
        _attrCount = seed(min: 3, max: 6)
        createAttrs()
        initialized = true
        createPrice()
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
    }
    override func createQuality() {
        sacredAttrCount()
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
        _level = 15
        _chance = 50
    }
    override func createQuality() {
        sacredAttrCount()
    }
}
class CopperRing:Ring {
    override init() {
        super.init()
        _name = "铜质戒指"
        _description = "火焰抵抗 +5"
        _level = 5
        removeAttrId(id: FIRERESISTANCE)
        _chance = 100
    }
    override func create() {
        _quality = Quality.SACRED
        initialized = true
        _attrCount = 3
        createAttrs()
        createPrice()
    }
    override func on() {
        super.on()
        Game.instance.char._ElementalResistance.fire += 5
    }
    override func off() {
        super.off()
        Game.instance.char._ElementalResistance.fire -= 5
    }
}
class SilverRing:Ring {
    override init() {
        super.init()
        _name = "银质戒指"
        _description = "火焰抵抗 +15"
        _level = 15
        removeAttrId(id: FIRERESISTANCE)
        _chance = 100
    }
    override func create() {
        _quality = Quality.SACRED
        initialized = true
        _attrCount = 3
        createAttrs()
        createPrice()
    }
    override func on() {
        super.on()
        Game.instance.char._ElementalResistance.fire += 15
    }
    override func off() {
        super.off()
        Game.instance.char._ElementalResistance.fire -= 15
    }
}
class DellarsGoldenRing:Ring {
    override init() {
        super.init()
        _name = "德拉的金戒"
        _description = "火焰抵抗 +35"
        _level = 35
        removeAttrId(id: FIRERESISTANCE)
        _chance = 60
    }
    override func create() {
        _quality = Quality.SACRED
        initialized = true
        _attrCount = seed(min: 3, max: 6)
        createAttrs()
        createPrice()
    }
    override func on() {
        super.on()
        Game.instance.char._ElementalResistance.fire += 35
    }
    override func off() {
        super.off()
        Game.instance.char._ElementalResistance.fire -= 35
    }
}
class LuckyRing:Ring {
    override init() {
        super.init()
        _name = "幸运指环"
        _avoid = seed(min: 10, max: 16).toFloat()
        _lucky = seed(min: 10, max: 16).toFloat()
        _description = "幸运 +\(_lucky) & 闪避 +\(_avoid)"
        _level = 15
        removeAttrId(id: LUCKY)
        removeAttrId(id: AVOID)
        _chance = 100
    }
    var _lucky:CGFloat = 0
    var _avoid:CGFloat = 0
    override func createQuality() {
        sacredAttrCount()
        _attrCount = 3
    }
    override func on() {
        super.on()
        Game.instance.char._lucky += _lucky
        Game.instance.char._extensions.avoid += _avoid
    }
    override func off() {
        super.off()
        Game.instance.char._lucky -= _lucky
        Game.instance.char._extensions.avoid -= _avoid
    }
}

