//
//  Item.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/6.
//  Copyright © 2018年 Chen. All rights reserved.
//
import SpriteKit


class Item:Core, Castable, Showable {
    func findTarget() {
        
    }
    
    
    
    
    
    var _battle: Battle
    {
        set {
            _curBattle = newValue
        }
        get {
            return _curBattle
        }
    }
    var _curBattle:Battle!
    
    
    init(_ type:String) {
        super.init()
        if type.isEmpty {
            return
        }
        _type = type
        setValue()
//        if _type == Item.SpellBook {
//            
//        }
    }
    
    func setValue() {
        let data = ItemData.data[_type]!
        _type = data.type
        _name = data.name
        _description = data.desc
        _count = data.count
        _quality = data.quality
        _level = data.level
        _value = data.value
        _price = data.price
        _priceType = data.priceType
        autoCast = data.autoCast
        usable = data.usable
        castable = data.castable
        self.stackable = data.stackable
    }
    
    func selectable() -> Bool {
        let b = _battle
        if _type == Item.PsychicScroll {
            if b._playerPart.count >= 6 {
                return false
            }
        }
        return true
    }
    
    func cast(completion: @escaping () -> Void) {
        let b = _battle
        if _type == Item.PsychicScroll {
            let seats = _battle.getEmptySeats(top: !b._curRole.playerPart)
            _battle._curRole.actionCast {
                let seat = seats.one()
                let uw = [UndeadWarrior(), MummyMinion(), UndeadWitch(), UndeadMinion()].one()
                uw.create(level: b._curRole._unit._level)
                uw._seat = seat
                let bu = self._battle._curRole.playerPart ? b.addPlayerMinion(unit: uw) : b.addEnemy(unit: uw)
                bu.actionSummon {
                    completion()
                }
            }
        } else if _type == Item.SealScroll {
            let char = Game.instance.char!
            let c = _battle._curRole
            let unit = _battle._selectedTarget!
            c.showText(text: "封印") {
                unit.actionSealed {
                    let chance = self.seed(max: unit.getHealth().toInt()) * unit._unit._quality / 2
                    if Mode.debug || chance > unit.getHp().toInt() {
                        if char._minions.count >= 6 {
                            showMsg(text: "随从位已满！")
                            completion()
                        } else {
                            unit.actionDead {
                                unit.removeFromBattle()
                                unit.removeFromParent()
                                unit._unit._seat = BUnit.STAND_BY
                                char._minions.append(unit._unit as! Creature)
                                setTimeout(delay: 0.5) {
                                    if !self._battle.hasFinished() {
                                        completion()
                                    }
                                }
                            }
                        }
                    } else {
                        showMsg(text: "封印失败！")
                        completion()
                    }
                }
            }
        } else if _type == Item.Potion || _type == Item.LittlePotion || _type == Item.GiantPotion {
            let unit = _battle._selectedTarget!
            _battle._curRole.showText(text: _name) {
                unit.cure1f() {
                    let change = unit.getHealth() * self._value
                    unit.showValue(value: change) {
                        completion()
                    }
                }
            }
        } else if _type == Item.TownScroll {
            Game.instance.curStage.removeBattle(_battle)
            let c = CenterCamping()
            let char = Game.instance.curStage._curScene._role!
            let stage = Game.instance.curStage
            stage?.showUI()
            Game.instance.curStage.switchScene(next: c, completion: {
                c.setRole(x: 5, y: 7, char: char)
            })
        } else if _type == Item.DeathTownScroll {
            Game.instance.curStage.removeBattle(_battle)
            let c = DemonTownPortal()
            let char = Game.instance.curStage._curScene._role!
            let stage = Game.instance.curStage
            stage?.showUI()
            Game.instance.curStage.switchScene(next: c, completion: {
                c.setRole(x: 6, y: 5, char: char)
            })
        } else if _type == Item.GodTownScroll {
            Game.instance.curStage.removeBattle(_battle)
            let c = SnowLandingHome()
            let char = Game.instance.curStage._curScene._role!
            let stage = Game.instance.curStage
            stage?.showUI()
            Game.instance.curStage.switchScene(next: c, completion: {
                c.setRole(x: 7, y: 7, char: char)
            })
        }
        
        removeAfterUse()
    }
    
