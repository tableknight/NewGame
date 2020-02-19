////
////  ArmorPanel.swift
////  TheWitchNight
////
////  Created by kai chen on 2018/4/15.
////  Copyright © 2018年 Chen. All rights reserved.
////
//  confirmed
import SpriteKit
class OutfitPanel: UIPanel {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        _infosDisplay.removeFromParent()
        let touchPoint = touches.first?.location(in: self)
        
        if _discardButton.contains(touchPoint!) {
            if !_discardButton.selected {
                _discardButton.selected = true
                return
            }
            if _lastSelectedIcon != nil && _discardButton.selected {
                _char.removeItem(_lastSelectedIcon.displayItem as! Outfit)
                pageReload()
                _lastSelectedIcon = nil
                return
            }
        }
        
        _discardButton.selected = false
        
        if _nextButton.contains(touchPoint!) {
            let size = ceil(getOutfits().count.toFloat() / _pageSize.toFloat()).toInt()
            if size > _curPage {
                _curPage += 1
                pageReload()
            }
            _lastSelectedIcon = nil
            return
        }
        if _prevButton.contains(touchPoint!) {
            if _curPage > 1 {
                _curPage -= 1
                pageReload()
            }
            _lastSelectedIcon = nil
            return
        }
        
        
        if _char.hasWeapon && outfitOff(slot: _weapon, callback: {Game.instance.char._weapon = nil}, touchPoint: touchPoint!) {
            return
        }
        if outfitOff(slot: _amulet, callback: {Game.instance.char._amulet = nil}, touchPoint: touchPoint!) {
            return
        }
        if _char.hasShield && outfitOff(slot: _shield, callback: {Game.instance.char._shield = nil}, touchPoint: touchPoint!) {
            return
        }
        if outfitOff(slot: _leftRing, callback: {Game.instance.char._leftRing = nil}, touchPoint: touchPoint!) {
            return
        }
        if outfitOff(slot: _rightRing, callback: {Game.instance.char._rightRing = nil}, touchPoint: touchPoint!) {
            return
        }
        if _char.hasMark && outfitOff(slot: _magicMark, callback: {Game.instance.char._magicMark = nil}, touchPoint: touchPoint!) {
            return
        }
        if outfitOff(slot: _soulStone, callback: {Game.instance.char._soulStone = nil}, touchPoint: touchPoint!) {
            return
        }
        _selectedSlot = nil
        
        if nil != _lastSelectedIcon && _lastSelectedIcon.contains(touchPoint!) {
            if nil == _lastSelectedIcon._displayItem {
                return
            }
            let outfit = _lastSelectedIcon._displayItem as! Outfit
            if outfit._level.toFloat() > _char._level + 3 {
                showMsg(text: "暂时无法使用这件装备。")
                return
            }
            if outfit.isWeapon() {
                if _char._weapon != nil {
                    _char._weapon!.off()
                    _char.addItem(_char._weapon!)
                }
                _weapon.outfit = outfit
                _char._weapon = outfit
                _weapon.iconLabel = outfit._name
                _weapon.quality = outfit._quality
            }
            if outfit._type == Outfit.Amulet || outfit._type == Outfit.EarRing {
                if _char._amulet != nil {
                    _char._amulet!.off()
                    _char.addItem(_char._amulet!)
                }
                _amulet.outfit = outfit
                _char._amulet = outfit
                _amulet.iconLabel = outfit._name
                _amulet.quality = outfit._quality
            }
            if outfit._type == Outfit.Shield {
                if _char._shield != nil {
                    _char._shield!.off()
                    _char.addItem(_char._shield!)
                }
                _shield.outfit = outfit
                _char._shield = outfit
                _shield.iconLabel = outfit._name
                _shield.quality = outfit._quality
            }
            if outfit._type == Outfit.SoulStone {
                if _char._soulStone != nil {
                    _char._soulStone!.off()
                    _char.addItem(_char._soulStone!)
                }
                _soulStone.outfit = outfit
                _char._soulStone = outfit
                _soulStone.iconLabel = outfit._name
                _soulStone.quality = outfit._quality
            }
            if outfit._type == Outfit.MagicMark {
                if _char._magicMark != nil {
                    _char._magicMark!.off()
                    _char.addItem(_char._magicMark!)
                }
                _magicMark.outfit = outfit
                _char._magicMark = outfit
                _magicMark.iconLabel = outfit._name
                _magicMark.quality = outfit._quality
            }
            
            if outfit._type == Outfit.Ring {
                if outfit._unique && outfit._effection == _char._leftRing?._effection {
                    _char._leftRing?.off()
                    _char.addItem(_char._leftRing!)
                    _char._leftRing = outfit
                    _leftRing.outfit = outfit
                    _leftRing.iconLabel = outfit._name
                    _leftRing.quality = outfit._quality
                } else if outfit._unique && outfit._effection == _char._rightRing?._effection {
                    _char._rightRing?.off()
                    _char.addItem(_char._rightRing!)
                    _char._rightRing = outfit
                    _rightRing.outfit = outfit
                    _rightRing.iconLabel = outfit._name
                    _rightRing.quality = outfit._quality
                } else  if _char._leftRing != nil && _char._rightRing != nil {
                   _char._leftRing!.off()
                   _char.addItem(_char._leftRing!)
                   _char._leftRing = outfit
                   _leftRing.outfit = outfit
                   _leftRing.iconLabel = outfit._name
                   _leftRing.quality = outfit._quality
               } else if _char._leftRing == nil {
                   _char._leftRing = outfit
                   _leftRing.outfit = outfit
                   _leftRing.iconLabel = outfit._name
                   _leftRing.quality = outfit._quality
               } else if _char._rightRing == nil {
                   _char._rightRing = outfit
                   _rightRing.outfit = outfit
                   _rightRing.iconLabel = outfit._name
                   _rightRing.quality = outfit._quality
               } else {
                   debug("ring on error in itempanel")
               }

            }
            outfit.on()
            _char.removeItem(outfit)
            pageReload()
            _lastSelectedIcon.selected = false
            _lastSelectedIcon = nil
            return
        }
        
