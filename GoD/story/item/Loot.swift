//
//  Loot.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/6.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Loot: Core {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        if nil != Game.instance.char {
            _char = Game.instance.char!
        }
    }
    private var _char:Character!
    func getWeaponById(id:Int) -> Outfit {
        switch id {
        case 0:
            return Outfit(Outfit.Bow)
        case 1:
            return Outfit(Outfit.Sword)
        case 2:
            return Outfit(Outfit.Wand)
        case 3:
            return Outfit(Outfit.Dagger)
        case 4:
            return Outfit(Outfit.Blunt)
        case 6:
            return Outfit(Outfit.Instrument)
        case 5:
            return Outfit(Outfit.Fist)
        default:
            return Outfit(Outfit.Sword)
        }
    }
    var _weaponlist = [0,1,2,3,4,5,6]
    func lootWeapon(level:Int) -> Outfit {
        let list = [0,0,0,1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,66]
        let weapon = getWeaponById(id: list.one())
        weapon.create(level: level)
        return weapon
    }
    
    func getArmorById(id:Int) -> Outfit {
        switch id {
        case 0:
            return Outfit(Outfit.Amulet)
        case 1:
            return Outfit(Outfit.Ring)
        case 3:
            return Outfit(Outfit.MagicMark)
        case 2:
            return Outfit(Outfit.Shield)
        case 4:
            return Outfit(Outfit.EarRing)
        default:
            return Outfit(Outfit.Ring)
        }
    }
    
    var _armorlist = [0,1,2,3,4,5]
    func lootArmor(level:Int) -> Outfit {
        let list = [0,0,0,1,1,1,2,2,2,4,4,4,3,3]
        let armor = getArmorById(id: list.one())
        armor.create(level: level)
        return armor
    }
    static func getSpellById(_ id:Int) -> Spell {
        var spell = Loot.getNormalSpell(id: id)
        if spell._id == -1 {
            spell = Loot.getGoodSpell(id: id)
        }
        if spell._id == -1 {
            spell = Loot.getRareSpell(id: id)
        }
        if spell._id == -1 {
            spell = Loot.getSacredSpell(id: id)
        }
        if spell._id == -1 {
            spell = Loot.getSpellUnrecorded(id: id)
        }
        return spell
    }
