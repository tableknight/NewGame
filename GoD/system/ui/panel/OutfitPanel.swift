////
////  ArmorPanel.swift
////  TheWitchNight
////
////  Created by kai chen on 2018/4/15.
////  Copyright © 2018年 Chen. All rights reserved.
////
//
import SpriteKit
class OutfitPanel: UIPanel {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        _infosDisplay.removeFromParent()
        let touchPoint = touches.first?.location(in: self)
        //        if _closeButton.contains(touchPoint!) {
        //            Data.instance.stage.removeItemPanel(panel: self)
        //            return
        //        }
        if _nextButton.contains(touchPoint!) {
            let size = ceil(getOutfits().count.toFloat() / _pageSize.toFloat()).toInt()
            if size > _curPage {
                _curPage += 1
                pageReload()
            }
            return
        }
        if _prevButton.contains(touchPoint!) {
            if _curPage > 1 {
                _curPage -= 1
                pageReload()
            }
            return
        }
        outfitOff(slot: _weapon, callback: {Game.instance.char._weapon = nil}, touchPoint: touchPoint!)
        outfitOff(slot: _amulet, callback: {Game.instance.char._amulet = nil}, touchPoint: touchPoint!)
        outfitOff(slot: _shield, callback: {Game.instance.char._shield = nil}, touchPoint: touchPoint!)
        outfitOff(slot: _leftRing, callback: {Game.instance.char._leftRing = nil}, touchPoint: touchPoint!)
        outfitOff(slot: _rightRing, callback: {Game.instance.char._rightRing = nil}, touchPoint: touchPoint!)
        outfitOff(slot: _magicMark, callback: {Game.instance.char._magicMark = nil}, touchPoint: touchPoint!)
        outfitOff(slot: _soulStone, callback: {Game.instance.char._soulStone = nil}, touchPoint: touchPoint!)
        
//        if _weapon.contains(touchPoint!) {
//            if nil != _weapon.outfit {
//                if nil == _selectedSlot || _weapon != _selectedSlot {
//                    displayInfos(icon: _weapon)
//                    _selectedSlot = _weapon
//                    return
//                } else {
//                    _weapon.outfit?.off()
//                    _char.addProp(p: _weapon.outfit!)
//                    _weapon.outfit = nil
//                    _selectedSlot = nil
//                    _char._weapon = nil
//                    pageReload()
//                    return
//                }
//            }
//        }

        
        
