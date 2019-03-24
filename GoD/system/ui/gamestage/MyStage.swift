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
        createSceneChangeMask()
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
//        _scenes.append(scene)
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
    func hideUI() {
        for ui in _uiComponentList {
            ui.hide()
        }
    }
    func showUI() {
        for ui in _uiComponentList {
            ui.show()
        }
    }
    func showPanel(_ panel:UIPanel) {
        panel.zPosition = MyStage.UI_PANEL_Z
        _curPanel = panel
        addChild(panel)
    }
    func removePanel(_ panel:UIPanel) {
        _curPanel = nil
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
    func addStatus(status:Status) {
        _curScene._status.append(status)
    }
    func getSceneByIndex(index:Int) -> AcientRoad? {
        for sc in _scenes {
            if sc._index == index {
                return sc
            }
        }
        return nil
    }
    func addBattle(_ b:Battle) {
        if nil != childNode(withName: "battle") {
            debug("battle exist! error")
            return
        }
        hideUI()
        hideScene()
        addChild(b)
    }
    func removeBattle(_ b:Battle) {
        b.removeFromParent()
        showUI()
        showScene()
    }
    func hideScene() {
        _curScene.isHidden = true
    }
    func showScene() {
        _curScene.isHidden = false
    }
    func showDialog(img:SKTexture, text:String, name:String, action:@escaping () -> Void = {}) {
        if nil != _curDialog {
            return
        }
        hideUI()
//        _char.removeSpeak()
        let dlg = Dialog()
        dlg._name = name
        dlg.create(img: img)
        dlg.text = text
        addChild(dlg)
        dlg.yAxis = -cellSize * 2
        _curDialog = dlg
        action()
    }
    
    func removeDialog(dlg:Dialog) {
        dlg.removeFromParent()
        showUI()
        _curDialog = nil
    }
    func showSceneMask() {
        _sceneChangeMask.isHidden = false
        _sceneChangeMask.alpha = 1
    }
    //进入以创建场景设置角色用completion事件 进入未初始化地图用afterCreation
    func switchScene(next:MyScene, afterCreation:@escaping () -> Void = {},  completion:@escaping () -> Void = {}) {
        if !loaded {
            return
        }
        showSceneMask()
        loaded = false
        _curScene.removeFromParent()
        _curScene._role.removeFromParent()
        //        return
        let this = self
        setTimeout(delay: 1, completion: {
            
            //            let wait = SKAction.wait(forDuration: TimeInterval(1))
            let out = SKAction.fadeOut(withDuration: TimeInterval(1))
            if !next.initialized {
                next.create()
                afterCreation()
            }
            //        return
            //            let go = SKAction.sequence([wait, out])
            this.loadScene(scene: next)
            
            this._sceneChangeMask.run(out) {
                completion()
                this.loaded = true
            }
        })
    }
    func enterFloor(floor:CGFloat) {
        clearScene()
        let char = _curScene._role!
        if 0 == floor {
            let scene = CenterCamping()
            switchScene(next: scene, afterCreation: {
                scene.setRole(x: 5, y: 7, char: char)
                char.faceSouth()
            })
        } else {
            let ar = AcientRoad()
            let  scene = floor > 6 ? ar.getSceneById(id: ar.sceneList.one()) : ar.getSceneById(id: floor.toInt())
            scene._level = floor
            saveScene(scene: scene)
            switchScene(next: scene, afterCreation: {
                scene.setRole(x: scene._portalPrev.x, y: scene._portalPrev.y, char: char)
                char.faceSouth()
            })
        }
    }
    func gohome() {
        let char = _curScene._role!
        let scene = SelfHome()
        switchScene(next: scene, afterCreation: {
            scene.setRole(x: 2, y: 1, char: char)
            char.faceSouth()
        })
    }
    private var _sceneChangeMask = SKSpriteNode()
    private func createSceneChangeMask() {
        let cover = createBackground(width: cellSize * 13, height: cellSize * 12)
        cover.fillColor = UIColor.black
        cover.position.x = 0
        cover.position.y = 0
        _sceneChangeMask.addChild(cover)
        _sceneChangeMask.isHidden = true
        _sceneChangeMask.zPosition = MyScene.MASK_LAYER_Z
        addChild(_sceneChangeMask)
    }
    func getSceneIndex() -> Int {
        return _scenes.count + 1
    }
    func clearScene() {
        _scenes = []
    }
    func saveScene(scene:AcientRoad) {
        _scenes.append(scene)
    }
    var _curDialog:Dialog?
    var _curScene:MyScene!
    var _charButton:RoundButton!
    var _itemButton:RoundButton!
    var _outfitButton:RoundButton!
    var _spellButton:RoundButton!
    var _minionButton:RoundButton!
    var _uiComponentList:Array<SKSpriteNode> = []
    var _scenes = Array<AcientRoad>()
    var _curPanel:UIPanel?
    var _messageNode = SKSpriteNode()
    private var loaded = true
//    var _
}
