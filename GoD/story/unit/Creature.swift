//
//  Creature.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/1/14.
//  Copyright © 2018年 Chen. All rights reserved.
//
import SpriteKit
class Creature: Unit {
    private enum CodingKeys: String, CodingKey {
        case _stars
        case _growth
        case _birth
        case _natural
        case _sensitive
        case _type
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _stars = try values.decode(Mains.self, forKey: ._stars)
        _natural = try values.decode(Mains.self, forKey: ._natural)
        _birth = try values.decode(Mains.self, forKey: ._birth)
        _growth = try values.decode(Mains.self, forKey: ._growth)
        _sensitive = try values.decode(Int.self, forKey: ._sensitive)
        _type = try values.decode(String.self, forKey: ._type)
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_stars, forKey: ._stars)
        try container.encode(_growth, forKey: ._growth)
        try container.encode(_natural, forKey: ._natural)
        try container.encode(_birth, forKey: ._birth)
        try container.encode(_sensitive, forKey: ._sensitive)
        try container.encode(_type, forKey: ._type)
        try super.encode(to: encoder)
    }
    
    override init() {
        super.init()
    }
    init(_ type:String) {
        super.init()
        _type = type
        if type.isEmpty {
            return
        }
        let md = Minions.data[type]!
        _stars.stamina = md.settingGrowth.stamina
        _stars.strength = md.settingGrowth.strength
        _stars.agility = md.settingGrowth.agility
        _stars.intellect = md.settingGrowth.intellect
        _natural.stamina = md.settingValue.stamina
        _natural.strength = md.settingValue.strength
        _natural.agility = md.settingValue.agility
        _natural.intellect = md.settingValue.intellect
        _name = md.name
        _race = md.race
        _imgUrl = md.imgUrl
        _img = SKTexture(imageNamed: _imgUrl)
        for s in md.spells {
            _spells.append(s)
        }
        if md.spellCountMax == md.spellCountMin {
            _spellCount = md.spellCountMin
        } else if md.spellCountMin < md.spellCountMax {
            _spellCount = seed(min: md.spellCountMin, max: md.spellCountMax)
        }
        
    }
    
    var _stars:Mains = Mains(stamina: 0, strength: 0, agility: 0, intellect: 0)
    var _growth:Mains = Mains(stamina: 0, strength: 0, agility: 0, intellect: 0)
    var _birth = Mains(stamina: 0, strength: 0, agility: 0, intellect: 0)
    var _natural = Mains(stamina: 20, strength: 20, agility: 20, intellect: 20)
    var _sensitive = 33
    var _type = ""
    
    func beMore() -> Bool {
        let sed = seed(max: 100)
        if sed < _quality * 20 {
            return true
        }
        
        return false
    }
    func extraProperty(value: CGFloat) -> CGFloat {
        let max = (value * 12).toInt()
        let min = (value * 3).toInt()
        var float = seed(min: min, max: max).toFloat() * 0.01
        if !beMore() {
            float *= -1
        }
        return value + float
    }
    func createQuality() {
        let l = _level.toInt()
        let sed = seed(to: 100 + l / 2)
        if sed < 50 {
            _quality = Quality.NORMAL
        } else if sed < 80 {
            _quality = Quality.GOOD
        } else if sed < 96 {
            _quality = Quality.RARE
        } else {
            _quality = Quality.SACRED
        }
    }
    func createBirthValue() {
        _birth.strength = extraProperty(value: _natural.strength)
        _birth.stamina = extraProperty(value: _natural.stamina)
        _birth.agility = extraProperty(value: _natural.agility)
        _birth.intellect = extraProperty(value: _natural.intellect)
    }
    func createGrowthValue() {
        _growth.stamina = extraProperty(value: _stars.stamina)
        _growth.strength = extraProperty(value: _stars.strength)
        _growth.agility = extraProperty(value: _stars.agility)
        _growth.intellect = extraProperty(value: _stars.intellect)
    }
    func create(level:CGFloat) {
        _level = level
        createQuality()
        createBirthValue()
        createGrowthValue()
        levelTo(level: level)
        _extensions.hp = _extensions.health
        createSensitive()
        let l = _level.toInt()
        if _level > 30 {
            _elementalResistance.fire = seed(to: l * 2).toFloat()
            _elementalResistance.water = seed(to: l * 2).toFloat()
            _elementalResistance.thunder = seed(to: l * 2).toFloat()
        }
        if _level > 1 && _spellCount > _spellsInuse.count && d3() {
            let spells = [
                Loot.getRandomNormalSpell(),
                Loot.getRandomGoodSpell(),
                Loot.getRandomRareSpell(),
                Loot.getRandomSacredSpell()]
            let spell = spells.one()
            if !(spell is BowSkill) && !(spell is HandSkill) && !(spell is Interchange) && !(spell is SwapHealth) {
                _spellsInuse.append(spell._id)
            }
        }
    }
    func createSensitive() {
        _sensitive = seed(min: 15, max: 56)
    }
    func levelTo(level:CGFloat) {
        staminaChange(value: (level - 1) * _growth.stamina + _birth.stamina)
        strengthChange(value: (level - 1) * _growth.strength + _birth.strength)
        agilityChange(value: (level - 1) * _growth.agility + _birth.agility)
        intellectChange(value: (level - 1) * _growth.intellect + _birth.intellect)
        _level = level
        for _ in 1...level.toInt() {
            let sd = seed()
            if sd < 25 {
                staminaChange(value: 1)
            } else if sd < 50 {
                strengthChange(value: 1)
            } else if sd < 75 {
                agilityChange(value: 1)
            } else {
                intellectChange(value: 1)
            }
        }
    }
    
    override func levelup() {
        staminaChange(value: _growth.stamina)
        strengthChange(value: _growth.strength)
        agilityChange(value: _growth.agility)
        intellectChange(value: _growth.intellect)
        _level += 1
        _leftPoint += 1
        _extensions.hp = _extensions.health
    }
    
    
    func d(baseRate:Int = 45) -> Bool {
        return seed() < baseRate + _level.toInt()
    }
    static func getCreatureByClass(c:Creature) -> Creature? {
//        if c.classForCoder == VirulentToad.classForCoder() {
//            return DarkNinja()
//        }
//        if c.classForCoder == TreeSpirit.classForCoder() {
//            return DarkNinja()
//        }
//        if c.classForCoder == Python.classForCoder() {
//            return DarkNinja()
//        }
//        if c.classForCoder == GiantWasp.classForCoder() {
//            return DarkNinja()
//        }
//        if c.classForCoder == DarkNinja.classForCoder() {
//            return DarkNinja()
//        }
        return nil
    }
    static let GreenSpirit = "GreenSpirit"
    static let Luki = "Luki"
    static let TreeSpirit = "TreeSpirit"
    static let Fairy = "Fairy"

    static let BoneWitch = "BoneWitch"
    static let RedEyeDemon = "RedEyeDemon"
    static let DeadSpirit = "DeadSpirit"
    static let WasteWalker = "WasteWalker"

    static let SnowLady = "SnowLady"
    static let FrozenSlime = "FrozenSlime"
    static let IceBeast = "IceBeast"
    static let SnowSpirit = "SnowSpirit"

    static let BloodBat = "BloodBat"
    static let Kodagu = "Kodagu"
    static let EvilSpirit = "EvilSpirit"
    static let HellBaron = "HellBaron"

    static let ChildLizard = "ChildLizard"
    static let ForestGuard = "ForestGuard"
    static let CrazyPlant = "CrazyPlant"
    static let CrazyCow = "CrazyCow"

    static let DarkNinja = "DarkNinja"
    static let HellNight = "HellNight"
    static let BloodQueen = "BloodQueen"
    static let ManWizard = "ManWizard"

}