//
//    func loot(role:Creature) {
//        var chance = seed().toFloat()
//        let lucky = Game.instance.char._lucky * 0.01 + 1
//        if chance < 20 * lucky  {
//            let a = lootArmor(level: role._level)
//            _props.append(a)
//        }
//        chance = seed().toFloat()
//        if chance < 15 * lucky {
//            let w = lootWeapon(level: role._level)
//            _props.append(w)
//        }
//        chance = seed().toFloat()
//        if chance < 2 * lucky {
//            let book = SpellBook()
//            book.spell = getSpellBook(role: role)
//            _props.append(book)
//        }
//        chance = seed().toFloat()
//        if chance < 30 * lucky {
//            let item = getItem()
//            _props.append(item)
//        }
//        chance = seed().toFloat()
//        if chance < 10 * lucky {
//            let sacred = getSacred()
//            if nil != sacred {
//                _props.append(sacred!)
//            }
//        }
//        externalLootAction()
//    }
    func lootInBossRoad(level:CGFloat) {
        var chance = seed().toFloat()
        let lucky = _char._lucky * 0.01 + getLevelDeviation()
        if chance < 5 * lucky  {
            _props.append(Item(Item.GiantPotion))
        }
        chance = seed().toFloat()
        if chance < 3 * lucky {
            _props.append(Item(Item.PsychicScroll))
        }
        chance = seed().toFloat()
        if chance < 2 * lucky {
            _props.append(Item(Item.GodTownScroll))
        }
        chance = seed().toFloat()
        if chance < 2 * lucky {
            _props.append(Item(Item.DeathTownScroll))
        }
        chance = seed().toFloat()
        if chance < 5 * lucky {
            _props.append(Item(Item.RedoSeed))
        }
        chance = seed().toFloat()
        if chance < 2 * lucky {
            _props.append(Item(Item.MPPotion))
        }
        chance = seed().toFloat()
        if chance < 5 * lucky {
            _props.append(Item(Item.LittleMPPotion))
        }
    }
    func lootInPalace(level:CGFloat) {
        var chance = seed().toFloat()
        let lucky = _char._lucky * 0.01 + getLevelDeviation()
        if chance < 7 * lucky  {
            _props.append(Item(Item.Angelsfuther))
        }
        chance = seed().toFloat()
        if chance < 1 * lucky  {
            _props.append(Item(Item.Angelsfuther))
        }
    }
    func lootInDemonTown(level:CGFloat) {
        var chance = seed().toFloat()
        let lucky = _char._lucky * 0.01 + getLevelDeviation()
        if chance < 6 * lucky  {
            _props.append(Item(Item.DemonsBlood))
        }
        chance = seed().toFloat()
        if chance < 1 * lucky  {
            _props.append(Item(Item.DemonsBlood))
        }
    }
    func loot(level:Int) {
        var chance = seed().toFloat()
        let lucky = _char._lucky * 0.01 + getLevelDeviation()
        if chance < 15 * lucky  {
            let l = [level - 1, level, level + 1, level + 2].one()
            let a = lootArmor(level: l)
            _props.append(a)
        }
        chance = seed().toFloat()
        if chance < 15 * lucky {
            let l = [level - 1, level, level + 1, level + 2].one()
            let w = lootWeapon(level: l)
            _props.append(w)
        }
        chance = seed().toFloat()
        if chance < 35 * lucky {
            let item = getItem()
            _props.append(item)
        }
        chance = seed().toFloat()
        if chance < 4 * lucky {
            let item = getSpellBook()
            _props.append(item)
        }
        chance = seed().toFloat()
        if chance < 15 * lucky {
            let s = getSacred()
            if nil != s && s!._level <= level + 5 && s!._level >= level - 30 {
                _props.append(s!)
            }
        }
        
    }
    
    func getLevelDeviation() -> CGFloat {
        let charLevel = Game.instance.char._level
        let sceneLevel = Game.instance.curStage._curScene._level
        if charLevel > sceneLevel {
            return 1 - (charLevel - sceneLevel) / 10
        }
        return 1
    }
    
    func getExp(selfUnit:BUnit, enemyLevel:CGFloat) -> CGFloat {
        let selfLevel = selfUnit._unit._level
        if selfLevel - enemyLevel > 5 {
          return 1
        }
        let lRate = 1 + (enemyLevel - selfLevel) * 0.1
        let range = seed(min: 80, max: 121).toFloat() * 0.01
        var val = (100 + enemyLevel * 2.5) * lRate * range
//        if selfUnit.ringIs(RingFromElder.EFFECTION) {
//            val *= 1.25
//        }
        if selfUnit.hasSpell(spell: VeryEcperienced()) {
            val *= 1.5
        }
        return val
    }
    var _normalSpellArray = [0,1,2,3,4,5,6,7,8,9]
    
    
    
    func getSpellBook() -> Item {
        let sed = seed()
        var s:Spell!
        
        if sed < 40 {
            s = Loot.getRandomNormalSpell()
        } else if sed < 70 {
            s = Loot.getRandomGoodSpell()
        } else if sed < 96 {
            s = Loot.getRandomRareSpell()
        } else {
            s = Loot.getRandomSacredSpell()
        }
        
        if s._id == -1 {
            return getSpellBook()
        }
        
        let sb = Item(Item.SpellBook)
        sb.spell = s
        
        return sb
    }
    static func getRandomNormalSpell() -> Spell {
        return Loot.getNormalSpell(id: Core().seed(min: 1001, max: 1024))
    }
    static func getRandomGoodSpell() -> Spell {
        return Loot.getGoodSpell(id: Loot.getRandomGoodSpellId())
    }
    static func getRandomRareSpell() -> Spell {
        return Loot.getRareSpell(id: Loot.getRandomRareSpellId())
    }
    static func getRandomSacredSpell() -> Spell {
        return Loot.getSacredSpell(id: Loot.getRandomSacredSpellId())
    }
    static func getRandomNormalSpellId() -> Int {
        return Core().seed(min: 1001, max: 1024)
    }
    static func getRandomGoodSpellId() -> Int {
        return Core().seed(min: 2001, max: 2029)
    }
    static func getRandomRareSpellId() -> Int {
        return Core().seed(min: 3001, max: 3032)
    }
    static func getRandomSacredSpellId() -> Int {
        return Core().seed(min: 4001, max: Loot.LastSacredSpellCountId + 1)
    }
    static let LastSacredSpellCountId = 4036
    static func getNormalSpell(id:Int) -> Spell {
//        debug("normal = \(id)")
        switch id {
        case Spell.Cruel:
            return Cruel()
        case Spell.Bellicose:
            return Bellicose()
        case Spell.BargeAbout:
            return BargeAbout()
        case Spell.FeignAttack:
            return FireBreath()
        case Spell.FireBreath:
            return FireBreath()
        case Spell.ToughHeart:
            return ToughHeart()
        case Spell.Focus:
            return Focus()
        case Spell.Strong:
            return Strong()
        case Spell.Energetic:
            return Energetic()
        case Spell.ThunderAttack:
            return ThunderAttack()
        case Spell.LowlevelFlame:
            return LowlevelFlame()
        case Spell.BreakDefence:
            return BreakDefence()
        case Spell.AttackHard:
            return AttackHard()
        case Spell.ScreamLoud:
            return ScreamLoud()
        case Spell.Burn:
            return Burn()
        case Spell.ControlWind:
            return ControlWind()
        case Spell.SharpStone:
            return SharpStone()
        case Spell.SkyAndLand:
            return SkyAndLand()
        case Spell.Powerful:
            return Powerful()
        case Spell.ChaosCore:
            return ChaosCore()
        case Spell.PoisonCurse:
            return PoisonCurse()
        case Spell.ColdWind:
            return ColdWind()
        case Spell.Heal:
            return Heal()
        default:
            return Attack()
        }
    }
    static func getGoodSpell(id:Int) -> Spell {
//        debug("good = \(id)")
        switch id {
        case Spell.BloodThirsty:
            return BloodThirsty()
        case Spell.LineAttack:
            return LineAttack()
        case Spell.FireFist:
            return FireFist()
        case Spell.FrozenShoot:
            return FrozenShoot()
        case Spell.Disappear:
            return Disappear()
        case Spell.IceFist:
            return IceFist()
        case Spell.QuickHeal:
            return QuickHeal()
        case Spell.Sacrifice:
            return Sacrifice()
        case Spell.Bitslap:
            return Bitslap()
        case Spell.LastChance:
            return LastChance()
        case Spell.PriceOfBlood:
            return PriceOfBlood()
        case Spell.MightOfOaks:
            return MightOfOaks()
        case Spell.ChaosAttack:
            return ChaosAttack()
        case Spell.Vanguard:
            return Vanguard()
        case Spell.TrueSight:
            return TrueSight()
        case Spell.LowerSummon:
            return LowerSummon()
        case Spell.IceSpear:
            return IceSpear()
        case Spell.DragonBlood:
            return DragonBlood()
        case Spell.FlameAttack:
            return FlameAttack()
        case Spell.OathBreaker:
            return OathBreaker()
        case Spell.WindAttack:
            return WindAttack()
        case Spell.WindPunish:
            return WindPunish()
        case Spell.BurningAll:
            return BurningAll()
        case Spell.ElementDestory:
            return ElementDestory()
        case Spell.SetTimeBack:
            return SetTimeBack()
        case Spell.AsShadow:
            return AsShadow()
        case Spell.Predict:
            return Predict()
        case Spell.Combustion:
            return Combustion()
        default:
            return Attack()
        }
    }
    static func getRareSpell(id:Int) -> Spell {
//        debug("rare = \(id)")
        switch id {
        case Spell.Lighting:
            return Lighting()
        case Spell.LeeAttack:
            return LeeAttack()
        case Spell.ProtectFromGod:
            return ProtectFromGod()
        case Spell.OneShootDoubleKill:
            return OneShootDoubleKill()
        case Spell.FireRain:
            return FireRain()
        case Spell.ThunderArray:
            return ThunderArray()
        case Spell.FragileCurse:
            return FragileCurse()
        case Spell.FireOrFired:
            return FireOrFired()
        case Spell.Firelord:
            return Firelord()
        case Spell.DeathStrike:
            return DeathStrike()
        case Spell.Taunt:
            return Taunt()
        case Spell.Interchange:
            return Interchange()
        case Spell.ProtectionFromIce:
            return ProtectionFromIce()
        case Spell.IceGuard:
            return IceGuard()
        case Spell.TruePower:
            return TruePower()
        case Spell.Dominate:
            return Dominate()
        case Spell.ShootAll:
            return ShootAll()
        case Spell.QiWave:
            return QiWave()
        case Spell.SongOfElement:
            return SongOfElement()
        case Spell.DancingDragon:
            return DancingDragon()
        case Spell.BallLighting:
            return BallLighting()
        case Spell.SuperWater:
            return SuperWater()
        case Spell.FireExplode:
            return FireExplode()
        case Spell.Reinforce:
            return Reinforce()
        case Spell.AttackPowerUp:
            return AttackPowerUp()
        case Spell.HolySacrifice:
            return HolySacrifice()
        case Spell.LifeFlow:
            return LifeFlow()
        case Spell.LeeAttack:
            return LeeAttack()
        case Spell.Ignite:
            return Ignite()
        case Spell.Blizzard:
            return Blizzard()
        case Spell.ShootTwo:
            return ShootTwo()
        case Spell.LavaExplosion:
            return LavaExplosion()
        default:
            return Attack()
        }
    }
    static func getSacredSpell(id:Int) -> Spell {
        switch id {
        case Spell.VampireBlood:
            return VampireBlood()
        case Spell.RaceSuperiority:
            return RaceSuperiority()
        case Spell.DancingOnIce:
            return DancingOnIce()
        case Spell.OnePunch:
            return OnePunch()
        case Spell.TurnAttack:
            return TurnAttack()
        case Spell.MagicConvert:
            return MagicConvert()
        case Spell.AttackReturnBack:
            return AttackReturnBack()
        case Spell.MagicReflect:
            return MagicReflect()
        case Spell.LifeDraw:
            return LifeDraw()
        case Spell.MagicSword:
            return MagicSword()
        case Spell.Refresh:
            return Refresh()
        case Spell.SummonFlower:
            return SummonFlower()
        case Spell.SwapHealth:
            return SwapHealth()
        case Spell.Steal:
            return Steal()
        case Spell.DeathGaze:
            return DeathGaze()
        case Spell.SpiritIntervene:
            return SpiritIntervene()
        case Spell.Immune:
            return Immune()
        case Spell.Reborn:
            return Reborn()
        case Spell.SoulLash:
            return SoulLash()
        case Spell.LightingFist:
            return LightingFist()
        case Spell.IceBomb:
            return IceBomb()
        case Spell.ElementMaster:
            return ElementMaster()
        case Spell.SpringIsComing:
            return SpringIsComing()
        case Spell.ControlUndead:
            return ControlUndead()
        case Spell.WaterCopy:
            return WaterCopy()
        case Spell.HighLevelSummon:
            return HighLevelSummon()
        case Spell.BearFriend:
            return BearFriend()
        case Spell.ElementPowerUp:
            return ElementPowerUp()
        case Spell.SoulExtract:
            return SoulExtract()
        case Spell.MindIntervene:
            return MindIntervene()
        case Spell.HealAll:
            return HealAll()
        case Spell.SilenceAll:
            return SilenceAll()
        case Spell.SixShooter:
            return SixShooter()
        case Spell.Zealot:
            return Zealot()
        case Spell.VeryEcperienced:
            return VeryEcperienced()
        case Spell.BurnHeart:
            return BurnHeart()
        default:
            return Attack()
        }
    }
    static func getSpellUnrecorded(id:Int) -> Spell {
        if id == Spell.ReduceLife {
            return ReduceLife()
        }
        if id == Spell.HorribleImage {
            return HorribleImage()
        }
        if id == Spell.HealOfFlower {
            return HealOfFlower()
        }
        if id == Spell.FacelessSpell {
            return FacelessSpell()
        }
        if id == Spell.DarkFall {
            return DarkFall()
        }
        if id == Spell.MessGhost {
            return MessGhost()
        }
        if id == Spell.SoulReaping {
            return SoulReaping()
        }
        if id == Spell.SoulSlay {
            return SoulSlay()
        }
        if id == Spell.Observant {
            return Observant()
        }
        if id == Spell.ThrowWeapon {
            return ThrowWeapon()
        }
        if id == Spell.ShadowCopy {
            return ShadowCopy()
        }
        if id == Spell.FlashPowder {
            return FlashPowder()
        }
        if id == Spell.Escape {
            return Escape()
        }
        if id == Spell.Thorny {
            return Thorny()
        }
        if id == Spell.TreadEarth {
            return TreadEarth()
        }
        if id == Spell.TakeRest {
            return TakeRest()
        }
        if id == Spell.ThrowRock {
            return ThrowRock()
        }
        if id == Spell.BeingTired {
            return BeingTired()
        }
        if id == Spell.Disintegrate {
            return Disintegrate()
        }
        if id == Spell.Infection {
            return Infection()
        }
        if id == Spell.BurningOut {
            return BurningOut()
        }
        if id == Spell.DrawBlood {
            return DrawBlood()
        }
        if id == Spell.Screaming {
            return Screaming()
        }
        if id == Spell.CriticalBite {
            return CriticalBite()
        }
        if id == Spell.SummonCopy {
            return SummonCopy()
        }
        if id == Spell.ExposeWeakness {
            return ExposeWeakness()
        }
        if id == Spell.SummonServant {
            return SummonServant()
        }
        if id == Spell.Nova {
            return Nova()
        }
        if id == Spell.DeathAttack {
            return DeathAttack()
        }
        if id == Spell.NoAction {
            return NoAction()
        }
        if id == Spell.HandOfGod {
            return HandOfGod()
        }
        if id == Spell.BlowMana {
            return BlowMana()
        }
        return Attack()
    }
    
    func getItem() -> Item {
        var list = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        list += [1,1,1,1,1,1,1,1]
        list += [2,2,2,2,2]
        list += [3,3]
        list += [4]
        list += [5]
        list += [6]
        list += [10]
        list += [11]
        return getItemByid(id: list.one())
    }
    func getItemByid(id: Int) -> Item {
        if 0 == id {
            return Item(Item.Tear)
        }
        if 1 == id {
            return Item(Item.LittlePotion)
        }
        if 2 == id {
            return Item(Item.Potion)
        }
        if 3 == id {
            return Item(Item.TownScroll)
        }
        if 4 == id {
            return Item(Item.SealScroll)
        }
        
        if 5 == id {
            return Item(Item.GodTownScroll)
        }
        
        if 6 == id {
            return Item(Item.DeathTownScroll)
        }
        
        if 7 == id {
            return Item(Item.RandomSacredSpell)
        }
        
        if 8 == id {
            return Item(Item.TransportScroll)
        }
        
        if 9 == id {
            return Item(Item.PsychicScroll)
        }
        if 10 == id {
            return Item(Item.RedoSeed)
        }
        if 11 == id {
            return Item(Item.MagicSyrup)
        }
        
        return Item(Item.Tear)
    }
    private var _props = Array<Item>()
    func getList() -> Array<Item> {
        return _props
    }
    var _sacredSwords = [1,2,3,4,5,6,7,8]
    static func getSacredSword(id:Int) -> Outfit {
        let outfit = Outfit(Outfit.Sword)
        switch id {
        case 1:
            outfit.create(effection: Sacred.NewSword)
            break
        case 2:
            outfit.create(effection: Sacred.NewSwordPlus)
            break
        case 3:
            outfit.create(effection: Sacred.DragonSlayer)
            break
        case 4:
            outfit.create(effection: Sacred.DragonSaliva)
            break
        case 5:
            outfit.create(effection: Sacred.TheExorcist)
            break
        case 6:
            outfit.create(effection: Sacred.BloodBlade)
            break
        case 7:
            outfit.create(effection: Sacred.ElementalSword)
            break
        case 8:
            outfit.create(effection: Sacred.IberisHand)
            break
        case 9:
            outfit.create(effection: Sacred.AssassinsSword)
            break
        default:
            break
        }
        return outfit
    }
