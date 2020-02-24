//
//  ItemInfo.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/2.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class ItemInfo:SKSpriteNode {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        zPosition = MyStage.UI_TOPEST_Z
    }
    
    private var _item:Item!
    func create(item:Item) {
        _item = item
        let startX = cellSize * 0.25
        let startY = -cellSize * 0.25
        
        _displayWidth = cellSize * 3
        _displayHeight = cellSize * 0.5
        
        let name = Label()
        if item._type == Item.SpellBook {
            name.text = "[法术书·\(_item._name)]"
        } else {
            name.text = "[\(_item._name)]"
        }
        name.fontSize = 24
        name.fontColor = QualityColor.getColor(item._quality)
        name.position.x = startX
        name.position.y = startY
        addChild(name)
        
        _displayHeight += name.fontSize
        
        
        let des = MultipleLabel()
        des._lineCharNumber = 10
        des._fontSize = 18
        des.text = item._description
        des.position.x = startX
        des.position.y = name.position.y - cellSize * 0.5
        addChild(des)
        
        _displayHeight += des._height + cellSize * 0.5
        
        if item._price > 0 {
            let price = Label()
            price.position.x = startX
            price.position.y = des.position.y - des._height - cellSize * 0.5
            price.fontSize = 16
//            var p = item._price
//            if item._priceType == Item.PRICE_TYPE_TEAR {
//                p = item._price * 4
//            }
            price.text = "出售价格：\(item.price4sale)G"
            price.fontColor = UIColor.orange
            addChild(price)
            _displayHeight += price.fontSize + cellSize * 0.5
        }
        
        let bg = createBackground(width: _displayWidth, height: _displayHeight)
        bg.position.x = _displayWidth * 0.5
        bg.position.y = -_displayHeight * 0.5
        _bg = bg
        addChild(bg)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var _bg = SKShapeNode()
    var _displayHeight:CGFloat = 0
    var _displayWidth:CGFloat = 0
}
