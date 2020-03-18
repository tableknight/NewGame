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
    }
    
    func setValue() {
        let data = ItemData.data[_type]!
        _type = data.type
        _name = data.name
        _showingText = data.showingText
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
        
        if _type == Item.SealScroll {
            targetEnemy = true
        } else if _type == Item.MagicSyrup {
            _reserveBool = seed() < 50
            _description = "法术敏感\(_reserveBool ? "提升" : "降低")1"
        } else if _type == Item.RedoSeed {
            _reserveBool = seed() < 50
            _reserveInt = seed(min: 1, max: 7)
            let v = abs(_reserveInt)
            let b = _reserveInt < 0
            if 1 == v {
                if b {
                    _description = "力量 +1，\(Attribute.STAMINA_TEXT) -1"
                } else {
                    _description = "力量 -1，\(Attribute.STAMINA_TEXT) +1"
                }
            } else if 2 == v {
                if b {
                    _description = "力量 +1，敏捷 -1"
                } else {
                    _description = "力量 -1，敏捷 +1"
                }
            } else if 3 == v {
                if b {
                    _description = "力量 +1，智力 -1"
                } else {
                    _description = "力量 -1，智力 +1"
                }
            } else if 4 == v {
                if b {
                    _description = "\(Attribute.STAMINA_TEXT) +1， 敏捷 -1"
                } else {
                    _description = "\(Attribute.STAMINA_TEXT) -1， 敏捷 +1"
                }
            } else if 5 == v {
                if b {
                    _description = "\(Attribute.STAMINA_TEXT) +1， 智力 -1"
                } else {
                    _description = "\(Attribute.STAMINA_TEXT) -1， 智力 +1"
                }
            } else if 6 == v {
                if b {
                    _description = "敏捷 +1，智力 -1"
                } else {
                    _description = "敏捷 -1，智力 +1"
                }
            }
        }
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
                Sound.play(node: c, fileName: "down")
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
                                unit._unit._elementalResistance.fire = 0
                                unit._unit._elementalResistance.water = 0
                                unit._unit._elementalResistance.thunder = 0
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
                Sound.play(node: unit, fileName: "heal")
                unit.cure1f() {
                    let change = unit.getHealth() * self._value
                    unit.showValue(value: change) {
                        completion()
                    }
                }
            }
        } else if _type == Item.TownScroll {
            Game.instance.curStage.removeBattle(_battle)
            let c = CenterV()
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
            let c = CenterV()
            Sound.play(node: Game.instance.curStage, fileName: "scroll")
            let char = Game.instance.curStage._curScene._role!
            let stage = Game.instance.curStage
            stage?.showUI()
            Game.instance.curStage.switchScene(next: c, completion: {
                c.setRole(x: 5, y: 7, char: char)
            })
        } else if _type == Item.DeathTownScroll {
            let c = DemonTownPortal()
            Sound.play(node: Game.instance.curStage, fileName: "scroll")
            let char = Game.instance.curStage._curScene._role!
            let stage = Game.instance.curStage
            stage?.showUI()
            Game.instance.curStage.switchScene(next: c, completion: {
                c.setRole(x: 6, y: 5, char: char)
            })
        } else if _type == Item.GodTownScroll {
            let c = SnowLandingHome()
            Sound.play(node: Game.instance.curStage, fileName: "scroll")
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
            Sound.play(node: Game.instance.curStage, fileName: "herb")
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
            Sound.dialog()
        } else if _type == Item.SpellBook {
            if _char.hasSpell(id: _spell) {
                showMsg(text: "已经习得该法术")
                return
            } else {
                _char._spells.append(_spell)
                showMsg(text: "习得法术[\(_name)]")
            }
            Sound.dialog()
        } else if _type == "lvScroll" {
            for u in [_char] + _char._minions {
                u.levelup()
            }
        } else if _type == Item.CreatureEssence {
            if _char._minions.count >= 6 {
                showMsg(text: "无法支配更多随从！")
                return
            } else {
                let c = Creature(_reserveStr)
                c.create(quality: _quality)
                _char._minions.append(c)
                showMsg(text: "获得了[lv1 \(c._name)]")
            }
        }
        removeAfterUse()
    }
    
    func use(target:Unit) {
        if _type == Item.Potion || _type == Item.LittlePotion || _type == Item.GiantPotion {
            target._extensions.hp += target._extensions.health * _value
            Sound.play(node: Game.instance.curStage, fileName: "heal")
            if target._extensions.hp >= target._extensions.health {
                target._extensions.hp = target._extensions.health
            }
        } else if _type == Item.LittleMPPotion || _type == Item.MPPotion || _type == Item.SoulMPPotion {
            target._extensions.mp += _value
            Sound.play(node: Game.instance.curStage, fileName: "buff")
            if target._extensions.mp >= target._extensions.mpMax {
                target._extensions.mp = target._extensions.mpMax
            }
        } else if _type == Item.ExpBook {
            Sound.play(node: Game.instance.curStage, fileName: "buff")
            target.expUp(up: _value)
        } else if _type == Item.RedoSeed {
            Sound.play(node: Game.instance.curStage, fileName: "heal")
            let v = abs(_reserveInt)
            let b = _reserveInt < 0
            if 1 == v {
                if b {
                    target.strengthChange(value: 1)
                    target.staminaChange(value: -1)
                } else {
                    target.strengthChange(value: -1)
                    target.staminaChange(value: 1)
                }
            } else if 2 == v {
                if b {
                    target.strengthChange(value: 1)
                    target.agilityChange(value: -1)
                } else {
                    target.strengthChange(value: -1)
                    target.agilityChange(value: 1)
                }
            } else if 3 == v {
                if b {
                    target.strengthChange(value: 1)
                    target.intellectChange(value: -1)
                } else {
                    target.strengthChange(value: -1)
                    target.intellectChange(value: 1)
                }
            } else if 4 == v {
                if b {
                    target.staminaChange(value: 1)
                    target.agilityChange(value: -1)
                } else {
                    target.staminaChange(value: -1)
                    target.agilityChange(value: 1)
                }
            } else if 5 == v {
                if b {
                    target.staminaChange(value: 1)
                    target.intellectChange(value: -1)
                } else {
                    target.staminaChange(value: -1)
                    target.intellectChange(value: 1)
                }
            } else if 6 == v {
                if b {
                    target.agilityChange(value: 1)
                    target.intellectChange(value: -1)
                } else {
                    target.agilityChange(value: -1)
                    target.intellectChange(value: 1)
                }
            }
        } else if _type == Item.MagicSyrup {
            Sound.play(node: Game.instance.curStage, fileName: "heal")
            let t = target as! Creature
            if _reserveBool {
                t._sensitive += 1
            } else {
                t._sensitive -= 1
            }
        }
        removeAfterUse()
    }
    
    private func removeAfterUse() {
        if Mode.itemcountless {
            return
        }
        Game.instance.char.removeItem(self)
    }
    private func inirAsSpellBook() {
        
    }

    var priceInStore:Int {
        get {
            if _priceType == Item.PRICE_TYPE_GOLD {
                return _price * 4
            }
            return _price
        }
    }
    
    var price4sale:Int {
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
            if spell._quality == Quality.NORMAL {
                _price = 6
            } else if spell._quality == Quality.GOOD {
                _price = 12
            } else if spell._quality == Quality.RARE {
                _price = 24
            } else {
                _price = 64
            }
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
    static let LittleMPPotion = "LittleMPPotion"
    static let SoulMPPotion = "SoulMPPotion"
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
    static let Angelsfuther = "Angelsfuther"
    static let DemonsBlood = "DemonsBlood"

    static let PureMagicStone = "PureMagicStone"
    static let MagicStone = "MagicStone"
    static let PureLifeStone = "PureLifeStone"
    static let LifeStone = "LifeStone"
    static let FireStone = "FireStone"
    static let WaterStone = "WaterStone"
    static let PureWaterStone = "PureWaterStone"
    static let PureFireStone = "PureFireStone"
    
    static let GoldCoin = "GoldCoin"
    static let RandomArmor = "RandomArmor"
    static let RandomWeapon = "RandomWeapon"
    static let RandomSpell = "RandomSpell"
    
    static let TearCluster = "TearCluster"
    
    var targetAll: Bool = false
    var canBeTargetSelf: Bool = false
    var targetEnemy: Bool = false
    var isClose: Bool = false
    var autoCast: Bool = false
    var canBeTargetSummonUnit: Bool = false
    var _type = ""
    var _name = ""
    var _showingText = ""
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
    var _reserveStr = ""
    var _reserveBool = false
    var _reserveInt = -1
    
    private enum CodingKeys: String, CodingKey {
        case targetAll
        case canBeTargetSelf
        case targetEnemy
        case isClose
        case autoCast
        case canBeTargetSummonUnit
        case _type
        case _name
        case _showingText
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
        case _reserveStr
        case _reserveBool
        case _reserveInt
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
        _showingText = try values.decode(String.self, forKey: ._showingText)
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
        _reserveStr = try values.decode(String.self, forKey: ._reserveStr)
        _reserveBool = try values.decode(Bool.self, forKey: ._reserveBool)
        _reserveInt = try values.decode(Int.self, forKey: ._reserveInt)
        
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
        try container.encode(_showingText, forKey: ._showingText)
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
        try container.encode(_reserveStr, forKey: ._reserveStr)
        try container.encode(_reserveBool, forKey: ._reserveBool)
        try container.encode(_reserveInt, forKey: ._reserveInt)
    }
}
//
struct ItemData:Codable {
    var type = ""
    var name = ""
    var showingText = ""
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
        Item.Tear: ItemData(type: Item.Tear, name: "天使之泪", showingText: "泪", desc: "一滴来自天使的眼泪，经过时间的沉淀，变成了一颗晶莹剔透的水晶，似乎拥有某种魔力", price: 6),
        Item.Skin: ItemData(type:Item.Skin, name: "皮毛", price: 6),
        Item.GoatHoof: ItemData(type:Item.GoatHoof, name: "羊蹄", price: 6),
        Item.Milk: ItemData(type:Item.Milk, name: "牛奶", price: 6),
        Item.LizardEye: ItemData(type:Item.LizardEye, name: "蜥蜴的眼球", price: 6),
        Item.Mushroom: ItemData(type:Item.Mushroom, name: "蘑菇", price: 6),
        Item.Egg: ItemData(type:Item.Egg, name: "鸟蛋", price: 6),
        Item.Angelsfuther: ItemData(type:Item.Angelsfuther, name: "天使之羽", showingText: "羽", price: 16),
        Item.DemonsBlood: ItemData(type:Item.DemonsBlood, name: "恶魔之血", showingText: "血", price: 16),
        Item.SpellBook: ItemData(type: Item.SpellBook, name: "法术书",  showingText: "书",price: 48, stackable: false, usable: true),
        Item.TearEssence: ItemData(type: Item.TearEssence, name: "眼泪精华", showingText: "精", desc: "获取若干个天使之泪", price: 32, usable: true),
        Item.CreatureEssence: ItemData(type: Item.CreatureEssence, name: "灵魂精华", desc: "灵魂凝聚而形成的结晶", price: 36, stackable: false, usable: true),
        Item.TownScroll: ItemData(type: Item.TownScroll, name: "传送卷轴·贝", desc: "传送到\(Game.VILLAGE_NAME)", price: 8, usable: true, castable: true),
        Item.GodTownScroll: ItemData(type: Item.GodTownScroll, name: "传送卷轴·雪", desc: "传送到神域·雪之国", price: 24, quality: Quality.RARE, usable: true, castable: true),
        Item.DeathTownScroll: ItemData(type: Item.DeathTownScroll, name: "传送卷轴·冥", desc: "传送到冥界·黄昏之城", price: 12, quality: Quality.GOOD, usable: true, castable: true),
        Item.TransportScroll: ItemData(type: Item.TransportScroll, name: "穿梭卷轴", desc: "越过面前的一块区域，只能在远古之路使用", price: 8, usable: true),
        Item.RandomSacredSpell: ItemData(type: Item.RandomSacredSpell, name: "无字天书", desc: "学会一个法术", price: 18, usable: true),
        