//    var _sacredDaggers = [1,2]
    static func getSacredDagger(id:Int) -> Outfit {
        let outfit = Outfit(Outfit.Dagger)
        switch id {
        case 1:
            outfit.create(effection: Sacred.NightBlade)
            break
        case 2:
            outfit.create(effection: Sacred.LazesPedicureKnife)
            break
        default:
            break
        }
        return outfit
    }
//    var _sacredShields = [1,2,3,4]
    static func getSacredShield(id:Int) -> Outfit {
        let outfit = Outfit(Outfit.Shield)
        switch id {
        case 1:
            outfit.create(effection: Sacred.Faceless)
            break
        case 2:
            outfit.create(effection: Sacred.Accident)
            break
        case 3:
            outfit.create(effection: Sacred.FrancisFace)
            break
        case 4:
            outfit.create(effection: Sacred.EvilExpel)
            break
        default:
            break
        }
        return outfit
    }
//    var _sacredAmulets = [1,2,3,4,5,6,7,8]
    static func getSacredAmulet(id:Int) -> Outfit {
        let outfit = Outfit(Outfit.Amulet)
        switch id {
            case 1:
                outfit.create(effection: Sacred.TrueLie)
                break
            case 2:
                outfit.create(effection: Sacred.MedalOfCourage)
                break
            case 3:
                outfit.create(effection: Sacred.FangOfVampire)
                break
            case 4:
                outfit.create(effection: Sacred.MoonShadow)
                break
            case 5:
                outfit.create(effection: Sacred.EternityNight)
                break
            case 6:
                outfit.create(effection: Sacred.Sparkling)
                break
            case 7:
                outfit.create(effection: Sacred.MedalOfHero)
                break
            case 8:
                outfit.create(effection: Sacred.HeartOfJade)
                break
            default:
                break
        }
        return outfit
    }
