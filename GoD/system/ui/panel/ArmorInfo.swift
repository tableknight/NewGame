//
//  ArmorInfo.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/2.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit

class ArmorInfo:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        zPosition = MyStage.UI_TOPEST_Z
        
    }
    
    func create(armor:Outfit) {
        _armor = armor
        let startX = cellSize * 0.25
        let startY = -cellSize * 0.25
        let gap:CGFloat = 6
        
        let name = Label()
        var nameText = armor._name
        if armor._quality == Quality.SACRED {
            nameText = getOutfitNameText(armor._type) + " · " + armor._name
        }
        if armor._type == Outfit.MagicMark {
            nameText = getOutfitNameText(armor._type) + " · " + Loot.getSpellById(armor._spell)._name
        } else if armor._type == Outfit.Instrument {
            nameText = getOutfitNameText(armor._type)
        }
        name.text = "Lv\(armor._level) [\(nameText)]"
        name.fontSize = 24
        name.fontColor = QualityColor.getColor(armor._quality)
        name.position.x = startX
        name.position.y = startY
        addChild(name)
        _nameText = name.text!
        
        _displayWidth = (name.text!.count.toFloat() - 3) * name.fontSize
        _displayHeight = cellSize
        if _displayWidth < cellSize * 3 {
            _displayWidth = cellSize * 3
        }
        
//        if armor.isRandom {
//            _displayHeight = cellSize * 4
//            let bg = SKShapeNode(rect: CGRect(origin: CGPoint(x: 0, y: -_displayHeight), size: CGSize(width: _displayWidth, height: _displayHeight)), cornerRadius: 4 )
//            bg.fillColor = UIColor.black
//            bg.lineWidth = 2
//            //        bg.glowWidth = 3
//            bg.strokeColor = UIColor.lightGray
//            _bg = bg
//            addChild(bg)
//            name.text = "[\(armor._name)??]"
//            name.fontColor = QualityColor.getColor(Quality.NORMAL)
////            name.position.y = -cellSize * 0.75
//
//            let des = Label()
//            des.text = "未鉴定的\(armor._name)"
//            des.fontSize = 12
//            des.fontColor = QualityColor.GOOD
//            des.align = "left"
//            des.position.x = startX
//            des.position.y = name.position.y - 25
//            addChild(des)
//            _displayHeight += 25
//
//            return
//        }
        
        var lastY = name.position.y - name.fontSize
        if armor._attackSpeed > 0 {
            let spd = Label()
            let speedText = "\(armor._attackSpeed)"
            var str = ""
            var i = 0
            for c in speedText {
                if i < 4 {
                    str.append(c)
                }
                i += 1
            }
            spd.text = "攻速 \(str)"
            
            spd.fontColor = UIColor.white
            spd.position.x = startX - 1
            spd.position.y = lastY - gap
            spd.fontSize = 15
            addChild(spd)
            _displayHeight += name.fontSize + gap * 2
            lastY = spd.position.y - spd.fontSize - gap
            _speedText = "攻速 \(str)"
        }
        
        if armor._attrs.count > 0 {
            for i in 0...armor._attrs.count - 1 {
                if armor._attrs[i]._hidden {
                    continue
                }
                let label = Label()
                label.fontSize = name.fontSize * 0.7
                //                label.fontName = ""
                label.text = armor._attrs[i].getText()
                label.position.x = startX
                label.position.y = lastY - gap
                label.fontColor = UIColor.white
                addChild(label)
                lastY = label.position.y - label.fontSize
                _displayHeight += label.fontSize + gap
                _attrTexts.append(label.text!)
            }
        }
        
        if armor._type == Outfit.MagicMark {
//            let spellName = Label()
//            spellName.text = "[\(armor._spell._name)]"
//            spellName.fontSize = 18
//            spellName.position.x = startX
//            spellName.position.y = lastY - gap
//            spellName.fontColor = QualityColor.getColor(armor._spell._quality)
//            lastY = spellName.position.y - spellName.fontSize
//            _displayHeight += spellName.fontSize + gap
//            addChild(spellName)
//            _markSpellName = spellName.text!
        }
        
        if !armor._description.isEmpty || armor._type == Outfit.Instrument {
            let des = Label()
            des.text = armor._description
            des.fontSize = 18
            
            des.fontColor = QualityColor.GOOD
            if armor._type == Outfit.Instrument {
                let s = Loot.getSpellById(armor._spell)
                des.text = "[\(s._name)]"
                des.fontColor = QualityColor.getColor(s._quality)
            }
            des.position.x = startX
            des.position.y = lastY - gap
            lastY = lastY - gap - 18
            _displayHeight += des.fontSize + gap
            addChild(des)
            _desText = des.text!
            let desWidth = _desText.count.toFloat() * des.fontSize + cellSize * 0.5
            if desWidth > _displayWidth {
                _displayWidth = desWidth + cellSize * 0.25
            }
        } else if armor._type == Outfit.MagicMark {
            let s = Loot.getSpellById(armor._spell)
            let des = Label()
            des.text = s._description
            des.fontSize = 18
//            if armor is Instrument {
//                des.fontSize = name.fontSize
//            }
            des.fontColor = QualityColor.NORMAL
            des.position.x = startX
            des.position.y = lastY - gap
            lastY = lastY - gap - 18
            _displayHeight += des.fontSize + gap
            addChild(des)
            _desText = des.text!
            let desWidth = _desText.count.toFloat() * des.fontSize + cellSize * 0.5
            if desWidth > _displayWidth {
                _displayWidth = desWidth + cellSize * 0.25
            }
//            let spellName = Label()
//            spellName.align = "left"
//            spellName.position.x = startX
//            spellName.position.y = lastY - gap
//            spellName.fontColor = QualityColor.getColor(s._quality)
//            spellName.fontSize = 18
//            spellName.text = "[\(s._description)]"
//            lastY = lastY - gap - 18
//            _displayHeight += 30
//            addChild(spellName)
//            _insSpellName = spellName.text!
        }
        
        if armor._unique {
            let spellName = Label()
            spellName.align = "left"
            spellName.position.x = startX
            spellName.position.y = lastY - gap
            spellName.fontColor = QualityColor.getColor(Quality.RARE)
            spellName.fontSize = 18
            spellName.text = "装备唯一"
            lastY = lastY - gap - 18
            _displayHeight += 30
            addChild(spellName)
        }
        

        
        if armor._price > 0 {
            let price = Label()
            price.align = "left"
            price.position.x = startX
            price.position.y = lastY - gap * 2
            price.fontSize = name.fontSize * 0.6
            price.text = "出售价格：\(armor._price)G"
            price.fontColor = UIColor.orange
            addChild(price)
            _displayHeight += price.fontSize + gap * 2
            _priceText = price.text!
        }
        
        let bg = createBackground(width: _displayWidth, height: _displayHeight)
        bg.position.x = _displayWidth * 0.5
        bg.position.y = -_displayHeight * 0.5
        bg.strokeColor = UIColor.lightGray
        _bg = bg
        addChild(bg)
//        let bg = SKShapeNode(rect: CGRect(origin: CGPoint(x: 0, y: -_displayHeight), size: CGSize(width: width, height: _displayHeight)), cornerRadius: 4 )
//        bg.fillColor = UIColor.black
//        bg.lineWidth = 2
//        //        bg.glowWidth = 3
//
//        bg.strokeColor = UIColor.lightGray
//        _bg = bg
//        addChild(bg)
        
//        let img = SKShapeNode(rect: CGRect(x: 0, y: 0, width: cellSize, height: cellSize), cornerRadius: 2)
//        img.position.x = startX
//        img.position.y = startY - 12
//        img.strokeColor = QualityColor.getColor(armor._quality)
//        //        img.lineWidth = 2
//        addChild(img)

    }
    
    func getOutfitNameText(_ type:String) -> String {
        if type ==  Outfit.Amulet {
            return "项链"
        }
        if type ==  Outfit.Shield {
            return "盾"
        }
        if type ==  Outfit.Ring {
            return "戒指"
        }
        if type ==  Outfit.MagicMark {
            return "魔印"
        }
        if type ==  Outfit.SoulStone {
            return "灵魂石"
        }
        if type ==  Outfit.Sword {
            return "剑"
        }
        if type ==  Outfit.Wand {
            return "法杖"
        }
        if type ==  Outfit.Instrument {
            return "法器"
        }
        if type ==  Outfit.Dagger {
            return "匕首"
        }
        if type ==  Outfit.Fist {
            return "拳套"
        }
        if type ==  Outfit.Blunt {
            return "钝器"
        }
        if type ==  Outfit.Bow {
            return "弓"
        }
        if type ==  Outfit.EarRing {
            return "耳环"
        }
        return ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private var _armor = Outfit()
    var _displayWidth:CGFloat = 0
    var _nameText = ""
    var _speedText = ""
    var _attrTexts = Array<String>()
    var _markSpellName = ""
    var _desText = ""
    var _insSpellName = ""
    var _priceText = ""
    var _bg = SKShapeNode()
    var _displayHeight:CGFloat = 0
}