        Item.GoldPackage: ItemData(type: Item.GoldPackage, name: "一袋金币", showingText: "币", desc: "一袋沉甸甸的金币，不知道有多少个", price: 12, usable: true),
        Item.RedoSeed: ItemData(type: Item.RedoSeed, name: "重来的种子", showingText: "种", desc: "", price: 32, quality: Quality.SACRED, stackable: false, autoCast: false, usable: true),
        Item.MagicSyrup: ItemData(type: Item.MagicSyrup, name: "魔法糖浆", showingText: "浆", desc: "", price: 24, quality: Quality.GOOD, stackable: false, autoCast: false, usable: true),
        Item.Potion: ItemData(type: Item.Potion, name: "治疗药水", showingText: "药", desc: "恢复50%最大生命值", price: 6, quality: Quality.GOOD, value: 0.5, autoCast: false, usable: true, castable: true),
        Item.LittlePotion: ItemData(type: Item.LittlePotion, name: "小型治疗药水", showingText: "药", desc: "恢复25%最大生命值", price: 3,value: 0.25, autoCast: false, usable: true, castable: true),
        Item.GiantPotion: ItemData(type: Item.GiantPotion, name: "巨人药水", showingText: "药", desc: "恢复100%最大生命值", price: 18, quality: Quality.RARE, value: 1, autoCast: false, usable: true, castable: true),
        Item.MPPotion: ItemData(type: Item.MPPotion, name: "法力药水", showingText: "法", desc: "恢复200点法力", priceType: Item.PRICE_TYPE_TEAR, price: 6, quality: Quality.GOOD, value: 200, autoCast: false, usable: true),
        Item.LittleMPPotion: ItemData(type: Item.LittleMPPotion, name: "小型法力药水", showingText: "法", desc: "恢复75点法力", priceType: Item.PRICE_TYPE_TEAR, price: 2, value: 75, autoCast: false, usable: true),
        Item.SoulMPPotion: ItemData(type: Item.SoulMPPotion, name: "灵魂法力药水", showingText: "法", desc: "恢复450点法力", priceType: Item.PRICE_TYPE_TEAR, price: 12, quality: Quality.RARE, value: 450, autoCast: false, usable: true),
        Item.SealScroll: ItemData(type: Item.SealScroll, name: "封印卷轴", desc: "将一个虚弱的灵魂封印在卷轴里", price: 12, autoCast: false, usable: false, castable: true),
        Item.ExpBook: ItemData(type: Item.ExpBook, name: "传承之书", desc: "获得经验640点", price: 28, value: 640, autoCast: false, usable: true),
        
