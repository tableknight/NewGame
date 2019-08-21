//
//  Welcome.swift
//  GoD
//
//  Created by kai chen on 2019/4/25.
//  Copyright © 2019 Chen. All rights reserved.
//

import SpriteKit
class Welcome: SKSpriteNode {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        if _selectRoleButton.contains(touchPoint!) {
            self.removeFromParent()
            let sd = SelectDocument()
            sd.create()
            _gameScene.addChild(sd)
            sd._gameScene = _gameScene
            return
        }
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        isUserInteractionEnabled = true
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func create() {
        _selectRoleButton.zPosition = self.zPosition + 2
        _selectRoleButton.xAxis = -cellSize * 0.75
        _selectRoleButton.yAxis = -cellSize * 6
        _selectRoleButton.text = "选择角色"
        let bounds = UIScreen.main.bounds.size
        let rate:CGFloat = 2
        let bg = SKSpriteNode(texture: SKTexture(imageNamed: "Fountain"))
        bg.size = CGSize(width: bounds.height * 1.3 * rate, height: bounds.height * rate)
        bg.position.x = -bounds.width
        addChild(bg)
        addChild(_selectRoleButton)
    }
    internal var _selectRoleButton = Button()
    var _gameScene:GameScene!
}
