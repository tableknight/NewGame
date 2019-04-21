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
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
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
        let char = Game.instance.char!
        if !(char.hasSpell(spell: _spell)) {
            char._spells.append(_spell)
            _spellAppended = true
        }
    }
    override func off() {
        if _spellAppended {
            let char = Game.instance.char!
            char.removeSpell(spell: _spell)
            _spellAppended = false
        }
    }
    var _spellAppended = false
    var _spell:Spell!
    private enum CodingKeys: String, CodingKey {
        case _spellAppended
        case _spell
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _spellAppended = try values.decode(Bool.self, forKey: ._spellAppended)
        _spell = try values.decode(Spell.self, forKey: ._spell)
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_spellAppended, forKey: ._spellAppended)
        try container.encode(_spell, forKey: ._spell)
        try super.encode(to: encoder)
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
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

