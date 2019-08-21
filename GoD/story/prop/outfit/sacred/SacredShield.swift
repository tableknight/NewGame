//
//  SacredShield.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/4.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Faceless:Shield {
    override init() {
        super.init()
        _name = "无面者"
        _description = "每三个回合释放一次法术反射。"
        _level = 30
        _chance = 30
        _quality = Quality.SACRED
        price = 305
    }
    override func create() {
        createSelfAttrs()
        createAttr(attrId: STAMINA, value: seedFloat(min: 15, max: 26), remove: true)
        _attrCount = 4
        createAttrs()
    }
    var _spellAppended = false
    var _spell:Spell = FacelessSpell()
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
    override func on() {
        let char = Game.instance.char!
        char._spellsHidden.append(_spell)
    }
    override func off() {
        let char = Game.instance.char!
        for i in 0...char._spellsHidden.count - 1 {
            if type(of: char._spellsHidden[i]) == type(of: _spell) {
                char._spellsHidden.remove(at: i)
                return
            }
        }
    }
}

import SpriteKit
class FacelessSpell: Passive {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        isMagical = true
        _name = "法术反射"
        _description = "对己方单位释放护盾，将下一次魔法伤害反弹施法者"
        _quality = Quality.SACRED
        hasAfterMoveAction = true
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = c
        if _battle._round % 3 == 1 {
            removeSpecialStatus(t:t)
            let status = Status()
            status._type = Status.EYE_TO_EYE
            status._timeleft = 2
            t.addStatus(status: status)
            t.showText(text: "无面者")
            t.mixed1(index: 13, completion: completion)
        } else {
            completion()
        }
    }
    override func findTarget() {

    }
}


class Accident:Shield {
    override init() {
        super.init()
        _name = "无妄之灾"
        _description = "将所有受到的法术伤害转移给队友"
        _level = 42
        _chance = 20
        _quality = Quality.SACRED
        price = 388
    }
    override func create() {
        createSelfAttrs()
        createAttr(attrId: FIRERESISTANCE, value: 30, remove: true)
        createAttr(attrId: WATERRESISTANCE, value: 30, remove: true)
        createAttr(attrId: THUNDERRESISTANCE, value: 30, remove: true)
        createAttr(attrId: HEALTH, value: seedFloat(min: 30, max: 76), remove: true)
        _attrCount = 1
        createAttrs()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class FrancisFace:Shield {
    override init() {
        super.init()
        _name = "佛朗西斯的面容"
        _description = "受到伤害时有一定几率获得5暴击"
        _level = 40
        _chance = 25
        _quality = Quality.SACRED
        price = 422
    }
    override func create() {
        createSelfAttrs()
        createAttr(attrId: STRENGTH, value: seedFloat(min: 20, max: 31), remove: true)
        createAttr(attrId: STAMINA, value: seedFloat(min: 20, max: 31), remove: true)
        createAttr(attrId: AVOID, value: 20, remove: true)
        createAttr(attrId: REVENGE, value: 10, remove: true)
        _attrCount = 1
        createAttrs()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
class EvilExpel:Shield {
    override init() {
        super.init()
        _name = "辟邪"
        _description = "有一定几率低挡来自恶魔的伤害"
        _level = 23
        _chance = 50
        _quality = Quality.SACRED
        price = 228
    }
    override func create() {
        createSelfAttrs()
        createAttr(attrId: STAMINA, value: 12, remove: true)
        createAttr(attrId: HEALTH, value: 30, remove: true)
        createAttr(attrId: THUNDERRESISTANCE, value: 20, remove: true)
        _attrCount = 3
        createAttrs()
    }
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
