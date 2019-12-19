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
    var externalLootAction = {}
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
        let list = [0,0,0,1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6]
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
        let lucky = _char._lucky * 0.01 + 1
        if chance < 6 * lucky  {
            _props.append(Item(Item.GiantPotion))
        }
        chance = seed().toFloat()
        if chance < 3 * lucky {
            _props.append(Item(Item.PsychicScroll))
        }
        chance = seed().toFloat()
        if chance < 12 * lucky {
            _props.append(Item(Item.GodTownScroll))
        }
        chance = seed().toFloat()
        if chance < 12 * lucky {
            _props.append(Item(Item.DeathTownScroll))
        }
    }
    func loot(level:Int) {
        var chance = seed().toFloat()
        let lucky = _char._lucky * 0.01 + 1
        if chance < 15 * lucky  {
            let a = lootArmor(level: level)
            _props.append(a)
        }
        chance = seed().toFloat()
        if chance < 15 * lucky {
            let w = lootWeapon(level: level)
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
        
        externalLootAction()
//        return _props
    }
    
//    func createList() -> Array<Prop> {
//
//    }
    
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
        
//        if sed < 40 {
//            s = getRandomNormalSpell()
//        } else if sed < 70 {
//            s = getRandomGoodSpell()
//        } else if sed < 96 {
//            s = getRandomRareSpell()
//        } else {
//            s = getRandomSacredSpell()
//        }
        let sb = Item(Item.SpellBook)
//        sb.spell = s
        return sb
    }
//    static func getAllSpells() -> Array<Spell> {
//        var spells = Array<Spell>()
//        for i in 0...normalSpellCount - 1 {
//            spells.append(Loot.getNormalSpell(id: i))
//        }
//        for i in 0...goodSpellCount - 1 {
//            spells.append(Loot.getGoodSpell(id: i))
//        }
//        for i in 0...rareSpellCount - 1 {
//            spells.append(Loot.getRareSpell(id: i))
//        }
//        for i in 0...sacredSpellCount - 1 {
//            spells.append(Loot.getSacredSpell(id: i))
//        }
////        spells.append(BreakDefence())
//        spells.append(Heal())
//        spells.append(FireFist())
//        spells.append(Predict())
//        spells.append(Petrify())
//        spells.append(LowlevelFlame())
//        ///未收录 ------
//        spells.append(LavaExplode())
//        spells.append(Combustion())
//        spells.append(BurningOut())
//        spells.append(BurnHeart())
//        //--------------
//        return spells
//    }
//    func getRandomNormalSpell() -> Spell {
//        return getNormalSpell(id: seed(to: normalSpellCount))
//    }
//    func getRandomGoodSpell() -> Spell {
//        return getGoodSpell(id: seed(to: goodSpellCount))
//    }
//    func getRandomRareSpell() -> Spell {
//        return getRareSpell(id: seed(to: rareSpellCount))
//    }
//    func getRandomSacredSpell() -> Spell {
//        return getSacredSpell(id: seed(to: sacredSpellCount))
//    }
    let normalSpellCount = 22
    static func getNormalSpell(id:Int) -> Spell {
        switch id {
        case Spell.Cruel:
            return Cruel()
        case Spell.Bellicose:
            return Bellicose()
        case Spell.BargeAbout:
            return BargeAbout()
        case Spell.FeignAttack:
            return FeignAttack()
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
        default:
            return Attack()
        }
    }
    var _goodSpellArray = [0,1,2,3,4,5,6,7,8,9,10,11]
    let goodSpellCount = 26
    static func getGoodSpell(id:Int) -> Spell {
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
        default:
            return Attack()
        }
    }
    var _rareSpellArray = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]
    let rareSpellCount = 31
    
    static func getRareSpell(id:Int) -> Spell {
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
        default:
            return Attack()
        }
    }
    
    func getItem() -> Item {
        var list = [0,0,0,0,0,0,0,0,0,0]
        list += [1,1,1,1,1,1]
        list += [2,2,2]
        list += [3,3]
        list += [4]
        list += [5]
        list += [6]
        return getItemByid(id: list.one())
    }
    var _maxItemNumber = 10
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
        
        return Item(Item.Tear)
    }
    private var _props = Array<Item>()
    func getList() -> Array<Item> {
        return _props
    }
    var _sacredSwords = [1,2,3,4,5,6,7,8]
    func getSacredSword(id:Int) -> Outfit {
//        switch id {
//        case 1:
//            return NewSword()
//        case 2:
//            return NewSwordPlus()
//        case 3:
//            return DragonSlayer()
//        case 4:
//            return DragonSaliva()
//        case 5:
//            return TheExorcist()
//        case 6:
//            return BloodBlade()
//        case 7:
//            return ElementalSword()
//        case 8:
//            return IberisHand()
//        default:
//            return NewSword()
//        }
        return Outfit()
    }
