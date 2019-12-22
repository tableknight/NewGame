//
//  NPCBattle.swift
//  GoD
//
//  Created by kai chen on 2019/8/26.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class NPCBattle: BossBattle {
    var _level:CGFloat = 1
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        expRate = 1
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func victorys() {
        if isVictory {
            return
        }
//        let l = Loot()
//        let ms:Array<Creature> = [_char] + _char.getReadyMinions()
//        for u in _evilsOrg {
//            for r in ms {
//                let exp = l.getExp(selfLevel: r._level, enemyLevel: u._unit._level) * expRate
//                r.expUp(up: exp)
//            }
//            if _char._level - u._unit._level <= 5 {
//                l.loot(level: u._unit._level)
//            }
//        }
        isVictory = true
        let list = specialLoot()
        
        fadeOutBattle()
        
        if list.count > 0 {
            let p = LootPanel()
            p.create(props: list)
            setTimeout(delay: 0.5, completion: {
                for u in self._playerPart {
                    u.removeFromParent()
                }
                Game.instance.curStage.showPanel(p)
            })
            p.confirmAction = {
                self.lootPanelConfirmAction()
            }
        } else {
            self.lootPanelConfirmAction()
        }
    }
}
