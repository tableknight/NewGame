//
//  RoleInfo.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/12.
//  Copyright © 2018年 Chen. All rights reserved.
//


import SpriteKit
class RolePanel:UIPanel {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        _spellInfoPanel?.removeFromParent()
        if _closeButton.contains(touchPoint!) {
            Game.instance.curStage.removePanel(self)
            if nil != _parentPanel {
                Game.instance.curStage.showPanel(_parentPanel!)
                _parentPanel?.pageReload()
            }
            return
        }
        for si in _listSpells {
            if si.contains(touchPoint!) {
                if _lastSelectedSpellIcon == si {
                    
                } else {
                    _lastSelectedSpellIcon.selected = false
                    si.selected = true
                    _lastSelectedSpellIcon = si
//                    self.displayInfos(icon: si)
                    if nil != si.spell {
                        showSpellInfo(si)
                    } else {
                        debug("empty!!!!!!!!")
                    }
                }
                return
            }
        }
        if _unit._leftPoint > 0 {
            if _attrStrength.contains(touchPoint!) {
                changeProperties(p: "str")
            } else if _attrStamina.contains(touchPoint!) {
                changeProperties(p: "sta")
            } else if _attrAgility.contains(touchPoint!) {
                changeProperties(p: "agl")
            } else if _attrIntellect.contains(touchPoint!) {
                changeProperties(p: "int")
            }
        }
        if _unit is Character {
            for sn in _seatNodes {
                if sn.contains(touchPoint!) {
                    for snc in _seatNodes {
                        snc.color = SeatNode.UNSELECTED_COLOR
                    }
                    sn.color = SeatNode.SELECTED_COLOR
                    let char = _unit as! Character
                    char._seat = sn._seat
                    for m in char._minions {
                        if m._seat == sn._seat {
                            m._seat = BUnit.STAND_BY
                        }
                    }
                }
            }
        } else {
            for sn in _seatNodes {
                if sn.contains(touchPoint!) {
                    let char = Game.instance.char!
                    //如果是非主角，点击到了跟h主角同样的位置，则无变化
                    if sn._seat == char._seat {
                        return
                    }
                    //如果点到了跟其他随从一样的位置，则取代那个随从
                    for m in char._minions {
                        if m._seat == sn._seat {
                            _unit._seat = sn._seat
                            m._seat = BUnit.STAND_BY
                            for _sn in _seatNodes {
                                _sn.color = SeatNode.UNSELECTED_COLOR
                            }
                            sn.color = UIColor.white
                            return
                        }
                    }
                    //如果是没有任何单位占据的位置，则判断是否合法
                    if _unit._level > char._level {
                        debug("无法控制超过自己等级的c随从！")
                        return
                    }
                    if (char.getReadyMinions().count >= char._minionsCount) && _unit._seat == BUnit.STAND_BY {
                        debug("c作战随从已达上限！")
                        return
                    }
                    for snc in _seatNodes {
                        snc.color = SeatNode.UNSELECTED_COLOR
                    }
                    if _unit is Character {
                        sn.color = SeatNode.SELECTED_COLOR
                    } else {
                        sn.color = UIColor.white
                    }
                    _unit._seat = sn._seat
                }
            }
        }
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    func create(unit:Creature) {
        createCloseButton()
        _unit = unit
        let bUnitRole = BUnit()
        bUnitRole.setUnit(unit: unit)
        _propertyLayer.zPosition = self.zPosition + 2
        addChild(_propertyLayer)
        
        let startX = _startX + cellSize * 0.25
        let startY = _startY - cellSize * 0.25
        let roleImage = SKSpriteNode(texture: unit._img.getCell(1, 0))
        roleImage.anchorPoint = CGPoint(x: 0, y: 1)
        roleImage.size = CGSize(width: cellSize * 1.25, height: cellSize * 1.25)
        roleImage.position.x = startX + cellSize * 0.125
        roleImage.position.y = startY
        _propertyLayer.addChild(roleImage)
        
        let roleImageBorder = SKShapeNode(rect: CGRect(x: startX, y: startY - cellSize * 1.5, width: cellSize * 1.5, height: cellSize * 1.5), cornerRadius: 4)
        roleImageBorder.lineWidth = 1
        roleImageBorder.strokeColor = Game.UNSELECTED_STROKE_COLOR

        _propertyLayer.addChild(roleImageBorder)
        
        let gap = cellSize * 0.25
        
        let lv = Label()
        lv.text = "lv.\(unit._level.toInt())\(unit._name)"
        lv.fontSize = 22
        lv.position.x = startX + cellSize * 1.5 + gap
        lv.position.y = startY - cellSize * 0.25 - 10
        _propertyLayer.addChild(lv)
        
        let race = Label()
        race.text = EvilType.getTypeLabel(type: unit._race)
        race.fontSize = 20
        race.position.x = lv.position.x
        race.position.y = lv.position.y - 24
        _propertyLayer.addChild(race)
        
        let hpbar = HBar()
        hpbar.create(width: cellSize * 2, height: 12, value: unit._extensions.hp / unit._extensions.health, color: UIColor.red)
        hpbar.position.y = race.position.y - 32
        hpbar.position.x = race.position.x
        _propertyLayer.addChild(hpbar)
        
        let expbar = HBar()
        expbar.create(width: cellSize * 2, height: 10, value: unit._exp / unit.expNext(), color: UIColor.green)
        expbar.position.y = hpbar.position.y - 20
        expbar.position.x = hpbar.position.x
        _propertyLayer.addChild(expbar)
        
        var colorLight = UIColor.white
        let seatGap:CGFloat = 8
        if unit is Character {
            colorLight = SeatNode.SELECTED_COLOR
        }
        
        _btl = getSeatNode()
        _btl.position.y = startY
        _btl.position.x = lv.position.x + cellSize * 2.25
        _btl._seat = BUnit.BTL
        if unit._seat == BUnit.BTL {
            _btl.color = colorLight
        }
        _propertyLayer.addChild(_btl)
        
        _btm = getSeatNode()
        _btm.position.y = startY
        _btm.position.x = _btl.position.x + _btl.size.width + seatGap
        _btm._seat = BUnit.BTM
        if unit._seat == BUnit.BTM {
            _btm.color = colorLight
        }
        _propertyLayer.addChild(_btm)
        
        _btr = getSeatNode()
        _btr.position.y = startY
        _btr.position.x = _btm.position.x + _btl.size.width + seatGap
        _btr._seat = BUnit.BTR
        if unit._seat == BUnit.BTR {
            _btr.color = colorLight
        }
        _propertyLayer.addChild(_btr)
        
        _bbl = getSeatNode()
        _bbl.position.y = _btl.position.y - _btl.size.height - seatGap
        _bbl.position.x = _btl.position.x
        _bbl._seat = BUnit.BBL
        if unit._seat == BUnit.BBL {
            _bbl.color = colorLight
        }
        _propertyLayer.addChild(_bbl)
        
        _bbm = getSeatNode()
        _bbm.position.y = _btl.position.y - _btl.size.height - seatGap
        _bbm.position.x = _btm.position.x
        _bbm._seat = BUnit.BBM
        if unit._seat == BUnit.BBM {
            _bbm.color = colorLight
        }
        _propertyLayer.addChild(_bbm)
        
        _bbr = getSeatNode()
        _bbr.position.y = _btl.position.y - _btl.size.height - seatGap
        _bbr.position.x = _btr.position.x
        _bbr._seat = BUnit.BBR
        if unit._seat == BUnit.BBR {
            _bbr.color = colorLight
        }
        _propertyLayer.addChild(_bbr)
        
        _seatNodes.append(_btl)
        _seatNodes.append(_btm)
        _seatNodes.append(_btr)
        _seatNodes.append(_bbl)
        _seatNodes.append(_bbm)
        _seatNodes.append(_bbr)
        
//        let strength = AttrLabel()
//        strength.position.x = startX
//        strength.position.y = startY - cellSize * 1.5 - cellSize * 0.25
//        strength.text = "力量"
//        strength.value = bUnitRole.getStrength().toInt()
//        _propertyLayer.addChild(strength)
        let attrWidth = cellSize * 1.5 + 3
        let attrHeight = cellSize * 0.75
        let x1 = startX
        let x2 = startX + attrWidth
        let x3 = startX + attrWidth * 2
        let x4 = startX + attrWidth * 3
        let x5 = startX + attrWidth * 4
        let y1 = startY - cellSize * 1.75
        let y2 = y1 - attrHeight
        let y3 = y2 - attrHeight
        let y4 = y3 - attrHeight
        let y5 = y4 - attrHeight
        let y6 = y5 - attrHeight
        _attrStrength = addAttrLabel(x: x1, y: y1, text: "力量", value: bUnitRole.getStrength())
        _attrStamina = addAttrLabel(x: x1, y: y2, text: "耐力", value: bUnitRole.getStamina())
        _attrAgility = addAttrLabel(x: x1, y: y3, text: "敏捷", value: bUnitRole.getAgility())
        _attrIntellect = addAttrLabel(x: x1, y: y4, text: "智力", value: bUnitRole.getIntellect())
        
        if unit._leftPoint > 0 {
            _attrLeftPoint = addAttrLabel(x: x1, y: y5, text: "未分配", value: unit._leftPoint.toFloat())
            _attrStrength.editable = true
            _attrStamina.editable = true
            _attrAgility.editable = true
            _attrIntellect.editable = true
        }
        
        _attrAttack = addAttrLabel(x: x2, y: y1, text: "攻击", value: bUnitRole.getAttack())
        var def = bUnitRole.getDefence()
        if bUnitRole.hasSpell(spell: OnePunch()) || bUnitRole.hasSpell(spell: DancingOnIce()) {
            def = 0
        }
        _attrDefence = addAttrLabel(x: x2, y: y2, text: "防御", value: def)
        _attrSpeed = addAttrLabel(x: x2, y: y3, text: "速度", value: bUnitRole.getSpeed())
        _attrSpirit = addAttrLabel(x: x2, y: y4, text: "精神", value: bUnitRole.getSpirit())
        _attrHealth = addAttrLabel(x: x2, y: y5, text: "生命", value: bUnitRole.getHealth())
        
        _attrCritical = addAttrLabel(x: x3, y: y1, text: "必杀", value: bUnitRole.getCriticalForShow())
        _attrAvoid = addAttrLabel(x: x3, y: y2, text: "闪避", value: bUnitRole.getAvoid())
        _attrAccuracy = addAttrLabel(x: x3, y: y3, text: "命中", value: bUnitRole.getAccuracy())
        _attrMind = addAttrLabel(x: x3, y: y4, text: "念力", value: bUnitRole.getMind())
        
        
        _attrFirePower = addAttrLabel(x: x4, y: y1, text: "火", value: bUnitRole.getFirePower(), value2: bUnitRole.getFireResistance())
        _attrWaterPower = addAttrLabel(x: x4, y: y2, text: "冰", value: bUnitRole.getWaterPower(), value2: bUnitRole.getWaterResistance())
        _attrThunderPower = addAttrLabel(x: x4, y: y3, text: "雷", value: bUnitRole.getThunderPower(), value2:bUnitRole.getThunderResistance())
//        _attrFireRes = addAttrLabel(x: x4, y: y4, text: "火抗", value: bUnitRole.getFireResistance())
//        _attrWaterRes = addAttrLabel(x: x4, y: y5, text: "冰抗", value: bUnitRole.getWaterResistance())
//        _attrThunderRes = addAttrLabel(x: x4, y: y6, text: "雷抗", value: bUnitRole.getThunderResistance())
        
        _attrBreak = addAttrLabel(x: x5, y: y1, text: "破甲", value: bUnitRole.getBreak())
        _ = addAttrLabel(x: x5, y: y2, text: "律动", value: bUnitRole.getRhythm())
        if unit is Character {
            _attrLucky = addAttrLabel(x: x5, y: y3, text: "幸运", value: bUnitRole.getLucky())
            _attrRevenge = addAttrLabel(x: x5, y: y4, text: "复仇", value: bUnitRole.getRevenge())
        }
        if unit._spellCount > 0 {
            for i in 0...unit._spellCount - 1 {
                let spellIcon = SpellIcon()
                spellIcon.position.x = startX + cellSize * 1.25 * i.toFloat()
                spellIcon.position.y = y6
//                spellIcon.anchorPoint = CGPoint(x: 0, y: 1)
                _propertyLayer.addChild(spellIcon)
                if unit._spellsInuse.count > i {
                    spellIcon.spell = unit._spellsInuse[i]
                    spellIcon._displayItemType = unit._spellsInuse[i]
                }
                _listSpells.append(spellIcon)
            }
        }
    }
    func addAttrLabel(x:CGFloat, y:CGFloat, text:String, value:CGFloat) -> AttrLabel {
        let label = AttrLabel()
        label.position.x = x
        label.position.y = y
        label.text = text
        label.value = value.toInt()
        _propertyLayer.addChild(label)
        return label
    }
    func addAttrLabel(x:CGFloat, y:CGFloat, text:String, value:CGFloat, value2:CGFloat) -> AttrLabel {
        let label = AttrLabel()
        label.position.x = x
        label.position.y = y
        label.text = text + " \(value.toInt()) /"
        label.value = value2.toInt()
        _propertyLayer.addChild(label)
        return label
    }
    