//    var _sacredDaggers = [1,2]
//    func getSacredDagger(id:Int) -> Dagger {
//        switch id {
//        case 1:
//            return NightBlade()
//        case 2:
//            return LazesPedicureKnife()
//        default:
//            return NightBlade()
//        }
//    }
//    var _sacredShields = [1,2,3,4]
//    func getSacredShield(id:Int) -> Shield {
//        switch id {
//        case 1:
//            return Faceless()
//        case 2:
//            return Accident()
//        case 3:
//            return FrancisFace()
//        case 4:
//            return EvilExpel()
//        default:
//            return Faceless()
//        }
//    }
//    var _sacredAmulets = [1,2,3,4,5,6,7,8]
//    func getSacredAmulet(id:Int) -> Amulet {
//        switch id {
//        case 1:
//            return TrueLie()
//        case 2:
//            return MedalOfCourage()
//        case 3:
//            return FangOfVampire()
//        case 4:
//            return MoonShadow()
//        case 5:
//            return EternityNight()
//        case 6:
//            return Sparkling()
//        case 7:
//            return MedalOfHero()
//        case 8:
//            return JadeHeart()
//        default:
//            return TrueLie()
//        }
//    }
//    var _sacredRings = [1,2,3,4,5,6,7,8,9,10]
//    func getSacredRing(id:Int) -> Ring {
//        switch id {
//        case 1:
//            return RingOfDead()
//        case 2:
//            return IdlirWeddingRing()
//        case 3:
//            return ApprenticeRing()
//        case 4:
//            return CopperRing()
//        case 5:
//            return SilverRing()
//        case 6:
//            return DellarsGoldenRing()
//        case 7:
//            return LuckyRing()
//        case 8:
//            return RingFromElder()
//        case 9:
//            return RingOfReborn()
//        case 10:
//            return FireCore()
//        default:
//            return LuckyRing()
//        }
//    }
//    var _sacredSoulstones = [1,2,3]
//    func getSacredSoulstone(id:Int) -> SoulStone {
//        switch id {
//        case 1:
//            return HeartOfSwamp()
//        case 2:
//            return PandoraHeart()
//        case 3:
//            return HeartOfTarrasque()
//        default:
//            return HeartOfSwamp()
//        }
//    }
//    var _sacredInstruments = [1,2,3,4,5,6,7,8]
//    func getSacredInstrument(id:Int) -> Instrument {
//        switch id {
//        case 1:
//            return TheMonatNotes()
//        case 2:
//            return NoPants()
//        case 3:
//            return CreationMatrix()
//        case 4:
//            return TheSurvive()
//        case 5:
//            return TheDeath()
//        case 6:
//            return TheSurpass()
//        case 7:
//            return TheFear()
//        case 8:
//            return TheAbandon()
//        default:
//            return TheMonatNotes()
//        }
//    }
//    var _sacredWands = [1,2,3,4]
//    func getSacredWand(id:Int) -> Wand {
//        switch id {
//        case 1:
//            return LightingRod()
//        case 2:
//            return FireMaster()
//        case 3:
//            return WitchWand()
//        case 4:
//            return PuppetMaster()
//        default:
//            return LightingRod()
//        }
//    }
//    var _sacredBlunts = [1,2,3,4,5]
//    func getSacredBlunt(id:Int) -> Blunt {
//        switch id {
//        case 1:
//            return IberisThignbone()
//        case 2:
//            return GiantFang()
//        case 3:
//            return ThorsHammer()
//        case 4:
//            return HolyPower()
//        case 5:
//            return IdyllssHand()
//        case 6:
//            return BansMechanArm()
//        default:
//            return IberisThignbone()
//        }
//    }
//    var _sacredMarks = [1,2,3,4,5,6,7]
//    func getSacredMark(id:Int) -> MagicMark {
//        switch id {
//        case 1:
//            return PuppetMark()
//        case 2:
//            return MarkOfOaks()
//        case 3:
//            return MarkOfDeathGod()
//        case 4:
//            return MarkOfVitality()
//        case 5:
//            return MarkOfHeaven()
//        case 6:
//            return MoltenFire()
//        case 7:
//            return TheEye()
//        default:
//            return PuppetMark()
//        }
//    }
//    var _sacredBows = [1,2,3,4,5,6]
//    func getSacredBow(id:Int) -> Bow {
//        switch id {
//        case 1:
//            return Hawkeye()
//        case 2:
//            return Boreas()
//        case 3:
//            return Skylark()
//        case 4:
//            return SoundOfWind()
//        case 5:
//            return Aonena()
//        case 6:
//            return FollowOn()
//        default:
//            return Hawkeye()
//        }
//    }
//    var _sacredFists = [1,2,3,4,5]
//    func getSacredFist(id:Int) -> Fist {
//        switch id {
//        case 1:
//            return FingerBone()
//        case 2:
//            return LiosHold()
//        case 3:
//            return DragonClaw()
//        case 4:
//            return NilSeal()
//        case 5:
//            return DeepCold()
//        default:
//            return FingerBone()
//        }
//    }
//    var _sacredEarrings = [1,2,3,4]
//    func getSacredEarring(id:Int) -> EarRing {
//        switch id {
//        case 1:
//            return VerdasTear()
//        case 2:
//            return DeepSeaPearl()
//        case 3:
//            return EyeOfDius()
//        case 4:
//            return LavaCrystal()
//        default:
//            return VerdasTear()
//        }
//    }
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
}
