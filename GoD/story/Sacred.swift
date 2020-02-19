//
//  Sacred.swift
//  GoD
//
//  Created by kai chen on 2019/12/17.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
struct Sacred {
    var effection = ""
    var type = ""
    var name = ""
    var desc = ""
    var level = 1
    var price = 0
    var chance = 0
    var attrs = Array<SacredAttr>()
    var randomAttrCountMin = -1
    var randomAttrCountMax = -1
    var quality = Quality.SACRED
    static let data = [
        Sacred.TrueLie: Sacred(
            effection: Sacred.TrueLie,
            type: Outfit.Amulet,
            name: "真实的谎言",
            desc: "获得一个额外的技能卡槽",
            level: 38,
            price: 889,
            chance: 5,
            attrs: [
                SacredAttr(type: Attribute.AVOID, valueMin: 30, valueMax: 30),
                SacredAttr(type: Attribute.REVENGE, valueMin: 10, valueMax: 20),
                SacredAttr(type: Attribute.SPIRIT, valueMin: 30, valueMax: 60)
            ],
            randomAttrCountMin: 2,
            randomAttrCountMax: 2
        ),
        Sacred.MedalOfCourage: Sacred(
            effection: Sacred.MedalOfCourage,
            type: Outfit.Amulet,
            name: "勇气勋章",
            desc: "献给最有勇气的冒险者",
            level: 5,
            price: 18,
            chance: 100,
            attrs: [
                SacredAttr(type: Attribute.STAMINA, valueMin: 4, valueMax: 4),
                SacredAttr(type: Attribute.STRENGTH, valueMin: 4, valueMax: 4),
                SacredAttr(type: Attribute.AGILITY, valueMin: 4, valueMax: 4),
                SacredAttr(type: Attribute.INTELLECT, valueMin: 4, valueMax: 4)
            ],
            randomAttrCountMin: 1,
            randomAttrCountMax: 1
        ),
        Sacred.FangOfVampire: Sacred(
            effection: Sacred.FangOfVampire,
            type: Outfit.Amulet,
            name: "吸血鬼獠牙",
            desc: "提升所有物理吸血效果100%",
            level: 25,
            price: 229,
            chance: 50,
            attrs: [
                SacredAttr(type: Attribute.STRENGTH, valueMin: 15, valueMax: 15),
                SacredAttr(type: Attribute.CRITICAL, valueMin: 15, valueMax: 15),
                SacredAttr(type: Attribute.FIREPOWER, valueMin: 15, valueMax: 15)
            ],
            randomAttrCountMin: 2,
            randomAttrCountMax: 2
        ),
        Sacred.MoonShadow: Sacred(
            effection: Sacred.MoonShadow,
            type: Outfit.Amulet,
            name: "月影",
            desc: "",
            level: 15,
            price: 82,
            chance: 660,
            attrs: [
                SacredAttr(type: Attribute.AGILITY, valueMin: 15, valueMax: 25)
            ],
            randomAttrCountMin: 2,
            randomAttrCountMax: 4
        ),
        Sacred.EternityNight: Sacred(
            effection: Sacred.EternityNight,
            type: Outfit.Amulet,
            name: "永夜",
            desc: "",
            level: 18,
            price: 126,
            chance: 80,
            attrs: [
                SacredAttr(type: Attribute.AVOID, valueMin: 15, valueMax: 15),
                SacredAttr(type: Attribute.WATERPOWER, valueMin: 25, valueMax: 25),
                SacredAttr(type: Attribute.WATERRESISTANCE, valueMin: 25, valueMax: 25),
                SacredAttr(type: Attribute.LUCKY, valueMin: 15, valueMax: 25)
            ],
            randomAttrCountMin: 0,
            randomAttrCountMax: 0
        ),
        Sacred.Sparkling: Sacred(
            effection: Sacred.Sparkling,
            type: Outfit.Amulet,
            name: "群星闪耀",
            desc: "",
            level: 12,
            price: 75,
            chance: 75,
            attrs: [
                SacredAttr(type: Attribute.STAMINA, valueMin: 10, valueMax: 10),
                SacredAttr(type: Attribute.DEFENCE, valueMin: 20, valueMax: 20),
                SacredAttr(type: Attribute.SPEED, valueMin: 10, valueMax: 15)
            ],
            randomAttrCountMin: 2,
            randomAttrCountMax: 2
        ),
        Sacred.MedalOfHero: Sacred(
            effection: Sacred.MedalOfHero,
            type: Outfit.Amulet,
            name: "英雄勋章",
            desc: "低挡一次致命伤害",
            level: 18,
            price: 186,
            chance: 40,
            attrs: [
                SacredAttr(type: Attribute.FIRERESISTANCE, valueMin: 20 , valueMax: 30),
                SacredAttr(type: Attribute.WATERRESISTANCE, valueMin: 20, valueMax: 30),
                SacredAttr(type: Attribute.THUNDERRESISTANCE, valueMin: 20, valueMax: 30)
            ],
            randomAttrCountMin: 2,
            randomAttrCountMax: 2
        ),
        Sacred.HeartOfJade: Sacred(
            effection: Sacred.HeartOfJade,
            type: Outfit.Amulet,
            name: "翡翠之心",
            desc: "降低来自首领的伤害",
            level: 33,
            price: 654,
            chance: 20,
            attrs: [
                SacredAttr(type: Attribute.STAMINA, valueMin: 30 , valueMax: 40),
                SacredAttr(type: Attribute.THUNDERRESISTANCE, valueMin: 30, valueMax: 40),
                SacredAttr(type: Attribute.SPEED, valueMin: 30, valueMax: 40)
            ],
            randomAttrCountMin: 2,
            randomAttrCountMax: 3
        ),
        Sacred.IberisThignbone: Sacred(
            effection: Sacred.IberisThignbone,
            type: Outfit.Blunt,
            name: "伊比利斯的腿骨",
            desc: "打人特别疼",
            level: 16,
            price: 126,
            chance: 90,
            attrs: [
                SacredAttr(type: Attribute.STAMINA, valueMin: 12 , valueMax: 12),
                SacredAttr(type: Attribute.STRENGTH, valueMin: 12, valueMax: 12),
                SacredAttr(type: Attribute.REVENGE, valueMin: 12, valueMax: 12),
                SacredAttr(type: Attribute.SPEED, valueMin: -12, valueMax: -12)
            ],
            randomAttrCountMin: 1,
            randomAttrCountMax: 1
        ),
        Sacred.GiantFang: Sacred(
            effection: Sacred.GiantFang,
            type: Outfit.Blunt,
            name: "巨牙",
            desc: "攻击吸血",
            level: 22,
            price: 222,
            chance: 60,
            attrs: [
                SacredAttr(type: Attribute.STAMINA, valueMin: 20 , valueMax: 20),
                SacredAttr(type: Attribute.HEALTH, valueMin: 20, valueMax: 40),
                SacredAttr(type: Attribute.DEFENCE, valueMin: 20, valueMax: 40)
            ],
            randomAttrCountMin: 3,
            randomAttrCountMax: 3
        ),
        Sacred.ThorsHammer: Sacred(
            effection: Sacred.ThorsHammer,
            type: Outfit.Blunt,
            name: "雷神之锤",
            desc: "提升落雷伤害100%",
            level: 28,
            price: 882,
            chance: 30,
            attrs: [
                SacredAttr(type: Attribute.STRENGTH, valueMin: 20 , valueMax: 25),
                SacredAttr(type: Attribute.THUNDERPOWER, valueMin: 40, valueMax: 40),
                SacredAttr(type: Attribute.THUNDERRESISTANCE, valueMin: 40, valueMax: 40)
            ],
            randomAttrCountMin: 3,
            randomAttrCountMax: 3
        ),
        Sacred.HolyPower: Sacred(
            effection: Sacred.HolyPower,
            type: Outfit.Blunt,
            name: "神圣力量",
            desc: "对亡灵的伤害提升100%",
            level: 39,
            price: 998,
            chance: 35,
            attrs: [
                SacredAttr(type: Attribute.STRENGTH, valueMin: 30 , valueMax: 30),
                SacredAttr(type: Attribute.STAMINA, valueMin: 30, valueMax: 30),
                SacredAttr(type: Attribute.INTELLECT, valueMin: 30, valueMax: 30),
                SacredAttr(type: Attribute.HEALTH, valueMin: 60, valueMax: 100)
            ],
            randomAttrCountMin: 1,
            randomAttrCountMax: 1
        ),
        Sacred.IdyllssHand: Sacred(
            effection: Sacred.IdyllssHand,
            type: Outfit.Blunt,
            name: "埃迪斯之手",
            desc: "普通攻击有一定几率攻击两次",
            level: 40,
            price: 2882,
            chance: 5,
            attrs: [
                SacredAttr(type: Attribute.STRENGTH, valueMin: 30 , valueMax: 30),
                SacredAttr(type: Attribute.AGILITY, valueMin: 30, valueMax: 30),
                SacredAttr(type: Attribute.CRITICAL, valueMin: 30, valueMax: 30),
                SacredAttr(type: Attribute.RHYTHM, valueMin: 10, valueMax: 20)
            ],
            randomAttrCountMin: 2,
            randomAttrCountMax: 2
        ),
        Sacred.BansMechanArm: Sacred(
            effection: Sacred.BansMechanArm,
            type: Outfit.Blunt,
            name: "班桑的机械臂",
            desc: "降低目标生命回复",
            level: 12,
            price: 115,
            chance: 25,
            attrs: [
                SacredAttr(type: Attribute.STRENGTH),
                SacredAttr(type: Attribute.CRITICAL),
                SacredAttr(type: Attribute.ACCURACY)
            ],
            randomAttrCountMin: 2,
            randomAttrCountMax: 3
        ),
        //bow
        Sacred.Hawkeye: Sacred(
            effection: Sacred.Hawkeye,
            type: Outfit.Bow,
            name: "鹰眼",
            desc: "攻击无法被闪避",
            level: 23,
            price: 235,
            chance: 50,
            attrs: [
                SacredAttr(type: Attribute.CRITICAL, valueMin: 10 , valueMax: 15),
                SacredAttr(type: Attribute.SPEED, valueMin: 10, valueMax: 15),
                SacredAttr(type: Attribute.LUCKY, valueMin: 20, valueMax: 30),
            ],
            randomAttrCountMin: 2,
            randomAttrCountMax: 2
        ),
        Sacred.Boreas: Sacred(
            effection: Sacred.Boreas,
            type: Outfit.Bow,
            name: "北风之神",
            desc: "攻击力翻倍",
            level: 40,
            price: 1445,
            chance: 40,
            attrs: [
                SacredAttr(type: Attribute.STRENGTH, valueMin: 32 , valueMax: 32),
                SacredAttr(type: Attribute.THUNDERRESISTANCE, valueMin: 32, valueMax: 32),
                SacredAttr(type: Attribute.DEFENCE, valueMin: 40, valueMax: 60),
                SacredAttr(type: Attribute.HEALTH, valueMin: 100, valueMax: 120)
            ],
            randomAttrCountMin: 2,
            randomAttrCountMax: 2
        ),
        Sacred.Skylark: Sacred(
            effection: Sacred.Skylark,
            type: Outfit.Bow,
            name: "云雀",
            desc: "射箭时发出云雀般的声音",
            level: 11,
            price: 100,
            chance: 100,
            attrs: [
                SacredAttr(type: Attribute.SPEED, valueMin: 12 , valueMax: 22),
                SacredAttr(type: Attribute.AVOID, valueMin: 12, valueMax: 12)
            ],
            randomAttrCountMin: 3,
            randomAttrCountMax: 3
        ),
        Sacred.Aonena: Sacred(
            effection: Sacred.Aonena,
            type: Outfit.Bow,
            name: "艾欧妮娜",
            desc: "王国一等弓箭手之弓",
            level: 24,
            price: 148,
            chance: 55,
            attrs: [],
            randomAttrCountMin: 5,
            randomAttrCountMax: 5
        ),
        Sacred.SoundOfWind: Sacred(
            effection: Sacred.SoundOfWind,
            type: Outfit.Bow,
            name: "丧钟",
            desc: "",
            level: 36,
            price: 677,
            chance: 30,
            attrs: [
                SacredAttr(type: Attribute.STRENGTH, valueMin: 25, valueMax: 30),
                SacredAttr(type: Attribute.STAMINA, valueMin: 25, valueMax: 30),
                SacredAttr(type: Attribute.AGILITY, valueMin: 25, valueMax: 30),
                SacredAttr(type: Attribute.INTELLECT, valueMin: 25, valueMax: 30),
                SacredAttr(type: Attribute.AVOID, valueMin: 25, valueMax: 30)
            ],
            randomAttrCountMin: 0,
            randomAttrCountMax: 0
        ),
        Sacred.FollowOn: Sacred(
            effection: Sacred.FollowOn,
            type: Outfit.Bow,
            name: "追击",
            desc: "你的随从会攻击你上一个攻击的的目标",
            level: 26,
            price: 490,
            chance: 30,
            attrs: [
                SacredAttr(type: Attribute.ACCURACY, valueMin: 20, valueMax: 30)
            ],
            randomAttrCountMin: 3,
            randomAttrCountMax: 5
        ),
        Sacred.NightBlade: Sacred(
            effection: Sacred.NightBlade,
            type: Outfit.Dagger,
            name: "夜刃",
            desc: "对亡灵造成的全伤害提升25%",
            level: 15,
            price: 48,
            chance: 48,
            attrs: [
                SacredAttr(type: Attribute.STRENGTH, valueMin: 10, valueMax: 10),
                SacredAttr(type: Attribute.AGILITY, valueMin: 10, valueMax: 10)
            ],
            randomAttrCountMin: 2,
            randomAttrCountMax: 4
        ),
        Sacred.LazesPedicureKnife: Sacred(
            effection: Sacred.LazesPedicureKnife,
            type: Outfit.Dagger,
            name: "拉兹的修脚刀",
            desc: "普通攻击有几率获得一点敏捷",
            level: 21,
            price: 185,
            chance: 100,
            attrs: [
                SacredAttr(type: Attribute.AGILITY, valueMin: 15, valueMax: 15),
                SacredAttr(type: Attribute.ACCURACY, valueMin: 15, valueMax: 15),
                SacredAttr(type: Attribute.LUCKY, valueMin: 15, valueMax: 15)
            ],
            randomAttrCountMin: 2,
            randomAttrCountMax: 2
        ),
        Sacred.VerdasTear: Sacred(
            effection: Sacred.VerdasTear,
            type: Outfit.Amulet,
            name: "维尔达之泪",
            desc: "略微降低法术伤害",
            level: 20,
            price: 289,
            chance: 80,
            attrs: [
                SacredAttr(type: Attribute.FIREPOWER, valueMin: 15, valueMax: 20),
                SacredAttr(type: Attribute.WATERPOWER, valueMin: 15, valueMax: 20),
                SacredAttr(type: Attribute.THUNDERPOWER, valueMin: 15, valueMax: 20),
                SacredAttr(type: Attribute.FIRERESISTANCE, valueMin: 15, valueMax: 20),
                SacredAttr(type: Attribute.WATERRESISTANCE, valueMin: 15, valueMax: 20),
                SacredAttr(type: Attribute.THUNDERPOWER, valueMin: 15, valueMax: 20)
            ],
            randomAttrCountMin: 0,
            randomAttrCountMax: 0
        ),
        Sacred.DeepSeaPearl: Sacred(
            effection: Sacred.DeepSeaPearl,
            type: Outfit.Amulet,
            name: "深海珍珠",
            desc: "",
            level: 11,
            price: 50,
            chance: 100,
            attrs: [
                SacredAttr(type: Attribute.WATERPOWER, valueMin: 15, valueMax: 15),
                SacredAttr(type: Attribute.SPEED, valueMin: 10, valueMax: 10),
                SacredAttr(type: Attribute.REVENGE, valueMin: 5, valueMax: 5)
            ],
            randomAttrCountMin: 2,
            randomAttrCountMax: 2
        ),
        Sacred.EyeOfDius: Sacred(
            effection: Sacred.EyeOfDius,
            type: Outfit.Amulet,
            name: "迪乌斯之眼",
            desc: "",
            level: 32,
            price: 168,
            chance: 30,
            attrs: [
                SacredAttr(type: Attribute.STRENGTH, valueMin: 20, valueMax: 20),
                SacredAttr(type: Attribute.AGILITY, valueMin: 20, valueMax: 20),
                SacredAttr(type: Attribute.HEALTH_BY_RATE, valueMin: 8, valueMax: 15)
            ],
            randomAttrCountMin: 3,
            randomAttrCountMax: 3
        ),
        Sacred.LavaCrystal: Sacred(
            effection: Sacred.LavaCrystal,
            type: Outfit.EarRing,
            name: "熔岩结晶",
            desc: "提升50%单体火焰法术伤害",
            level: 30,
            price: 889,
            chance: 15,
            attrs: [
                SacredAttr(type: Attribute.INTELLECT, valueMin: 20, valueMax: 20),
                SacredAttr(type: Attribute.SPIRIT, valueMin: 20, valueMax: 30),
                SacredAttr(type: Attribute.FIREPOWER, valueMin: 20, valueMax: 30)
            ],
            randomAttrCountMin: 2,
            randomAttrCountMax: 3
        ),
        Sacred.FingerBone: Sacred(
            effection: Sacred.FingerBone,
            type: Outfit.Fist,
            name: "指骨",
            desc: "",
            level: 25,
            price: 120,
            chance: 25,
            attrs: [
                SacredAttr(type: Attribute.AGILITY, valueMin: 21, valueMax: 21),
                SacredAttr(type: Attribute.CRITICAL, valueMin: 21, valueMax: 21)
            ],
            randomAttrCountMin: 3,
            randomAttrCountMax: 3
        ),
        Sacred.LiosHold: Sacred(
            effection: Sacred.LiosHold,
            type: Outfit.Fist,
            name: "莱奥斯之握",
            desc: "碎冰拳附加的冰冷伤害现在为生命上限",
            level: 33,
            price: 292,
            chance: 25,
            attrs: [
                SacredAttr(type: Attribute.HEALTH, valueMin: 40, valueMax: 75),
                SacredAttr(type: Attribute.HEALTH_BY_RATE, valueMin: 10, valueMax: 15),
                SacredAttr(type: Attribute.WATERPOWER, valueMin: 20, valueMax: 30)
            ],
            randomAttrCountMin: 1,
            randomAttrCountMax: 2
        ),
        Sacred.DragonClaw: Sacred(
            effection: Sacred.DragonClaw,
            type: Outfit.Fist,
            name: "巨龙爪",
            desc: "烈焰拳不再有冷却时间",
            level: 34,
            price: 1545,
            chance: 25,
            attrs: [
                SacredAttr(type: Attribute.STRENGTH, valueMin: 15, valueMax: 25),
                SacredAttr(type: Attribute.FIREPOWER, valueMin: 15, valueMax: 25)
            ],
            randomAttrCountMin: 3,
            randomAttrCountMax: 3
        ),
        Sacred.NilSeal: Sacred(
            effection: Sacred.NilSeal,
            type: Outfit.Fist,
            name: "尼尔的禁锢",
            desc: "气功波增加1目标",
            level: 38,
            price: 680,
            chance: 30,
            attrs: [
                SacredAttr(type: Attribute.STRENGTH, valueMin: 20, valueMax: 25),
                SacredAttr(type: Attribute.STAMINA, valueMin: 20, valueMax: 25),
                SacredAttr(type: Attribute.AGILITY, valueMin: 20, valueMax: 25),
                SacredAttr(type: Attribute.INTELLECT, valueMin: 20, valueMax: 25)
            ],
            randomAttrCountMin: 1,
            randomAttrCountMax: 1
        ),
        Sacred.DeepCold: Sacred(
            effection: Sacred.DeepCold,
            type: Outfit.Fist,
            name: "极寒之握",
            desc: "进入极寒领域，冻结触碰到的一切",
            level: 40,
            price: 1410,
            chance: 20,
            attrs: [
                SacredAttr(type: Attribute.STAMINA, valueMin: 25, valueMax: 35),
                SacredAttr(type: Attribute.INTELLECT, valueMin: 25, valueMax: 35),
                SacredAttr(type: Attribute.WATERPOWER, valueMin: 25, valueMax: 35),
                SacredAttr(type: Attribute.MIND, valueMin: 25, valueMax: 35)
            ],
            randomAttrCountMin: 1,
            randomAttrCountMax: 2
        ),
        Sacred.TheMonatNotes: Sacred(
            effection: Sacred.TheMonatNotes,
            type: Outfit.Instrument,
            name: "莫纳手记",
            desc: "该法器提供的技能可以使用两次",
            level: 38,
            price: 2380,
            chance: 10,
            attrs: [
                SacredAttr(type: Attribute.INTELLECT, valueMin: 28, valueMax: 28),
                SacredAttr(type: Attribute.SPIRIT, valueMin: 28, valueMax: 28),
                SacredAttr(type: Attribute.FIREPOWER, valueMin: 40, valueMax: 40),
                SacredAttr(type: Attribute.RHYTHM, valueMin: 8, valueMax: 15)
            ],
            randomAttrCountMin: 2,
            randomAttrCountMax: 2
        ),
        Sacred.NoPants: Sacred(
            effection: Sacred.NoPants,
            type: Outfit.Instrument,
            name: "真空",
            desc: "施法时有一定几率走光",
            level: 12,
            price: 100,
            chance: 100,
            attrs: [
                SacredAttr(type: Attribute.MAGICAL_POWER, valueMin: 5, valueMax: 6),
                SacredAttr(type: Attribute.FIREPOWER, valueMin: 10, valueMax:12),
                SacredAttr(type: Attribute.WATERPOWER, valueMin: 10, valueMax: 12),
                SacredAttr(type: Attribute.THUNDERPOWER, valueMin: 10, valueMax: 12),
            ],
            randomAttrCountMin: 1,
            randomAttrCountMax: 1
        ),
        Sacred.CreationMatrix: Sacred(
            effection: Sacred.CreationMatrix,
            type: Outfit.Instrument,
            name: "创世之矩",
            desc: "战斗开始时，移除一个技能的冷却时间",
            level: 40,
            price: 3218,
            chance: 10,
            attrs: [
                SacredAttr(type: Attribute.INTELLECT, valueMin: 32, valueMax: 32),
                SacredAttr(type: Attribute.HEALTH, valueMin: 120, valueMax: 120),
                SacredAttr(type: Attribute.DEFENCE, valueMin: 40, valueMax: 40),
                SacredAttr(type: Attribute.MIND, valueMin: 25, valueMax: 35),
                SacredAttr(type: Attribute.AVOID, valueMin: 25, valueMax: 35)
            ],
            randomAttrCountMin: 1,
            randomAttrCountMax: 2
        ),
        Sacred.IssHead: Sacred(
            effection: Sacred.IssHead,
            type: Outfit.Instrument,
            name: "艾斯斯之颅",
            desc: "傀儡师的头也是木头做的",
            level: 10,
            price: 120,
            chance: 60,
            attrs: [
                SacredAttr(type: Attribute.INTELLECT, valueMin: 10, valueMax: 10)
            ],
            randomAttrCountMin: 3,
            randomAttrCountMax: 4
        ),
        Sacred.TheSurvive: Sacred(
            effection: Sacred.TheSurvive,
            type: Outfit.Instrument,
            name: "复生之书",
            desc: "提升生灵召唤物的属性",
            level: 35,
            price: 10,
            chance: 650,
            attrs: [
                SacredAttr(type: Attribute.STAMINA, valueMin: 20, valueMax: 25),
                SacredAttr(type: Attribute.INTELLECT, valueMin: 20, valueMax: 25)
            ],
            randomAttrCountMin: 3,
            randomAttrCountMax: 3
        ),
        Sacred.TheDeath: Sacred(
            effection: Sacred.TheDeath,
            type: Outfit.Instrument,
            name: "亡者之书",
            desc: "提升亡灵召唤物的属性",
            level: 35,
            price: 420,
            chance: 20,
            attrs: [
                SacredAttr(type: Attribute.STAMINA, valueMin: 20, valueMax: 25),
                SacredAttr(type: Attribute.INTELLECT, valueMin: 20, valueMax: 25)
            ],
            randomAttrCountMin: 3,
            randomAttrCountMax: 3
        ),
        Sacred.TheAbandon: Sacred(
            effection: Sacred.TheAbandon,
            type: Outfit.Instrument,
            name: "弃之书",
            desc: "提升恶魔召唤物的属性",
            level: 35,
            price: 540,
            chance: 20,
            attrs: [
                SacredAttr(type: Attribute.STAMINA, valueMin: 20, valueMax: 25),
                SacredAttr(type: Attribute.INTELLECT, valueMin: 20, valueMax: 25)
            ],
            randomAttrCountMin: 3,
            randomAttrCountMax: 3
        ),
        Sacred.TheSurpass: Sacred(
            effection: Sacred.TheSurpass,
            type: Outfit.Instrument,
            name: "越之书",
            desc: "赋予你的召唤物此物品所携带的法术",
            level: 35,
            price: 820,
            chance: 10,
            attrs: [
                SacredAttr(type: Attribute.STAMINA, valueMin: 20, valueMax: 25),
                SacredAttr(type: Attribute.INTELLECT, valueMin: 20, valueMax: 25)
            ],
            randomAttrCountMin: 3,
            randomAttrCountMax: 3
        ),
        Sacred.TheFear: Sacred(
            effection: Sacred.TheFear,
            type: Outfit.Instrument,
            name: "畏之书",
            desc: "移除所有召唤术的冷却时间",
            level: 35,
            price: 820,
            chance: 10,
            attrs: [
                SacredAttr(type: Attribute.STAMINA, valueMin: 20, valueMax: 25),
                SacredAttr(type: Attribute.INTELLECT, valueMin: 20, valueMax: 25)
            ],
            randomAttrCountMin: 3,
            randomAttrCountMax: 3
        ),
        Sacred.PuppetMark: Sacred(
            effection: Sacred.PuppetMark,
            type: Outfit.MagicMark,
            name: "傀儡印记",
            desc: "减少一个技能栏，增加一个随从位",
            level: 10,
            price: 120,
            chance: 15,
            attrs: [
                SacredAttr(type: Attribute.STAMINA, valueMin: -10, valueMax: -10)
            ]
        ),
        Sacred.MarkOfOaks: Sacred(
            effection: Sacred.MarkOfOaks,
            type: Outfit.MagicMark,
            name: "橡树印记",
            desc: "受物理伤害时有几率对释放橡树之力",
            level: 25,
            price: 320,
            chance: 40
        ),
        Sacred.MarkOfDeathGod: Sacred(
            effection: Sacred.MarkOfDeathGod,
            type: Outfit.MagicMark,
            name: "死神印记",
            desc: "免疫即死和静默",
            level: 31,
            price: 698,
            chance: 15
        ),
        Sacred.MarkOfVitality: Sacred(
            effection: Sacred.MarkOfVitality,
            type: Outfit.MagicMark,
            name: "生命印记",
            desc: "提升生命之花的治疗效果",
            level: 18,
            price: 170,
            chance: 70
        ),
        Sacred.MarkOfHeaven: Sacred(
            effection: Sacred.MarkOfHeaven,
            type: Outfit.MagicMark,
            name: "天堂印记",
            desc: "降低来自恶魔的伤害",
            level: 21,
            price: 310,
            chance: 40
        ),
        Sacred.MoltenFire: Sacred(
            effection: Sacred.MoltenFire,
            type: Outfit.MagicMark,
            name: "融火",
            desc: "大幅提升火元素伤害",
            level: 28,
            price: 440,
            chance: 30
        ),
        Sacred.TheEye: Sacred(
            effection: Sacred.TheEye,
            type: Outfit.MagicMark,
            name: "撒旦之眼",
            desc: "获得一个额外的技能卡槽",
            level: 40,
            price: 2890,
            chance: 8
        ),
        Sacred.FireMark: Sacred(
            effection: Sacred.FireMark,
            type: Outfit.MagicMark,
            name: "火焰纹章",
            desc: "延长燃烧效果一回合",
            level: 29,
            price: 689,
            chance: 20
        ),
        Sacred.IssMark: Sacred(
            effection: Sacred.IssMark,
            type: Outfit.MagicMark,
            name: "艾斯斯之印",
            desc: "获得一个召唤系技能",
            level: 10,
            price: 140,
            chance: 50
        ),
        Sacred.RingOfDead: Sacred(
            effection: Sacred.RingOfDead,
            type: Outfit.Ring,
            name: "亡灵之戒",
            desc: "种族转换为亡灵",
            level: 12,
            price: 176,
            chance: 80,
            attrs: [
                SacredAttr(type: Attribute.INTELLECT, valueMin: 10, valueMax: 10),
                SacredAttr(type: Attribute.MIND, valueMin: 10, valueMax: 10),
                SacredAttr(type: Attribute.WATERPOWER, valueMin: 10, valueMax: 10)
            ],
            randomAttrCountMin: 1,
            randomAttrCountMax: 2
        ),
        Sacred.IdlirWeddingRing: Sacred(
            effection: Sacred.IdlirWeddingRing,
            type: Outfit.Ring,
            name: "伊德利尔的婚戒",
            desc: "变形成为伊德利尔的新娘",
            level: 19,
            price: 291,
            chance: 45,
            attrs: [
                SacredAttr(type: Attribute.SPIRIT, valueMin: 0, valueMax: 0),
                SacredAttr(type: Attribute.SPEED, valueMin: 0, valueMax: 0),
                SacredAttr(type: Attribute.AVOID, valueMin: 0, valueMax: 0),
            ],
            randomAttrCountMin: 1,
            randomAttrCountMax: 2
        ),
        Sacred.ApprenticeRing: Sacred(
            effection: Sacred.ApprenticeRing,
            type: Outfit.Ring,
            name: "学徒法戒",
            desc: "略微提高玩火的成功几率",
            level: 2,
            price: 28,
            chance: 50,
            attrs: [
                SacredAttr(type: Attribute.INTELLECT, valueMin: 2, valueMax: 2),
                SacredAttr(type: Attribute.SPIRIT, valueMin: 2, valueMax: 2),
                SacredAttr(type: Attribute.FIREPOWER, valueMin: 5, valueMax: 5)
            ],
            randomAttrCountMin: 1,
            randomAttrCountMax: 2
        ),
        Sacred.CopperRing: Sacred(
            effection: Sacred.CopperRing,
            type: Outfit.Ring,
            name: "铜质戒指",
            desc: "铜的比较耐火",
            level: 5,
            price: 18,
            chance: 80,
            attrs: [
                SacredAttr(type: Attribute.FIRERESISTANCE, valueMin: 20, valueMax: 30)
            ],
            randomAttrCountMin: 2,
            randomAttrCountMax: 3
        ),
        Sacred.SilverRing: Sacred(
            effection: Sacred.SilverRing,
            type: Outfit.Ring,
            name: "银质戒指",
            desc: "",
            level: 15,
            price: 168,
            chance: 60,
            attrs: [
                SacredAttr(type: Attribute.STRENGTH, valueMin: 10, valueMax: 10),
                SacredAttr(type: Attribute.AVOID, valueMin: 10, valueMax: 15),
                SacredAttr(type: Attribute.FIRERESISTANCE, valueMin: 10, valueMax: 15)
            ],
            randomAttrCountMin: 1,
            randomAttrCountMax: 2
        ),
        Sacred.DellarsGoldenRing: Sacred(
            effection: Sacred.DellarsGoldenRing,
            type: Outfit.Ring,
            name: "德拉的金戒",
            desc: "真金不怕火炼",
            level: 25,
            price: 60,
            chance: 245,
            attrs: [
                SacredAttr(type: Attribute.FIREPOWER, valueMin: 25, valueMax: 30),
                SacredAttr(type: Attribute.FIRERESISTANCE, valueMin: 25, valueMax: 30)
            ],
            randomAttrCountMin: 2,
            randomAttrCountMax: 3
        ),
        Sacred.LuckyRing: Sacred(
            effection: Sacred.LuckyRing,
            type: Outfit.Ring,
            name: "幸运指环",
            desc: "",
            level: 15,
            price: 88,
            chance: 100,
            attrs: [
                SacredAttr(type: Attribute.CRITICAL, valueMin: 10, valueMax: 15),
                SacredAttr(type: Attribute.AVOID, valueMin: 10, valueMax: 15),
                SacredAttr(type: Attribute.RHYTHM, valueMin: 10, valueMax: 15),
                SacredAttr(type: Attribute.REVENGE, valueMin: 10, valueMax: 15),
                SacredAttr(type: Attribute.LUCKY, valueMin: 20, valueMax: 30)
            ],
            randomAttrCountMin: 0,
            randomAttrCountMax: 0
        ),
        Sacred.RingOfDeath: Sacred(
            effection: Sacred.RingOfDeath,
            type: Outfit.Ring,
            name: "逝者之戒",
            desc: "提升自身50%的治疗效果",
            level: 28,
            price: 322,
            chance: 35,
            attrs: [
                SacredAttr(type: Attribute.SPIRIT, valueMin: 20, valueMax: 30)
            ],
            randomAttrCountMin: 3,
            randomAttrCountMax: 4
        ),
        Sacred.RingFromElder: Sacred(
            effection: Sacred.RingFromElder,
            type: Outfit.Ring,
            name: "长者之戒",
            desc: "提升自身25%经验获取",
            level: 15,
            price: 255,
            chance: 35,
            attrs: [
                SacredAttr(type: Attribute.INTELLECT, valueMin: 10, valueMax: 20),
                SacredAttr(type: Attribute.LUCKY, valueMin: 20, valueMax: 25)
            ],
            randomAttrCountMin: 2,
            randomAttrCountMax: 3
        ),
        Sacred.RingOfReborn: Sacred(
            effection: Sacred.RingOfReborn,
            type: Outfit.Ring,
            name: "再生指环",
            desc: "额外刻印一个恢复系法术",
            level: 22,
            price: 439,
            chance: 25,
            attrs: [
                SacredAttr(type: Attribute.STAMINA, valueMin: 15, valueMax: 20),
                SacredAttr(type: Attribute.HEALTH, valueMin: 30, valueMax: 40)
            ],
            randomAttrCountMin: 2,
            randomAttrCountMax: 4
        ),
        Sacred.FireCore: Sacred(
            effection: Sacred.FireCore,
            type: Outfit.Ring,
            name: "火源核心",
            desc: "提升所有点燃成功几率",
            level: 28,
            price: 320,
            chance: 45,
            attrs: [
                SacredAttr(type: Attribute.MIND, valueMin: 20, valueMax: 30),
                SacredAttr(type: Attribute.FIREPOWER, valueMin: 20, valueMax: 30),
                SacredAttr(type: Attribute.FIRERESISTANCE, valueMin: 20, valueMax: 30)
            ],
            randomAttrCountMin: 1,
            randomAttrCountMax: 2
        ),
        Sacred.Faceless: Sacred(
            effection: Sacred.Faceless,
            type: Outfit.Shield,
            name: "无面者",
            desc: "每三个回合释放一次法术反射",
            level: 30,
            price: 340,
            chance: 30,
            attrs: [
                SacredAttr(type: Attribute.STAMINA, valueMin: 15, valueMax: 25)
            ],
            randomAttrCountMin: 4,
            randomAttrCountMax: 4
        ),
        Sacred.Accident: Sacred(
            effection: Sacred.Accident,
            type: Outfit.Shield,
            name: "无妄之灾",
            desc: "将所有受到的法术伤害转移给队友",
            level: 36,
            price: 388,
            chance: 20,
            attrs: [
                SacredAttr(type: Attribute.FIRERESISTANCE, valueMin: 30, valueMax: 35),
                SacredAttr(type: Attribute.WATERRESISTANCE, valueMin: 30, valueMax: 35),
                SacredAttr(type: Attribute.THUNDERRESISTANCE, valueMin: 30, valueMax: 35)
            ],
            randomAttrCountMin: 1,
            randomAttrCountMax: 2
        ),
        Sacred.FrancisFace: Sacred(
            effection: Sacred.FrancisFace,
            type: Outfit.Shield,
            name: "佛朗西斯的面容",
            desc: "受到伤害时有一定几率获得5暴击",
            level: 40,
            price: 768,
            chance: 15,
            attrs: [
                SacredAttr(type: Attribute.STRENGTH, valueMin: 30, valueMax: 30),
                SacredAttr(type: Attribute.STAMINA, valueMin: 30, valueMax: 30),
                SacredAttr(type: Attribute.HEALTH, valueMin: 100, valueMax: 120),
                SacredAttr(type: Attribute.REVENGE, valueMin: 15, valueMax: 20)
            ],
            randomAttrCountMin: 1,
            randomAttrCountMax: 1
        ),
        Sacred.EvilExpel: Sacred(
            effection: Sacred.EvilExpel,
            type: Outfit.Shield,
            name: "辟邪",
            desc: "有一定几率低挡来自恶魔的伤害",
            level: 23,
            price: 210,
            chance: 40,
            attrs: [
                SacredAttr(type: Attribute.STAMINA, valueMin: 16, valueMax: 16),
                SacredAttr(type: Attribute.THUNDERRESISTANCE, valueMin: 20, valueMax: 20),
                SacredAttr(type: Attribute.HEALTH, valueMin: 40, valueMax: 40)
            ],
            randomAttrCountMin: 2,
            randomAttrCountMax: 3
        ),
        Sacred.HeartOfSwamp: Sacred(
            effection: Sacred.HeartOfSwamp,
            type: Outfit.SoulStone,
            name: "沼泽之心",
            desc: "种族转换为生灵",
            level: 20,
            price: 440,
            chance: 55,
            attrs: []
        ),
        Sacred.PandoraHeart: Sacred(
            effection: Sacred.PandoraHeart,
            type: Outfit.SoulStone,
            name: "潘多拉之心",
            desc: "随机获取一个未获得的神之技",
            level: 35,
            price: 2200,
            chance: 15,
            attrs: []
        ),
        Sacred.HeartOfTarrasque: Sacred(
            effection: Sacred.HeartOfTarrasque,
            type: Outfit.SoulStone,
            name: "魔龙之心",
            desc: "提升重生的治疗效果100%",
            level: 25,
            price: 458,
            chance: 45,
            attrs: []
        ),
        Sacred.SoulPeace: Sacred(
            effection: Sacred.SoulPeace,
            type: Outfit.SoulStone,
            name: "灵魂碎片",
            desc: "种族转化为天使",
            level: 22,
            price: 322,
            chance: 70,
            attrs: []
        ),
        Sacred.GiantSoul: Sacred(
            effection: Sacred.GiantSoul,
            type: Outfit.SoulStone,
            name: "巨人之魂",
            desc: "种族变为巨人",
            level: 25,
            price: 434,
            chance: 40,
            attrs: []
        ),
        Sacred.NewSwordPlus: Sacred(
            effection: Sacred.NewSwordPlus,
            type: Outfit.Sword,
            name: "冒险者之剑(改)",
            desc: "冒险者最梦寐以求的武器",
            level: 10,
            price: 10,
            chance: 100,
            attrs: [
                SacredAttr(type: Attribute.STRENGTH, valueMin: 10, valueMax: 10),
                SacredAttr(type: Attribute.STAMINA, valueMin: 10, valueMax: 10),
                SacredAttr(type: Attribute.AGILITY, valueMin: 10, valueMax: 10),
                SacredAttr(type: Attribute.INTELLECT, valueMin: 10, valueMax: 10),
            ],
            randomAttrCountMin: 0,
            randomAttrCountMax: 0
        ),
        Sacred.NewSword: Sacred(
            effection: Sacred.NewSword,
            type: Outfit.Sword,
            name: "冒险者之剑",
            desc: "冒险者们最初的武器",
            level: 1,
            price: 1,
            chance: 100,
            attrs: [
                SacredAttr(type: Attribute.STRENGTH, valueMin: 2, valueMax: 2),
                SacredAttr(type: Attribute.STAMINA, valueMin: 2, valueMax: 2),
                SacredAttr(type: Attribute.AGILITY, valueMin: 2, valueMax: 2),
                SacredAttr(type: Attribute.INTELLECT, valueMin: 2, valueMax: 2),
            ],
            randomAttrCountMin: 0,
            randomAttrCountMax: 0
        ),
        Sacred.DragonSlayer: Sacred(
            effection: Sacred.DragonSlayer,
            type: Outfit.Sword,
            name: "屠龙者",
            desc: "对龙类造成的全伤害提升100%",
            level: 40,
            price: 1440,
            chance: 30,
            attrs: [
                SacredAttr(type: Attribute.STAMINA, valueMin: 25, valueMax: 35),
                SacredAttr(type: Attribute.CRITICAL, valueMin: 25, valueMax: 35),
                SacredAttr(type: Attribute.REVENGE, valueMin: 15, valueMax: 25)
            ],
            randomAttrCountMin: 2,
            randomAttrCountMax: 3
        ),
        Sacred.DragonSaliva: Sacred(
            effection: Sacred.DragonSaliva,
            type: Outfit.Sword,
            name: "龙涎剑",
            desc: "攻击附带30%的火焰伤害",
            level: 40,
            price: 1988,
            chance: 15,
            attrs: [
                SacredAttr(type: Attribute.STRENGTH, valueMin: 25, valueMax: 35),
                SacredAttr(type: Attribute.STAMINA, valueMin: 25, valueMax: 35),
                SacredAttr(type: Attribute.AGILITY, valueMin: 25, valueMax: 35),
                SacredAttr(type: Attribute.INTELLECT, valueMin: 25, valueMax: 35),
                SacredAttr(type: Attribute.FIREPOWER, valueMin: 25, valueMax: 35)
            ],
            randomAttrCountMin: 1,
            randomAttrCountMax: 1
        ),
        Sacred.TheExorcist: Sacred(
            effection: Sacred.TheExorcist,
            type: Outfit.Sword,
            name: "驱魔剑",
            desc: "攻击亡灵时有一定几率直接杀死",
            level: 35,
            price: 1124,
            chance: 25,
            attrs: [
                SacredAttr(type: Attribute.ACCURACY, valueMin: 35, valueMax: 35),
                SacredAttr(type: Attribute.MIND, valueMin: 35, valueMax: 35),
                SacredAttr(type: Attribute.SPIRIT, valueMin: 15, valueMax: 25),
                SacredAttr(type: Attribute.LUCKY, valueMin: 15, valueMax: 25),
            ],
            randomAttrCountMin: 1,
            randomAttrCountMax: 1
        ),
        Sacred.BloodBlade: Sacred(
            effection: Sacred.BloodBlade,
            type: Outfit.Sword,
            name: "血刃",
            desc: "生命值越低，攻击力越高",
            level: 25,
            price: 344,
            chance: 35,
            attrs: [
                SacredAttr(type: Attribute.AGILITY, valueMin: 15, valueMax: 15),
                SacredAttr(type: Attribute.CRITICAL, valueMin: 15, valueMax: 15),
                SacredAttr(type: Attribute.ACCURACY, valueMin: 15, valueMax: 15)
            ],
            randomAttrCountMin: 2,
            randomAttrCountMax: 3
        ),
        Sacred.ElementalSword: Sacred(
            effection: Sacred.ElementalSword,
            type: Outfit.Sword,
            name: "元素剑",
            desc: "获得元素大师效果",
            level: 15,
            price: 188,
            chance: 40,
            attrs: [
                SacredAttr(type: Attribute.INTELLECT, valueMin: 10, valueMax: 10),
                SacredAttr(type: Attribute.SPIRIT, valueMin: 15, valueMax: 20),
                SacredAttr(type: Attribute.LUCKY, valueMin: 15, valueMax: 20)
            ],
            randomAttrCountMin: 2,
            randomAttrCountMax: 3
        ),
        Sacred.IberisHand: Sacred(
            effection: Sacred.IberisHand,
            type: Outfit.Sword,
            name: "伊比利斯之舞",
            desc: "提升乱舞次数",
            level: 30,
            price: 560,
            chance: 30,
            attrs: [
                SacredAttr(type: Attribute.AVOID, valueMin: 25, valueMax: 35),
                SacredAttr(type: Attribute.ACCURACY, valueMin: 25, valueMax: 35),
                SacredAttr(type: Attribute.CRITICAL, valueMin: 25, valueMax: 35),
                SacredAttr(type: Attribute.SPEED, valueMin: 25, valueMax: 35),
                SacredAttr(type: Attribute.REVENGE, valueMin: 10, valueMax: 15),
                SacredAttr(type: Attribute.RHYTHM, valueMin: 10, valueMax: 15)
            ],
            randomAttrCountMin: 0,
            randomAttrCountMax: 0
        ),
        Sacred.AssassinsSword: Sacred(
            effection: Sacred.AssassinsSword,
            type: Outfit.Sword,
            name: "刺客之刃",
            desc: "提升50点必杀和50点毁灭",
            level: 24,
            price: 320,
            chance: 40,
            attrs: [
                SacredAttr(type: Attribute.AGILITY, valueMin: 12, valueMax: 18),
                SacredAttr(type: Attribute.ACCURACY, valueMin: 24, valueMax: 24),
                SacredAttr(type: Attribute.AVOID, valueMin: 24, valueMax: 24),
                SacredAttr(type: Attribute.CRITICAL, valueMin: 50, valueMax: 50),
                SacredAttr(type: Attribute.DESTROY, valueMin: 50, valueMax: 50)
            ],
            randomAttrCountMin: 0,
            randomAttrCountMax: 0
        ),
        Sacred.LightingRod: Sacred(
            effection: Sacred.LightingRod,
            type: Outfit.Wand,
            name: "避雷针",
            desc: "有效的降低雷电伤害",
            level: 6,
            price: 32,
            chance: 80,
            attrs: [
                SacredAttr(type: Attribute.THUNDERRESISTANCE, valueMin: 50, valueMax: 50)
            ],
            randomAttrCountMin: 2,
            randomAttrCountMax: 4
        ),
        Sacred.FireMaster: Sacred(
            effection: Sacred.FireMaster,
            type: Outfit.Wand,
            name: "驭火者",
            desc: "降低所有火系法术1的冷却回合",
            level: 29,
            price: 449,
            chance: 40,
            attrs: [
                SacredAttr(type: Attribute.STAMINA, valueMin: 20, valueMax: 20),
                SacredAttr(type: Attribute.SPIRIT, valueMin: 30, valueMax: 30),
                SacredAttr(type: Attribute.FIREPOWER, valueMin: 25, valueMax: 35)
            ],
            randomAttrCountMin: 2,
            randomAttrCountMax: 3
        ),
        Sacred.WitchWand: Sacred(
            effection: Sacred.WitchWand,
            type: Outfit.Wand,
            name: "巫毒法杖",
            desc: "诅咒不再有冷却时间",
            level: 33,
            price: 1440,
            chance: 30,
            attrs: [
                SacredAttr(type: Attribute.STAMINA, valueMin: 25, valueMax: 25),
                SacredAttr(type: Attribute.HEALTH, valueMin: 60, valueMax: 100),
                SacredAttr(type: Attribute.DEFENCE, valueMin: 40, valueMax: 50),
                SacredAttr(type: Attribute.MIND, valueMin: 40, valueMax: 50),
            ],
            randomAttrCountMin: 2,
            randomAttrCountMax: 2
        ),
        Sacred.PuppetMaster: Sacred(
            effection: Sacred.PuppetMaster,
            type: Outfit.Wand,
            name: "大傀儡师",
            desc: "增加一个随从位",
            level: 40,
            price: 4220,
            chance: 10,
            attrs: [
                SacredAttr(type: Attribute.STAMINA, valueMin: 30, valueMax: 40),
                SacredAttr(type: Attribute.MIND, valueMin: 30, valueMax: 40),
                SacredAttr(type: Attribute.WATERRESISTANCE, valueMin: 30, valueMax: 30)
            ],
            randomAttrCountMin: 3,
            randomAttrCountMax: 3
        ),
    ]
    