//    var _sacredRings = [1,2,3,4,5,6,7,8,9,10]
    static func getSacredRing(id:Int) -> Outfit {
        let outfit = Outfit(Outfit.Ring)
        switch id {
        case 1:
            outfit.create(effection: Sacred.RingOfDead)
            break
        case 2:
            outfit.create(effection: Sacred.IdlirWeddingRing)
            break
        case 3:
            outfit.create(effection: Sacred.ApprenticeRing)
            break
        case 4:
            outfit.create(effection: Sacred.CopperRing)
            break
        case 5:
            outfit.create(effection: Sacred.SilverRing)
            break
        case 6:
            outfit.create(effection: Sacred.DellarsGoldenRing)
            break
        case 7:
            outfit.create(effection: Sacred.LuckyRing)
            break
        case 8:
            outfit.create(effection: Sacred.RingFromElder)
            break
        case 9:
            outfit.create(effection: Sacred.RingOfReborn)
            break
        case 10:
            outfit.create(effection: Sacred.FireCore)
            break
        default:
            break
        }
        return outfit
    }
//    var _sacredSoulstones = [1,2,3]
    static func getSacredSoulstone(id:Int) -> Outfit {
        let outfit = Outfit(Outfit.SoulStone)
        switch id {
        case 1:
            outfit.create(effection: Sacred.HeartOfSwamp)
            break
        case 2:
            outfit.create(effection: Sacred.PandoraHeart)
            break
        case 3:
            outfit.create(effection: Sacred.HeartOfTarrasque)
            break
        case 4:
            outfit.create(effection: Sacred.SoulPeace)
            break
        case 5:
            outfit.create(effection: Sacred.GiantSoul)
            break
        default:
            break
        }
        return outfit
    }
