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
    var randomAttrCountMin = 1
    var randomAttrCountMax = 1
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
//        Sacred.MedalOfCourage: Sacred(
//            effection: Sacred.MedalOfCourage,
//            type: <#T##String#>,
//            name: <#T##String#>,
//            desc: <#T##String#>,
//            level: <#T##Int#>,
//            price: <#T##Int#>,
//            chance: <#T##Int#>,
//            attrs: [
//                SacredAttr(type: Attribute.AGILITY, valueMin: <#T##Int#>, valueMax: <#T##Int#>),
//                SacredAttr(type: Attribute.AGILITY, valueMin: <#T##Int#>, valueMax: <#T##Int#>),
//                SacredAttr(type: Attribute.AGILITY, valueMin: <#T##Int#>, valueMax: <#T##Int#>),
//                SacredAttr(type: Attribute.AGILITY, valueMin: <#T##Int#>, valueMax: <#T##Int#>),
//                SacredAttr(type: Attribute.AGILITY, valueMin: <#T##Int#>, valueMax: <#T##Int#>)
//            ],
//            randomAttrCountMin: <#T##Int#>,
//            randomAttrCountMax: <#T##Int#>
//        ),
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
}
