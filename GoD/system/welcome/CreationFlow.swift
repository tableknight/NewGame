//
//  CreationFlow.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/6.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class CreationFlow:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func create() {
        let this = self
        let selectImage = SelectImage()
        selectImage.create()
        addChild(selectImage)
        
        let selectPro = SelecProfession()
        selectPro.create()
        selectPro.hide()
        addChild(selectPro)
        
        let selectItems = SelectItems()
        selectItems.create()
        selectItems.hide()
        addChild(selectItems)
        
        let selectMinion = SelectMinion()
        selectMinion.create()
        selectMinion.hide()
        addChild(selectMinion)
        
        selectImage.nextAction = {
            this.showPanel(1)
        }
        selectPro.nextAction = {
            this.showPanel(2)
        }
        selectPro.prevAction = {
            this.showPanel(0)
        }
        selectItems.nextAction = {
            this.showPanel(3)
        }
        selectItems.prevAction = {
            this.showPanel(1)
        }
        selectMinion.prevAction = {
            this.showPanel(2)
        }
        selectMinion.nextAction = {
            if nil == selectImage._lastSelectedComponent._image {
                self.showPanel(0)
                return
            }
            let image = selectImage._lastSelectedComponent._image!
            var role = selectPro._selectedRole
            if nil == role {
                role = ["冒险者", "", 5, true, false, true, 3, 2, []]
            }
            let items = selectItems._selectedItems
            let minion = selectMinion._lastSelectedComponent._minion
            let stage = MyStage()
            let scene = SelfHome()
            scene.create()
            let e = Character()
            e.create(level: 1)
            e._img = image
            e._imgUrl = selectImage._lastSelectedComponent._imgUrl
            e._spellsInuse = role![8] as! Array<Spell>
            e._props = items
            e.hasWeapon = role![3] as! Bool
            e.hasShield = role![4] as! Bool
            e.hasMark = role![5] as! Bool
            e._minionsCount = role![6] as! Int
            e._spellCount = role![7] as! Int
            e._levelPoint = role![2] as! Int
            e._seat = BUnit.BBM
            e._pro = role![0] as! String
            e._name = selectImage._lastSelectedComponent._name
            //-------------------------------------
            e._money = 12000
            let t = TheWitchsTear()
            t._count = 500
            e._props.append(t)                   //test
            e._dungeonLevel = 99                 //data
            let l = Loot()
            e._spells = l.getAllSpells()
            //-------------------------------------
            scene.setRole(x: 2, y: 1, role: e)
            if minion != nil {
                minion!._seat = BUnit.BTM
                e._minions = [minion!]
            }
            stage.loadScene(scene: scene)
            stage.createMenu()
            self.gameScene!.addChild(stage)
            
            self.actionCreate()
            setTimeout(delay: 1, completion: {
                Game.saving(sync: false)
            })
        }
        
        _panels.append(selectImage)
        _panels.append(selectPro)
        _panels.append(selectItems)
        _panels.append(selectMinion)
    }
    
//    private func loadStage(char:Character) {
//        removeFromParent()
//        Game.instance._char = char
//        let bUnit = BUnit()
//        bUnit.setUnit(unit: char)
//        bUnit.createForStage()
//        let stage = UIStage()
//        stage.showSceneMask()
//        stage.setChar(bUnit)
//        Game.instance.stage = stage
//        Game.instance.scene.addChild(stage)
//        stage.maskFadeOut {
//            stage._char.speak(text: "新的世界，新的旅程！")
//        }
//    }
    var actionCreate = {}
    var actionReturn = {}
    
    func showPanel(_ i:Int) {
        for u in _panels {
            u.hide()
        }
        _panels[i].show()
    }
    
    private var _panels = Array<UIPanel>()
    var gameScene:GameScene!
}
