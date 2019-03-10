//
//  File.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/12.
//  Copyright © 2018年 Chen. All rights reserved.
//  let spellPanel = SpellPanel()
//  spellPanel.create(role:Creature)
//  stage.addChild(spellPanel)
//

import SpriteKit

class SpellPanel:UIPanel {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let touchPoint = touches.first?.location(in: self)
        _infosDisplay.removeFromParent()
        if _nextButton.contains(touchPoint!) {
            let size = Game.instance.char._spells.count / _pageSize
            if size > _curPage - 1 {
                _spellBoxUnused.removeAllChildren()
                _curPage += 1
                showSpellsUnused()
            }
            return
        }
        if _prevButton.contains(touchPoint!) {
            if _curPage > 1 {
                _spellBoxUnused.removeAllChildren()
                _curPage -= 1
                showSpellsUnused()
            }
            return
        }
//        let _char = Data.instance._char!
        if nil != _lastSelectedIcon && _lastSelectedIcon.contains(touchPoint!) {
            let spell = _lastSelectedIcon._displayItemType as! Spell
            if _spellBoxInuse.contains(_lastSelectedIcon) {
                let index = _role._spellsInuse.index(of: spell)
                if nil != index {
                    _role._spellsInuse.remove(at: index!)
                } else {
                    debug("remove spell in use failed!")
                }
                if !_char.hasSpell(spell: spell) {
//                    debug("add spell unused failed in spellpanel")
                    _char._spells.append(spell)
                } else {
                    debug("spell exist in spellpanel \(spell._name)")
                }
                pageReload()
            } else {
                if _role._spellsInuse.count < _role._spellCount {
                    let index = _char._spells.index(of: spell)
                    if nil != index {
                        _char._spells.remove(at: index!)
                        _role._spellsInuse.append(spell)
                    } else {
                        debug("_char._spells.remove failed! spellpanel")
                    }
                    pageReload()
                }
            }
            _lastSelectedIcon = Icon()
            return
        }
        let _ = showInfosAction(node: _spellBoxInuse, touchPoint: touchPoint!)
        let _ = showInfosAction(node: _spellBoxUnused, touchPoint: touchPoint!)
        
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    override func createPanelbackground() {
        let height = cellSize * 1.5
        let spellsInuse = createBackground(width: _standardWidth, height: height)
        spellsInuse.zPosition = self.zPosition + 2
        spellsInuse.position.y = _standardHeight * 0.5 - height * 0.5
        spellsInuse.position.x = 0
        addChild(spellsInuse)
        
        let spellsUnused = createBackground(width: _standardWidth, height: _standardHeight - cellSize * 0.25 - height)
        spellsUnused.zPosition = self.zPosition + 2
        spellsUnused.position.y = -height * 0.5 - cellSize * 0.125
        spellsUnused.position.x = 0
        addChild(spellsUnused)
    }
    var _role:Creature!
    
    func instrumentMonatNotes() -> Bool {
        if Game.instance._char._weapon is TheMonatNotes {
            let mn = Game.instance._char._weapon as! TheMonatNotes
            if mn._spellAppended {
                return true
            }
        }
        return false
    }
    func getSpellWhichFromMonatNotes() -> Array<Spell> {
        var spells = Array<Spell>()
        let _char = Game.instance._char!
        let mn = _char._weapon as! TheMonatNotes
        for s in Game.instance._char._spells {
            if s == mn._spell {
                spells.append(s)
            }
        }
        for s in _char._spellsInuse {
            if s == mn._spell {
                spells.append(s)
            }
        }
        
        for u in _char._minions {
            for s in u._spellsInuse {
                if s == mn._spell {
                    spells.append(s)
                }
            }
        }
        
        for u in _char._storedMinions {
            for s in u._spellsInuse {
                if s == mn._spell {
                    spells.append(s)
                }
            }
        }
        
        return spells
    }
    
    func create(role:Creature) {
        _role = role
        _pageSize = 24
        createCloseButton()
        showSpellsInuse()
        if Game.instance.char._spells.count > _pageSize {
            createPageButtons()
        }
        showSpellsUnused()
        addChild(_spellBoxUnused)
        addChild(_spellBoxInuse)
        _label.text = "Lv.\(role._level.toInt()) [\(role._name)] 技能栏: \(role._spellCount)"
    }
    