    func use() {
        let _char = Game.instance.char!
        if _type == Item.TownScroll {
            let c = CenterCamping()
            let char = Game.instance.curStage._curScene._role!
            let stage = Game.instance.curStage
            stage?.showUI()
            Game.instance.curStage.switchScene(next: c, completion: {
                c.setRole(x: 5, y: 7, char: char)
            })
        } else if _type == Item.DeathTownScroll {
            let c = DemonTownPortal()
            let char = Game.instance.curStage._curScene._role!
            let stage = Game.instance.curStage
            stage?.showUI()
            Game.instance.curStage.switchScene(next: c, completion: {
                c.setRole(x: 6, y: 5, char: char)
            })
        } else if _type == Item.GodTownScroll {
            let c = SnowLandingHome()
            let char = Game.instance.curStage._curScene._role!
            let stage = Game.instance.curStage
            stage?.showUI()
            Game.instance.curStage.switchScene(next: c, completion: {
                c.setRole(x: 7, y: 7, char: char)
            })
        } else if _type == Item.TransportScroll {
            let stage = Game.instance.curStage!
            let scene = Game.instance.curStage._curScene!
            
            if !(scene is AcientRoad) || scene is BossRoad {
                showMsg(text: "这里无法使用")
                return
            }
            if stage._curPanel != nil {
                stage.removePanel(stage._curPanel!)
            }
            
            let ar = scene as! AcientRoad
            if !ar.transport() {
                showMsg(text: "穿梭失败！")
                return
            }
        } else if _type == Item.StarStone {
            var count = seed(min: 2, max: 6)
            if _quality == Quality.GOOD {
                count = seed(min: 4, max: 9)
            } else if _quality == Quality.RARE {
                count = seed(min: 6, max: 11)
            } else if _quality == Quality.SACRED {
                count = seed(min: 9, max: 16)
            }
            let t = Item(Item.Tear)
            t._count = count
            _char.addItem(t)
            showMsg(text: "获得[天使之泪]x\(count)")
        } else if _type == Item.SpellBook {
            if _char.hasSpell(id: _spell) {
                showMsg(text: "已经习得该法术")
            } else {
                _char._spells.append(_spell)
                showMsg(text: "习得法术[\(_name)]")
            }
        }
        removeAfterUse()
    }
    
    func use(target:Unit) {
        if _type == Item.Potion || _type == Item.LittlePotion || _type == Item.GiantPotion {
            target._extensions.hp += target._extensions.health * _value
            if target._extensions.hp >= target._extensions.health {
                target._extensions.hp = target._extensions.health
            }
        } else if _type == Item.ExpBook {
            target.expUp(up: _value)
        } else if _type == Item.SpellBook {
//            if !_char.hasSpell(spell: _spell) {
////                _char._spells.append(_spell)
//            } else {
//                debug("spell exist")
//                return
//            }
        }
        removeAfterUse()
    }
    
    private func removeAfterUse() {
        Game.instance.char.removeItem(self)
    }
    private func inirAsSpellBook() {
        
    }

    var price:Int {
        set {
            _price = newValue
        }
        get {
            return _price
        }
    }
    var spell:Spell {
        set {
            _spell = newValue._id
            _quality = newValue._quality
            _name = newValue._name
            _description = newValue._description
        }
        get {
            return Loot.getSpellById(_spell)
        }
    }
//    private func actionSummon(unit: BUnit, completion: @escaping () -> Void) {
//        let b = _battle
//        let seats = _battle.getEmptySeats(top: !b._curRole.playerPart)
//        _battle._curRole.actionCast {
//            let seat = seats.one()
//            let uw = [UndeadWarrior(), MummyMinion(), UndeadWitch(), UndeadMinion()].one()
//            uw.create(level: b._curRole._unit._level)
//            uw._seat = seat
//            let bu = self._battle._curRole.playerPart ? b.addPlayerMinion(unit: uw) : b.addEnemy(unit: uw)
//            bu.actionSummon {
//                completion()
//            }
//        }
//    }
//    private func actionSeal(unit: BUnit, completion: @escaping () -> Void) {
//        let c = _battle._curRole
//        let _char = Game.instance.char!
//        c.showText(text: "封印") {
//            unit.actionSealed {
//                let chance = self.seed(max: unit.getHealth().toInt()) * unit._unit._quality / 2
//                if Mode.debug || chance > unit.getHp().toInt() {
//                    if _char._minions.count >= 6 {
//                        showMsg(text: "随从位已满！")
//                        completion()
//                    } else {
//                        unit.actionDead {
//                            unit.removeFromBattle()
//                            unit.removeFromParent()
//                            unit._unit._seat = BUnit.STAND_BY
//                            _char._minions.append(unit._unit as! Creature)
//                            setTimeout(delay: 0.5) {
//                                if !self._battle.hasFinished() {
//                                    completion()
//                                }
//                            }
//                        }
//                    }
//                } else {
//                    showMsg(text: "封印失败！")
//                    completion()
//                }
//            }
//        }
//    }

