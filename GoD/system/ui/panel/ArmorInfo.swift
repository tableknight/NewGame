//
//  ArmorInfo.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/2.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit

class ArmorInfo:SKSpriteNode, IPanelSize {
//    func getDisplayNode() -> SKSpriteNode {
//        return self
//    }
    
    func getDisplayWidth() -> CGFloat {
        return _displayWidth
    }
    
    func getDisplayHeight() -> CGFloat {
        return _displayHeight
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        zPosition = MyStage.UI_TOPEST_Z
        
    }
    
    private var _armor = Outfit()
    var _displayWidth:CGFloat = 0
    func create(armor:Outfit) {
        _armor = armor
        let startX = cellSize * 0.25
        let startY = -cellSize * 0.25
        let gap:CGFloat = 6
        
//        let i = SKSpriteNode(texture: Data.instance.inside_c.getCell(10, 0))
//        i.position.x = startX
//        i.position.y = startY - 12
//        i.anchorPoint = CGPoint(x: 0, y: 0)
//        addChild(i)
        
        let name = Label()
        var nameText = armor._name
        if armor._quality == Quality.SACRED {
            nameText = armor._outfitName + " · " + armor._name
        }
        name.text = "Lv.\(armor._level.toInt()) [\(nameText)]"
        name.fontSize = 24
        name.fontColor = QualityColor.getColor(armor._quality)
        name.position.x = startX
        name.position.y = startY
        addChild(name)
        
        var width:CGFloat = 100 + (nameText.count * 24).toFloat()
        _displayHeight = cellSize
        if width < cellSize * 3 {
            width = cellSize * 3
        }
        
        if armor.isRandom {
            _displayHeight = cellSize * 4
            let bg = SKShapeNode(rect: CGRect(origin: CGPoint(x: 0, y: -_displayHeight), size: CGSize(width: width, height: _displayHeight)), cornerRadius: 4 )
            bg.fillColor = UIColor.black
            bg.lineWidth = 2
            //        bg.glowWidth = 3
            bg.strokeColor = UIColor.lightGray
            _bg = bg
            addChild(bg)
            name.text = "[\(armor._name)??]"
            name.fontColor = QualityColor.getColor(Quality.NORMAL)
//            name.position.y = -cellSize * 0.75
            
            let des = Label()
            des.text = "未鉴定的\(armor._name)"
            des.fontSize = 12
            des.fontColor = QualityColor.GOOD
            des.align = "left"
            des.position.x = startX
            des.position.y = name.position.y - 25
            addChild(des)
            _displayHeight += 25
            
            return
        }
        
        var lastY = name.position.y - name.fontSize
        if armor is Weapon {
            let w = armor as! Weapon
            let spd = Label()
            
            let speedText = "\(w._attackSpeed)"
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
        }
        
        if armor._attrs.count > 0 {
            for i in 0...armor._attrs.count - 1 {
                let label = Label()
                label.fontSize = name.fontSize * 0.7
                //                label.fontName = ""
                label.text = armor._attrs[i].getText()
                label.position.x = startX - 1
                label.position.y = lastY - gap
                label.fontColor = UIColor.white
                addChild(label)
                lastY = label.position.y - label.fontSize
                _displayHeight += label.fontSize + gap
            }
        }
        
        if armor is MagicMark {
            let spellName = Label()
            let mark = armor as! MagicMark
            spellName.text = "[\(mark._spell._name)]"
            spellName.fontSize = name.fontSize * 0.8
            spellName.position.x = startX
            spellName.position.y = lastY - gap
            lastY = spellName.position.y - spellName.fontSize
            _displayHeight += spellName.fontSize + gap
            addChild(spellName)
        }
        
        if !armor._description.isEmpty {
            let des = Label()
            des.text = armor._description
            des.fontSize = 18
//            if armor is Instrument {
//                des.fontSize = name.fontSize
//            }
            des.fontColor = QualityColor.GOOD
            des.position.x = startX
            des.position.y = lastY - gap
            lastY = lastY - gap - 18
            _displayHeight += des.fontSize + gap
            addChild(des)
        }
        
//        if armor is Instrument {
//            //            let ins = armor as! Instrument
//            let spellName = Label()
//            spellName.align = "left"
//            spellName.position.x = startX
//            spellName.position.y = lastY - 30
//            spellName.fontColor = QualityColor.getColor(armor._quality)
//            spellName.fontSize = 16
//            spellName.text = armor._description
//            lastY = lastY - 30
//            addChild(spellName)
//        }
        
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
        }
        _displayWidth = width
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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var _bg = SKShapeNode()
    var _displayHeight:CGFloat = 0
}