    private func dataReload() {
        let bChar = BUnit()
        bChar.setUnit(unit: _unit)
        
        let to = Creature()
        to._level = 0
        
        _attrStrength.value = bChar.getStrength().toInt()
        _attrStamina.value = bChar.getStamina().toInt()
        _attrAgility.value = bChar.getAgility().toInt()
        _attrIntellect.value = bChar.getIntellect().toInt()
        _attrAttack.value = bChar.getAttack(t: to).toInt()
        _attrDefence.value = bChar.getDefence(t: to).toInt()
        _attrSpeed.value = bChar.getSpeed().toInt()
        _attrSpirit.value = bChar.getSpirit(t: to).toInt()
        _attrHealth.value = bChar.getHealth().toInt()
        _attrCritical.value = bChar.getCriticalForShow(t: to).toInt()
        _attrAvoid.value = bChar.getAvoid(t: to).toInt()
        _attrAccuracy.value = bChar.getAccuracy(t: to).toInt()
//        _attrMind.value = bChar.getMind(target: to).toInt()
//        _attrBreak.value = bChar.getBreak().toInt()
        _attrLeftPoint.value = _unit._leftPoint
    }
    
    private func changeProperties(p:String) {
        let char = _unit!
        switch p {
        case "str":
            char.strengthChange(value: 1)
            char._leftPoint -= 1
            break
        case "sta":
            char.staminaChange(value: 1)
            char._leftPoint -= 1
            break
        case "agl":
            char.agilityChange(value: 1)
            char._leftPoint -= 1
            break
        case "int":
            char.intellectChange(value: 1)
            char._leftPoint -= 1
            break
        default:
            break
        }
        if char._leftPoint < 1 {
            _attrLeftPoint.removeFromParent()
            _attrStrength.editable = false
            _attrStamina.editable = false
            _attrAgility.editable = false
            _attrIntellect.editable = false
        }
        dataReload()
    }
   
