//
//  SpellCard.swift
//  GoD
//
//  Created by kai chen on 2018/12/18.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class BattleSpellCard:UIPanel {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let touchPoint = touches.first?.location(in: self)
        _infosDisplay.removeFromParent()
        
        if _roundCloseButton.contains(touchPoint!) {
            closeAction()
            removeFromParent()
            return
        }
        
        //        let _char = Data.instance._char!
        if _lastSelectedIcon.contains(touchPoint!) {
            let spell = _lastSelectedIcon._displayItemType as! Spell
            selectedSpell = spell
            _lastSelectedIcon = Icon()
            selectAction()
            removeFromParent()
            return
        }
        for icon in _spellBox.children {
            if icon.contains(touchPoint!) {
                let bsi = icon as! BattleSpellIcon
                if bsi.timeleft > 0 {
                    
                } else {
//                    _lastSelectedIcon.selected = false
//                    _lastSelectedIcon = icon as! Icon
//                    _lastSelectedIcon.selected = true
                    let spell = bsi._displayItemType as! Spell
                    selectedSpell = spell
                    selectAction()
                    removeFromParent()
                }
//                displayInfos(icon: icon as! Icon)
            }
        }

        
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    override func createPanelbackground() {
//        let height = cellSize * 1.5
//        let spellsInuse = createBackground(width: _standardWidth, height: height)
//        spellsInuse.zPosition = self.zPosition + 2
//        spellsInuse.position.y = -_standardHeight * 0.25
//        spellsInuse.position.x = 0
//        addChild(spellsInuse)
        
    }
    
    override func createCloseButton() {
        _roundCloseButton.create(text: "关闭", size: 28)
        _roundCloseButton.yAxis = -cellSize * 4
        _roundCloseButton.zPosition = self.zPosition + 2
        addChild(_roundCloseButton)
    }
    
    func create(spells:Array<Spell>) {
        _spells = spells
        addChild(_spellBox)
        createCloseButton()
        showSpells()
    }
    private func showSpells() {
        let spells = _spells
        let startX = getStartX()
        let startY = -_standardHeight * 0.25 + cellSize * 0.5
        if spells.count > 0 {
            for i in 0...spells.count - 1 {
                let x = i % 10
                let icon = BattleSpellIcon()
                icon.timeleft = spells[i]._timeleft
                icon.spell = spells[i]
                icon._displayItemType = spells[i]
                icon.position.y = startY
                icon.position.x = startX + cellSize * 1.25 * x.toFloat()
                icon.zPosition = self.zPosition + 3
                _spellBox.addChild(icon)
                
            }
            
        }
    }
    
    override func close() {
        closeAction()
    }
    
    private var _spells = Array<Spell>()
    private var _spellBox = SKSpriteNode()
    private var _roundCloseButton = RoundButton()
//    private var _spellBox = 
    var closeAction = {}
    var selectAction = {}
    var selectedSpell:Spell?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class BattleSpellIcon:SpellIcon {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _mask = createBackground(width: cellSize, height: cellSize)
        _mask.alpha = 0.65
        _mask.lineWidth = 0
        
        _label.text = "12"
        _label.fontSize = cellSize * 0.5
        _label.align = "center"
        _label.position.y = -cellSize * 0.5 + _label.fontSize * 0.5
        _label.position.x = cellSize * 0.5
        _name.align = "center"
        _name.position.x = cellSize * 0.5
        _name.position.y = -cellSize * 1.25
        _name.fontSize = 18
        addChild(_name)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(quality: Int) {
        super.init(quality: quality)
    }
    
    var timeleft:Int {
        set {
            if newValue > 0 {
                addChild(_mask)
                addChild(_label)
                _label.text = "-\(newValue)"
                _timeleft = newValue
            } else {
                _mask.removeFromParent()
                _label.removeFromParent()
            }
        }
        get {
            return _timeleft
        }
    }
    private var _timeleft:Int = 0
    private var _mask:SKShapeNode!
    private var _label = Label()
    override var spell:Spell? {
        set {
            _spell = newValue
            quality = newValue!._quality
            _name.text = _spell?._name
        }
        get {
            return _spell ?? nil
        }
    }
    private var _name = Label()
}