    static let PRICE_TYPE_GOLD = 1
    static let PRICE_TYPE_TEAR = 2
    static let Tear = "Tear"
    static let Meat = "Meat"
    static let Skin = "Skin"
    static let GoatHoof = "GoatHoof"
    static let Milk = "Milk"
    static let LizardEye = "LizardEye"
    static let Mushroom = "Mushroom"
    static let Egg = "Egg"


    static let SpellBook = "SpellBook"

    static let TearEssence = "TearEssence"
    static let CreatureEssence = "CreatureEssence"
    static let TownScroll = "TownScroll"
    static let GodTownScroll = "GodTownScroll"
    static let DeathTownScroll = "DeathTownScroll"
    static let GoldPackage = "GoldPackage"
    static let RedoSeed = "RedoSeed"
    static let MagicSyrup = "MagicSyrup"

    static let Potion = "Potion"
    static let LittlePotion = "LittlePotion"
    static let GiantPotion = "GiantPotion"
    static let MPPotion = "MPPotion"
    static let SummonScroll = "SummonScroll"
    static let PsychicScroll = "PsychicScroll"
    static let ExpBook = "ExpBook"
    static let StarStone = "StarStone"
    static let SoulEssence = "SoulEssence"
    static let SealScroll = "SealScroll"
    static let TransportScroll = "TransportScroll"
    static let RandomSacredSpell = "RandomSacredSpell"

    static let DragonRoot = "DragonRoot"
    static let SkyAroma = "SkyAroma"
    static let PanGrass = "PanGrass"
    static let Caesalpinia = "Caesalpinia"
    static let Curium = "Curium"

    static let PureMagicStone = "PureMagicStone"
    static let MagicStone = "MagicStone"
    static let PureLifeStone = "PureLifeStone"
    static let LifeStone = "LifeStone"
    static let FireStone = "FireStone"
    static let WaterStone = "WaterStone"
    static let PureWaterStone = "PureWaterStone"
    static let PureFireStone = "PureFireStone"
    
    static let GoldCoin = "GoldCoin"
    
    var targetAll: Bool = false
    var canBeTargetSelf: Bool = false
    var targetEnemy: Bool = false
    var isClose: Bool = false
    var autoCast: Bool = false
    var canBeTargetSummonUnit: Bool = false
    var _type = ""
    var _name = ""
    var _description = ""
    var _count = 1
    var _quality = 1
    var _level = 1
    var _value:CGFloat = 0
    var _price = 0
    var _priceType = 1
    var showCount = true
    var stackable = true
    var usable = false
    var castable = false
    var _spell = -1
    
    private enum CodingKeys: String, CodingKey {
        case targetAll
        case canBeTargetSelf
        case targetEnemy
        case isClose
        case autoCast
        case canBeTargetSummonUnit
        case _type
        case _name
        case _description
        case _count
        case _quality
        case _level
        case _value
        case _price
        case _priceType
        case showCount
        case stackable
        case usable
        case castable
        case _spell
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        targetAll = try values.decode(Bool.self, forKey: .targetAll)
        canBeTargetSelf = try values.decode(Bool.self, forKey: .canBeTargetSelf)
        targetEnemy = try values.decode(Bool.self, forKey: .targetEnemy)
        isClose = try values.decode(Bool.self, forKey: .isClose)
        autoCast = try values.decode(Bool.self, forKey: .autoCast)
        canBeTargetSummonUnit = try values.decode(Bool.self, forKey: .canBeTargetSummonUnit)
        