//    var _sacredInstruments = [1,2,3,4,5,6,7,8]
    static func getSacredInstrument(id:Int) -> Outfit {
        let outfit = Outfit(Outfit.Instrument)
        switch id {
        case 1:
            outfit.create(effection: Sacred.TheMonatNotes)
            break
        case 2:
            outfit.create(effection: Sacred.NoPants)
            break
        case 3:
            outfit.create(effection: Sacred.CreationMatrix)
            break
        case 4:
            outfit.create(effection: Sacred.TheSurvive)
            break
        case 5:
            outfit.create(effection: Sacred.TheDeath)
            break
        case 6:
            outfit.create(effection: Sacred.TheSurpass)
            break
        case 7:
            outfit.create(effection: Sacred.TheFear)
            break
        case 8:
            outfit.create(effection: Sacred.TheAbandon)
            break
        case 9:
            outfit.create(effection: Sacred.IssHead)
            break
        default:
            break

        }
        return outfit
    }
//    var _sacredWands = [1,2,3,4]
    static func getSacredWand(id:Int) -> Outfit {
        let outfit = Outfit(Outfit.Wand)
        switch id {
        case 1:
            outfit.create(effection: Sacred.LightingRod)
            break
        case 2:
            outfit.create(effection: Sacred.FireMaster)
            break
        case 3:
            outfit.create(effection: Sacred.WitchWand)
            break
        case 4:
            outfit.create(effection: Sacred.PuppetMaster)
            break
        default:
            break
        }
        return outfit
    }
