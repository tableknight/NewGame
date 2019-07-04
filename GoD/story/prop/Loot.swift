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
    func getWeaponById(id:Int) -> Weapon {
        switch id {
        case 0:
            return Bow()
        case 1:
            return Sword()
        case 2:
            return Wand()
        case 3:
            return Dagger()
        case 4:
            return Blunt()
        case 6:
            return Instrument()
        case 5:
            return Fist()
        default:
            return Sword()
        }
    }
    var _weaponlist = [0,1,2,3,4,5,6]
    func lootWeapon(level:CGFloat) -> Weapon {
        let list = [0,0,0,1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6]
        let weapon = getWeaponById(id: list.one())
        weapon.create(level: level)
        return weapon
    }
    
    func getArmorById(id:Int) -> Armor {
        switch id {
        case 0:
            return Amulet()
        case 1:
            return Ring()
        case 3:
            return MagicMark()
        case 2:
            return Shield()
        case 4:
            return EarRing()
        default:
            return Ring()
        }
    }
    
    var _armorlist = [0,1,2,3,4,5]
    func lootArmor(level:CGFloat) -> Armor {
        let list = [0,0,0,1,1,1,2,2,2,4,4,4,3,3]
        let armor = getArmorById(id: list.one())
        armor.create(level: level)
        return armor
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
    func loot(level:CGFloat) {
        var chance = seed().toFloat()
        let lucky = _char._lucky * 0.01 + 1
        if chance < 20 * lucky  {
            let a = lootArmor(level: level)
            _props.append(a)
        }
        chance = seed().toFloat()
        if chance < 20 * lucky {
            let w = lootWeapon(level: level)
            _props.append(w)
        }
        chance = seed().toFloat()
        if chance < 50 * lucky {
            let item = getItem()
            _props.append(item)
        }
        chance = seed().toFloat()
        if chance < 3 * lucky {
            let item = getSpellBook()
            _props.append(item)
        }
        chance = seed().toFloat()
        if chance < 25 * lucky {
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
    
    func getExp(selfLevel:CGFloat, enemyLevel:CGFloat) -> CGFloat {
        if abs(selfLevel - enemyLevel) > 5 {
          return 0
        }
        let lRate = 1 + (enemyLevel - selfLevel) * 0.1
        let range = seed(min: 80, max: 121).toFloat() * 0.01
        return (100 + enemyLevel * 2.5) * lRate * range
    }
    var _normalSpellArray = [0,1,2,3,4,5,6,7,8,9]
    
    
    
    func getSpellBook() -> SpellBook {
        let sed = seed()
        var s = Spell()
        
        if sed < 50 {
            s = getRandomNormalSpell()
        } else if sed < 80 {
            s = getRandomGoodSpell()
        } else if sed < 96 {
            s = getRandomRareSpell()
        } else {
            s = getRandomSacredSpell()
        }
        let sb = SpellBook()
        sb.spell = s
        return sb
    }
    func getAllSpells() -> Array<Spell> {
        var spells = Array<Spell>()
        for i in 0...normalSpellCount - 1 {
            spells.append(getNormalSpell(id: i))
        }
        for i in 0...goodSpellCount - 1 {
            spells.append(getGoodSpell(id: i))
        }
        for i in 0...rareSpellCount - 1 {
            spells.append(getRareSpell(id: i))
        }
        for i in 0...sacredSpellCount - 1 {
            spells.append(getSacredSpell(id: i))
        }
        spells.append(BreakDefence())
        spells.append(Heal())
        spells.append(FireFist())
        spells.append(Predict())
        spells.append(Petrify())
        ///未收录 ------
        spells.append(LavaExplode())
        spells.append(Combustion())
        spells.append(BurningOut())
        spells.append(BurnHeart())
        //--------------
        return spells
    }
    func getRandomNormalSpell() -> Spell {
        return getNormalSpell(id: seed(to: normalSpellCount))
    }
    func getRandomGoodSpell() -> Spell {
        return getGoodSpell(id: seed(to: goodSpellCount))
    }
    func getRandomRareSpell() -> Spell {
        return getRareSpell(id: seed(to: rareSpellCount))
    }
    func getRandomSacredSpell() -> Spell {
        return getSacredSpell(id: seed(to: sacredSpellCount))
    }
    let normalSpellCount = 16
    func getNormalSpell(id:Int) -> Spell {
        switch id {
        case 0:
            return Cruel()
        case 1:
            return Bellicose()
        case 2:
            return BargeAbout()
        case 3:
            return FeignAttack()
        case 4:
            return FireBreath()
//        case 5:
//            return Heal() //职业初始技能专属
        case 6:
            return Focus()
        case 7:
            return Strong()
        case 8:
            return Energetic()
        case 9:
            return ThunderAttack()
        case 10:
            return LowlevelFlame()
//        case 11:
//            return BreakDefence()
        case 12:
            return AttackHard()
        case 13:
            return ScreamLoud()
        case 14:
            return Burn()
        case 15:
            return ControlWind()
        default:
            return Cruel()
        }
    }
    var _goodSpellArray = [0,1,2,3,4,5,6,7,8,9,10,11]
    let goodSpellCount = 25
    func getGoodSpell(id:Int) -> Spell {
        switch id {
        case 0:
            return BloodThirsty()
        case 1:
            return LineAttack()
//        case 2:
//            return FireFist()
        case 3:
            return FrozenShoot()
        case 4:
            return Disappear()
        case 5:
            return IceFist()
        case 6:
            return QuickHeal()
        case 7:
            return Sacrifice()
        case 8:
            return Bitslap()
        case 9:
            return LastChance()
        case 10:
            return PriceOfBlood()
        case 11:
            return MightOfOaks()
        case 12:
            return ChaosAttack()
        case 13:
            return Vanguard()
        case 14:
            return TrueSight()
        case 15:
            return LowerSummon()
        case 16:
            return IceSpear()
        case 17:
            return DragonBlood()
        case 18:
            return FlameAttack()
        case 19:
            return OathBreaker()
        case 20:
            return WindAttack()
        case 21:
            return WindPunish()
        case 22:
            return BurningAll()
        case 23:
            return ElementDestory()
        case 24:
            return SetTimeBack()
        default:
            return BloodThirsty()
        }
    }
    var _rareSpellArray = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]
    let rareSpellCount = 31
    func getRareSpell(id:Int) -> Spell {
        switch id {
        case 0:
            return Lighting()
        case 1:
            return LeeAttack() //
        case 2:
            return ProtectFromGod()
        case 3:
            return OneShootDoubleKill()
        case 4:
            return FireRain()
        case 5:
            return ThunderArray()
        case 6:
            return FragileCurse()
        case 7:
            return FireOrFired()
        case 8:
            return Firelord()
        case 9:
            return DeathStrike()
        case 10:
            return Taunt()
        case 11:
            return Interchange()
        case 12:
            return ProtectionFromIce()
        case 13:
            return IceGuard()
        case 14:
            return TruePower()
        case 15:
            return Dominate()
        case 16:
            return ShootAll()
        case 17:
            return QiWave()
        case 18:
            return SongOfElement()
        case 19:
            return Lighting() //多余
        case 20:
            return DancingDragon()
        case 21:
            return BallLighting()
        case 22:
            return SuperWater()
        case 23:
            return FireExplode()
        case 24:
            return Reinforce()
        case 25:
            return AttackPowerUp()
        case 26:
            return HolySacrifice()
        case 27:
            return LifeFlow()
        case 28:
            return LeeAttack()
        case 29:
            return Ignite()
        case 30:
            return Blizzard()
        default:
            return Lighting()
        }
    }
    var _sacredSpellArray = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18]
    let sacredSpellCount = 33
    func getSacredSpell(id:Int) -> Spell {
        switch id {
        case 0:
            return VampireBlood()
        case 1:
            return RaceSuperiority()
        case 2:
            return DancingOnIce()
        case 3:
            return OnePunch()
        case 4:
            return TurnAttack()
        case 5:
            return MagicConvert()
        case 6:
            return AttackReturnBack()
        case 7:
            return MagicReflect()
        case 8:
            return LifeDraw()
        case 9:
            return MagicSword()
        case 10:
            return Refresh()
        case 11:
            return SummonFlower()
        case 12:
            return SwapHealth()
        case 13:
            return Steal()
        case 14:
            return DeathGaze()
        case 15:
            return SpiritIntervene()
        case 16:
            return Immune()
        case 17:
            return Reborn()
        case 18:
            return SoulLash()
        case 19:
            return LightingFist()
        case 20:
            return IceBomb()
        case 21:
            return ElementMaster()
        case 22:
            return SpringIsComing()
        case 23:
            return ControlUndead()
        case 24:
            return WaterCopy()
        case 25:
            return HighLevelSummon()
        case 26:
            return BearFriend()
        case 27:
            return ElementPowerUp()
        case 28:
            return SoulExtract()
        case 29:
            return MindIntervene()
        case 30:
            return HealAll()
        case 31:
            return SilenceAll()
        case 32:
            return SixShooter()
        default:
            return VampireBlood()
        }
    }
    
    func getItem() -> Item {
        var list = [0,0,0,0,0,0,0,0,0,0]
        list += [1,1,1,1,1,1]
        list += [2,2,2]
        list += [3,3]
        list += [4]
        return getItemByid(id: list.one())
    }
    func getItemByid(id: Int) -> Item {
        if 0 == id {
            return TheWitchsTear()
        }
        if 1 == id {
            return LittlePotion()
        }
        if 2 == id {
            return Potion()
        }
        if 3 == id {
            return TownScroll()
        }
        if 4 == id {
            return SealScroll()
        }
        
        if 5 == id {
            return GodTownScroll()
        }
        
        if 6 == id {
            return DeathTownScroll()
        }
        
        if 7 == id {
            return RandomSacredSpell()
        }
        
        return TheWitchsTear()
    }
    private var _props = Array<Prop>()
    func getList() -> Array<Prop> {
        return _props
    }
    var _sacredSwords = [1,2,3,4,5,6,7,8]
    func getSacredSword(id:Int) -> Sword {
        switch id {
        case 1:
            return NewSword()
        case 2:
            return NewSwordPlus()
        case 3:
            return DragonSlayer()
        case 4:
            return DragonSaliva()
        case 5:
            return TheExorcist()
        case 6:
            return BloodBlade()
        case 7:
            return ElementalSword()
        case 8:
            return IberisHand()
        default:
            return NewSword()
        }
    }
    var _sacredDaggers = [1,2]
    func getSacredDagger(id:Int) -> Dagger {
        switch id {
        case 1:
            return NightBlade()
        case 2:
            return LazesPedicureKnife()
        default:
            return NightBlade()
        }
    }
    var _sacredShields = [1,2,3,4]
    func getSacredShield(id:Int) -> Shield {
        switch id {
        case 1:
            return Faceless()
        case 2:
            return Accident()
        case 3:
            return FrancisFace()
        case 4:
            return EvilExpel()
        default:
            return Faceless()
        }
    }
    var _sacredAmulets = [1,2,3,4,5,6,7,8]
    func getSacredAmulet(id:Int) -> Amulet {
        switch id {
        case 1:
            return TrueLie()
        case 2:
            return MedalOfCourage()
        case 3:
            return FangOfVampire()
        case 4:
            return MoonShadow()
        case 5:
            return EternityNight()
        case 6:
            return Sparkling()
        case 7:
            return MedalOfHero()
        case 8:
            return JadeHeart()
        default:
            return TrueLie()
        }
    }
    var _sacredRings = [1,2,3,4,5,6,7]
    func getSacredRing(id:Int) -> Ring {
        switch id {
        case 1:
            return RingOfDead()
        case 2:
            return IdlirWeddingRing()
        case 3:
            return ApprenticeRing()
        case 4:
            return CopperRing()
        case 5:
            return SilverRing()
        case 6:
            return DellarsGoldenRing()
        case 7:
            return LuckyRing()
        default:
            return LuckyRing()
        }
    }
    var _sacredSoulstones = [1,2,3]
    func getSacredSoulstone(id:Int) -> SoulStone {
        switch id {
        case 1:
            return HeartOfSwamp()
        case 2:
            return PandoraHearts()
        case 3:
            return HeartOfTarrasque()
        default:
            return HeartOfSwamp()
        }
    }
    var _sacredInstruments = [1,2]
    func getSacredInstrument(id:Int) -> Instrument {
        switch id {
        case 1:
            return TheMonatNotes()
        case 2:
            return NoPants()
        default:
            return TheMonatNotes()
        }
    }
    var _sacredWands = [1,2,3,4]
    func getSacredWand(id:Int) -> Wand {
        switch id {
        case 1:
            return LightingRod()
        case 2:
            return FireMaster()
        case 3:
            return WitchWand()
        case 4:
            return PuppetMaster()
        default:
            return LightingRod()
        }
    }
    var _sacredBlunts = [1,2,3,4,5]
    func getSacredBlunt(id:Int) -> Blunt {
        switch id {
        case 1:
            return IberisThignbone()
        case 2:
            return GiantFang()
        case 3:
            return ThorsHammer()
        case 4:
            return HolyPower()
        case 5:
            return IdyllssHand()
        default:
            return IberisThignbone()
        }
    }
    var _sacredMarks = [1,2,3,4,5,6,7]
    func getSacredMark(id:Int) -> MagicMark {
        switch id {
        case 1:
            return PuppetMark()
        case 2:
            return MarkOfOaks()
        case 3:
            return MarkOfDeathGod()
        case 4:
            return MarkOfVitality()
        case 5:
            return MarkOfHeaven()
        case 6:
            return MoltenFire()
        case 7:
            return TheEye()
        default:
            return PuppetMark()
        }
    }
    var _sacredBows = [1,2,3,4]
    func getSacredBow(id:Int) -> Bow {
        switch id {
        case 1:
            return Hawkeye()
        case 2:
            return Boreas()
        case 3:
            return Skylark()
        case 4:
            return SoundOfWind()
        default:
            return Hawkeye()
        }
    }
    var _sacredEarrings = [1,2,3,4]
    func getSacredEarring(id:Int) -> EarRing {
        switch id {
        case 1:
            return VerdasTear()
        case 2:
            return DeepSeaPearl()
        case 3:
            return EyeOfDius()
        case 4:
            return LavaCrystal()
        default:
            return VerdasTear()
        }
    }
    private func getSacredOutfit(id:Int) -> Outfit {
        switch id {
        case 1:
            return getSacredSword(id:_sacredSwords.one())
        case 2:
            return getSacredDagger(id:_sacredDaggers.one())
        case 3:
            return getSacredShield(id:_sacredShields.one())
        case 4:
            return getSacredAmulet(id:_sacredAmulets.one())
        case 5:
            return getSacredRing(id:_sacredRings.one())
        case 6:
            return getSacredSoulstone(id:_sacredSoulstones.one())
        case 7:
            return getSacredInstrument(id:_sacredInstruments.one())
        case 8:
            return getSacredWand(id:_sacredWands.one())
        case 9:
            return getSacredBlunt(id:_sacredBlunts.one())
        case 10:
            return getSacredMark(id:_sacredMarks.one())
        case 11:
            return getSacredBow(id:_sacredBows.one())
        case 12:
            return getSacredEarring(id:_sacredEarrings.one())
        default:
            return getSacredSword(id:_sacredSwords.one())
        }
        
    }
    
    func getSacred() -> Outfit? {
        let outfit = getSacredOutfit(id: [1,2,3,4,5,6,7,8,9,10,11,12].one())
        if outfit._level <= _char._level + 5 {
            if seed(max: 150) <= outfit._chance {
                outfit.create()
                return outfit
            }
        }
        return nil
    }
    
    //abandoned
    private func resetSacredChance() {
        _sacredSwords = []
        _sacredDaggers = []
        _sacredShields = []
        _sacredAmulets = []
        _sacredRings = []
        _sacredSoulstones = []
        _sacredInstruments = []
        _sacredWands = []
        _sacredBlunts = []
        _sacredMarks = []
        _sacredBows = []
        _sacredEarrings = []
    }
}
