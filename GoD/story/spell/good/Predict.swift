//
//  Predict.swift
//  GoD
//
//  Created by kai chen on 2019/6/11.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class Predict: Magical {
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    override init() {
        super.init()
        _id = Spell.Predict
        _cooldown = 3
        _name = "预言"
        _description = "预言自己的未来，大幅度提升某项属性"
        targetEnemy = false
        _quality = Quality.GOOD
        autoCast = true
        _mpCost = 10 * _costRate
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        
        let status = Status()
        status._type = "_predict"
        status._labelText = "P"
        status._timeleft = 5
        let sd = seed(to: 110)
        var speak = ""
        if sd < 10 {
            speak = "攻无不克"
            c._valueUnit._extensions.attack += 50
            status.timeupAction = {
                c._valueUnit._extensions.attack -= 50
            }
        } else if sd < 20 {
            speak = "铜墙铁壁"
            c._valueUnit._extensions.defence += 50
            status.timeupAction = {
                c._valueUnit._extensions.defence -= 50
            }
        } else if sd < 30 {
            speak = "敏锐洞察"
            c._valueUnit._extensions.critical += 50
            status.timeupAction = {
                c._valueUnit._extensions.critical -= 50
            }
        } else if sd < 40 {
            speak = "身轻如燕"
            c._valueUnit._extensions.avoid += 50
            status.timeupAction = {
                c._valueUnit._extensions.avoid -= 50
            }
        } else if sd < 50 {
            speak = "精力充沛"
            c._valueUnit._extensions.spirit += 50
            status.timeupAction = {
                c._valueUnit._extensions.spirit -= 50
            }
        } else if sd < 60 {
            speak = "复仇天神"
            c._valueUnit._revenge += 50
            status.timeupAction = {
                c._valueUnit._revenge -= 50
            }
        } else if sd < 70 {
            speak = "节奏灵快"
            c._valueUnit._rhythm += 50
            status.timeupAction = {
                c._valueUnit._rhythm -= 50
            }
        } else if sd < 80 {
            speak = "头脑清醒"
            c._valueUnit._extensions.mind += 50
            status.timeupAction = {
                c._valueUnit._extensions.mind -= 50
            }
        } else if sd < 90 {
            speak = "掌控火源"
            c._valueUnit._elementalPower.fire += 50
            c._valueUnit._elementalResistance.fire += 50
            status.timeupAction = {
                c._valueUnit._elementalResistance.fire -= 50
                c._valueUnit._elementalPower.fire -= 50
            }
        } else if sd < 100 {
            speak = "雷电掌控"
            c._valueUnit._elementalPower.thunder += 50
            c._valueUnit._elementalResistance.thunder += 50
            status.timeupAction = {
                c._valueUnit._elementalResistance.thunder -= 50
                c._valueUnit._elementalPower.thunder -= 50
            }
        } else {
            speak = "掌控潮汐"
            c._valueUnit._elementalPower.water += 50
            c._valueUnit._elementalResistance.water += 50
            status.timeupAction = {
                c._valueUnit._elementalResistance.water -= 50
                c._valueUnit._elementalPower.water -= 50
            }
        }
        c.actionCast {
            c.showText(text: speak)
            c.cure3t() {
                c.addStatus(status: status)
                completion()
            }
            c.play("Raise3")
        }
    }
    override func findTarget() {
    }
}