    private func getSeatNode(color:UIColor = UIColor.lightGray) -> SeatNode {

        return SeatNode()
    }
    
    private func showSpellInfo(_ si:SpellIcon) {
        let spellInfo = SpellInfo()
        spellInfo.create(spell: si.spell!)
        spellInfo.zPosition = MyStage.UI_TOPEST_Z
        spellInfo.position.x = si.position.x
        spellInfo.position.y = si.position.y + spellInfo._displayHeight + cellSize * 0.25
        addChild(spellInfo)
        _spellInfoPanel = spellInfo
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private var _llt:SKSpriteNode!
    private var _llm:SKSpriteNode!
    private var _llb:SKSpriteNode!
    private var _lrt:SKSpriteNode!
    private var _lrm:SKSpriteNode!
    private var _lrb:SKSpriteNode!
    
    private var _btl:SeatNode!
    private var _btm:SeatNode!
    private var _btr:SeatNode!
    private var _bbl:SeatNode!
    private var _bbm:SeatNode!
    private var _bbr:SeatNode!
    private var _seatNodes = Array<SeatNode>()
    
    private var _attrStrength:AttrLabel!
    private var _attrStamina:AttrLabel!
    private var _attrAgility:AttrLabel!
    private var _attrIntellect:AttrLabel!
    private var _attrLeftPoint:AttrLabel!
    private var _attrAttack:AttrLabel!
    private var _attrDefence:AttrLabel!
    private var _attrSpeed:AttrLabel!
    private var _attrSpirit:AttrLabel!
    private var _attrHealth:AttrLabel!
    private var _attrCritical:AttrLabel!
    private var _attrAvoid:AttrLabel!
    private var _attrAccuracy:AttrLabel!
    private var _attrLucky:AttrLabel!
    private var _attrChaos:AttrLabel!
    private var _attrMind:AttrLabel!
    private var _attrBreak:AttrLabel!
    private var _attrRevenge:AttrLabel!
    private var _attrFirePower:AttrLabel!
    private var _attrThunderPower:AttrLabel!
    private var _attrWaterPower:AttrLabel!
    private var _attrFireRes:AttrLabel!
    private var _attrThunderRes:AttrLabel!
    private var _attrWaterRes:AttrLabel!
    
    private var _propertyLayer = SKSpriteNode()
    private var _unit:Creature!
    private var _listSpells = Array<SpellIcon>()
    private var _lastSelectedSpellIcon = SpellIcon()
    private var _spellInfoPanel:SpellInfo?
    var _parentPanel:UIPanel?
}

class SeatNode:SKSpriteNode {
    static let SELECTED_COLOR = QualityColor.RARE
    static let UNSELECTED_COLOR = UIColor.lightGray
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.size = CGSize(width: cellSize * 0.7, height: cellSize * 0.7)
        self.color = SeatNode.UNSELECTED_COLOR
        self.anchorPoint = CGPoint(x: 0, y: 1)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var _seat = ""
}