        Item.SummonScroll: ItemData(type: Item.SummonScroll, name: "", desc: "", usable: true),
        Item.PsychicScroll: ItemData(type: Item.PsychicScroll, name: "通灵卷轴", desc: "召唤一个强大的亡灵战士为你而战", priceType: Item.PRICE_TYPE_TEAR, price: 24, quality: Quality.SACRED, castable: true),
        Item.StarStone: ItemData(type: Item.StarStone, name: "星之石", desc: "高密度能量结晶，可以拆解出大量高纯度天使之泪", price: 128, usable: true),
        
        Item.DragonRoot: ItemData(type: Item.DragonRoot, name: "龙根", desc: "", price: 6, imgX: 11, imgY: 7),
        Item.SkyAroma: ItemData(type: Item.SkyAroma, name: "天麻", desc: "", price: 6, imgX: 7, imgY: 13),
        Item.PanGrass: ItemData(type: Item.PanGrass, name: "石菊", desc: "", price: 6, imgX: 3, imgY: 12),
        Item.Caesalpinia: ItemData(type: Item.Caesalpinia, name: "苦石莲", desc: "", price: 6, imgX: 10, imgY: 6),
        Item.Curium: ItemData(type: Item.Curium, name: "黄姜", desc: "", price: 6, imgX: 11, imgY: 5),
        