    //amulet
    static let TrueLie = "TrueLie"
    static let MedalOfCourage = "MedalOfCourage"
    static let FangOfVampire = "FangOfVampire"
    static let MoonShadow = "MoonShadow"
    static let EternityNight = "EternityNight"
    static let Sparkling = "Sparkling"
    static let MedalOfHero = "MedalOfHero"
    static let HeartOfJade = "HeartOfJade"
    
    //blunt
    static let IberisThignbone = "IberisThignbone"
    static let GiantFang = "GiantFang"
    static let ThorsHammer = "ThorsHammer"
    static let HolyPower = "HolyPower"
    static let IdyllssHand = "IdyllssHand"
    static let BansMechanArm = "BansMechanArm"
    
    //bow
    static let Hawkeye = "Hawkeye"
    static let Boreas = "Boreas"
    static let Skylark = "Skylark"
    static let Aonena = "Aonena"
    static let SoundOfWind = "SoundOfWind"
    static let FollowOn = "FollowOn"
    
    //dagger
    static let NightBlade = "NightBlade"
    static let LazesPedicureKnife = "LazesPedicureKnife"
    
    //earring
    static let VerdasTear = "VerdasTear"
    static let DeepSeaPearl = "DeepSeaPearl"
    static let EyeOfDius = "EyeOfDius"
    static let LavaCrystal = "LavaCrystal"
    
