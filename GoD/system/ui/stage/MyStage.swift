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
        } else if _saveButton.contains(touchPoint!) && _saveButton.visible {
//            Game.save(c: Game.instance.char!, key: "char")
//            self.removeFromParent()
            let char = Game.instance.char!
            var roles = Game.roles
            if char._key.isEmpty {
                char._key = "doc\(Game.roles.count)"
                let roleDoc = RoleDocument()
                roleDoc._name = char._name
                roleDoc._pro = char._pro
                roleDoc._level = char._level.toInt()
                roleDoc._key = char._key
                roleDoc._imgUrl = char._imgUrl
                roles.append(roleDoc)
            } else {
                for c in roles {
                    if c._key == char._key {
                        c._level = char._level.toInt()
                        break
                    }
                }
            }
            Game.save(c: char, key: char._key)
            Game.saveRoles(roles: roles)
            showSceneMask()
            _sceneChangeMask.alpha = 0.65
            cancelMove = true
            setTimeout(delay: 2, completion: {
                showMsg(text: "保存成功！")
                self._sceneChangeMask.isHidden = true
                self.cancelMove = false
            })
        }
    }
    func loadScene(scene:MyScene) {
        addChild(scene)
        _curScene = scene
//        _scenes.append(scene)
    }
    func createMenu() {
        let y = -cellSize * 6.5
        let size:CGFloat = cellSize * 0.45
        let x = cellSize * 3.5
        let gap = size + cellSize * 0.5
        _charButton = createMenuButtons(x: x, y: y, size: size, text: "角色")
        _outfitButton = createMenuButtons(x: x - gap, y: y, size: size, text: "装备")
        _itemButton = createMenuButtons(x: x - gap * 2 , y: y, size: size, text: "物品")
        _spellButton = createMenuButtons(x: x - gap * 3, y: y, size: size, text: "法术")
        _minionButton = createMenuButtons(x: x - gap * 4, y: y, size: size, text: "随从")
//        _quitButton = createMenuButtons(x: -x, y: -cellSize * 6.3, size: cellSize * 0.6, text: "保存")
        let bounds = UIScreen.main.bounds.size
        let padding = cellSize * 0.25
        _quitButton.text = "退出"
        _quitButton.yAxis = bounds.height - padding
        _quitButton.xAxis = -bounds.width + padding
        addChild(_quitButton)
        _uiComponentList.append(_quitButton)
        _saveButton.text = "保存"
        _saveButton.yAxis = bounds.height - padding
        _saveButton.xAxis = bounds.width - padding - _saveButton.width
        addChild(_saveButton)
        _uiComponentList.append(_saveButton)
        
//        let roleImage = Game.instance.char._img.getNode(1, 0)
//        roleImage.position.x = -bounds.width + padding + 12
//        roleImage.position.y = -bounds.height + padding + 28
//        addChild(roleImage)
        
        
        let hpbar = HBar()
        hpbar.create(width: bounds.width * 0.35, height: 10, value: 1, color: UIColor.red)
        hpbar.position.y = -bounds.height + padding + 30
        hpbar.position.x = -bounds.width + padding
        addChild(hpbar)
        _uiComponentList.append(hpbar)
        _hpbar = hpbar
        
        let expbar = HBar()
        expbar.create(width: bounds.width * 0.45, height: 10, value: 1, color: UIColor.green)
        expbar.position.y = -bounds.height + padding + 10
        expbar.position.x = hpbar.position.x
//        expbar.position.x = bounds.width * 0.5 - padding
        addChild(expbar)
        _uiComponentList.append(expbar)
        _expbar = expbar
        
        setBarValue()
    }
    private var _hpbar = HBar()
    private var _expbar = HBar()
    func setBarValue() {
        let role = _curScene._role!
        _hpbar.setBar(value: role.getHp() / role.getHealth())
        _expbar.setBar(value: role._unit._exp / role._unit.expNext())
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
    var cancelMove = false
    func addBattle(_ b:Battle) {
        if nil != childNode(withName: "battle") {
            debug("battle exist! error")
            return
        }
        cancelMove = true
        hideUI()
        hideScene()
        showSceneMask()
        _showingLabel.text = "进入战斗"
        _showingLabel.isHidden = false
        setTimeout(delay: 1, completion: {
            self._showingLabel.isHidden = true
            self._sceneChangeMask.isHidden = true
            self.addChild(b)
            b.zPosition = MyScene.MASK_LAYER_Z + 2
        })
    }
    func removeBattle(_ b:Battle) {
        cancelMove = false
        b.removeFromParent()
        showUI()
        showScene()
        setBarValue()
    }
    func hideScene() {
//        _curScene.isHidden = true
        _curScene.alpha = 0.25
        _curScene._nameLabel.isHidden = true
    }
    func showScene() {
//        _curScene.isHidden = false
        _curScene.alpha = 1
        _curScene._nameLabel.isHidden = false
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
    func switchScene(next:MyScene, completion:@escaping () -> Void = {}) {
        if !loaded {
            return
        }
        showSceneMask()
        _showingLabel.text = next._name
        _showingLabel.isHidden = false
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
            }
            //        return
            //            let go = SKAction.sequence([wait, out])
            this.loadScene(scene: next)
            self._showingLabel.isHidden = true
            completion()
            
            this._sceneChangeMask.run(out) {
                self._sceneChangeMask.isHidden = true
                this.loaded = true
            }
        })
    }
    func enterFloor(floor:CGFloat) {
        clearScene()
        let char = _curScene._role!
        if 0 == floor {
            let scene = CenterCamping()
            switchScene(next: scene, completion: {
                scene.setRole(x: 5, y: 7, char: char)
                char.faceSouth()
            })
        } else {
            let ar = AcientRoad()
            let  scene = floor > 6 ? ar.getSceneById(id: ar.sceneList.one()) : ar.getSceneById(id: floor.toInt())
            scene._level = floor
            saveScene(scene: scene)
            switchScene(next: scene, completion: {
                scene.setRole(x: scene._portalPrev.x, y: scene._portalPrev.y, char: char)
                char.faceSouth()
            })
        }
    }
    func gohome() {
        let char = _curScene._role!
        let scene = SelfHome()
        switchScene(next: scene, completion: {
            scene.setRole(x: 2, y: 1, char: char)
            char.faceSouth()
        })
    }
    private var _sceneChangeMask = SKSpriteNode()
    private var _showingLabel = Label()
    private func createSceneChangeMask() {
        let screenBounds:CGSize = UIScreen.main.bounds.size
        let cover = createBackground(width: screenBounds.width * 2, height: screenBounds.height * 2)
        cover.fillColor = UIColor.black
        cover.position.x = 0
        cover.position.y = 0
        cover.lineWidth = 0
        _sceneChangeMask.addChild(cover)
        _sceneChangeMask.isHidden = true
        _sceneChangeMask.zPosition = MyScene.MASK_LAYER_Z
        addChild(_sceneChangeMask)
        
        _showingLabel.isHidden = true
        _showingLabel.fontSize = 36
        _showingLabel.align = "center"
        _showingLabel.zPosition = _sceneChangeMask.zPosition + 1
        _showingLabel.position.y = 18
        addChild(_showingLabel)
        
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
    var _quitButton = Button()
    var _saveButton = Button()
    var _uiComponentList:Array<SKSpriteNode> = []
    var _scenes = Array<AcientRoad>()
    var _curPanel:UIPanel?
    var _messageNode = SKSpriteNode()
    private var loaded = true
//    var _
}