    private func showSpellsInuse() {
        let spells = _role._spellsInuse
        let startX:CGFloat = getStartX()
//        let startX = -_standardWidth * 0.5 + _standardGap + cellSize * 0.125
        let startY = _standardHeight * 0.5 - _standardGap
        if spells.count > 0 {
            for i in 0...spells.count - 1 {
                let x = i % 10
                let icon = SpellIcon()
                icon.iconLabel = spells[i]._name
                icon.spell = spells[i]
                icon._displayItemType = spells[i]
                icon.position.y = startY
                icon.position.x = startX + cellSize * 1.25 * x.toFloat()
                icon.zPosition = self.zPosition + 3
                _spellBoxInuse.addChild(icon)
                
            }
            
        }
    }
    private func getSpellUnused() -> Array<Spell> {
        var spells = Array<Spell>()
        for s in Game.instance.char._spells {
            if _role is Character {
                spells.append(s)
            } else {
                if !(s is BowSkill) && !(s is HandSkill) {
                    spells.append(s)
                }
            }
        }
        return spells
    }
    private func showSpellsUnused() {
        let spells = getSpellUnused()
//        let startX:CGFloat = 0
        let startX = -_standardWidth * 0.5 + cellSize * 0.375
        let startY = _standardHeight * 0.5 - _standardGap - cellSize * 1.75
//        _curPageSpells = Array<SpellComponent>()
        if spells.count > 0 {
            let end = getPageEnd()
            var start = (_curPage - 1) * _pageSize
            if start >= end {
                _curPage -= 1
                start = (_curPage - 1) * _pageSize
            }
            
            for i in start...end - 1 {
                let base = i - (_curPage - 1) * _pageSize
                let y = base / 6
                let x = base % 6
                let icon = SpellIcon()
                icon.iconLabel = spells[i]._name
                icon.spell = spells[i]
                icon._displayItemType = spells[i]
                icon.position.y = startY - (_standardGap + cellSize) * y.toFloat()
                icon.position.x = startX + (_standardGap + cellSize) * x.toFloat()
                icon.zPosition = self.zPosition + 3
                _spellBoxUnused.addChild(icon)
                
            }
            
        }
    }
    private func getPageEnd() -> Int {
        let pages = Game.instance.char._spells.count / _pageSize
        if pages >= _curPage {
            return _curPage * _pageSize
        }
        return Game.instance.char._spells.count
    }
    override func pageReload() {
        _spellBoxUnused.removeAllChildren()
        _spellBoxInuse.removeAllChildren()
        _lastSelectedIcon = nil
        showSpellsUnused()
        showSpellsInuse()
    }
    override func close() {
        Game.instance.curStage.removePanel(self)
        closeAction()
    }
//    func displayInfos(icon:Icon) {
//        let spell = icon._displayItemType as! Spell
////        let id = icon._infosDisplay.getInfosDisplay()
//        let node = SpellInfo()
//        node.create(spell: spell)
//        node.position.x = icon.position.x + cellSize * 0.5 + 5
//        if icon.position.y < 0 {
//            node.position.y = icon.position.y + node.getDisplayHeight() - cellSize * 0.5
//        } else {
//            node.position.y = icon.position.y + cellSize * 0.5
//        }
//        if icon.position.x > cellSize * 4 {
//            node.position.x = icon.position.x - node.getDisplayWidth()
//        }
//        addChild(node)
//        _infosDisplay = node
//    }
//    private var _infosDisplay = SKSpriteNode()
    private var _spellBoxUnused = SKSpriteNode()
    private var _spellBoxInuse = SKSpriteNode()
    var closeAction = {}
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


class SpellInfo:SKSpriteNode, IPanelSize {
    
    func getDisplayWidth() -> CGFloat {
        return _displayWidth
    }
    
    func getDisplayHeight() -> CGFloat {
        return _displayHeight
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
//        zPosition = UIStage.PANEL_LAYER + 4
    }
    private var _spell = Spell()
    func create(spell:Spell) {
        _spell = spell
        let startX:CGFloat = cellSize * 0.25
        let startY:CGFloat = -cellSize * 0.25
        
//        let i = SKSpriteNode(texture: Data.instance.inside_c.getCell(10, 0))
//        i.position.x = startX
//        i.position.y = startY - 12
//        i.anchorPoint = CGPoint(x: 0, y: 0)
//        addChild(i)
        
        let name = Label()
        name.text = "[\(_spell._name)]"
        name.fontSize = 24
        name.fontColor = QualityColor.getColor(_spell._quality)
        name.position.x = startX
        name.position.y = startY
        addChild(name)
        _displayHeight = cellSize * 1.5
        let des = MultipleLabel()
        var text = _spell._description
        if _spell._cooldown > 0 {
            var cd = _spell._cooldown
            if wandFireMaster() {
                cd -= 1
            }
            text += "，冷却\(cd)回合"
        }
        if _spell._tear > 0 {
            text += "，消耗\(TheWitchsTear.NAME)x\(_spell._tear)"
        }
        des._lineCharNumber = 10
        des._fontSize = cellSize * 0.25
        des.text = text
        des.position.x = startX
        des.position.y = name.position.y - cellSize * 0.5
        addChild(des)
        
        _displayHeight += des._height
        
        _displayWidth = cellSize * 3
        
        let bg = createBackground(width: _displayWidth, height: _displayHeight)
        bg.position.x = _displayWidth * 0.5
        bg.position.y = -_displayHeight * 0.5
        bg.strokeColor = UIColor.lightGray
        addChild(bg)
        
//        let img = SKShapeNode(rect: CGRect(x: 0, y: 0, width: cellSize, height: cellSize), cornerRadius: 2)
//        img.position.x = startX
//        img.position.y = startY - 12
//        img.strokeColor = QualityColor.getColor(_spell._quality)
//        addChild(img)
    }
    
    func wandFireMaster() -> Bool {
//        if _spell.isMagical && _spell.isFire {
//            let char = Data.instance._char!
//            if char._spells.index(of: _spell) != nil || char._spellsInuse.index(of: _spell) != nil {
//                return true
//            }
//        }
        
        return false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var _displayHeight:CGFloat = 0
    var _displayWidth:CGFloat = 0
}