//    var _sacredBlunts = [1,2,3,4,5]
    static func getSacredBlunt(id:Int) -> Outfit {
        let outfit = Outfit(Outfit.Blunt)
        switch id {
            case 1:
                outfit.create(effection: Sacred.IberisThignbone)
                break
            case 2:
                outfit.create(effection: Sacred.GiantFang)
                break
            case 3:
                outfit.create(effection: Sacred.ThorsHammer)
                break
            case 4:
                outfit.create(effection: Sacred.HolyPower)
                break
            case 5:
                outfit.create(effection: Sacred.IdyllssHand)
                break
            case 6:
                outfit.create(effection: Sacred.BansMechanArm)
                break
            default:
                break
        }
        return outfit
    }
//    var _sacredMarks = [1,2,3,4,5,6,7]
    static func getSacredMark(id:Int) -> Outfit {
        let outfit = Outfit(Outfit.MagicMark)
        switch id {
        case 1:
            outfit.create(effection: Sacred.PuppetMark)
            break
        case 2:
            outfit.create(effection: Sacred.MarkOfOaks)
            break
        case 3:
            outfit.create(effection: Sacred.MarkOfDeathGod)
            break
        case 4:
            outfit.create(effection: Sacred.MarkOfVitality)
            break
        case 5:
            outfit.create(effection: Sacred.MarkOfHeaven)
            break
        case 6:
            outfit.create(effection: Sacred.MoltenFire)
            break
        case 7:
            outfit.create(effection: Sacred.TheEye)
            break
        case 8:
            outfit.create(effection: Sacred.FireMark)
            break
        case 9:
            outfit.create(effection: Sacred.IssMark)
            break
        default:
            break
        }
        return outfit
    }
