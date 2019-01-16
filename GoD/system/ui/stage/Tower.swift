//
//  Tower.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/30.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Tower:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _xSize = 1
        _ySize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    internal var _triggered = false
    var _text = ""
    var _towerName = ""
    func showDialog() {
        let stage = Game.instance.curStage!
        stage.showDialog(img: self.texture!,
                         text: _text,
                         name: _towerName
        )
    }
    var _status:Status!
}
class FireEnerge:Status {
    override init() {
        super.init()
        _type = Status.FIRE_ENERGE
        _name = "火源守护"
        _description = "提升50点火焰伤害和50点火焰抗性"
    }
}
class FireEnergeTower:Tower {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.tiled_dungeons.getCell(15, 11, 1, 2))
        _status = FireEnerge()
        _text = "东之圣灵的守护：\(_status._name) —— \(_status._description)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func triggerEvent() {
        if !_triggered {
            _triggered = true
            let s = _status!
            showMsg(text: "[\(s._name)] \(s._description)")
            Game.instance.curStage.addStatus(status: s)
        }
    }
}
class WaterEnerge:Status {
    override init() {
        super.init()
        _type = Status.WATER_ENERGE
        _name = "寒冰守护"
        _description = "提升50点冰冷伤害和50点冰冷抗性。"
    }
}
class WaterEnergeTower:Tower {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.tiled_dungeons.getCell(14, 11, 1, 2))
        _status = WaterEnerge()
        _text = "西之圣灵的守护：\(_status._name) —— \(_status._description)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func triggerEvent() {
        if !_triggered {
            _triggered = true
            let s = _status!
            showMsg(text: "[\(s._name)] \(s._description)")
            Game.instance.curStage.addStatus(status: s)
        }
    }
}

class ThunderEnerge:Status {
    override init() {
        super.init()
        _type = Status.WATER_ENERGE
        _name = "雷鸣守护"
        _description = "提升50点雷电伤害和50点雷电抗性。"
    }
}
class ThunderEnergeTower:Tower {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.dungeon_b.getCell(13, 8, 1, 2))
        _status = ThunderEnerge()
        _text = "南之圣灵的守护：\(_status._name) —— \(_status._description)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func triggerEvent() {
        if !_triggered {
            _triggered = true
            let s = _status!
            showMsg(text: "[\(s._name)] \(s._description)")
            Game.instance.curStage.addStatus(status: s)
        }
    }
}
class TimeReduce:Status {
    override init() {
        super.init()
        _type = Status.WATER_ENERGE
        _name = "时空扭转"
        _description = "减少所有技能1回合冷却时间。"
    }
}
class TimeReduceTower:Tower {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.dungeon_b.getCell(12, 8, 1, 2))
        _status = TimeReduce()
        _text = "北之圣灵的守护：\(_status._name) —— \(_status._description)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func triggerEvent() {
        if !_triggered {
            _triggered = true
            let s = _status!
            showMsg(text: "[\(s._name)] \(s._description)")
            Game.instance.curStage.addStatus(status: s)
        }
    }
}
class PhysicalPower:Status {
    override init() {
        super.init()
        _type = Status.WATER_ENERGE
        _name = "无坚不摧之力"
        _description = "提升50%造成物理伤害。"
    }
}
class PhysicalPowerTower:Tower {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.dungeon_b.getCell(8, 8, 1, 2))
        _status = PhysicalPower()
        _text = "马库斯的力量祝福：\(_status._name) —— \(_status._description)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func triggerEvent() {
        if !_triggered {
            _triggered = true
            let s = PhysicalPower()
            showMsg(text: "[\(s._name)] \(s._description)")
            Game.instance.curStage.addStatus(status: s)
        }
    }
}
class MagicalPower:Status {
    override init() {
        super.init()
        _type = Status.WATER_ENERGE
        _name = "黑暗降临"
        _description = "提升50%造成法术伤害。"
    }
}
class MagicalPowerTower:Tower {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.inside_c.getCell(11, 6, 1, 2))
        _status = MagicalPower()
        _text = "的力量祝福：\(_status._name) —— \(_status._description)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func triggerEvent() {
        if !_triggered {
            _triggered = true
            let s = MagicalPower()
            showMsg(text: "[\(s._name)] \(s._description)")
            Game.instance.curStage.addStatus(status: s)
        }
    }
}
class AttackPower:Status {
    override init() {
        super.init()
        _type = Status.THUNDER_ENERGE
        _name = "战争之神"
        _description = "提升50点攻击力和25点必杀。"
    }
}
class AttackPowerTower:Tower {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.dungeon_b.getCell(9, 8, 1, 2))
        _status = AttackPower()
        _text = "伊比利斯的进攻祝福：\(_status._name) —— \(_status._description)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func triggerEvent() {
        if !_triggered {
            _triggered = true
            let s = AttackPower()
            showMsg(text: "[\(s._name)] \(s._description)")
            Game.instance.curStage.addStatus(status: s)
        }
    }
}
class DefencePower:Status {
    override init() {
        super.init()
        _type = Status.DEFENCE_POWER
        _name = "守护之神"
        _description = "提升50点防御和25点闪避。"
    }
}
class DefencePowerTower:Tower {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.dungeon_b.getCell(10, 8, 1, 2))
        _status = DefencePower()
        _text = "天使的守护：\(_status._name) —— \(_status._description)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func triggerEvent() {
        if !_triggered {
            _triggered = true
            let s = DefencePower()
            showMsg(text: "[\(s._name)] \(s._description)")
            Game.instance.curStage.addStatus(status: s)
        }
    }
}
class MindPower:Status {
    override init() {
        super.init()
        _type = Status.MIND_POWER
        _name = "智慧之神"
        _description = "提升25点念力。"
    }
}
class MindPowerTower:Tower {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.inside_c.getCell(8, 6, 1, 2))
        _status = MindPower()
        _text = "天使的守护：\(_status._name) —— \(_status._description)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func triggerEvent() {
        if !_triggered {
            _triggered = true
            let s = MindPower()
            showMsg(text: "[\(s._name)] \(s._description)")
            Game.instance.curStage.addStatus(status: s)
        }
    }
}
class LuckyPower:Status {
    override init() {
        super.init()
        _type = Status.LUCKY_POWER
        _name = "幸运之神"
        _description = "提升25点幸运。"
    }
}

class LuckyPowerTower:Tower {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.sf_inside_c.getCell(8, 11, 1, 2))
        _status = LuckyPower()
        _text = "天使的守护：\(_status._name) —— \(_status._description)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func triggerEvent() {
        if !_triggered {
            _triggered = true
            let s = LuckyPower()
            showMsg(text: "[\(s._name)] \(s._description)")
            Game.instance.curStage.addStatus(status: s)
        }
    }
}
class SpeedPower:Status {
    override init() {
        super.init()
        _type = Status.SPEED_POWER
        _name = "光影之神"
        _description = "提升50点速度和25点命中。"
    }
}


class SpeedPowerTower:Tower {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Game.instance.sf_inside_c.getCell(10, 11, 1, 2))
        _status = SpeedPower()
        _text = "天使的守护：\(_status._name) —— \(_status._description)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func triggerEvent() {
        if !_triggered {
            _triggered = true
            let s = SpeedPower()
            showMsg(text: "[\(s._name)] \(s._description)")
            Game.instance.curStage.addStatus(status: s)
        }
    }
}
