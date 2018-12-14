//
//  Charactor.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/1/22.
//  Copyright © 2018年 Chen. All rights reserved.
//
// let unit = UIUnit()
// unit.setTexture("xxx.pmg")
//

import SpriteKit
class UIUnit:UIItem {
    private var _charTexture:SKTexture!
    var _charNode = SKSpriteNode()
    var _moveSpeed:CGFloat = 1
    var _contentUnit:Creature!
    var _sha:SKSpriteNode!
    private var _selectTexture = SKTexture(imageNamed: "select.png")
    var specialUnit = false
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
//        size = CGSize(width: cellSize, height: cellSize)
        self.size = CGSize(width: cellSize, height: cellSize)
//        addChild(_charNode)
        let shadow = SKSpriteNode(texture: _selectTexture.getCell(3, 0))
        shadow.size = CGSize(width: cellSize, height: cellSize)
        shadow.position.y = cellSize * 0.25
        shadow.zPosition = self.zPosition - 1
        addChild(shadow)
        _sha = shadow
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setTexture(_ imageUrl:String) {
        _charTexture = SKTexture(imageNamed: imageUrl)
        faceSouth()
    }
    override func setTexture(_ texture:SKTexture) {
        _charTexture = texture
//        self.size = CGSize(width: texture.size().width * 1.5, height: texture.size().height * 1.5)
        faceSouth()
    }
    func faceSouth() {
        self.texture = _charTexture.getCell(1, 0)
    }
    func faceNorth() {
        var y:CGFloat = 3
        if specialUnit {
            y = 2
        }
        self.texture = _charTexture.getCell(1, y)
    }
    func faceWest() {
        self.texture = _charTexture.getCell(1, 1)
    }
    func faceEast() {
        var y:CGFloat = 2
        if specialUnit {
            y = 3
        }
        self.texture = _charTexture.getCell(1, y)
    }
    
}