        let rlt = showInfosAction(node: _propBox, touchPoint: touchPoint!)
        if !rlt {
            _lastSelectedIcon?.selected = false
            _lastSelectedIcon = Icon()
        }
        
    }
    private var _discardButton = Button()
    override func create() {
        _label.text = "卸下/装备：再次点击已选中的物品。"
        _pageSize = 20
        createCloseButton()
        createPageButtons()
        _discardButton.xAxis = _closeButton.xAxis - _closeButton.width - _standardGap
        _discardButton.yAxis = _closeButton.yAxis
        _discardButton.zPosition = _closeButton.zPosition
        _discardButton.text = "丢弃"
        addChild(_discardButton)
        createOutfitList()
        addChild(_propBox)
        createPropList()
    }
    private func outfitOff(slot:OutfitSlot, callback: @escaping () -> Void, touchPoint:CGPoint) -> Bool {
        if slot.contains(touchPoint) {
            if nil != slot.outfit {
                if nil == _selectedSlot || slot != _selectedSlot {
                    displayInfos(icon: slot)
                    _selectedSlot = slot
                    return true
                } else {
                    slot.outfit?.off()
                    _char.addItem(slot.outfit!)
                    slot.outfit = nil
                    _selectedSlot = nil
                    callback()
                    pageReload()
                    slot.iconLabel = ""
                    return true
                }
            }
        }
        return false
    }
    func getOutfits() -> Array<Outfit> {
        return _char._armors
    }
    func createPropList() {
        let props = getOutfits()
        let startX = -cellSize
        let startY:CGFloat = cellSize * 3
        let gap = cellSize + _standardGap
        if props.count > 0 {
            let end = getPageEnd(props.count)
            var start = (_curPage - 1) * _pageSize
            if start >= end {
                _curPage -= 1
                start = (_curPage - 1) * _pageSize
            }
            
            for i in start...end - 1 {
                let base = i - (_curPage - 1) * _pageSize
                let y = base / 4
                let x = base % 4
                let icon = Icon()
                icon.iconLabel = props[i]._name
                icon._displayItem = props[i]
                icon.quality = props[i]._quality
                icon.position.y = startY - gap * y.toFloat()
                icon.position.x = startX + gap * x.toFloat()
                icon.zPosition = self.zPosition + 3
                _propBox.addChild(icon)
            }
        }
    }
    override func createPanelbackground() {
        super.createPanelbackground()
//        let outfitPanel = createBackground(width: cellSize * 2.875, height: _standardHeight)
//        outfitPanel.position.x = -cellSize * 2.5
//        outfitPanel.position.y = 0
//        outfitPanel.zPosition = self.zPosition + 2
//        addChild(outfitPanel)
//        let listPanel = createBackground(width: cellSize * 4.875, height: _standardHeight)
//        listPanel.position.x = cellSize * 1.75
//        listPanel.position.y = outfitPanel.position.y
//        listPanel.zPosition = self.zPosition + 2
//        addChild(listPanel)
    }
    
    func createOutfitList() {
        let startX:CGFloat = -_standardWidth * 0.5 + _standardGap
        let gap = cellSize * 1.25
        let line2 = startX + cellSize * 1.5
        let startY:CGFloat = cellSize * 3
        _amulet = createSlot(x: startX + cellSize * 0.75, y: startY)
        if _char._amulet != nil {
            _amulet.outfit = _char._amulet
            _amulet.iconLabel = _char._amulet!._name
            _amulet.quality = _char._amulet!._quality
        }
//        _char.hasWeapon = true
//        _char.hasShield = true
//        _char.hasMark = true
        addChild(_amulet)
        _outfitSlots.append(_amulet)
        if _char.hasWeapon {
            _weapon = createSlot(x: startX, y: _amulet.position.y - gap)
            if _char._weapon != nil {
                _weapon.outfit = _char._weapon
                _weapon.iconLabel = _char._weapon!._name
                _weapon.quality = _char._weapon!._quality
            }
            addChild(_weapon)
            _outfitSlots.append(_weapon)
        }
        if _char.hasShield {
            _shield = createSlot(x: line2, y: _amulet.position.y - gap)
            if _char._shield != nil {
                _shield.outfit = _char._shield
                _shield.iconLabel = _char._shield!._name
                _shield.quality = _char._shield!._quality
            }
            addChild(_shield)
            _outfitSlots.append(_shield)
        }
        _leftRing = createSlot(x: startX, y: _amulet.position.y - gap * 2)
        if _char._leftRing != nil {
            _leftRing.outfit = _char._leftRing
            _leftRing.iconLabel = _char._leftRing!._name
            _leftRing.quality = _char._leftRing!._quality
        }
        addChild(_leftRing)
        _outfitSlots.append(_leftRing)
        _rightRing = createSlot(x: line2, y: _amulet.position.y - gap * 2)
        if _char._rightRing != nil {
            _rightRing.outfit = _char._rightRing
            _rightRing.iconLabel = _char._rightRing!._name
            _rightRing.quality = _char._rightRing!._quality
        }
        addChild(_rightRing)
        _outfitSlots.append(_rightRing)
        if _char.hasMark {
            _magicMark = createSlot(x: _amulet.xAxis, y: _leftRing.position.y - gap)
            if _char._magicMark != nil {
                _magicMark.outfit = _char._magicMark
                _magicMark.iconLabel = _char._magicMark!._name
                _magicMark.quality = _char._magicMark!._quality
            }
            addChild(_magicMark)
            _outfitSlots.append(_magicMark)
        }
        _soulStone = createSlot(x: _amulet.xAxis, y: _leftRing.position.y - gap * 2)
        if _char._soulStone != nil {
            _soulStone.outfit = _char._soulStone
            _soulStone.iconLabel = _char._soulStone!._name
            _soulStone.quality = _char._soulStone!._quality
        }
        addChild(_soulStone)
        _outfitSlots.append(_soulStone)
    }
    
    func createSlot(x:CGFloat, y:CGFloat) -> OutfitSlot {
        let slot = OutfitSlot()
        slot.position = CGPoint(x: x, y: y)
        slot.zPosition = self.zPosition + 3
        return slot
    }
    override func pageReload() {
        _propBox.removeAllChildren()
        createPropList()
    }
    private var _weapon:OutfitSlot!
    private var _amulet:OutfitSlot!
    private var _leftRing:OutfitSlot!
    private var _rightRing:OutfitSlot!
    private var _magicMark:OutfitSlot!
    private var _shield:OutfitSlot!
    private var _soulStone:OutfitSlot!
    private var _selectedSlot:OutfitSlot?
    private var _outfitSlots = Array<OutfitSlot>()
    private var _propBox:SKSpriteNode = SKSpriteNode()
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.zPosition = MyStage.UI_PANEL_Z
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}



class OutfitSlot:Icon {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    var outfit:Outfit? {
        set {
            if nil == newValue {
                _background.lineWidth = Game.UNSELECTED_STROKE_WIDTH
                _background.strokeColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.8)
            } else {
                _background.lineWidth = Game.SELECTED_STROKE_WIDTH
                _background.strokeColor = QualityColor.getColor((newValue?._quality)!)
            }
            _outfit = newValue
            _displayItem = newValue
        }
        get {
            return _outfit
        }
    }
    
    override var selected: Bool {
        set {
            _selected = newValue
        }
        get {
            return _selected
        }
    }
    
    private var _outfit:Outfit?
}
