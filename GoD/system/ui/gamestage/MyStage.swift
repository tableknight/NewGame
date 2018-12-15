//
//  GameScene.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/12/8.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class MyStage: SKSpriteNode {
    static let UI_LAYER_Z:CGFloat = 200
    static let UI_PANEL_Z:CGFloat = 300
    static let UI_SUB_PANEL_Z:CGFloat = 400
    static let UI_TOPEST_Z:CGFloat = 1000
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        isUserInteractionEnabled = true
        Game.instance.curStage = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        if _minionButton.contains(touchPoint!) && !_minionButton.isHidden {
            let c = Game.instance.char
            if (c?._minions.count)! < 1 {
                return
            }
            let ml = MinionsList()
            ml.create(minions: (c?._minions)!)
            showPanel(ml)
            return
        } else if _spellButton.contains(touchPoint!) && !_spellButton.isHidden {
            let sp = SpellPanel()
            sp.create(role: Game.instance.char)
            showPanel(sp)
            return
        } else if _charButton.contains(touchPoint!) && !_charButton.isHidden {
//            let ci = RoleInfoPanel()
//            ci.create(char: Game.instance._char)
            let panel = RolePanel()
            panel.create(unit: Game.instance.char)
            showPanel(panel)
            return
        } else if _itemButton.contains(touchPoint!) && !_itemButton.isHidden {
            let ap = ItemPanel()
            ap.create()
            showPanel(ap)
            return
        } else if _outfitButton.contains(touchPoint!) && !_outfitButton.isHidden {
            let op = OutfitPanel()
            op.create()
            showPanel(op)
            return
        }
    }
    func loadScene(scene:MyScene) {
        addChild(scene)
        _curScene = scene
        _scenes.append(scene)
    }
    func createMenu() {
        let y = -cellSize * 6.5
        let size:CGFloat = cellSize * 0.4
        let x = cellSize * 2
        _charButton = createMenuButtons(x: -cellSize * 2.5 + x, y: y, size: size, text: "角色")
        _outfitButton = createMenuButtons(x: -cellSize * 1.5 + x, y: y, size: size, text: "装备")
        _itemButton = createMenuButtons(x: -cellSize * 0.5 + x , y: y, size: size, text: "物品")
        _spellButton = createMenuButtons(x: cellSize * 0.5 + x, y: y, size: size, text: "法术")
        _minionButton = createMenuButtons(x: cellSize * 1.5 + x, y: y, size: size, text: "随从")
        
        
    }
    private func createMenuButtons(x:CGFloat, y:CGFloat, size:CGFloat, text:String) -> RoundButton {
        let s = RoundButton()
        s.create(text: text, size: size)
        s.position.x = x
        s.position.y = y
        s.zPosition = MyStage.UI_LAYER_Z
        addChild(s)
        _uiComponentList.append(s)
        return s
    }
    func showPanel(_ panel:UIPanel) {
        panel.zPosition = MyStage.UI_PANEL_Z
        addChild(panel)
    }
    func removePanel(_ panel:UIPanel) {
        panel.removeFromParent()
    }
    func hasTowerStatus(status:Status) -> Bool {
        for scn in _scenes {
            for s in scn._status {
                if s._type == status._type {
                    return true
                }
            }
        }
        return false
    }
    var _curScene:MyScene!
    var _charButton:RoundButton!
    var _itemButton:RoundButton!
    var _outfitButton:RoundButton!
    var _spellButton:RoundButton!
    var _minionButton:RoundButton!
    var _uiComponentList:Array<SKSpriteNode> = []
    var _scenes = Array<MyScene>()
//    var _
}
