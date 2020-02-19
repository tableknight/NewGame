//
//  SelectImage.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/6.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class SelectImage:UIPanel {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        _roleInfo?.removeFromParent()
        
        for u in _listBox.children {
            if u.contains(touchPoint!) {
                let rc = u as! ImageComponent
                _lastSelectedComponent?.selected = false
                _lastSelectedComponent = rc
                _lastSelectedComponent.selected = true
                _roleInfo = RoleInfo()
                _roleInfo.create(data: rc._roleData)
                _roleInfo.position.x = rc.xAxis
                if rc.xAxis > -cellSize {
                    _roleInfo.position.x = rc.xAxis - cellSize * 1.5
                }
                _roleInfo.yAxis = rc.yAxis - cellSize * 2 - 4
                addChild(_roleInfo)
//                selectedRoleData = rc._roleData
                return
            }
        }
        if _nextButton.contains(touchPoint!) {
//            nextAction()
            createCharactor()
            return
        }
        if _prevButton.contains(touchPoint!) {
            prevAction()
            return
        }
        
        if _closeButton.contains(touchPoint!) {
            self.removeFromParent()
            let sd = SelectDocument()
            sd.create()
            Game.instance.gameScene.addChild(sd)
            closeAction()
            return
        }
        
    }
    override func createPanelbackground() {
        super.createPanelbackground()
        _bg.strokeColor = Game.SELECTED_HIGHLIGH_COLOR
        _bg.lineWidth = Game.SELECTED_STROKE_WIDTH
    }
    var nextAction = {}
    var prevAction = {}
    var closeAction = {}
    override func create() {
        createCloseButton()
        createPageButtons()
        _label.text = "抉择：选择角色"
        _closeButton.text = "返回"
        _closeButton._bg.strokeColor = Game.SELECTED_HIGHLIGH_COLOR
        _closeButton._bg.lineWidth = Game.SELECTED_STROKE_WIDTH
//        _prevButton.text = "上一步"
        _prevButton.isHidden = true
        _nextButton.text = "确定"
        _nextButton._bg.strokeColor = Game.SELECTED_HIGHLIGH_COLOR
        _nextButton._bg.lineWidth = Game.SELECTED_STROKE_WIDTH
        addChild(_listBox)
        _images = [
//            Game.instance.pictureCollabo8_2.getCell(6, 3, 3, 4),
//            Game.instance.pictureActor3.getCell(3, 7, 3, 4),
//            Game.instance.pictureActor1.getCell(0, 7, 3, 4),
//            Game.instance.pictureActor1.getCell(9, 3, 3, 4),
//            Game.instance.picturePeople1.getCell(0, 3, 3, 4),
//            Game.instance.picturePeople1.getCell(3, 3, 3, 4),
//            SKTexture(imageNamed: "role_1"),
//            SKTexture(imageNamed: "role_2"),
//            SKTexture(imageNamed: "role_3"),
//            SKTexture(imageNamed: "role_4"),
//            SKTexture(imageNamed: "role_5"),
//            SKTexture(imageNamed: "role_6"),
//            SKTexture(imageNamed: "role_7"),
//            SKTexture(imageNamed: "role_8")
            "role_01",
            "role_02",
            "role_03",
//            "role_04",
//            "role_05",
            "role_06"
        ]
        _names = ["马可","艾丽丝", "伊莎贝拉",
//                  "火云", "京",
                  "梅露露"]
        _roleDatas = [
            RoleData(growthPoint: 5, spellCount: 3, minionCount: 2, hasWeapon: true, hasShield: true, hasMark: true),
            RoleData(growthPoint: 5, spellCount: 2, minionCount: 3, hasWeapon: true, hasShield: false, hasMark: true, spell: Spell.Burn),
            RoleData(growthPoint: 4, spellCount: 3, minionCount: 3, hasWeapon: true, hasShield: true, hasMark: true, spell: Spell.QuickHeal),
//            RoleData(growthPoint: 5, spellCount: 3, minionCount: 3, hasWeapon: true, hasShield: false, hasMark: false),
            RoleData(growthPoint: 6, spellCount: 2, minionCount: 2, hasWeapon: true, hasShield: true, hasMark: false, spell: Spell.ToughHeart)
        ]
        showImages()
        
    }
    
    func showImages() {
        let startX = -_standardWidth * 0.5 + cellSize * 0.25
        let startY = _standardHeight * 0.5 - cellSize * 0.5
        let gap = cellSize * 2
        var i = 0
        for t in _images {
            let ic = ImageComponent()
            let x = i % 4
            let y = i / 4
            ic.yAxis = startY - gap * y.toFloat()
            ic.xAxis = startX + gap * x.toFloat()
            ic.zPosition = self.zPosition + 3
            ic.create(image: t, name: _names[i])
            ic._roleData = _roleDatas[i]
            _listBox.addChild(ic)
            i += 1
        }
    }
    
    private func createCharactor() {
        if nil == _lastSelectedComponent {
            return
        }
        let roleData = _lastSelectedComponent._roleData!
        let image = _lastSelectedComponent._image!
        let stage = MyStage()
        let scene = SecretMeadow()
        scene.create()
        let e = Character()
        e.create()
        Game.instance.char = e
        e._img = image
        e._imgUrl = _lastSelectedComponent._imgUrl
        let p = Item(Item.Potion)
        p._count = 2
        e.addItem(p)
        let ts = Item(Item.TownScroll)
        ts._count = 2
        e.addItem(ts)
        
        let ps = Item(Item.SealScroll)
        ps._count = 2
        e.addItem(ps)
        e._minionsCount = roleData.minionCount
        e._spellCount = roleData.spellCount
        e.hasMark = roleData.hasMark
        e.hasShield = roleData.hasShield
        e.hasWeapon = roleData.hasWeapon
        e._levelPoint = roleData.growthPoint
        
        e._spellsInuse = [roleData.spell]
        
        e._spellsInuse.append(Spell.ColdWind)
        e._spellsInuse.append(Spell.ThunderArray)
        
        let i = Item("lvScroll")
//        i._count = 40
        e.addItem(i)
//        e._minionsCount = 2
//        e._spellCount = 3
//        e._levelPoint = 5
        e._seat = BUnit.BBM
        e._pro = "冒险者"
        e._name = _lastSelectedComponent._name
        //-------------------------------------
        if Mode.debug {
//            e._props.append(LevelUpScroll())
        }
        //-------------------------------------
        scene.setRole(x: scene._portalPrev.x, y: scene._portalPrev.y, role: e)
        let kiki = BlackCat()
        kiki.create(level: 1)
        kiki._seat = BUnit.BTM
        e._minions.append(kiki)
        stage.loadScene(scene: scene)
        stage.createMenu()
        self.removeFromParent()
        
        self.removeFromParent()
        Game.instance.gameScene.addChild(stage)
        
        setTimeout(delay: 1, completion: {
            Game.saving(sync: false)
        })
    }
    
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var _listBox = SKSpriteNode()
    var _images = Array<String>()
    var _names = Array<String>()
    var _lastSelectedComponent:ImageComponent!
    var _roleDatas = Array<RoleData>()
    private var _roleInfo:RoleInfo!
}