        _type = try values.decode(String.self, forKey: ._type)
        _name = try values.decode(String.self, forKey: ._name)
        _description = try values.decode(String.self, forKey: ._description)
        _count = try values.decode(Int.self, forKey: ._count)
        _quality = try values.decode(Int.self, forKey: ._quality)
        _level = try values.decode(Int.self, forKey: ._level)
        _value = try values.decode(CGFloat.self, forKey: ._value)
        _price = try values.decode(Int.self, forKey: ._price)
        _priceType = try values.decode(Int.self, forKey: ._priceType)
        showCount = try values.decode(Bool.self, forKey: .showCount)
        stackable = try values.decode(Bool.self, forKey: .stackable)
        usable = try values.decode(Bool.self, forKey: .usable)
        castable = try values.decode(Bool.self, forKey: .castable)
        _spell = try values.decode(Int.self, forKey: ._spell)
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(targetAll, forKey: .targetAll)
        try container.encode(canBeTargetSelf, forKey: .canBeTargetSelf)
        try container.encode(targetEnemy, forKey: .targetEnemy)
        try container.encode(isClose, forKey: .isClose)
        try container.encode(autoCast, forKey: .autoCast)
        try container.encode(canBeTargetSummonUnit, forKey: .canBeTargetSummonUnit)
        try container.encode(_type, forKey: ._type)
        try container.encode(_name, forKey: ._name)
        try container.encode(_description, forKey: ._description)
        try container.encode(_count, forKey: ._count)
        try container.encode(_quality, forKey: ._quality)
        try container.encode(_level, forKey: ._level)
        try container.encode(_value, forKey: ._value)
        try container.encode(_price, forKey: ._price)
        try container.encode(_priceType, forKey: ._priceType)
        try container.encode(showCount, forKey: .showCount)
        try container.encode(stackable, forKey: .stackable)
        try container.encode(usable, forKey: .usable)
        try container.encode(castable, forKey: .castable)
        try container.encode(_spell, forKey: ._spell)
    }
}
//
struct ItemData:Codable {
    var type = ""
    var name = ""
    var desc = ""
    var priceType = 1
    var price = 0
    var level = 1
    var count = 1
    var quality = 1
    var value:CGFloat = 0
    var stackable = true
    var imgX:CGFloat = 0
    var imgY:CGFloat = 0
    var autoCast = true
    var usable = false
    var castable = false
    
