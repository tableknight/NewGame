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
        if _type == Item.SpellBook {
            
        }
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
        self.stackable = data.stackable
    }
    
    func selectable() -> Bool {
        return true
    }
    
    func cast(completion: @escaping () -> Void) {
        
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
    
    func use(unit: BUnit, completion: @escaping () -> Void) {
        if _type == Item.Potion || _type == Item.LittlePotion || _type == Item.GiantPotion {
            _battle._curRole.showText(text: _name) {
                unit.cure1f() {
                    let change = unit.getHealth() * self._value
                    unit.showValue(value: change) {
                        completion()
                    }
                }
            }
        } else if _type == Item.SealScroll {
            actionSeal(unit: unit, completion: completion)
        } else if _type == Item.PsychicScroll {
            actionSummon(unit: unit, completion: completion)
        }
        
        removeAfterUse()
    }
    
    private func removeAfterUse() {
        
    }
    private func inirAsSpellBook() {
        
    }
//    var spell:String {
//        set {
////            _spell = newValue
////            _name = "\(newValue._name)之书"
////            _description = "使用后习得法术[\(newValue._name)]，\(newValue._description)"
////            _quality = newValue._quality
////            if _quality == Quality.NORMAL {
////                _price = 18
////            } else if _quality == Quality.GOOD {
////                _price = 48
////            } else if _quality == Quality.RARE {
////                _price = 108
////            } else if _quality == Quality.SACRED {
////                _price = 144
////            }
//        }
//        get {
////            return _spell
//        }
//    }
    var price:Int {
        set {
            _price = newValue
        }
        get {
            return _price
        }
    }
    private func actionSummon(unit: BUnit, completion: @escaping () -> Void) {
        let b = _battle
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
    }
    private func actionSeal(unit: BUnit, completion: @escaping () -> Void) {
        let c = _battle._curRole
        let _char = Game.instance.char!
        c.showText(text: "封印") {
            unit.actionSealed {
                let chance = self.seed(max: unit.getHealth().toInt()) * unit._unit._quality / 2
                if Mode.debug || chance > unit.getHp().toInt() {
                    if _char._minions.count >= 6 {
                        showMsg(text: "随从位已满！")
                        completion()
                    } else {
                        unit.actionDead {
                            unit.removeFromBattle()
                            unit.removeFromParent()
                            unit._unit._seat = BUnit.STAND_BY
                            _char._minions.append(unit._unit as! Creature)
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
    }
    
//    static let TYPE_TEAR = 1
//    static let TYPE_GOLD = 0
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//    var targetAll: Bool {
//        get {
//            return _isTargetAll
//        }
//    }
//
//    var targetEnemy: Bool {
//        set {
//            _isTargetEnemy = newValue
//        }
//        get {
//            return _isTargetEnemy
//        }
//    }
//
//    var canBeTargetPlayer: Bool {
//        get {
//            return _canBeTargetPlayer
//        }
//    }
//    var canBeTargetSelf: Bool {
//        set {
//            _canBeTargetSelf = newValue
//        }
//        get {
//            return _canBeTargetSelf
//        }
//    }
//
//    var canBeTargetSummonUnit: Bool {
//        set {
//            _canBeTargetSummonUnit = newValue
//        }
//        get {
//            return _canBeTargetSummonUnit
//        }
//    }
//
//    var isClose: Bool {
//        set {
//            _isClose = newValue
//        }
//        get {
//            return _isClose
//        }
//    }
//
//    var _isTargetAll = false
//    var _isTargetEnemy = false
//    var _canBeTargetPlayer = true
//    var _canBeTargetSelf = true
//    var _canBeTargetSummonUnit = true
//    var _isClose = false
//    var autoCast = false
//
//
//    func use() {}
//    func use(target:Creature) {}
//    func use(unit: BUnit, completion:@escaping () -> Void) {}
//    func selectable() -> Bool {
//        return true
//    }
//
//    override init() {
//        super.init()
//        _type = Prop.ITEM
//    }
//
////    required init(from decoder: Decoder) throws {
////        fatalError("init(from:) has not been implemented")
////    }
//
//    var usable = false
//    var usableInBattle = false
//    var _timeleft = 0
//    var _battle:Battle!
//    var _cooldown = 0
//
//    func timeleft() -> Int {
//        return _timeleft
//    }
//
//    func removeFromChar() {
//        Game.instance.char.removeProp(p: self)
//    }
//
//    override func getInfosDisplay() -> IPanelSize {
//        return ItemInfo()
//    }
//    func reduce() {
//        _count -= 1
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
    var _spell = ""
    
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
        _spell = try values.decode(String.self, forKey: ._spell)
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
        try container.encode(_spell, forKey: ._spell)
    }
}
//
//class TheWitchsTear:Item {
//    static let NAME = "天使之泪"
//    override init() {
//        super.init()
//        _showChar = "泪"
//        _price = 6
//        _storePrice = 24
//        _name = TheWitchsTear.NAME
//        _level = 1
//        _quality = Quality.NORMAL
//        _description = "一滴来自天使的眼泪，经过时间的沉淀，变成了一颗晶莹剔透的水晶，似乎拥有某种魔力"
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}
//
//class Potion:Item {
//    override init() {
//        super.init()
//        usable = true
//        usableInBattle = true
//        _price = 4
//        _storePrice = 16
//        _cooldown = 4
//        _showChar = "药"
//        _quality = Quality.GOOD
//        _name = "治疗药水"
//        _description = "恢复50%最大生命值"
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//    internal var _rate:CGFloat = 0.5
//
//    override func use(target: Creature) {
//        removeFromChar()
//        target._extensions.hp += target._extensions.health * _rate
//        if target._extensions.hp >= target._extensions.health {
//            target._extensions.hp = target._extensions.health
//        }
//    }
//
//    override func use(unit: BUnit, completion: @escaping () -> Void) {
//        _battle._curRole.showText(text: _name) {
//            unit.cure1f() {
//                let change = unit.getHealth() * self._rate
//                unit.showValue(value: change) {
//                    completion()
//                }
//            }
//        }
//        removeFromChar()
//    }
//}
//
//class LittlePotion:Potion {
//    override init() {
//        super.init()
//        _price = 3
//        _storePrice = 12
//        _cooldown = 2
//        _name = "治疗药水(小)"
//        _quality = Quality.NORMAL
//        _description = "恢复25%最大生命值"
//        _rate = 0.25
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}
//
//class GiantPotion:Potion {
//    override init() {
//        super.init()
//        _price = 36
//        _storePrice = 144
//        _cooldown = 2
//        _name = "巨人药水"
//        _quality = Quality.RARE
//        _description = "恢复100%最大生命值"
//        _rate = 1
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//}
//
//class SealScroll:Item {
//    override init() {
//        super.init()
//        usable = false
//        usableInBattle = true
//        targetEnemy = true
//        canBeTargetSummonUnit = false
//        _price = 8
//        _storePrice = 32
//        _cooldown = 0
//        _name = "封印卷轴"
//        _description = "对目标释放封印术"
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//    override func use(unit: BUnit, completion:@escaping () -> Void) {
//        let this = self
//        let char = Game.instance.char!
//        let c = _battle._curRole
//        removeFromChar()
//        c.showText(text: "封印") {
//            unit.actionSealed {
//                let chance = this.seed(max: unit.getHealth().toInt()) * unit._unit._quality / 2
//                if Mode.debug || chance > unit.getHp().toInt() {
//                    if char._minions.count >= 6 {
//                        showMsg(text: "随从位已满！")
//                        completion()
//                    } else {
//                        unit.actionDead {
//                            unit.removeFromBattle()
//                            unit.removeFromParent()
//                            unit._unit._seat = BUnit.STAND_BY
//                            char._minions.append(unit._unit)
//                            setTimeout(delay: 0.5) {
//                                if !this._battle.hasFinished() {
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
//}
//
//class TownScroll:Item {
//    override init() {
//        super.init()
//        usable = true
//        usableInBattle = true
//        _price = 6
//        _storePrice = 24
//        autoCast = true
//        _name = "传送卷轴·贝"
//        _showChar = "贝"
//        _description = "传送到贝拉姆村"
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//    override func use() {
//        removeFromChar()
////        showMsg(text: _description)
//        let c = CenterCamping()
//        let char = Game.instance.curStage._curScene._role!
//        let stage = Game.instance.curStage
//        stage?.showUI()
//        Game.instance.curStage.switchScene(next: c, completion: {
//            c.setRole(x: 5, y: 7, char: char)
//        })
//    }
//}
//class GodTownScroll:TownScroll {
//    override init() {
//        super.init()
//        usable = true
//        usableInBattle = true
//        _price = 24
//        _storePrice = 96
//        _name = "传送卷轴·雪"
//        _showChar = "雪"
//        _description = "传送到神域·雪之国"
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//    override func use() {
//        removeFromChar()
////        showMsg(text: _description)
//        let c = SnowLandingHome()
//        let char = Game.instance.curStage._curScene._role!
//        //        let stage = Game.instance.
//        let stage = Game.instance.curStage
//        stage?.showUI()
//        Game.instance.curStage.switchScene(next: c, completion: {
//            c.setRole(x: 7, y: 7, char: char)
//        })
//    }
//}
//class DeathTownScroll:TownScroll {
//    override init() {
//        super.init()
//        usable = true
//        usableInBattle = true
//        _price = 12
//        _storePrice = 48
//        _name = "传送卷轴·冥"
//        _showChar = "冥"
//        _description = "传送到黄昏之城"
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//    override func use() {
//        removeFromChar()
////        showMsg(text: _description)
//        let c = DemonTownPortal()
//        let char = Game.instance.curStage._curScene._role!
//        //        let stage = Game.instance.
//        let stage = Game.instance.curStage
//        stage?.showUI()
//        Game.instance.curStage.switchScene(next: c, completion: {
//            c.setRole(x: 6, y: 5, char: char)
//        })
//    }
//}
//
//class BlastScroll:Item {
//    override init() {
//        super.init()
//        usable = true
//        usableInBattle = false
//        price = 3
//        _name = "爆破卷轴"
//        _description = "移除面前的一个障碍物(只能在远古秘径中使用)"
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//    override func use() {
//        let stage = Game.instance.curStage!
//        let scene = Game.instance.curStage._curScene!
//        let bChar = scene._role!
//        let this = self
//        if stage._curPanel != nil {
//            stage.removePanel(stage._curPanel!)
//        }
//        bChar.actionSpark {
//            if (scene as! AcientRoad).blastItem() {
//                this.removeFromChar()
//            }
//        }
//
//    }
//}
//
//class TransportScroll:Item {
//    override init() {
//        super.init()
//        usable = true
//        usableInBattle = false
//        price = 56
//        _name = "穿梭卷轴"
//        _description = "越过当前障碍物，只能在远古之路使用"
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//    override func use() {
//        let stage = Game.instance.curStage!
//        let scene = Game.instance.curStage._curScene!
//
//        if !(scene is AcientRoad) || scene is BossRoad {
//            showMsg(text: "这里无法使用")
//            return
//        }
//        if stage._curPanel != nil {
//            stage.removePanel(stage._curPanel!)
//        }
//
//        let ar = scene as! AcientRoad
//        if !ar.transport() {
//            showMsg(text: "穿梭失败！")
//            return
//        }
//        removeFromChar()
//
//    }
//}
//
//class RandomWeapon:Item {
//    override init() {
//        super.init()
//        usable = true
//        usableInBattle = false
//        _price = 48
//        _storePrice = 48
//        _name = "武器"
//        _description = "获得一个随机属性的\(_name)"
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//    override func use() {
//        removeFromChar()
//        let l = Loot()
//        let char = Game.instance.char!
//        let weapon = l.getWeaponById(id: weaponId)
//        weapon.create(level: char._level)
//        char.addProp(p: weapon)
//        let stage = Game.instance.curStage!
//        stage.removePanel(stage._curPanel!)
//        let op = OutfitPanel()
//        op.create()
//        stage.showPanel(op)
//    }
//    var weaponId:Int = 0
//}
//
//class RandomArmor:Item {
//    override init() {
//        super.init()
//        usable = true
//        usableInBattle = false
//        _price = 48
//        _storePrice = 48
//        _name = "防具"
//        _description = "获得一个随机属性的\(_name)"
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//    override func use() {
//        removeFromChar()
//        let l = Loot()
//        let char = Game.instance.char!
//        let armor = l.getArmorById(id: armorId)
//        armor.create(level: char._level)
//        char.addProp(p: armor)
//        let stage = Game.instance.curStage!
//        stage.removePanel(stage._curPanel!)
//        let op = OutfitPanel()
//        op.create()
//        stage.showPanel(op)
//    }
//    var armorId:Int = 0
//}
//
//class RandomSacredSpell:Item {
//    override init() {
//        super.init()
//        usable = true
//        usableInBattle = false
//        _price = 48
//        _storePrice = 48
//        _priceType = 1
//        _name = "法术?"
//        _description = "获得一个随机的神之技"
//        _quality = Quality.SACRED
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//    override func use() {
//        removeFromChar()
//        let l = Loot()
//        let char = Game.instance.char!
//        let book = SpellBook()
//        book.spell = l.getRandomSacredSpell()
//        char.addProp(p: book)
//    }
//}
//
//class LevelUpScroll:Item {
//    override init() {
//        super.init()
//        usable = true
//        usableInBattle = false
//        price = 180
//        _name = "升级卷轴"
//        _description = "画所有单位s等级提升1"
//        _quality = Quality.SACRED
//    }
//    required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//    override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//    }
//    override func use() {
//        let r:Array<Creature> = [Game.instance.char] + Game.instance.char._minions
//        for c in r {
//            c.levelup()
//
//        }
//        Game.instance.char._dungeonLevel += 1
//    }
//    var armorId:Int = 0
//}
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
        Item.TownScroll: ItemData(type: Item.TownScroll, name: "传送卷轴·贝", desc: "传送到贝拉鲁村", usable: true),
        Item.GodTownScroll: ItemData(type: Item.GodTownScroll, name: "传送卷轴·雪", desc: "传送到贝拉鲁村", usable: true),
        Item.DeathTownScroll: ItemData(type: Item.DeathTownScroll, name: "传送卷轴·冥", desc: "传送到贝拉鲁村", usable: true),
        Item.TransportScroll: ItemData(type: Item.TransportScroll, name: "穿梭卷轴", desc: "", usable: true),
        Item.RandomSacredSpell: ItemData(type: Item.RandomSacredSpell, name: "穿梭RandomSacredSpell", desc: "", usable: true),
        
        Item.GoldPackage: ItemData(type: Item.GoldPackage, name: "", desc: "", usable: true),
        Item.RedoSeed: ItemData(type: Item.RedoSeed, name: "", desc: "", autoCast: false, usable: true),
        Item.MagicSyrup: ItemData(type: Item.MagicSyrup, name: "", desc: "", autoCast: false, usable: true),
        Item.Potion: ItemData(type: Item.Potion, name: "治疗药水", desc: "恢复50%最大生命值", quality: Quality.GOOD, value: 0.5, autoCast: false, usable: true),
        Item.LittlePotion: ItemData(type: Item.LittlePotion, name: "", desc: "", autoCast: false, usable: true),
        Item.GiantPotion: ItemData(type: Item.GiantPotion, name: "", desc: "", autoCast: false, usable: true),
        Item.MPPotion: ItemData(type: Item.MPPotion, name: "", desc: "", autoCast: false, usable: true),
        Item.SealScroll: ItemData(type: Item.SealScroll, name: "封印卷轴", autoCast: false, usable: true),
        Item.ExpBook: ItemData(type: Item.ExpBook, name: "", desc: "", autoCast: false, usable: true),
        
        Item.SummonScroll: ItemData(type: Item.SummonScroll, name: "", desc: "", usable: true),
        Item.PsychicScroll: ItemData(type: Item.PsychicScroll, name: "", desc: "", usable: true),
        Item.StarStone: ItemData(type: Item.StarStone, name: "", desc: "", usable: true),
        
        Item.DragonRoot: ItemData(type: Item.DragonRoot, name: "龙根", desc: "", imgX: 11, imgY: 7),
        Item.SkyAroma: ItemData(type: Item.SkyAroma, name: "天麻", desc: "", imgX: 7, imgY: 13),
        Item.PanGrass: ItemData(type: Item.PanGrass, name: "石菊", desc: "", imgX: 3, imgY: 12),
        Item.Caesalpinia: ItemData(type: Item.Caesalpinia, name: "苦石莲", desc: "", imgX: 10, imgY: 6),
        Item.Curium: ItemData(type: Item.Curium, name: "黄姜", desc: "", imgX: 11, imgY: 5),
        
        Item.PureMagicStone: ItemData(type: Item.PureMagicStone, name: "", desc: ""),
        Item.MagicStone: ItemData(type: Item.MagicStone, name: "", desc: ""),
        Item.PureLifeStone: ItemData(type: Item.PureLifeStone, name: "", desc: ""),
        Item.LifeStone: ItemData(type: Item.LifeStone, name: "", desc: ""),
        Item.FireStone: ItemData(type: Item.FireStone, name: "", desc: ""),
        Item.PureFireStone: ItemData(type: Item.PureFireStone, name: "", desc: ""),
        Item.WaterStone: ItemData(type: Item.WaterStone, name: "", desc: ""),
        Item.PureWaterStone: ItemData(type: Item.PureWaterStone, name: "", desc: ""),
        
        
        
    ]
}