        Item.PureMagicStone: ItemData(type: Item.PureMagicStone, name: "完美火焰原石", desc: "", price: 8),
        Item.MagicStone: ItemData(type: Item.MagicStone, name: "", desc: "", price: 6),
        Item.PureLifeStone: ItemData(type: Item.PureLifeStone, name: "", desc: "", price: 8),
        Item.LifeStone: ItemData(type: Item.LifeStone, name: "", desc: "", price: 6),
        Item.FireStone: ItemData(type: Item.FireStone, name: "", desc: "", price: 6),
        Item.PureFireStone: ItemData(type: Item.PureFireStone, name: "", desc: "", price: 8),
        Item.WaterStone: ItemData(type: Item.WaterStone, name: "", desc: "", price: 6),
        Item.PureWaterStone: ItemData(type: Item.PureWaterStone, name: "", desc: "", price: 8),
        Item.TearCluster: ItemData(type: Item.TearCluster, name: "眼泪精华"),
        
        Item.GoldCoin: ItemData(type: Item.GoldCoin, name: "金币", stackable: true),
        
        Item.RandomArmor: ItemData(type: Item.RandomArmor, name: "防具", price: 12),
        Item.RandomWeapon: ItemData(type: Item.RandomWeapon, name: "武器", price: 12),
        Item.RandomSpell: ItemData(type: Item.RandomSpell, name: "法术书？", showingText: "书？", priceType: Item.PRICE_TYPE_TEAR, price: 48, quality: Quality.SACRED),
        "lvScroll": ItemData(type: "lvScroll", name: "升级卷轴", showingText: "升", priceType: Item.PRICE_TYPE_TEAR, price: 12, quality: Quality.SACRED, usable: true),
        
        
        
        
    ]
}