    static let data = [
        Item.Tear: ItemData(type: Item.Tear, name: "天使之泪", desc: "一滴来自天使的眼泪，经过时间的沉淀，变成了一颗晶莹剔透的水晶，似乎拥有某种魔力", price: 6),
        Item.Skin: ItemData(type:Item.Skin, name: "皮毛"),
        Item.GoatHoof: ItemData(type:Item.GoatHoof, name: "羊蹄"),
        Item.Milk: ItemData(type:Item.Milk, name: "牛奶"),
        Item.LizardEye: ItemData(type:Item.LizardEye, name: "蜥蜴的眼球"),
        Item.Mushroom: ItemData(type:Item.Mushroom, name: "蘑菇"),
        Item.Egg: ItemData(type:Item.Egg, name: "鸟蛋"),
        Item.SpellBook: ItemData(type: Item.SpellBook, name: "法术书", price: 48, stackable: false, usable: true),
        Item.TearEssence: ItemData(type: Item.TearEssence, name: "眼泪精华", desc: "获取若干个天使之泪", usable: true),
        Item.CreatureEssence: ItemData(type: Item.CreatureEssence, name: "灵魂精华", stackable: false, usable: true),
        Item.TownScroll: ItemData(type: Item.TownScroll, name: "传送卷轴·贝", desc: "传送到贝拉鲁村", usable: true, castable: true),
        Item.GodTownScroll: ItemData(type: Item.GodTownScroll, name: "传送卷轴·雪", desc: "传送到神域·雪之国", usable: true, castable: true),
        Item.DeathTownScroll: ItemData(type: Item.DeathTownScroll, name: "传送卷轴·冥", desc: "传送到冥界·黄昏之城", usable: true, castable: true),
        Item.TransportScroll: ItemData(type: Item.TransportScroll, name: "穿梭卷轴", desc: "越过面前的一块区域，只能在远古之路使用", usable: true),
        Item.RandomSacredSpell: ItemData(type: Item.RandomSacredSpell, name: "无字天书", desc: "学会一个法术", usable: true),
        
        Item.GoldPackage: ItemData(type: Item.GoldPackage, name: "一袋金币", desc: "一袋沉甸甸的金币，不知道有多少个", usable: true),
        Item.RedoSeed: ItemData(type: Item.RedoSeed, name: "重来的种子", desc: "", price: 32, quality: Quality.SACRED,autoCast: false, usable: true),
        Item.MagicSyrup: ItemData(type: Item.MagicSyrup, name: "魔法糖浆", desc: "", price: 24, quality: Quality.GOOD, autoCast: false, usable: true),
        Item.Potion: ItemData(type: Item.Potion, name: "治疗药水", desc: "恢复50%最大生命值", price: 6, quality: Quality.GOOD, value: 0.5, autoCast: false, usable: true, castable: true),
        Item.LittlePotion: ItemData(type: Item.LittlePotion, name: "小型治疗药水", desc: "恢复25%最大生命值", price: 3,value: 0.25, autoCast: false, usable: true, castable: true),
        Item.GiantPotion: ItemData(type: Item.GiantPotion, name: "巨人药水", desc: "恢复100%最大生命值", price: 18, quality: Quality.RARE, autoCast: false, usable: true, castable: true),
        Item.MPPotion: ItemData(type: Item.MPPotion, name: "法力药水", desc: "恢复35%f最大法力值", priceType: Item.PRICE_TYPE_TEAR, price: 36, autoCast: false, usable: true),
        Item.SealScroll: ItemData(type: Item.SealScroll, name: "封印卷轴", desc: "将一个虚弱的灵魂封印在卷轴里", price: 36, autoCast: false, usable: false, castable: true),
        Item.ExpBook: ItemData(type: Item.ExpBook, name: "传承之书", desc: "获得经验640点", value: 640, autoCast: false, usable: true),
        
        Item.SummonScroll: ItemData(type: Item.SummonScroll, name: "", desc: "", usable: true),
        Item.PsychicScroll: ItemData(type: Item.PsychicScroll, name: "通灵卷轴", desc: "召唤一个强大的亡灵战士为你而战", priceType: Item.PRICE_TYPE_TEAR, price: 42, castable: true),
        Item.StarStone: ItemData(type: Item.StarStone, name: "星之石", desc: "高密度能量结晶，可以拆解出大量高纯度天使之泪", price: 128, usable: true),
        
        Item.DragonRoot: ItemData(type: Item.DragonRoot, name: "龙根", desc: "", imgX: 11, imgY: 7),
        Item.SkyAroma: ItemData(type: Item.SkyAroma, name: "天麻", desc: "", imgX: 7, imgY: 13),
        Item.PanGrass: ItemData(type: Item.PanGrass, name: "石菊", desc: "", imgX: 3, imgY: 12),
        Item.Caesalpinia: ItemData(type: Item.Caesalpinia, name: "苦石莲", desc: "", imgX: 10, imgY: 6),
        Item.Curium: ItemData(type: Item.Curium, name: "黄姜", desc: "", imgX: 11, imgY: 5),
        
        Item.PureMagicStone: ItemData(type: Item.PureMagicStone, name: "完美火焰原石", desc: ""),
        Item.MagicStone: ItemData(type: Item.MagicStone, name: "", desc: ""),
        Item.PureLifeStone: ItemData(type: Item.PureLifeStone, name: "", desc: ""),
        Item.LifeStone: ItemData(type: Item.LifeStone, name: "", desc: ""),
        Item.FireStone: ItemData(type: Item.FireStone, name: "", desc: ""),
        Item.PureFireStone: ItemData(type: Item.PureFireStone, name: "", desc: ""),
        Item.WaterStone: ItemData(type: Item.WaterStone, name: "", desc: ""),
        Item.PureWaterStone: ItemData(type: Item.PureWaterStone, name: "", desc: ""),
        
        Item.GoldCoin: ItemData(type: Item.GoldCoin, name: "金币", stackable: true),
        
        
        
    ]
}