struct Minions {
    var type = ""
    var name = ""
    var race = 1
    var settingGrowth = Mains(stamina: 0, strength: 0, agility: 0, intellect: 0 )
    var settingValue = Mains(stamina: 0, strength: 0, agility: 0, intellect: 0 )
    var imgUrl = ""
    var spellCountMin = 1
    var spellCountMax = 3
    var spells = Array<Int>()
    var lootItems = Array<String>()
    static let data = [
        Creature.GreenSpirit: Minions(
            type: Creature.GreenSpirit,
            name: "绿精灵",
            race: EvilType.NATURE,
            settingGrowth: Mains(stamina: 2.8, strength: 1.0, agility: 0.6, intellect: 1.0),
            settingValue: Mains(stamina: 28, strength: 18, agility: 12, intellect: 10),
            imgUrl: "green_spirit",
            spellCountMin: 1,
            spellCountMax: 2,
            spells: [Spell.AttackHard],
            lootItems: []
        ),
        Creature.Luki: Minions(
            type: Creature.Luki,
            name: "露琪",
            race: EvilType.NATURE,
            settingGrowth: Mains(stamina: 0.5, strength: 2.2, agility: 2.0, intellect: 0.8),
            settingValue: Mains(stamina: 15, strength: 22, agility: 22, intellect: 15),
            imgUrl: "luki",
            spellCountMin: 1,
            spellCountMax: 3,
            spells: [Spell.Reborn],
            lootItems: []
        ),
        Creature.TreeSpirit: Minions(
            type: Creature.TreeSpirit,
            name: "树妖",
            race: EvilType.NATURE,
            settingGrowth: Mains(stamina: 2.0, strength: 1.0, agility: 1.0, intellect: 2.2),
            settingValue: Mains(stamina: 12, strength: 10, agility: 12, intellect: 29),
            imgUrl: "green_spirit",
            spellCountMin: 1,
            spellCountMax: 2,
            spells: [Spell.FragileCurse],
            lootItems: []
        ),
        Creature.Fairy: Minions(
            type: Creature.Fairy,
            name: "花仙子",
            race: EvilType.NATURE,
            settingGrowth: Mains(stamina: 1.4, strength: 1.5, agility: 1.3, intellect: 1.2),
            settingValue: Mains(stamina: 17, strength: 28, agility: 12, intellect: 16),
            imgUrl: "flower_fairy",
            spellCountMin: 1,
            spellCountMax: 3,
            spells: [Spell.AttackPowerUp],
            lootItems: []
        ),
        Creature.BoneWitch: Minions(
            type: Creature.BoneWitch,
            name: "白骨巫师",
            race: EvilType.RISEN,
            settingGrowth: Mains(stamina: 1.0, strength: 1.0, agility: 1.0, intellect: 2.8),
            settingValue: Mains(stamina: 15, strength: 10, agility: 15, intellect: 24),
            imgUrl: "bone_wizard",
            spellCountMin: 1,
            spellCountMax: 3,
            spells: [Spell.FireBreath],
            lootItems: []
        ),
        Creature.RedEyeDemon: Minions(
            type: Creature.RedEyeDemon,
            name: "红眼恶魔",
            race: EvilType.DEMON,
            settingGrowth: Mains(stamina: 2.1, strength: 1.0, agility: 2.1, intellect: 0.6),
            settingValue: Mains(stamina: 21, strength: 21, agility: 14, intellect: 12),
            imgUrl: "red_eye_demon",
            spellCountMin: 1,
            spellCountMax: 2,
            spells: [Spell.ChaosAttack],
            lootItems: []
        ),
        Creature.DeadSpirit: Minions(
            type: Creature.DeadSpirit,
            name: "死灵",
            race: EvilType.RISEN,
            settingGrowth: Mains(stamina: 1.0, strength: 0.8, agility: 2.2, intellect: 2.4),
            settingValue: Mains(stamina: 21, strength: 12, agility: 16, intellect: 16),
            imgUrl: "green_spirit",
            spellCountMin: 2,
            spellCountMax: 3,
            spells: [Spell.DeathStrike],
            lootItems: []
        ),
        Creature.WasteWalker: Minions(
            type: Creature.WasteWalker,
            name: "荒地行者",
            race: EvilType.RISEN,
            settingGrowth: Mains(stamina: 2.2, strength: 2.2, agility: 1, intellect: 0.4),
            settingValue: Mains(stamina: 12, strength: 25, agility: 19, intellect: 19),
            imgUrl: "waste_walker",
            spellCountMin: 2,
            spellCountMax: 2,
            spells: [Spell.Cruel],
            lootItems: []
        ),
        Creature.SnowLady: Minions(
            type: Creature.SnowLady,
            name: "冰雪女妖",
            race: EvilType.MAN,
            settingGrowth: Mains(stamina: 1.8, strength: 1.3, agility: 2.0, intellect: 0.5),
            settingValue: Mains(stamina: 21, strength: 18, agility: 22, intellect: 11),
            imgUrl: "snow_lady",
            spellCountMin: 1,
            spellCountMax: 3,
            spells: [Spell.Disappear],
            lootItems: []
        ),
        Creature.FrozenSlime: Minions(
            type: Creature.FrozenSlime,
            name: "冰冻史莱姆",
            race: EvilType.DEMON,
            settingGrowth: Mains(stamina: 2.4, strength: 1.1, agility: 1.5, intellect: 0.6),
            settingValue: Mains(stamina: 28, strength: 20, agility: 7, intellect: 10),
            imgUrl: "slime",
            spellCountMin: 3,
            spellCountMax: 3,
            spells: [Spell.Sacrifice],
            lootItems: []
        ),
        Creature.IceBeast: Minions(
            type: Creature.IceBeast,
            name: "寒冰巨兽",
            race: EvilType.NATURE,
            settingGrowth: Mains(stamina: 1.5, strength: 1.5, agility: 1.5, intellect: 1.5),
            settingValue: Mains(stamina: 12, strength: 12, agility: 24, intellect: 12),
            imgUrl: "ice_beast",
            spellCountMin: 1,
            spellCountMax: 1,
            spells: [Spell.QuickHeal],
            lootItems: []
        ),
        Creature.SnowSpirit: Minions(
            type: Creature.SnowSpirit,
            name: "雪精",
            race: EvilType.NATURE,
            settingGrowth: Mains(stamina: 0.8, strength: 1.1, agility: 2.5, intellect: 1.9),
            settingValue: Mains(stamina: 24, strength: 15, agility: 12, intellect: 18),
            imgUrl: "snow_spirit",
            spellCountMin: 1,
            spellCountMax: 2,
            spells: [],
            lootItems: []
        ),
        Creature.BloodBat: Minions(
            type: Creature.BloodBat,
            name: "血色蝙蝠",
            race: EvilType.NATURE,
            settingGrowth: Mains(stamina: 2.2, strength: 1.1, agility: 1.4, intellect: 0.9),
            settingValue: Mains(stamina: 22, strength: 13, agility: 18, intellect: 16),
            imgUrl: "blood_bat",
            spellCountMin: 1,
            spellCountMax: 3,
            spells: [Spell.VampireBlood],
            lootItems: []
        ),
        Creature.Kodagu: Minions(
            type: Creature.Kodagu,
            name: "达古",
            race: EvilType.DEMON,
            settingGrowth: Mains(stamina: 2.2, strength: 2.2, agility: 0.6, intellect: 0.6),
            settingValue: Mains(stamina: 22, strength: 22, agility: 10, intellect: 10),
            imgUrl: "Kodagu",
            spellCountMin: 1,
            spellCountMax: 2,
            spells: [Spell.VampireBlood],
            lootItems: []
        ),
        Creature.EvilSpirit: Minions(
            type: Creature.EvilSpirit,
            name: "邪灵",
            race: EvilType.RISEN,
            settingGrowth: Mains(stamina: 1.5, strength: 0.5, agility: 0.8, intellect: 2.5),
            settingValue: Mains(stamina: 11, strength: 18, agility: 11, intellect: 29),
            imgUrl: "evil_spirit",
            spellCountMin: 2,
            spellCountMax: 3,
            spells: [Spell.FireOrFired],
            lootItems: []
        ),
        Creature.HellBaron: Minions(
            type: Creature.HellBaron,
            name: "地狱男爵",
            race: EvilType.RISEN,
            settingGrowth: Mains(stamina: 0.6, strength: 0.6, agility: 2.1, intellect: 2.4),
            settingValue: Mains(stamina: 26, strength: 21, agility: 11, intellect: 11),
            imgUrl: "hell_baron",
            spellCountMin: 1,
            spellCountMax: 3,
            spells: [Spell.LifeDraw],
            lootItems: []
        ),
        Creature.ChildLizard: Minions(
            type: Creature.ChildLizard,
            name: "小蜥蜴",
            race: EvilType.NATURE,
            settingGrowth: Mains(stamina: 1.8, strength: 2.2, agility: 1.1, intellect: 0.6),
            settingValue: Mains(stamina: 21, strength: 12, agility: 18, intellect: 18),
            imgUrl: "child_lizard",
            spellCountMin: 2,
            spellCountMax: 2,
            spells: [Spell.IceGuard],
            lootItems: []
        ),
        Creature.ForestGuard: Minions(
            type: Creature.ForestGuard,
            name: "丛林守卫",
            race: EvilType.MAN,
            settingGrowth: Mains(stamina: 1.1, strength: 1.1, agility: 1.1, intellect: 2.6),
            settingValue: Mains(stamina: 16, strength: 14, agility: 22, intellect: 19),
            imgUrl: "forest_guard",
            spellCountMin: 3,
            spellCountMax: 3,
            spells: [Spell.WindPunish],
            lootItems: []
        ),
        Creature.CrazyPlant: Minions(
            type: Creature.CrazyPlant,
            name: "疯狂的草",
            race: EvilType.NATURE,
            settingGrowth: Mains(stamina: 2.1, strength: 1.6, agility: 1.4, intellect: 0.6),
            settingValue: Mains(stamina: 28, strength: 12, agility: 12, intellect: 18),
            imgUrl: "crazy_plant",
            spellCountMin: 2,
            spellCountMax: 2,
            spells: [Spell.LeeAttack],
            lootItems: []
        ),
        Creature.CrazyCow: Minions(
            type: Creature.CrazyCow,
            name: "暴躁的奶牛",
            race: EvilType.NATURE,
            settingGrowth: Mains(stamina: 2.9, strength: 1.0, agility: 0.6, intellect: 0.6),
            settingValue: Mains(stamina: 21, strength: 18, agility: 16, intellect: 16),
            imgUrl: "cow_cow",
            spellCountMin: 1,
            spellCountMax: 2,
            spells: [Spell.Taunt],
            lootItems: []
        ),
        Creature.DarkNinja: Minions(
            type: Creature.DarkNinja,
            name: "黑暗忍着",
            race: EvilType.MAN,
            settingGrowth: Mains(stamina: 0.8, strength: 2.0, agility: 2.0, intellect: 0.6),
            settingValue: Mains(stamina: 11, strength: 16, agility: 21, intellect: 14),
            imgUrl: "dark_ninja",
            spellCountMin: 1,
            spellCountMax: 2,
            spells: [Spell.Disappear],
            lootItems: []
        ),
        Creature.HellNight: Minions(
            type: Creature.HellNight,
            name: "地狱骑士",
            race: EvilType.DEMON,
            settingGrowth: Mains(stamina: 3.0, strength: 1.3, agility: 0.5, intellect: 0.66),
            settingValue: Mains(stamina: 21, strength: 18, agility: 13, intellect: 17),
            imgUrl: "hell_rider",
            spellCountMin: 1,
            spellCountMax: 3,
            spells: [Spell.BargeAbout],
            lootItems: []
        ),
        Creature.BloodQueen: Minions(
            type: Creature.BloodQueen,
            name: "鲜血女王",
            race: EvilType.DEMON,
            settingGrowth: Mains(stamina: 1.2, strength: 0.4, agility: 1.2, intellect: 2.6),
            settingValue: Mains(stamina: 15, strength: 21, agility: 18, intellect: 21),
            imgUrl: "blood_queen",
            spellCountMin: 3,
            spellCountMax: 3,
            spells: [Spell.DeathGaze],
            lootItems: []
        ),
        Creature.ManWizard: Minions(
            type: Creature.ManWizard,
            name: "旅法师",
            race: EvilType.MAN,
            settingGrowth: Mains(stamina: 0.8, strength: 1.1, agility: 2.5, intellect: 1.9),
            settingValue: Mains(stamina: 11, strength: 16, agility: 19, intellect: 22),
            imgUrl: "wander_wizard",
            spellCountMin: 2,
            spellCountMax: 3,
            spells: [Spell.IceSpear],
            lootItems: []
        )
        /*
        Creature.WasteWalker: Minions(
            type: Creature.WasteWalker,
            name: "",
            race: EvilType.RISEN,
            settingGrowth: Mains(stamina: <#T##CGFloat#>, strength: <#T##CGFloat#>, agility: <#T##CGFloat#>, intellect: <#T##CGFloat#>),
            settingValue: Mains(stamina: <#T##CGFloat#>, strength: <#T##CGFloat#>, agility: <#T##CGFloat#>, intellect: <#T##CGFloat#>),
            imgUrl: "",
            spellCountMin: <#T##Int#>,
            spellCountMax: <#T##Int#>,
            spells: [],
            lootItems: []
        ),
        Creature.WasteWalker: Minions(
            type: Creature.WasteWalker,
            name: "",
            race: EvilType.RISEN,
            settingGrowth: Mains(stamina: <#T##CGFloat#>, strength: <#T##CGFloat#>, agility: <#T##CGFloat#>, intellect: <#T##CGFloat#>),
            settingValue: Mains(stamina: <#T##CGFloat#>, strength: <#T##CGFloat#>, agility: <#T##CGFloat#>, intellect: <#T##CGFloat#>),
            imgUrl: "",
            spellCountMin: <#T##Int#>,
            spellCountMax: <#T##Int#>,
            spells: [],
            lootItems: []
        ),
        Creature.WasteWalker: Minions(
            type: Creature.WasteWalker,
            name: "",
            race: EvilType.RISEN,
            settingGrowth: Mains(stamina: <#T##CGFloat#>, strength: <#T##CGFloat#>, agility: <#T##CGFloat#>, intellect: <#T##CGFloat#>),
            settingValue: Mains(stamina: <#T##CGFloat#>, strength: <#T##CGFloat#>, agility: <#T##CGFloat#>, intellect: <#T##CGFloat#>),
            imgUrl: "",
            spellCountMin: <#T##Int#>,
            spellCountMax: <#T##Int#>,
            spells: [],
            lootItems: []
        ),
        */
    ]
}