        if _lastSelectedIcon.contains(touchPoint!) {
            if _char.hasWeapon && _lastSelectedIcon._displayItemType is Weapon {
                if _char._weapon != nil {
                    _char._weapon!.off()
                    _char.addProp(p: _char._weapon!)
                }
                let weapon = _lastSelectedIcon._displayItemType as! Weapon
                _char.removeProp(p: weapon)
                weapon.on()
                _weapon.outfit = weapon
                _char._weapon = weapon
                pageReload()
                _lastSelectedIcon.selected = false
                _lastSelectedIcon = Icon(quality: 1)
                return
            }
            if _lastSelectedIcon._displayItemType is Amulet {
                if _char._amulet != nil {
                    _char._amulet!.off()
                    _char.addProp(p: _char._amulet!)
                }
                let amulet = _lastSelectedIcon._displayItemType as! Amulet
                _char.removeProp(p: amulet)
                amulet.on()
                _amulet.outfit = amulet
                _char._amulet = amulet
                pageReload()
                _lastSelectedIcon.selected = false
                _lastSelectedIcon = Icon(quality: 1)
                return
            }
            if _char.hasShield && _lastSelectedIcon._displayItemType is Shield {
                if _char._shield != nil {
                    _char._shield!.off()
                    _char.addProp(p: _char._shield!)
                }
                let shield = _lastSelectedIcon._displayItemType as! Shield
                _char.removeProp(p: shield)
                shield.on()
                _shield.outfit = shield
                _char._shield = shield
                pageReload()
                _lastSelectedIcon.selected = false
                _lastSelectedIcon = Icon(quality: 1)
                return
            }
            if _lastSelectedIcon._displayItemType is Ring {
                let ring = _lastSelectedIcon._displayItemType as! Ring
                if _char._leftRing != nil && _char._rightRing != nil {
                    _char._leftRing!.off()
                    _char.addProp(p: _char._leftRing!)
                    _char._leftRing = ring
                    _leftRing.outfit = ring
                } else
                if _char._leftRing == nil {
                    _char._leftRing = ring
                    _leftRing.outfit = ring
                } else if _char._rightRing == nil {
                    _char._rightRing = ring
                    _rightRing.outfit = ring
                } else {
                    debug("ring on error in itempanel")
                }
                _char.removeProp(p: ring)
                ring.on()
                
                pageReload()
                _lastSelectedIcon.selected = false
                _lastSelectedIcon = Icon(quality: 1)
                return
            }
            if _char.hasMark && _lastSelectedIcon._displayItemType is MagicMark {
                if _char._magicMark != nil {
                    _char._magicMark!.off()
                    _char.addProp(p: _char._magicMark!)
                }
                let mark = _lastSelectedIcon._displayItemType as! MagicMark
                _char.removeProp(p: mark)
                mark.on()
                _magicMark.outfit = mark
                _char._magicMark = mark
                pageReload()
                _lastSelectedIcon.selected = false
                _lastSelectedIcon = Icon(quality: 1)
                return
            }
            if _lastSelectedIcon._displayItemType is SoulStone {
                if _char._soulStone != nil {
                    _char._soulStone!.off()
                    _char.addProp(p: _char._soulStone!)
                }
                let soulStone = _lastSelectedIcon._displayItemType as! SoulStone
                _char.removeProp(p: soulStone)
                soulStone.on()
                _soulStone.outfit = soulStone
                _char._soulStone = soulStone
                pageReload()
                _lastSelectedIcon.selected = false
                _lastSelectedIcon = Icon(quality: 1)
                return
            }
        }
        let rlt = showInfosAction(node: _propBox, touchPoint: touchPoint!)
        if !rlt {
            _lastSelectedIcon.selected = false
            _lastSelectedIcon = Icon()
        }
        
    }
    override func create() {
        _label.text = "卸下\\装备：再次点击已选中的物品。"
        _pageSize = 20
        createCloseButton()
        createPageButtons()
        createOutfitList()
        addChild(_propBox)
        createPropList()
    }
    private func outfitOff(slot:OutfitSlot, callback: @escaping () -> Void, touchPoint:CGPoint) {
        if slot.contains(touchPoint) {
            if nil != slot.outfit {
                if nil == _selectedSlot || slot != _selectedSlot {
                    displayInfos(icon: slot)
                    _selectedSlot = slot
                    return
                } else {
                    slot.outfit?.off()
                    _char.addProp(p: slot.outfit!)
                    slot.outfit = nil
                    _selectedSlot = nil
                    callback()
                    pageReload()
                    return
                }
            }
        }
    }
    func getOutfits() -> Array<Outfit> {
        var outfits = Array<Outfit>()
        for p in _char._props {
            if p is Outfit {
                outfits.append(p as! Outfit)
            }
        }
        return outfits
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
                icon._displayItemType = props[i]
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
        }
        _char.hasWeapon = true
        _char.hasShield = true
        _char.hasMark = true
        addChild(_amulet)
        _outfitSlots.append(_amulet)
        if _char.hasWeapon {
            _weapon = createSlot(x: startX, y: _amulet.position.y - gap)
            if _char._weapon != nil {
                _weapon.outfit = _char._weapon
            }
            addChild(_weapon)
            _outfitSlots.append(_weapon)
        }
        if _char.hasShield {
            _shield = createSlot(x: line2, y: _weapon.position.y)
            if _char._shield != nil {
                _shield.outfit = _char._shield
            }
            addChild(_shield)
            _outfitSlots.append(_shield)
        }
        _leftRing = createSlot(x: startX, y: _amulet.position.y - gap * 2)
        if _char._leftRing != nil {
            _leftRing.outfit = _char._leftRing
        }
        addChild(_leftRing)
        _outfitSlots.append(_leftRing)
        _rightRing = createSlot(x: line2, y: _amulet.position.y - gap * 2)
        if _char._rightRing != nil {
            _rightRing.outfit = _char._rightRing
        }
        addChild(_rightRing)
        _outfitSlots.append(_rightRing)
        if _char.hasMark {
            _magicMark = createSlot(x: _amulet.xAxis, y: _leftRing.position.y - gap)
            if _char._magicMark != nil {
                _magicMark.outfit = _char._magicMark
            }
            addChild(_magicMark)
            _outfitSlots.append(_magicMark)
        }
        _soulStone = createSlot(x: _amulet.xAxis, y: _leftRing.position.y - gap * 2)
        if _char._soulStone != nil {
            _soulStone.outfit = _char._soulStone
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
    override init(quality: Int) {
        super.init(quality: quality)
    }
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
                _background.strokeColor = Game.UNSELECTED_STROKE_COLOR
            } else {
                _background.lineWidth = Game.SELECTED_STROKE_WIDTH
                _background.strokeColor = QualityColor.getColor((newValue?._quality)!)
            }
            _outfit = newValue
            _displayItemType = newValue
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