    //fist
    static let FingerBone = "FingerBone"
    static let LiosHold = "LiosHold"
    static let DragonClaw = "DragonClaw"
    static let NilSeal = "NilSeal"
    static let DeepCold = "DeepCold"
    
    //instrument
    static let TheMonatNotes = "TheMonatNotes"
    static let NoPants = "NoPants"
    static let CreationMatrix = "CreationMatrix"
    static let IssHead = "IssHead"
    static let TheSurvive = "TheSurvive"
    static let TheDeath = "TheDeath"
    static let TheAbandon = "TheAbandon"
    static let TheSurpass = "TheSurpass"
    static let TheFear = "TheFear"
    
    //mark
    static let PuppetMark = "PuppetMark"
    static let MarkOfOaks = "MarkOfOaks"
    static let MarkOfDeathGod = "MarkOfDeathGod"
    static let MarkOfVitality = "MarkOfVitality"
    static let MarkOfHeaven = "MarkOfHeaven"
    static let MoltenFire = "MoltenFire"
    static let TheEye = "TheEye"
    static let FireMark = "FireMark"
    static let IssMark = "IssMark"
    
    //ring
    static let RingOfDead = "RingOfDead"
    static let IdlirWeddingRing = "IdlirWeddingRing"
    static let ApprenticeRing = "ApprenticeRing"
    static let CopperRing = "CopperRing"
    static let SilverRing = "SilverRing"
    static let DellarsGoldenRing = "DellarsGoldenRing"
    static let LuckyRing = "LuckyRing"
    static let RingOfDeath = "RingOfDeath"
    static let RingFromElder = "RingFromElder"
    static let RingOfReborn = "RingOfReborn"
    static let FireCore = "FireCore"
    
    //shield
    static let Faceless = "Faceless"
    static let Accident = "Accident"
    static let FrancisFace = "FrancisFace"
    static let EvilExpel = "EvilExpel"
    
    //soulstone
    static let HeartOfSwamp = "HeartOfSwamp"
    static let PandoraHeart = "PandoraHeart"
    static let HeartOfTarrasque = "HeartOfTarrasque"
    static let SoulPeace = "SoulPeace"
    static let GiantSoul = "GiantSoul"
    
    //sword
    static let NewSwordPlus = "NewSwordPlus"
    static let NewSword = "NewSword"
    static let DragonSlayer = "DragonSlayer"
    static let DragonSaliva = "DragonSaliva"
    static let TheExorcist = "TheExorcist"
    static let BloodBlade = "BloodBlade"
    static let ElementalSword = "ElementalSword"
    static let IberisHand = "IberisHand"
    static let AssassinsSword = "AssassinsSword"
    
    //wand
    static let LightingRod = "LightingRod"
    static let FireMaster = "FireMaster"
    static let WitchWand = "WitchWand"
    static let PuppetMaster = "PuppetMaster"
}
