//
//  SacredSoulStone.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/5.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class HeartOfSwamp: SoulStone {
    override init() {
        super.init()
        _name = "沼泽之心"
        _description = "种族转换为生灵。"
        _level = 30
        _race = EvilType.NATURE
        _chance = 30
        _quality = Quality.SACRED
        price = 286
    }
    override func create() {
        createAttr(attrId: MIND, value: seedFloat(min: 15, max: 31), remove: true)
    }
}
class PandoraHearts:SoulStone {
    override init() {
        super.init()
        _name = "潘多拉之心"
        _description = "随机获取一个未获得的神之技"
        _level = 55
        _race = EvilType.DEMON
        _chance = 2
        _quality = Quality.SACRED
        price = 2202
    }
    var _spell:Spell!
    override func create() {
        var unSavedSpells = Array<Spell>()
        let l = Loot()
        let c = Game.instance.char!
        for i in 0...l.sacredSpellCount - 1 {
            let spell = l.getSacredSpell(id: i)
            if !c.hasSpell(spell: spell) {
                unSavedSpells.append(spell)
            }
        }
        if unSavedSpells.count > 0 {
            _spell = unSavedSpells.one()
        }
    }
    override func on() {
        super.on()
        if nil != _spell {
            Game.instance.char._spells.append(_spell!)
        }
    }
    override func off() {
        super.off()
        if nil != _spell {
            Game.instance.char.removeSpell(spell: _spell!)
        }
    }
}
class HeartOfTarrasque:SoulStone {
    override init() {
        super.init()
        _name = "魔龙之心"
        _description = "提升重生的治疗效果100%"
        _level = 38
        _race = EvilType.NATURE
        _chance = 40
        _quality = Quality.SACRED
        price = 348
    }
    override func create() {
        
    }
}