class ImageComponent:SelectableComponent {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
//        _background.strokeColor =
        _background = createBackground(width: cellSize * 1.5, height: cellSize * 2)
        _background.lineWidth = 2
        _background.strokeColor = QualityColor.RARE
//        addChild(_background)
//        print(cellSize)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func create(image:String, name:String) {
        let i = SKTexture(imageNamed: image)
        let images:Array<SKTexture> = [i.getCell(0, 0), i.getCell(1, 0), i.getCell(2, 0)]
//        let i0 = SKAction.setTexture(images[0])
////        let i1 = SKAction.setTexture(images[1])
//        let i2 = SKAction.setTexture(images[2])
//        let wait = SKAction.wait(forDuration: TimeInterval(0.5))
//
//        let squ = SKAction.sequence([i0, wait, i2, wait])
//        let r = SKAction.repeatForever(squ)
        let role = SKSpriteNode()
        role.xAxis = cellSize * 0.75
        role.yAxis = -cellSize * 0.75
        role.texture = images[1]
        role.size = CGSize(width: cellSize * 1.25, height: cellSize * 1.25)
//        role.run(r)
        addChild(role)
        _image = i
        _imgUrl = image
        _name = name
        let nl = Label()
        nl.text = name
        nl.align = "center"
        nl.position.x = role.size.width * 0.5 + 6
        nl.position.y = role.yAxis - 12 - role.size.height * 0.5
        nl.fontSize = cellSize * 0.25
        addChild(nl)
    }
    var _image:SKTexture!
    var _imgUrl = ""
    var _name = ""
    var _roleData:RoleData!
    override var selected: Bool {
        set {
            _selected = newValue
            _background.removeFromParent()
            if newValue {
                addChild(_background)
            }
        }
        get {
            return _selected
        }
    }
}
struct RoleData {
    var growthPoint = 5
    var spellCount = 2
    var minionCount = 2
    var hasWeapon = true
    var hasShield = true
    var hasMark = true
    var spell = Spell.LowlevelFlame
}
class RoleInfo: SelectableComponent {
    func create(data:RoleData) {
        let yGap = cellSize * 0.5
        let growthLabel = Label()
        growthLabel.position.x = cellSize * 0.25
        growthLabel.position.y = -cellSize * 0.25
        growthLabel.fontSize = cellSize * 0.25
        growthLabel.text = "属性成长：\(data.growthPoint)"
        addChild(growthLabel)
        
        let spellCountLabel = Label()
        spellCountLabel.position.x = growthLabel.position.x
        spellCountLabel.position.y = growthLabel.position.y - yGap
        spellCountLabel.fontSize = growthLabel.fontSize
        spellCountLabel.text = "技能栏：\(data.spellCount)"
        addChild(spellCountLabel)
        
        let minionClountLabel = Label()
        minionClountLabel.position.x = growthLabel.position.x
        minionClountLabel.position.y = spellCountLabel.position.y - yGap
        minionClountLabel.fontSize = growthLabel.fontSize
        minionClountLabel.text = "随从位：\(data.minionCount)"
        addChild(minionClountLabel)
        
        let weapon = Label()
        weapon.position.x = growthLabel.position.x
        weapon.position.y = minionClountLabel.position.y - yGap
        weapon.fontSize = growthLabel.fontSize
        weapon.text = "是否可佩戴武器：\(data.hasWeapon ? "是" : "否")"
        addChild(weapon)
        
        let shield = Label()
        shield.position.x = growthLabel.position.x
        shield.position.y = weapon.position.y - yGap
        shield.fontSize = growthLabel.fontSize
        shield.text = "是否可装备盾牌：\(data.hasShield ? "是" : "否")"
        addChild(shield)
        
        let mark = Label()
        mark.position.x = growthLabel.position.x
        mark.position.y = shield.position.y - yGap
        mark.fontSize = growthLabel.fontSize
        mark.text = "是否可刻蚀魔印：\(data.hasMark ? "是" : "否")"
        addChild(mark)
        
        let spell = Label()
        spell.position.x = growthLabel.position.x
        spell.position.y = mark.position.y - yGap
        spell.fontSize = growthLabel.fontSize
        spell.text = "初始技能：\(Loot.getSpellById(data.spell)._name)"
        addChild(spell)
        

    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _background = createBackground(width: cellSize * 3, height: cellSize * 4)
        addChild(_background)
        self.zPosition = MyStage.UI_PANEL_Z + 3
        _background.strokeColor = Game.SELECTED_HIGHLIGH_COLOR
        _background.lineWidth = Game.SELECTED_STROKE_WIDTH
        print(cellSize)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
//    internal var _background:SKShapeNode = SKShapeNode()
//    private var _index = 1
}
