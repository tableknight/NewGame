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
            
        }
        
        _panels.append(selectImage)
        _panels.append(selectPro)
        _panels.append(selectItems)
        _panels.append(selectMinion)
    }
    
    private func loadStage(char:Character) {
        removeFromParent()
        Game.instance._char = char
        let bUnit = BUnit()
        bUnit.setUnit(unit: char)
        bUnit.createForStage()
        let stage = UIStage()
        stage.showSceneMask()
        stage.setChar(bUnit)
        Game.instance.stage = stage
        Game.instance.scene.addChild(stage)
        stage.maskFadeOut {
            stage._char.speak(text: "新的世界，新的旅程！")
        }
    }
    
    func showPanel(_ i:Int) {
        for u in _panels {
            u.hide()
        }
        _panels[i].show()
    }
    
    private var _panels = Array<UIPanel>()
}
