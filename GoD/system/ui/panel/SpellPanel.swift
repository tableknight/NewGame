//
//  File.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/12.
//  Copyright © 2018年 Chen. All rights reserved.
//  let spellPanel = SpellPanel()
//  spellPanel.create(role:Creature)
//  stage.addChild(spellPanel)
//  confirmed

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
        if nil != _lastSelectedIcon && _lastSelectedIcon.contains(touchPoint!) {
            if nil == _lastSelectedIcon._displayItem {
                return
            }
            let spell = _lastSelectedIcon._displayItem as! Spell
            if _spellBoxInuse.contains(_lastSelectedIcon) {
                let index = _role._spellsInuse.firstIndex(of: spell._id)
                if nil != index {
                    loseProperty(spell)
                    _role._spellsInuse.remove(at: index!)
                } else {
                    debug("remove spell in use failed!")
                }
                if !_char.hasSpell(spell: spell) {
                    _char._spells.append(spell._id)
                } else {
                    debug("spell exist in spellpanel \(spell._name)")
                }
                pageReload()
            } else {
                if _role._spellsInuse.count < _role._spellCount {
                    let index = _char._spells.firstIndex(of: spell._id)
                    if nil != index {
                        _char._spells.remove(at: index!)
                        _role._spellsInuse.append(spell._id)
                        addProperty(spell)
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
    private func loseProperty(_ spell:Spell) {
        if spell is TruePower {
            _role.strengthChange(value: -_role._mains.strength * 0.1)
        } else
        if spell is Powerful {
            _role.strengthChange(value: -Powerful.VALUE)
        } else
        if spell is SkyAndLand {
            _role.intellectChange(value: -SkyAndLand.VALUE)
        } else
        if spell is SharpStone {
            _role.agilityChange(value: -SharpStone.VALUE)
        }

    }
    private func addProperty(_ spell:Spell) {
        if spell is TruePower {
            _role.strengthChange(value: _role._mains.strength * 0.1)
        } else
            if spell is Powerful {
                _role.strengthChange(value: Powerful.VALUE)
            } else
                if spell is SkyAndLand {
                    _role.intellectChange(value: SkyAndLand.VALUE)
                } else
                    if spell is SharpStone {
                        _role.agilityChange(value: SharpStone.VALUE)
        }
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
    var _role:Unit!
    
    func instrumentMonatNotes() -> Bool {
//        if Game.instance.char._weapon is TheMonatNotes {
//            let mn = Game.instance.char._weapon as! TheMonatNotes
//            if mn._spellAppended {
//                return true
//            }
//        }
        return false
    }
    func getSpellWhichFromMonatNotes() -> Array<Spell> {
        var spells = Array<Spell>()
        let _char = Game.instance.char!
//        let mn = _char._weapon as! TheMonatNotes
//        for s in Game.instance.char._spells {
//            if s == mn._spell {
//                spells.append(s)
//            }
//        }
//        for s in _char._spellsInuse {
//            if s == mn._spell {
//                spells.append(s)
//            }
//        }
//
//        for u in _char._minions {
//            for s in u._spellsInuse {
//                if s == mn._spell {
//                    spells.append(s)
//                }
//            }
//        }
//
//        for u in _char._storedMinions {
//            for s in u._spellsInuse {
//                if s == mn._spell {
//                    spells.append(s)
//                }
//            }
//        }
        
        return spells
    }
    
    func create(role:Unit) {
        _role = role
        _pageSize = 24
        createCloseButton()
        showSpellsInuse()
        createPageButtons()
        showSpellsUnused()
        addChild(_spellBoxUnused)
        addChild(_spellBoxInuse)
        _label.text = "Lv.\(role._level.toInt()) [\(role._name)] 技能栏: \(role._spellCount)"
    }
    
    private func showSpellsInuse() {
        let spells = _role._spellsInuse
        let startX:CGFloat = getStartX()
        let startY = _standardHeight * 0.5 - _standardGap
        if spells.count > 0 {
            for i in 0...spells.count - 1 {
                let x = i % 10
                let icon = SpellIcon()
                let s = Loot.getSpellById(spells[i])
                icon.iconLabel = s._name
                icon.spell = s
                icon._displayItem = s
                icon.position.y = startY
                icon.position.x = startX + cellSize * 1.25 * x.toFloat()
                icon.zPosition = self.zPosition + 3
                _spellBoxInuse.addChild(icon)
                
            }
            
        }
    }
    private func getSpellUnused() -> Array<Int> {
        var spells = Array<Int>()
        for s in Game.instance.char._spells {
            if _role is Character {
                spells.append(s)
            } else {
                let sp = Loot.getSpellById(s)
                if !(sp is BowSkill) && !(sp is HandSkill) {
                    spells.append(s)
                }
            }
        }
        return spells
    }
    private func showSpellsUnused() {
        let spells = getSpellUnused()
        let startX = -_standardWidth * 0.5 + cellSize * 0.375
        let startY = _standardHeight * 0.5 - _standardGap - cellSize * 1.75
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
                let s = Loot.getSpellById(spells[i])
                icon.iconLabel = s._name
                icon.spell = s
                icon._displayItem = s
                icon.position.y = startY - (_standardGap + cellSize) * y.toFloat()
                icon.position.x = startX + (_standardGap + cellSize) * x.toFloat()
                icon.zPosition = self.zPosition + 3
                _spellBoxUnused.addChild(icon)
                
            }
            
        }
    }
    private func getPageEnd() -> Int {
        let spells = getSpellUnused()
        let pages = spells.count / _pageSize
        if pages >= _curPage {
            return _curPage * _pageSize
        }
        return spells.count
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
    private var _spellBoxUnused = SKSpriteNode()
    private var _spellBoxInuse = SKSpriteNode()
    var closeAction = {}
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


class SpellInfo:SKSpriteNode {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    private var _spell = Spell()
    func create(spell:Spell) {
        _spell = spell
        let startX:CGFloat = cellSize * 0.25
        let startY:CGFloat = -cellSize * 0.25
        
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
        var cd = _spell._cooldown
        if _spell._cooldown > 0 {
            if wandFireMaster() {
                cd -= 1
            }
        }
        if !(_spell is Passive) && !(_spell is Auro) {
            text += "，冷却\(cd)回合"
        }
        if spell is BowSkill {
            text += "，需要弓"
        } else
        if spell is HandSkill {
            text += "，需要空手或拳套"
        } else if spell is CloseSkill {
            text += "，需要近战"
        }
        if _spell._mpCost > 0 {
            text += "，消耗法力\(_spell._mpCost)点"
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
        
    }
    
    func wandFireMaster() -> Bool {
        
        return false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var _displayHeight:CGFloat = 0
    var _displayWidth:CGFloat = 0
}

