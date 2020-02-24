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
//        if !_menuButton.isHidden && _menuButton.contains(touchPoint!) {
//            showMenu()
//            return
//        }
//        if _confirmButton.contains(touchPoint!) {
//            if _menuButton.isHidden {
//                hideMenu()
//            }
//            _curScene.confirmEvent()
//            return
//        }
//        if _eButton.contains(touchPoint!) {
//            _curScene._direction = _curScene.EAST
//            _curScene.moveTo()
//            return
//        } else if _sButton.contains(touchPoint!) {
//            _curScene._direction = _curScene.SOUTH
//            _curScene.moveTo()
//            return
//        } else if _nButton.contains(touchPoint!) {
//            _curScene._direction = _curScene.NORTH
//            _curScene.moveTo()
//            return
//        } else if _wButton.contains(touchPoint!) {
//            _curScene._direction = _curScene.WEST
//            _curScene.moveTo()
//            return
//        } else
        if _minionButton.contains(touchPoint!) && !_minionButton.isHidden {
            let c = Game.instance.char
//            if (c?._minions.count)! < 1 {
//                showMsg(text: "没有携带随从的灵魂")
//                return
//            }
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
            Game.saving()
            return
        } else if _quitButton.contains(touchPoint!) && _quitButton.visible {
            self.removeFromParent()
            let welcome = Welcome()
            welcome.create()
            welcome._gameScene = Game.instance.gameScene
            Game.instance.gameScene.addChild(welcome)
            return
        }
        _curScene.touch(touchPoint: touchPoint)
    }
    func loadScene(scene:MyScene) {
        _curScene = scene
        showSceneMask()
        _showingLabel.text = scene._name
        _showingLabel.isHidden = false
        _messageLabel.isHidden = false
        _messageLabel.text = "& \(Strings.tips.one())"
        cancelMove = true
        setTimeout(delay: 1, completion: {
            let out = SKAction.fadeOut(withDuration: TimeInterval(1))
            self.addChild(scene)
            self._showingLabel.isHidden = true
            self._messageLabel.isHidden = true
            
            self._sceneChangeMask.run(out) {
                self._sceneChangeMask.isHidden = true
                self.cancelMove = false
            }
        })
    }
    func showMenu() {
        _charButton.isHidden = false
        _outfitButton.isHidden = false
        _itemButton.isHidden = false
        _spellButton.isHidden = false
        _minionButton.isHidden = false
//        _menuButton.isHidden = true
    }
    func hideMenu() {
        _charButton.isHidden = true
        _outfitButton.isHidden = true
        _itemButton.isHidden = true
        _spellButton.isHidden = true
        _minionButton.isHidden = true
//        _menuButton.isHidden = false
    }
    func createMenu() {
//        let y = -cellSize * 8
        let size:CGFloat = cellSize * 0.5
//        let operationButtonSize:CGFloat = cellSize * 0.5
//        let x = cellSize * 2.8
//        let gap = size + cellSize * 0.5
//        let standardX = -cellSize * 2.75
        let standardY = -cellSize * 6.25
        
//        _menuButton = createMenuButtons(x: cellSize * 1.75, y: standardY, size: size, text: "选项")
        _charButton = createMenuButtons(x: -cellSize * 2, y: standardY, size: size, text: "角色")
        _outfitButton = createMenuButtons(x: -cellSize * 1, y: standardY, size: size, text: "装备")
        _itemButton = createMenuButtons(x: 0 , y: standardY, size: size, text: "物品")
        _spellButton = createMenuButtons(x: cellSize, y: standardY, size: size, text: "法术")
        _minionButton = createMenuButtons(x: cellSize * 2, y: standardY, size: size, text: "随从")
//        hideMenu()
//        let operationButtonGap:CGFloat = cellSize * 0.85
        
        
//        _nButton = createMenuButtons(x: standardX, y: standardY + operationButtonGap, size: operationButtonSize, text: "N")
//        _sButton = createMenuButtons(x: standardX, y: standardY - operationButtonGap, size: operationButtonSize, text: "S")
//        _wButton = createMenuButtons(x: standardX - operationButtonGap, y: standardY, size: operationButtonSize, text: "W")
//        _eButton = createMenuButtons(x: standardX + operationButtonGap, y: standardY, size: operationButtonSize, text: "E")
//
////        _confirmButton = createMenuButtons(x: -standardX + operationButtonGap, y: standardY, size: operationButtonSize, text: "A")
//        _confirmButton = createMenuButtons(x: cellSize * 3, y: standardY, size: operationButtonSize * 1.25, text: "A")
//        _uiComponentList.append(_nButton)
//        _uiComponentList.append(_sButton)
//        _uiComponentList.append(_wButton)
//        _uiComponentList.append(_eButton)
//        _uiComponentList.append(_confirmButton)
//        _quitButton = createMenuButtons(x: -x, y: -cellSize * 6.3, size: cellSize * 0.6, text: "保存")
        /*
        SE
        320x568
        640x1136
        
        
        6(S)／7／8
        375x667
        750x1334
        
        
        6(S)+／7+／8+
        414x736
        1080x1920
        
        
        X(S)
        375x812
        1125x2436
        
        
        XR
        414x896
        828x1792
        
        
        XS Max
        414x896
        1242x2688
 */
        let bounds = UIScreen.main.bounds.size
        var rate:CGFloat = 1
        if bounds.width == 375 && bounds.height == 667 { //iphone8
            rate = 1
        } else if bounds.width == 414 && bounds.height == 736 { //iphone8s
            rate = 0.9
        } else if bounds.width == 414 && bounds.height == 896 { //iphone xr xsmax
            rate = 0.72
        } else if bounds.width == 375 && bounds.height == 812 { //iphone x
            rate = 0.78
        } else if bounds.width == 320 && bounds.height == 568 { //iphone x
            rate = 1
        }
        let w = bounds.width * rate
        let h = bounds.height * rate
        
        let padding = cellSize * 0.25
        _quitButton.text = "退出"
        _quitButton.yAxis = h - padding
        _quitButton.xAxis = -w + padding
        addChild(_quitButton)
        _uiComponentList.append(_quitButton)
        _saveButton.text = "保存"
        _saveButton.yAxis = h - padding
        _saveButton.xAxis = w - padding - _saveButton.width
        addChild(_saveButton)
        _uiComponentList.append(_saveButton)
        
//        let roleImage = Game.instance.char._img.getNode(1, 0)
//        roleImage.position.x = -bounds.width + padding + 12
//        roleImage.position.y = -bounds.height + padding + 28
//        addChild(roleImage)
        
        let offsetY:CGFloat = cellSize * 2
        let hpbar = HBar()
        hpbar.create(width: w * 0.35, height: 10, value: 1, color: UIColor.red)
        hpbar.position.y = h - offsetY + 30
        hpbar.position.x = -w + padding
        addChild(hpbar)
        hpbar.zPosition = MyStage.UI_LAYER_Z
        _uiComponentList.append(hpbar)
        _hpbar = hpbar
        
        _mpbar.create(width: w * 0.35, height: 10, value: 1, color: Game.MPBAR_COLOR)
        _mpbar.yAxis = h - offsetY + 10
        _mpbar.xAxis = hpbar.xAxis
        addChild(_mpbar)
        _mpbar.zPosition = MyStage.UI_LAYER_Z
        _uiComponentList.append(_mpbar)
        
        let expbar = HBar()
        expbar.create(width: w * 0.45, height: 10, value: 1, color: UIColor.green)
        expbar.position.y = h - offsetY - 10
        expbar.position.x = hpbar.position.x
        expbar.zPosition = MyStage.UI_LAYER_Z
//        expbar.position.x = bounds.width * 0.5 - padding
        addChild(expbar)
        _uiComponentList.append(expbar)
        _expbar = expbar
        
        setBarValue()
    }
    private var _hpbar = HBar()
    private var _mpbar = HBar()
    private var _expbar = HBar()
    func setBarValue() {
        let role = _curScene._role!
        _hpbar.setBar(value: role.getHp() / role.getHealth())
        _mpbar.setBar(value: role.getMp() / role.getMpMax())
        if role._unit._level >= 40 {
            _expbar.setBar(value: 1)
        } else {
            _expbar.setBar(value: role._unit._exp / role._unit.expNext())
        }
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
//        hideMenu()
//        _menuButton.isHidden = true
    }
    func showUI() {
        for ui in _uiComponentList {
            ui.show()
        }
//        showMenu()
    }
    func showPanel(_ panel:UIPanel) {
        if cancelMove && !panel.isChild {
            return
        }
        panel.zPosition = MyStage.UI_PANEL_Z
        _curPanel = panel
        addChild(panel)
        cancelMove = true
    }
    func removePanel(_ panel:UIPanel) {
        _curPanel = nil
        panel.removeFromParent()
        cancelMove = false
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
        cancelMove = true
    }
    
    func removeDialog(dlg:Dialog) {
        dlg.removeFromParent()
        showUI()
        _curDialog = nil
        cancelMove = false
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
        if _curPanel != nil {
            removePanel(_curPanel!)
        }
        showSceneMask()
        _messageNode.removeFromParent()
        _showingLabel.text = next._name
        _showingLabel.isHidden = false
        _messageLabel.text = "& \(Strings.tips.one())"
        _messageLabel.isHidden = false
        loaded = false
        _curScene.removeFromParent()
        _curScene._role.removeFromParent()
        cancelMove = true
        Game.saving(sync: false)
        //        return
//        let this = self
        setTimeout(delay: 1, completion: {
            
            //            let wait = SKAction.wait(forDuration: TimeInterval(1))
            let out = SKAction.fadeOut(withDuration: TimeInterval(1))
            if !next.initialized {
                next.create()
            }
            //        return
            //            let go = SKAction.sequence([wait, out])
//            this.loadScene(scene: next)
            self.addChild(next)
            self._curScene = next
            self._showingLabel.isHidden = true
            self._messageLabel.isHidden = true
            completion()
            
            self._sceneChangeMask.run(out) {
                self._sceneChangeMask.isHidden = true
                self.loaded = true
                self.cancelMove = false
            }
        })
    }
    func enterFloor(floor:CGFloat) {
        clearScene()
        let char = _curScene._role!
        if 0 == floor {
            let scene = CenterV()
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
    var _sceneChangeMask = SKSpriteNode()
    private var _showingLabel = Label()
    private var _messageLabel = Label()
    
    private func createSceneChangeMask() {
        let screenBounds:CGSize = UIScreen.main.bounds.size
        let cover = createBackground(width: screenBounds.width * 2, height: screenBounds.height * 2)
        cover.fillColor = UIColor.black
        cover.position.x = 0
        cover.position.y = 0
        cover.lineWidth = 0
        cover.alpha = 1
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
        
        _messageLabel.isHidden = true
        _messageLabel.fontSize = 18
        _messageLabel.align = "center"
        _messageLabel.zPosition = _sceneChangeMask.zPosition + 1
        _messageLabel.position.y = cellSize * -8
        addChild(_messageLabel)
        
//        let bg = createBackground(width: screenBounds.width * 2, height: screenBounds.height * 2)
//        bg.fillColor = UIColor.black
//        bg.position.x = 0
//        bg.position.y = 0
//        bg.lineWidth = 0
//        bg.zPosition = 0
//        addChild(bg)
        
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
    func refreshCharStatusUI() {
        self.setBarValue()
    }
    var _curDialog:Dialog?
    var _curScene:MyScene!
//    var _sButton:RoundButton!
//    var _nButton:RoundButton!
//    var _wButton:RoundButton!
//    var _eButton:RoundButton!
//    var _confirmButton:RoundButton!
    var _cancelButton:RoundButton!
    var _charButton:RoundButton!
//    var _menuButton:RoundButton!
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