//    var _sacredBows = [1,2,3,4,5,6]
    static func getSacredBow(id:Int) -> Outfit {
        let outfit = Outfit(Outfit.Bow)
        switch id {
            case 1:
                outfit.create(effection: Sacred.Hawkeye)
                break
            case 2:
                outfit.create(effection: Sacred.Boreas)
                break
            case 3:
                outfit.create(effection: Sacred.Skylark)
                break
            case 4:
                outfit.create(effection: Sacred.SoundOfWind)
                break
            case 5:
                outfit.create(effection: Sacred.Aonena)
                break
            case 6:
                outfit.create(effection: Sacred.FollowOn)
                break
            default:
                break
        }
        return outfit
    }
//    var _sacredFists = [1,2,3,4,5]
    static func getSacredFist(id:Int) -> Outfit {
        let outfit = Outfit(Outfit.Fist)
        switch id {
        case 1:
            outfit.create(effection: Sacred.FingerBone)
            break
        case 2:
            outfit.create(effection: Sacred.LiosHold)
            break
        case 3:
            outfit.create(effection: Sacred.DragonClaw)
            break
        case 4:
            outfit.create(effection: Sacred.NilSeal)
            break
        case 5:
            outfit.create(effection: Sacred.DeepCold)
            break
        default:
            break
        }
        return outfit
    }
//    var _sacredEarrings = [1,2,3,4]
    static func getSacredEarring(id:Int) -> Outfit {
        let outfit = Outfit(Outfit.Amulet)
        switch id {
        case 1:
            outfit.create(effection: Sacred.VerdasTear)
            break
        case 2:
            outfit.create(effection: Sacred.DeepSeaPearl)
            break
        case 3:
            outfit.create(effection: Sacred.EyeOfDius)
            break
        case 4:
            outfit.create(effection: Sacred.LavaCrystal)
            break
        default:
            break
        }
        return outfit
    }
//    private func getSacredOutfit(id:Int) -> Outfit {
//        switch id {
//        case 1:
//            return getSacredSword(id:_sacredSwords.one())
//        case 2:
//            return getSacredDagger(id:_sacredDaggers.one())
//        case 3:
//            return getSacredShield(id:_sacredShields.one())
//        case 4:
//            return getSacredAmulet(id:_sacredAmulets.one())
//        case 5:
//            return getSacredRing(id:_sacredRings.one())
//        case 6:
//            return getSacredSoulstone(id:_sacredSoulstones.one())
//        case 7:
//            return getSacredInstrument(id:_sacredInstruments.one())
//        case 8:
//            return getSacredWand(id:_sacredWands.one())
//        case 9:
//            return getSacredBlunt(id:_sacredBlunts.one())
//        case 10:
//            return getSacredMark(id:_sacredMarks.one())
//        case 11:
//            return getSacredBow(id:_sacredBows.one())
//        case 12:
//            return getSacredEarring(id:_sacredEarrings.one())
//        case 13:
//            return getSacredFist(id: _sacredFists.one())
//        default:
//            return getSacredSword(id:_sacredSwords.one())
//        }
//
//    }
    
    func getSacred() -> Outfit? {
//        let outfit = getSacredOutfit(id: [1,2,3,4,5,6,7,8,9,10,11,12].one())
//        if outfit._level <= _char._level + 5 {
//            if seed(max: 150) <= outfit._chance {
//                outfit.create()
//                return outfit
//            }
//        }
        return nil
    }
    
    //abandoned
    private func resetSacredChance() {
//        _sacredSwords = []
//        _sacredDaggers = []
//        _sacredShields = []
//        _sacredAmulets = []
//        _sacredRings = []
//        _sacredSoulstones = []
//        _sacredInstruments = []
//        _sacredWands = []
//        _sacredBlunts = []
//        _sacredMarks = []
//        _sacredBows = []
//        _sacredEarrings = []
    }
    static func showLootItems(_ list:Array<Item>) {
        let cellSize = Game.instance.cellSize
        let node = SKSpriteNode()
        let fontSize = cellSize * 0.5
        var newList = Array<Item>()
        for item in list {
            if item.stackable {
                var exist = false
                for ni in newList {
                    if item._type == ni._type {
                        ni._count += item._count
                        exist = true
                        break
                    }
                }
                if !exist {
                    newList.append(item)
                }
            } else {
                newList.append(item)
            }
        }
        let width = (11 * fontSize.toInt() + 100).toFloat()
        let height = newList.count.toFloat() * fontSize + (cellSize * 2)
        let startY = newList.count.toFloat() * fontSize * 0.5
        var y:CGFloat = 0
        for i in newList {
            var text = ""
            if i.stackable {
                text = "你获得了[\(i._name)]x\(i._count)"
            } else {
                text = "你获得了[Lv\(i._level) \(i._name)]"
            }
            
            Game.instance.char.addItem(i, count: i._count)
            let l = Label()
            l.fontSize = fontSize
            l.align = "center"
            l.fontColor = QualityColor.getColor(i._quality)
            l.text = text
            l.position.y = startY - y * fontSize
            l.alpha = 0.9
            node.addChild(l)
            y += 1
        }
        let rect = CGRect(x: -width * 0.5, y: -height * 0.5, width: width, height: height)
        let bg = SKShapeNode(rect: rect, cornerRadius: 12)
        bg.fillColor = UIColor.black
        bg.alpha = 0.65
        node.addChild(bg)
        
        let border = SKShapeNode(rect: rect, cornerRadius: 4)
        border.lineWidth = 2
        node.addChild(border)
        
        node.zPosition = 1200
        let stage = Game.instance.curStage!
        stage._messageNode.removeFromParent()
        stage._messageNode = node
    //    node.isUserInteractionEnabled = true
        stage.addChild(node)
        setTimeout(delay: 3, completion: {
            if stage.contains(node) {
                node.removeFromParent()
                stage._messageNode = SKSpriteNode()
            }
        })
    }
}
